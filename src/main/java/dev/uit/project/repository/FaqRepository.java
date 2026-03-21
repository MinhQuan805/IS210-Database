package dev.uit.project.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import dev.uit.project.domain.Faq;

public interface FaqRepository extends JpaRepository<Faq, Long> {
}
