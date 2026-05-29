package dev.uit.project.repository;

import dev.uit.project.domain.Booking;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.sql.Date;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDate;

import java.util.List;
import java.util.Optional;

public interface BookingRepository extends JpaRepository<Booking, Long>, JpaSpecificationExecutor<Booking> {

        @Query("""
                SELECT CASE WHEN COUNT(b) > 0 THEN true ELSE false END
                FROM Booking b
                WHERE b.room.id = :roomId
                AND b.status IN ('PENDING', 'CONFIRMED', 'CHECKED_IN')
                AND (
                :checkIn < b.checkOutDate
                AND :checkOut > b.checkInDate
                )
        """)
        boolean existsOverlappingBooking(
                @Param("roomId") Long roomId,
                @Param("checkIn") LocalDate checkIn,
                @Param("checkOut") LocalDate checkOut
        );

        Page<Booking> findByStatus(Booking.BookingStatus status, Pageable pageable);

        List<Booking> findByCustomerId(Long customerId);

        Optional<Booking> findByIdAndCustomerEmail(Long bookingId, String email);

        Page<Booking> findByCustomerId(Long customerId, Pageable pageable);

        @Query("SELECT COALESCE(SUM(b.totalPrice), 0) FROM Booking b WHERE b.status != 'CANCELLED' " +
                        "AND b.checkOutDate BETWEEN :startDate AND :endDate")
        BigDecimal calculateRevenue(@Param("startDate") LocalDate startDate,
                        @Param("endDate") LocalDate endDate);

        @Query("SELECT COUNT(b) FROM Booking b WHERE b.customer.id = :customerId")
        Long countByCustomerId(@Param("customerId") Long customerId);

        @Query("SELECT COALESCE(SUM(b.totalPrice), 0) FROM Booking b WHERE b.customer.id = :customerId AND b.status = 'CHECKED_OUT'")
        BigDecimal totalSpentByCustomer(@Param("customerId") Long customerId);

        @Query("SELECT COUNT(b) FROM Booking b WHERE b.customer.id = :customerId AND b.status = 'CANCELLED'")
        Long countCancelledByCustomer(@Param("customerId") Long customerId);

        @Query("SELECT COUNT(b) FROM Booking b WHERE b.customer.id = :customerId AND b.status = 'CHECKED_OUT'")
        Long countCompletedByCustomer(@Param("customerId") Long customerId);

        @Query("SELECT COUNT(b) FROM Booking b WHERE b.status NOT IN ('CANCELLED', 'CHECKED_OUT') " +
                        "AND b.checkInDate <= :date AND b.checkOutDate > :date")
        Long countOccupiedRoomsOnDate(@Param("date") LocalDate date);

        @Query("SELECT COUNT(b) FROM Booking b WHERE b.createdAt >= CAST(:startDate AS timestamp) " +
                        "AND b.createdAt < CAST(:endDate AS timestamp)")
        Long countBookingsInPeriod(@Param("startDate") LocalDate startDate,
                        @Param("endDate") LocalDate endDate);

        @Query("SELECT b.status, COUNT(b) FROM Booking b GROUP BY b.status")
        List<Object[]> countBookingsByStatus();

        @Query("SELECT b.room.roomType.name, COUNT(b), COALESCE(SUM(b.totalPrice), 0) " +
                        "FROM Booking b WHERE b.status = 'CHECKED_OUT' GROUP BY b.room.roomType.name")
        List<Object[]> getRevenueByRoomType();

        @Query("SELECT COUNT(b) FROM Booking b WHERE b.status = :status")
        Long countByStatus(@Param("status") Booking.BookingStatus status);

        @Query("SELECT b.room.roomType.name, COUNT(b) FROM Booking b " +
                        "WHERE b.checkInDate >= :startDate AND b.checkInDate <= :endDate " +
                        "GROUP BY b.room.roomType.name ORDER BY COUNT(b) DESC")
        List<Object[]> getPopularRoomTypes(@Param("startDate") LocalDate startDate,
                        @Param("endDate") LocalDate endDate);

        @Transactional
        @Modifying
        @Procedure(procedureName = "update_booking_status")
        void updateBookingStatus(@Param("p_booking_id") Long bookingId, @Param("p_new_status") String newStatus);
}
