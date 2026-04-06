package dev.uit.project.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import dev.uit.project.domain.Payment;

public interface PaymentRepository extends JpaRepository<Payment, Long> {

} 
