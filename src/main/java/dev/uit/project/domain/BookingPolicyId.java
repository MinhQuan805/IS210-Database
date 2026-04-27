package dev.uit.project.domain;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

@Embeddable
public class BookingPolicyId implements Serializable {

    @Column(name = "booking_id") // thêm cho rõ ràng
    private Long bookingId;

    @Column(name = "policy_id")
    private Long policyId;

    public BookingPolicyId(Long bookingId, Long policyId) {
        this.bookingId = bookingId;
        this.policyId = policyId;
    }
}