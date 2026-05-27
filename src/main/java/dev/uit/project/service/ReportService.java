package dev.uit.project.service;

import dev.uit.project.domain.Booking;
import dev.uit.project.domain.SalesReport;
import dev.uit.project.repository.BookingRepository;
import dev.uit.project.repository.CustomerRepository;
import dev.uit.project.repository.RoomRepository;
import dev.uit.project.repository.SalesReportRepository;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.*;

@Service
public class ReportService {

    @PersistenceContext
    private EntityManager entityManager;

    private final BookingRepository bookingRepository;
    private final RoomRepository roomRepository;
    private final CustomerRepository customerRepository;
    private final SalesReportRepository salesReportRepository;

    public ReportService(BookingRepository bookingRepository, RoomRepository roomRepository,
                         CustomerRepository customerRepository, SalesReportRepository salesReportRepository) {
        this.bookingRepository = bookingRepository;
        this.roomRepository = roomRepository;
        this.customerRepository = customerRepository;
        this.salesReportRepository = salesReportRepository;
    }

    private void refreshDailySalesReports(LocalDate startDate, LocalDate endDate) {
        if (startDate == null || endDate == null || startDate.isAfter(endDate)) {
            return;
        }
        try {
            StoredProcedureQuery query = entityManager.createStoredProcedureQuery("hotel.sp_generate_daily_sales_report");
            query.registerStoredProcedureParameter("p_report_date", java.sql.Date.class, ParameterMode.IN);

            LocalDate current = startDate;
            while (!current.isAfter(endDate)) {
                try {
                    query.setParameter("p_report_date", java.sql.Date.valueOf(current));
                    query.execute();
                } catch (Exception e) {
                    System.err.println("Failed to refresh daily sales report for " + current + ": " + e.getMessage());
                }
                current = current.plusDays(1);
            }
        } catch (Exception e) {
            System.err.println("Failed to initialize stored procedure query: " + e.getMessage());
        }
    }

    @Transactional
    public Map<String, Object> getRevenueReport(LocalDate startDate, LocalDate endDate,
                                                 String groupBy) {
        refreshDailySalesReports(startDate, endDate);

        List<SalesReport> reports = salesReportRepository.findByReportDateBetween(
            java.sql.Date.valueOf(startDate), java.sql.Date.valueOf(endDate)
        );

        BigDecimal totalRevenue = reports.stream()
            .map(SalesReport::getNetRevenue)
            .filter(Objects::nonNull)
            .reduce(BigDecimal.ZERO, BigDecimal::add);

        Map<String, Object> report = new LinkedHashMap<>();
        report.put("startDate", startDate);
        report.put("endDate", endDate);
        report.put("totalRevenue", totalRevenue);
        report.put("groupBy", groupBy);

        List<Map<String, Object>> breakdown = new ArrayList<>();
        LocalDate current = startDate;
        while (!current.isAfter(endDate)) {
            LocalDate periodEnd;
            switch (groupBy != null ? groupBy.toUpperCase() : "DAY") {
                case "WEEK":
                    periodEnd = current.plusWeeks(1).minusDays(1);
                    break;
                case "MONTH":
                    periodEnd = current.plusMonths(1).minusDays(1);
                    break;
                case "YEAR":
                    periodEnd = current.plusYears(1).minusDays(1);
                    break;
                default:
                    periodEnd = current;
            }
            if (periodEnd.isAfter(endDate))
                periodEnd = endDate;

            final LocalDate pStart = current;
            final LocalDate pEnd = periodEnd;

            BigDecimal periodRevenue = reports.stream()
                .filter(r -> {
                    LocalDate rd = r.getReportDate().toLocalDate();
                    return !rd.isBefore(pStart) && !rd.isAfter(pEnd);
                })
                .map(SalesReport::getNetRevenue)
                .filter(Objects::nonNull)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

            Map<String, Object> period = new LinkedHashMap<>();
            period.put("startDate", current);
            period.put("endDate", periodEnd);
            period.put("revenue", periodRevenue);
            breakdown.add(period);

            current = periodEnd.plusDays(1);
        }
        report.put("breakdown", breakdown);

        return report;
    }

    @Transactional
    public Map<String, Object> getOccupancyReport(LocalDate startDate, LocalDate endDate) {
        refreshDailySalesReports(startDate, endDate);

        long totalRooms = roomRepository.count();
        Map<String, Object> report = new LinkedHashMap<>();
        report.put("totalRooms", totalRooms);

        List<SalesReport> reports = salesReportRepository.findByReportDateBetween(
            java.sql.Date.valueOf(startDate), java.sql.Date.valueOf(endDate)
        );

        List<Map<String, Object>> daily = new ArrayList<>();
        LocalDate current = startDate;
        while (!current.isAfter(endDate)) {
            final LocalDate dateCursor = current;
            Optional<SalesReport> matchedReport = reports.stream()
                .filter(r -> r.getReportDate().toLocalDate().equals(dateCursor))
                .findFirst();

            BigDecimal rate = matchedReport.map(SalesReport::getRoomOccupancyRate).orElse(BigDecimal.ZERO);
            long occupied = Math.round(rate.doubleValue() * totalRooms / 100.0);

            Map<String, Object> day = new LinkedHashMap<>();
            day.put("date", current);
            day.put("totalRooms", totalRooms);
            day.put("occupiedRooms", occupied);
            day.put("occupancyRate", rate.setScale(1, RoundingMode.HALF_UP));
            daily.add(day);

            current = current.plusDays(1);
        }
        report.put("daily", daily);

        return report;
    }

    @Transactional
    public Map<String, Object> getBookingTrends(LocalDate startDate, LocalDate endDate) {
        refreshDailySalesReports(startDate, endDate);

        List<SalesReport> reports = salesReportRepository.findByReportDateBetween(
            java.sql.Date.valueOf(startDate), java.sql.Date.valueOf(endDate)
        );

        List<Map<String, Object>> trends = new ArrayList<>();
        LocalDate current = startDate;
        while (!current.isAfter(endDate)) {
            final LocalDate dateCursor = current;
            Optional<SalesReport> matchedReport = reports.stream()
                .filter(r -> r.getReportDate().toLocalDate().equals(dateCursor))
                .findFirst();

            long count = matchedReport.map(r -> r.getTotalBookings().longValue()).orElse(0L);
            BigDecimal dayRevenue = matchedReport.map(SalesReport::getNetRevenue).orElse(BigDecimal.ZERO);

            Map<String, Object> day = new LinkedHashMap<>();
            day.put("date", current);
            day.put("bookingCount", count);
            day.put("revenue", dayRevenue);
            trends.add(day);

            current = current.plusDays(1);
        }

        return Map.of("trends", trends);
    }

    @Transactional
    public Map<String, Object> getDashboardOverview() {
        Map<String, Object> overview = new LinkedHashMap<>();
        LocalDate today = LocalDate.now();
        LocalDate monthStart = today.withDayOfMonth(1);
        LocalDate lastMonthStart = monthStart.minusMonths(1);
        LocalDate lastMonthEnd = monthStart.minusDays(1);

        refreshDailySalesReports(lastMonthStart, today);

        List<SalesReport> currentMonthReports = salesReportRepository.findByReportDateBetween(
            java.sql.Date.valueOf(monthStart), java.sql.Date.valueOf(today)
        );
        List<SalesReport> lastMonthReports = salesReportRepository.findByReportDateBetween(
            java.sql.Date.valueOf(lastMonthStart), java.sql.Date.valueOf(lastMonthEnd)
        );

        BigDecimal monthlyRevenue = currentMonthReports.stream()
            .map(SalesReport::getNetRevenue)
            .filter(Objects::nonNull)
            .reduce(BigDecimal.ZERO, BigDecimal::add);

        BigDecimal lastMonthRevenue = lastMonthReports.stream()
            .map(SalesReport::getNetRevenue)
            .filter(Objects::nonNull)
            .reduce(BigDecimal.ZERO, BigDecimal::add);

        long totalRooms = roomRepository.count();
        long totalCustomers = customerRepository.count();
        long totalBookings = bookingRepository.count();

        Optional<SalesReport> todayReport = salesReportRepository.findByReportDate(java.sql.Date.valueOf(today));
        BigDecimal rateValue = todayReport.map(SalesReport::getRoomOccupancyRate).orElse(BigDecimal.ZERO);
        double occupancyRate = rateValue.doubleValue();
        long occupiedRooms = Math.round(occupancyRate * totalRooms / 100.0);

        double revenueGrowth = 0;
        if (lastMonthRevenue.compareTo(BigDecimal.ZERO) > 0) {
            revenueGrowth = monthlyRevenue.subtract(lastMonthRevenue)
                    .divide(lastMonthRevenue, 4, RoundingMode.HALF_UP)
                    .multiply(BigDecimal.valueOf(100))
                    .doubleValue();
        }

        Long todayBookings = todayReport.map(r -> r.getTotalBookings().longValue()).orElse(0L);

        overview.put("totalRooms", totalRooms);
        overview.put("totalCustomers", totalCustomers);
        overview.put("totalBookings", totalBookings);
        overview.put("monthlyRevenue", monthlyRevenue);
        overview.put("totalRevenue", monthlyRevenue);
        overview.put("occupiedRooms", occupiedRooms);
        overview.put("availableRooms", totalRooms - occupiedRooms);
        overview.put("occupancyRate", BigDecimal.valueOf(occupancyRate).setScale(1, RoundingMode.HALF_UP));
        overview.put("revenueGrowth", revenueGrowth);
        overview.put("todayBookings", todayBookings);

        return overview;
    }

    @Transactional
    public List<Map<String, Object>> getMonthlyRevenue(int months) {
        List<Map<String, Object>> result = new ArrayList<>();
        YearMonth current = YearMonth.now();

        for (int i = months - 1; i >= 0; i--) {
            YearMonth month = current.minusMonths(i);
            LocalDate start = month.atDay(1);
            LocalDate end = month.atEndOfMonth();

            refreshDailySalesReports(start, end);

            List<SalesReport> reports = salesReportRepository.findByReportDateBetween(
                java.sql.Date.valueOf(start), java.sql.Date.valueOf(end)
            );

            BigDecimal revenue = reports.stream()
                .map(SalesReport::getNetRevenue)
                .filter(Objects::nonNull)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

            long bookingCount = reports.stream()
                .map(r -> r.getTotalBookings().longValue())
                .reduce(0L, Long::sum);

            Map<String, Object> monthData = new LinkedHashMap<>();
            monthData.put("month", month.getMonth().toString().substring(0, 3));
            monthData.put("year", month.getYear());
            monthData.put("revenue", revenue);
            monthData.put("bookings", bookingCount);
            result.add(monthData);
        }

        return result;
    }

    @Transactional(readOnly = true)
    public List<Map<String, Object>> getRecentBookings(int limit) {
        List<Map<String, Object>> result = new ArrayList<>();

        List<Booking> recentBookings = bookingRepository.findAll(
                PageRequest.of(0, limit, Sort.by(Sort.Direction.DESC, "createdAt"))).getContent();

        for (Booking booking : recentBookings) {
            Map<String, Object> item = new LinkedHashMap<>();
            item.put("id", booking.getId());
            item.put("customerName", booking.getCustomer() != null ? booking.getCustomer().getFullName() : "N/A");
            item.put("customerEmail", booking.getCustomer() != null ? booking.getCustomer().getEmail() : "N/A");
            item.put("roomNumber", booking.getRoom() != null ? booking.getRoom().getRoomNumber() : "N/A");
            item.put("checkInDate", booking.getCheckInDate());
            item.put("checkOutDate", booking.getCheckOutDate());
            item.put("totalPrice", booking.getTotalPrice());
            item.put("status", booking.getStatus() != null ? booking.getStatus().name() : "UNKNOWN");
            item.put("createdAt", booking.getCreatedAt());
            result.add(item);
        }

        return result;
    }

    @Transactional
    public Map<String, Object> getDetailedOccupancy(LocalDate date) {
        refreshDailySalesReports(date, date);

        Optional<SalesReport> reportOpt = salesReportRepository.findByReportDate(java.sql.Date.valueOf(date));
        long totalRooms = roomRepository.count();
        double occupancyRate = reportOpt.map(r -> r.getRoomOccupancyRate().doubleValue()).orElse(0.0);
        long occupiedRooms = Math.round(occupancyRate * totalRooms / 100.0);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("date", date);
        result.put("totalRooms", totalRooms);
        result.put("occupiedRooms", occupiedRooms);
        result.put("availableRooms", totalRooms - occupiedRooms);
        result.put("occupancyRate", BigDecimal.valueOf(occupancyRate).setScale(1, RoundingMode.HALF_UP));

        return result;
    }

    @Transactional
    public BigDecimal getTotalRevenue(LocalDate startDate, LocalDate endDate) {
        refreshDailySalesReports(startDate, endDate);

        List<SalesReport> reports = salesReportRepository.findByReportDateBetween(
            java.sql.Date.valueOf(startDate), java.sql.Date.valueOf(endDate)
        );

        BigDecimal revenue = reports.stream()
            .map(SalesReport::getNetRevenue)
            .filter(Objects::nonNull)
            .reduce(BigDecimal.ZERO, BigDecimal::add);

        return revenue;
    }

    @Transactional(readOnly = true)
    public List<Map<String, Object>> getRoomsByType() {
        List<Map<String, Object>> result = new ArrayList<>();
        List<Object[]> data = roomRepository.countRoomsByType();

        for (Object[] row : data) {
            Map<String, Object> item = new LinkedHashMap<>();
            item.put("roomType", row[0]);
            item.put("count", row[1]);
            result.add(item);
        }

        return result;
    }

    @Transactional(readOnly = true)
    public List<Map<String, Object>> getRoomsByStatus() {
        List<Map<String, Object>> result = new ArrayList<>();
        List<Object[]> data = roomRepository.countRoomsByStatus();

        for (Object[] row : data) {
            Map<String, Object> item = new LinkedHashMap<>();
            item.put("status", row[0].toString());
            item.put("count", row[1]);
            result.add(item);
        }

        return result;
    }

    @Transactional(readOnly = true)
    public List<Map<String, Object>> getBookingsByStatus() {
        List<Map<String, Object>> result = new ArrayList<>();
        List<Object[]> data = bookingRepository.countBookingsByStatus();

        for (Object[] row : data) {
            Map<String, Object> item = new LinkedHashMap<>();
            item.put("status", row[0].toString());
            item.put("count", row[1]);
            result.add(item);
        }

        return result;
    }

    @Transactional(readOnly = true)
    public List<Map<String, Object>> getRevenueByRoomType() {
        List<Map<String, Object>> result = new ArrayList<>();
        List<Object[]> data = bookingRepository.getRevenueByRoomType();

        for (Object[] row : data) {
            Map<String, Object> item = new LinkedHashMap<>();
            item.put("roomType", row[0]);
            item.put("bookingCount", row[1]);
            item.put("revenue", row[2]);
            result.add(item);
        }

        return result;
    }

    @Transactional(readOnly = true)
    public List<Map<String, Object>> getPopularRoomTypes(LocalDate startDate, LocalDate endDate) {
        List<Map<String, Object>> result = new ArrayList<>();
        List<Object[]> data = bookingRepository.getPopularRoomTypes(startDate, endDate);

        for (Object[] row : data) {
            Map<String, Object> item = new LinkedHashMap<>();
            item.put("roomType", row[0]);
            item.put("bookingCount", row[1]);
            result.add(item);
        }

        return result;
    }
}
