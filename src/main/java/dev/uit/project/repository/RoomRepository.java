package dev.uit.project.repository;

import dev.uit.project.domain.Room;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface RoomRepository extends JpaRepository<Room, Long>, JpaSpecificationExecutor<Room> {

    List<Room> findByRoomTypeId(Long roomTypeId);

    List<Room> findByStatus(Room.RoomStatus status);

    List<Room> findByFloor(Integer floor);
    
    @Query("""
        SELECT r FROM Room r
        JOIN r.roomType rt
        WHERE rt.capacity >= :capacity
          AND r.status <> 'MAINTENANCE'
          AND NOT EXISTS (
              SELECT b FROM Booking b
              WHERE b.room = r
                AND b.status <> 'CANCELLED'
                AND NOT (
                    :checkOut <= b.checkInDate OR
                    :checkIn >= b.checkOutDate
                )
          )
    """)
    List<Room> findAvailableRooms(
        @Param("checkIn") LocalDate checkIn,
        @Param("checkOut") LocalDate checkOut,
        @Param("capacity") int capacity
    );

    @Query("SELECT r.roomType.name, COUNT(r) FROM Room r GROUP BY r.roomType.name")
    List<Object[]> countRoomsByType();

    @Query("SELECT r.status, COUNT(r) FROM Room r GROUP BY r.status")
    List<Object[]> countRoomsByStatus();

    @Query("SELECT COUNT(r) FROM Room r WHERE r.status = :status")
    Long countByStatus(@Param("status") Room.RoomStatus status);
}
