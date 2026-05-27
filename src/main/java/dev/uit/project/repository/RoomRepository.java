package dev.uit.project.repository;

import dev.uit.project.domain.Room;
import jakarta.persistence.LockModeType;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface RoomRepository extends JpaRepository<Room, Long>, JpaSpecificationExecutor<Room> {

        @Lock(LockModeType.PESSIMISTIC_WRITE)
        @Query("""
        SELECT r
        FROM Room r
        WHERE r.id = :id
        """)
    Room findByIdForUpdate(@Param("id") Long id);

    List<Room> findByRoomTypeId(Long roomTypeId);

    List<Room> findByStatus(Room.RoomStatus status);

    List<Room> findByFloor(Integer floor);

    @Query(value = "SELECT * FROM rooms r WHERE hotel.fn_check_room_availability(r.id, :checkInDate, :checkOutDate, NULL) = 1", nativeQuery = true)
    List<Room> findAvailableRooms(@Param("checkInDate") LocalDate checkInDate,
                                  @Param("checkOutDate") LocalDate checkOutDate);
    
    @Query(value = """
        SELECT r.* 
        FROM rooms r
        JOIN room_types rt ON r.room_type_id = rt.id
        WHERE rt.capacity >= :capacity
        AND hotel.fn_check_room_availability(r.id, :checkInDate, :checkOutDate, NULL) = 1
    """, nativeQuery = true)
    List<Room> findAvailableRooms(
            @Param("checkInDate") LocalDate checkInDate,
            @Param("checkOutDate") LocalDate checkOutDate,
            @Param("capacity") int capacity
    );

    @Query("SELECT r.roomType.name, COUNT(r) FROM Room r GROUP BY r.roomType.name")
    List<Object[]> countRoomsByType();

    @Query("SELECT r.status, COUNT(r) FROM Room r GROUP BY r.status")
    List<Object[]> countRoomsByStatus();

    @Query("SELECT COUNT(r) FROM Room r WHERE r.status = :status")
    Long countByStatus(@Param("status") Room.RoomStatus status);
}
