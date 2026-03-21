package dev.uit.project.repository;

import dev.uit.project.domain.BookingHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BookingHistoryRepository extends JpaRepository<BookingHistory, Long> {
    List<BookingHistory> findByBookingIdOrderByTimestampDesc(Long bookingId);

    @Query("""
        SELECT h FROM BookingHistory h
        WHERE h.booking.id = :bookingId
        ORDER BY h.timestamp DESC
    """)
    List<BookingHistory> findByBookingId(@Param("bookingId") Long bookingId);
}
