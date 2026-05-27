package dev.uit.project.repository;

import dev.uit.project.domain.SalesReport;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

public interface SalesReportRepository extends JpaRepository<SalesReport, Long> {

    @Query("SELECT r FROM SalesReport r WHERE r.reportDate BETWEEN :startDate AND :endDate ORDER BY r.reportDate ASC")
    List<SalesReport> findByReportDateBetween(
        @Param("startDate") Date startDate,
        @Param("endDate") Date endDate
    );

    Optional<SalesReport> findByReportDate(Date reportDate);
}
