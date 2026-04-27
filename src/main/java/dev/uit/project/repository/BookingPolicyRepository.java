package dev.uit.project.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import dev.uit.project.domain.BookingPolicy;
import dev.uit.project.domain.BookingPolicyId;

public interface BookingPolicyRepository extends JpaRepository<BookingPolicy, BookingPolicyId> {
    
}
