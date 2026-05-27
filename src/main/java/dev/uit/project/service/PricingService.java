package dev.uit.project.service;

import dev.uit.project.domain.Booking;
import dev.uit.project.domain.BookingPromotion;
import dev.uit.project.domain.DailyPrice;
import dev.uit.project.domain.Promotion;
import dev.uit.project.domain.RoomType;
import dev.uit.project.domain.SeasonalPrice;
import dev.uit.project.domain.dto.*;
import dev.uit.project.repository.*;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Comparator;
import java.util.List;

@Service
public class PricingService {

    @PersistenceContext
    private EntityManager entityManager;

    private final SeasonalPriceRepository seasonalPriceRepository;
    private final DailyPriceRepository dailyPriceRepository;
    private final PromotionRepository promotionRepository;
    private final RoomTypeRepository roomTypeRepository;
    private final BookingRepository bookingRepository;

    public PricingService(SeasonalPriceRepository seasonalPriceRepository, DailyPriceRepository dailyPriceRepository,
            PromotionRepository promotionRepository, RoomTypeRepository roomTypeRepository,
            BookingRepository bookingRepository) {
        this.seasonalPriceRepository = seasonalPriceRepository;
        this.dailyPriceRepository = dailyPriceRepository;
        this.promotionRepository = promotionRepository;
        this.roomTypeRepository = roomTypeRepository;
        this.bookingRepository = bookingRepository;
    }

    // Seasonal Pricing
    @Transactional(readOnly = true)
    public List<SeasonalPriceDTO> getAllSeasonalPrices(Long roomTypeId) {
        if (roomTypeId != null) {
            return seasonalPriceRepository.findByRoomTypeIdOrderByPriorityDesc(roomTypeId)
                    .stream().map(SeasonalPriceDTO::fromEntity).toList();
        }
        return seasonalPriceRepository.findAll()
                .stream().map(SeasonalPriceDTO::fromEntity).toList();
    }

    @Transactional
    public SeasonalPriceDTO createSeasonalPrice(Long roomTypeId, String name,
            LocalDate startDate, LocalDate endDate,
            BigDecimal priceMultiplier, Integer priority) {
        RoomType roomType = roomTypeRepository.findById(roomTypeId)
                .orElseThrow(() -> new RuntimeException("Room type not found"));

        SeasonalPrice sp = new SeasonalPrice();
        sp.setRoomType(roomType);
        sp.setName(name);
        sp.setStartDate(startDate);
        sp.setEndDate(endDate);
        sp.setPriceMultiplier(priceMultiplier);
        sp.setPriority(priority != null ? priority : 0);

        return SeasonalPriceDTO.fromEntity(seasonalPriceRepository.save(sp));
    }

    @Transactional
    public void deleteSeasonalPrice(Long id) {
        seasonalPriceRepository.deleteById(id);
    }

    @Transactional
    public SeasonalPriceDTO updateSeasonalPrice(Long id, Long roomTypeId, String name,
            LocalDate startDate, LocalDate endDate,
            BigDecimal priceMultiplier, Integer priority) {
        SeasonalPrice sp = seasonalPriceRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Seasonal price not found with id: " + id));
        RoomType roomType = roomTypeRepository.findById(roomTypeId)
                .orElseThrow(() -> new RuntimeException("Room type not found"));
        sp.setRoomType(roomType);
        sp.setName(name);
        sp.setStartDate(startDate);
        sp.setEndDate(endDate);
        sp.setPriceMultiplier(priceMultiplier);
        sp.setPriority(priority != null ? priority : 0);
        return SeasonalPriceDTO.fromEntity(seasonalPriceRepository.save(sp));
    }

    @Transactional(readOnly = true)
    public List<DailyPriceDTO> getDailyPrices(Long roomTypeId, LocalDate startDate, LocalDate endDate) {
        // TH1: Tìm price theo roomTypeId
        if (roomTypeId != null) {
            // TH1.1: Tìm tất cả price theo phạm vi
            if (startDate != null && endDate != null) {
                return dailyPriceRepository.findByRoomTypeIdAndDateBetween(roomTypeId, startDate, endDate)
                        .stream().map(DailyPriceDTO::fromEntity).toList();
            }
            // TH1.2: Tìm tất cả price hiện có
            return dailyPriceRepository.findAll().stream()
                    .filter(dp -> dp.getRoomType().getId().equals(roomTypeId))
                    .map(DailyPriceDTO::fromEntity).toList();
        }

        // TH2: Tìm tất cả price
        // TH2.1: Tìm tất cả price theo phạm vi
        if (startDate != null && endDate != null) {
            return dailyPriceRepository.findAll().stream()
                    .filter(dp -> !dp.getDate().isBefore(startDate) && !dp.getDate().isAfter(endDate))
                    .map(DailyPriceDTO::fromEntity).toList();
        }

        // TH2.2: Tìm tất cả price hiện có
        return dailyPriceRepository.findAll().stream().map(DailyPriceDTO::fromEntity).toList();
    }

    @Transactional(readOnly = true)
    public List<SeasonalPriceDTO> getSeasonalPrices(Long roomTypeId, LocalDate startDate, LocalDate endDate) {
        // TH1: Tìm price theo roomTypeId
        if (roomTypeId != null) {
            // TH1.1: Tìm tất cả price theo phạm vi
            if (startDate != null && endDate != null) {
                return seasonalPriceRepository
                        .findByRoomTypeIdAndStartDateLessThanEqualAndEndDateGreaterThanEqual(roomTypeId, endDate,
                                startDate)
                        .stream().map(SeasonalPriceDTO::fromEntity).toList();
            }
            // TH1.2: Tìm tất cả price hiện có
            return seasonalPriceRepository.findAll().stream()
                    .filter(sp -> sp.getRoomType().getId().equals(roomTypeId))
                    .map(SeasonalPriceDTO::fromEntity)
                    .toList();
        }

        // TH2: Tìm tất cả price
        // TH2.1: Tìm tất cả price theo phạm vi
        if (startDate != null && endDate != null) {
            return seasonalPriceRepository.findAll().stream()
                    .filter(sp -> !sp.getStartDate().isAfter(endDate) &&
                            !sp.getEndDate().isBefore(startDate))
                    .map(SeasonalPriceDTO::fromEntity)
                    .toList();
        }

        // TH2.2: Tìm tất cả price hiện có
        return seasonalPriceRepository.findAll().stream()
                .map(SeasonalPriceDTO::fromEntity)
                .toList();
    }

    @Transactional(readOnly = true)
    public BigDecimal getDailyPrice(Long roomTypeId, LocalDate date) {
        return dailyPriceRepository
                .findByRoomTypeIdAndDate(roomTypeId, date)
                .map(dp -> dp.getPrice())
                .orElse(null);
    }

    @Transactional(readOnly = true)
    public BigDecimal getSeasonalMultiplier(Long roomTypeId, LocalDate date) {
        return seasonalPriceRepository
                .findByRoomTypeIdAndStartDateLessThanEqualAndEndDateGreaterThanEqual(roomTypeId, date, date)
                .stream()
                .max(Comparator.comparing(SeasonalPrice::getPriority))
                .map(SeasonalPrice::getPriceMultiplier)
                .orElse(null);
    }

    @Transactional
    public DailyPriceDTO setDailyPrice(Long roomTypeId, LocalDate date, BigDecimal price, String reason) {
        RoomType roomType = roomTypeRepository.findById(roomTypeId)
                .orElseThrow(() -> new RuntimeException("Room type not found"));

        DailyPrice dp = dailyPriceRepository.findByRoomTypeIdAndDate(roomTypeId, date)
                .orElse(new DailyPrice());

        dp.setRoomType(roomType);
        dp.setDate(date);
        dp.setPrice(price);
        dp.setReason(reason);

        return DailyPriceDTO.fromEntity(dailyPriceRepository.save(dp));
    }

    @Transactional
    public DailyPriceDTO updateDailyPrice(Long id, Long roomTypeId, LocalDate date, BigDecimal price, String reason) {
        DailyPrice dp = dailyPriceRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Daily price not found with id: " + id));
        RoomType roomType = roomTypeRepository.findById(roomTypeId)
                .orElseThrow(() -> new RuntimeException("Room type not found"));
        dp.setRoomType(roomType);
        dp.setDate(date);
        dp.setPrice(price);
        dp.setReason(reason);
        return DailyPriceDTO.fromEntity(dailyPriceRepository.save(dp));
    }

    @Transactional
    public void deleteDailyPrice(Long id) {
        if (!dailyPriceRepository.existsById(id)) {
            throw new RuntimeException("Daily price not found with id: " + id);
        }
        dailyPriceRepository.deleteById(id);
    }

    // Promotions
    @Transactional(readOnly = true)
    public List<PromotionDTO> getAllPromotions() {
        return promotionRepository.findAll().stream().map(PromotionDTO::fromEntity).toList();
    }

    @Transactional
    public PromotionDTO createPromotion(CreatePromotionRequest request) {
        if (promotionRepository.existsByCode(request.getCode())) {
            throw new RuntimeException("Promotion code already exists: " + request.getCode());
        }

        Promotion promotion = new Promotion();
        promotion.setCode(request.getCode().toUpperCase());
        promotion.setDescription(request.getDescription());
        promotion.setDiscountType(request.getDiscountType());
        promotion.setDiscountValue(request.getDiscountValue());
        promotion.setStartDate(request.getStartDate());
        promotion.setEndDate(request.getEndDate());
        promotion.setMinNights(request.getMinNights());
        promotion.setMaxUses(request.getMaxUses());
        promotion.setUsedCount(0);

        return PromotionDTO.fromEntity(promotionRepository.save(promotion));
    }

    @Transactional
    public PromotionDTO togglePromotion(Long id) {
        Promotion promotion = promotionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Promotion not found with id: " + id));
        return PromotionDTO.fromEntity(promotionRepository.save(promotion));
    }

    @Transactional(readOnly = true)
    public List<PromotionDTO> getActivePromotions() {
        LocalDate today = LocalDate.now();
        return promotionRepository.findAll().stream()
                .filter(p -> !p.getStartDate().isAfter(today) && !p.getEndDate().isBefore(today)
                        && (p.getMaxUses() == null || p.getUsedCount() < p.getMaxUses()))
                .map(PromotionDTO::fromEntity)
                .toList();
    }

    @Transactional
    public PromotionDTO updatePromotion(Long id, CreatePromotionRequest request) {
        Promotion promotion = promotionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Promotion not found with id: " + id));

        if (!promotion.getCode().equalsIgnoreCase(request.getCode())
                && promotionRepository.existsByCode(request.getCode())) {
            throw new RuntimeException("Promotion code already exists: " + request.getCode());
        }

        promotion.setCode(request.getCode().toUpperCase());
        promotion.setDescription(request.getDescription());
        promotion.setDiscountType(request.getDiscountType());
        promotion.setDiscountValue(request.getDiscountValue());
        promotion.setStartDate(request.getStartDate());
        promotion.setEndDate(request.getEndDate());
        promotion.setMinNights(request.getMinNights());
        promotion.setMaxUses(request.getMaxUses());

        return PromotionDTO.fromEntity(promotionRepository.save(promotion));
    }

    @Transactional
    public void deletePromotion(Long id) {
        if (!promotionRepository.existsById(id)) {
            throw new RuntimeException("Promotion not found with id: " + id);
        }
        try {
            promotionRepository.deleteById(id);
            promotionRepository.flush();
        } catch (Exception e) {
            throw new RuntimeException("Không thể xóa khuyến mãi vì đã được sử dụng trong đặt phòng.");
        }
    }

    @Transactional(readOnly = true)
    public BigDecimal getRawPrice(Long roomTypeId, LocalDate checkInDate, LocalDate checkOutDate) {
        Query query = entityManager.createNativeQuery(
                "SELECT hotel.fn_calculate_room_price(:roomTypeId, :checkInDate, :checkOutDate) FROM DUAL");
        query.setParameter("roomTypeId", roomTypeId);
        query.setParameter("checkInDate", java.sql.Date.valueOf(checkInDate));
        query.setParameter("checkOutDate", java.sql.Date.valueOf(checkOutDate));

        Object result = query.getSingleResult();
        if (result == null) {
            return BigDecimal.ZERO;
        }
        return (BigDecimal) result;
    }

    @Transactional(readOnly = true)
    public BigDecimal getDiscountAmount(Long bookingId) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new IllegalArgumentException("Booking not found"));

        List<Promotion> bookingPromotions = booking.getPromotions();
        if (bookingPromotions.isEmpty()) {
            return BigDecimal.ZERO;
        }

        long numNights = ChronoUnit.DAYS.between(booking.getCheckInDate(), booking.getCheckOutDate());
        BigDecimal totalDiscount = BigDecimal.ZERO;

        for (Promotion promo : bookingPromotions) {
            Query query = entityManager.createNativeQuery(
                    "SELECT hotel.fn_calculate_promotion_discount(:rawPrice, :promoCode, :numNights) FROM DUAL");
            query.setParameter("rawPrice", booking.getRawPrice());
            query.setParameter("promoCode", promo.getCode());
            query.setParameter("numNights", numNights);

            BigDecimal discount = (BigDecimal) query.getSingleResult();
            if (discount != null) {
                totalDiscount = totalDiscount.add(discount);
            }
        }

        return totalDiscount;
    }
}
