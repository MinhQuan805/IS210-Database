package dev.uit.project.repository;

import dev.uit.project.domain.Promotion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface PromotionRepository extends JpaRepository<Promotion, Long> {
    Optional<Promotion> findByCode(String code);
    boolean existsByCode(String code);

    @Query(value = """
        SELECT p.* FROM booking_promotions bp
        JOIN promotions p ON bp.promotion_id = p.id
        WHERE bp.booking_id = :bookingId
    """, nativeQuery = true)
    List<Promotion> findByBookingId(@Param("bookingId") Long bookingId);
}
