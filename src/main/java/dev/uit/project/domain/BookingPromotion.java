package dev.uit.project.domain;

import jakarta.persistence.*;

@Entity
@Table(name = "booking_promotions")
public class BookingPromotion {
    // @Id
    // @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "booking_promotion_seq")
    // @SequenceGenerator(name = "booking_promotion_seq", sequenceName = "BOOKING_PROMOTION_SEQ", allocationSize = 1)
    // private Long id;

    @EmbeddedId
    private BookingPromotionId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("bookingId")
    @JoinColumn(name = "booking_id", nullable = false)
    private Booking booking;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("promotionId")
    @JoinColumn(name = "promotion_id", nullable = false)
    private Promotion promotion;
}
