package dev.uit.project.repository;

import dev.uit.project.domain.Policy;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PolicyRepository extends JpaRepository<Policy, Long> {
    List<Policy> findByType(Policy.PolicyType type);
}
