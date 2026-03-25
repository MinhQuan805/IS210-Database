package dev.uit.project.repository;

import dev.uit.project.domain.RoomType;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface RoomTypeRepository extends JpaRepository<RoomType, Long> {
    @Query("""
        SELECT r.roomType
        FROM Booking b
        JOIN b.room r
        WHERE b.id = :bookingId
    """)
    Optional<RoomType> findByBookingId(@Param("bookingId") Long bookingId);

    @Query("""
        SELECT rt FROM RoomType rt
        LEFT JOIN FETCH rt.amenities
        WHERE rt.id = :id
    """)
    Optional<RoomType> findByIdWithAmenities(Long id);
}
