package dev.uit.project.repository;

import dev.uit.project.domain.RoomType;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface RoomTypeRepository extends JpaRepository<RoomType, Long> {
     @Query("""
        SELECT DISTINCT rt FROM RoomType rt
        LEFT JOIN FETCH rt.amenities
        WHERE rt.id = :roomTypeId
    """)
    Optional<RoomType> findWithAmenities(@Param("roomTypeId") Long roomTypeId);
}
