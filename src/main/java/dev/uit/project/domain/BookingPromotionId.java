package dev.uit.project.domain;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

@Embeddable
public class BookingPromotionId implements Serializable {

    @Column(name = "booking_id") // thêm cho rõ ràng
    private Long bookingId;

    @Column(name = "promotion_id")
    private Long promotionId;

    // equals + hashCode (BẮT BUỘC)
}