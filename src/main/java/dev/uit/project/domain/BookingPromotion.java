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

    public BookingPromotion(BookingPromotionId id, Booking booking, Promotion promotion) {
        this.id = id;
        this.booking = booking;
        this.promotion = promotion;
    }

    public BookingPromotionId getId() {
        return id;
    }

    public void setId(BookingPromotionId id) {
        this.id = id;
    }

    public Booking getBooking() {
        return booking;
    }

    public void setBooking(Booking booking) {
        this.booking = booking;
    }

    public Promotion getPromotion() {
        return promotion;
    }

    public void setPromotion(Promotion promotion) {
        this.promotion = promotion;
    }

    
}
