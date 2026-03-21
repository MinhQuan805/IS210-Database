package dev.uit.project.repository;

import dev.uit.project.domain.Policy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface PolicyRepository extends JpaRepository<Policy, Long> {
    List<Policy> findByType(Policy.PolicyType type);
    
    @Query("""
    SELECT p FROM Policy p
        WHERE p.type = :type
        AND EXISTS (
            SELECT 1 FROM BookingPolicy bp
            WHERE bp.policy = p
        )
    """)
    Optional<Policy> findActiveByType(@Param("type") Policy.PolicyType type);

    @Query(value = """
        SELECT p.* FROM booking_policies bp
        JOIN policies p ON bp.policy_id = p.id
        WHERE bp.booking_id = :bookingId
    """, nativeQuery = true)
    List<Policy> findByBookingId(@Param("bookingId") Long bookingId);
}
