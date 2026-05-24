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

    public BookingPolicyId() {}

    public BookingPolicyId(Long bookingId, Long policyId) {
        this.bookingId = bookingId;
        this.policyId = policyId;
    }

    public Long getBookingId() {
        return bookingId;
    }

    public void setBookingId(Long bookingId) {
        this.bookingId = bookingId;
    }

    public Long getPolicyId() {
        return policyId;
    }

    public void setPolicyId(Long policyId) {
        this.policyId = policyId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        BookingPolicyId that = (BookingPolicyId) o;
        return java.util.Objects.equals(bookingId, that.bookingId) &&
               java.util.Objects.equals(policyId, that.policyId);
    }

    @Override
    public int hashCode() {
        return java.util.Objects.hash(bookingId, policyId);
    }
}