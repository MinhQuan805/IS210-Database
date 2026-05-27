package dev.uit.project.domain;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

@Embeddable
public class BookingPromotionId implements Serializable {

    @Column(name = "booking_id")
    private Long bookingId;

    @Column(name = "promotion_id")
    private Long promotionId;

    public BookingPromotionId() {
    }

    public BookingPromotionId(Long bookingId, Long promotionId) {
        this.bookingId = bookingId;
        this.promotionId = promotionId;
    }

    public Long getBookingId() {
        return bookingId;
    }

    public void setBookingId(Long bookingId) {
        this.bookingId = bookingId;
    }

    public Long getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(Long promotionId) {
        this.promotionId = promotionId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;
        BookingPromotionId that = (BookingPromotionId) o;
        return java.util.Objects.equals(bookingId, that.bookingId) &&
                java.util.Objects.equals(promotionId, that.promotionId);
    }

    @Override
    public int hashCode() {
        return java.util.Objects.hash(bookingId, promotionId);
    }
}