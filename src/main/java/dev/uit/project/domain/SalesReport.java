package dev.uit.project.domain;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.math.BigDecimal;

@Entity
@Table(name = "sales_reports")
public class SalesReport {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sales_reports_seq")
    @SequenceGenerator(name = "sales_reports_seq", sequenceName = "SALES_REPORTS_SEQ", allocationSize = 1)
    private Long id;

    @Column(name = "report_date", nullable = false, unique = true)
    private java.sql.Date reportDate;

    @Column(name = "total_bookings")
    private Integer totalBookings = 0;

    @Column(name = "gross_revenue", precision = 15, scale = 2)
    private BigDecimal grossRevenue = BigDecimal.ZERO;

    @Column(name = "discount_amount", precision = 15, scale = 2)
    private BigDecimal discountAmount = BigDecimal.ZERO;

    @Column(name = "net_revenue", nullable = false, precision = 15, scale = 2)
    private BigDecimal netRevenue;

    @Column(name = "room_occupancy_rate", precision = 5, scale = 2)
    private BigDecimal roomOccupancyRate;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public java.sql.Date getReportDate() {
        return reportDate;
    }

    public void setReportDate(java.sql.Date reportDate) {
        this.reportDate = reportDate;
    }

    public Integer getTotalBookings() {
        return totalBookings;
    }

    public void setTotalBookings(Integer totalBookings) {
        this.totalBookings = totalBookings;
    }

    public BigDecimal getGrossRevenue() {
        return grossRevenue;
    }

    public void setGrossRevenue(BigDecimal grossRevenue) {
        this.grossRevenue = grossRevenue;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getNetRevenue() {
        return netRevenue;
    }

    public void setNetRevenue(BigDecimal netRevenue) {
        this.netRevenue = netRevenue;
    }

    public BigDecimal getRoomOccupancyRate() {
        return roomOccupancyRate;
    }

    public void setRoomOccupancyRate(BigDecimal roomOccupancyRate) {
        this.roomOccupancyRate = roomOccupancyRate;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
