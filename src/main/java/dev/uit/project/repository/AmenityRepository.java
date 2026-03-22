package dev.uit.project.repository;

import dev.uit.project.domain.Amenity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AmenityRepository extends JpaRepository<Amenity, Long> {
    List<Amenity> findByCategory(String category);

    @Query("""
        SELECT a
        FROM Booking b
        JOIN b.room r
        JOIN r.roomType rt
        JOIN rt.amenities a
        WHERE b.id = :bookingId
    """)
    List<Amenity> findByBookingId(@Param("bookingId") Long bookingId);
}
