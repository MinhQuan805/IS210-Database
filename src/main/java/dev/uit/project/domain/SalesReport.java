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
}
