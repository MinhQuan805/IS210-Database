package dev.uit.project.domain;

import jakarta.persistence.*;

@Entity
@Table(name = "booking_policies")
public class BookingPolicy {

    @EmbeddedId
    private BookingPolicyId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("bookingId")
    @JoinColumn(name = "booking_id")
    private Booking booking;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("policyId")
    @JoinColumn(name = "policy_id")
    private Policy policy;

    public BookingPolicy(BookingPolicyId id, Booking booking, Policy policy) {
        this.id = id;
        this.booking = booking;
        this.policy = policy;
    }

    public BookingPolicyId getId() {
        return id;
    }

    public void setId(BookingPolicyId id) {
        this.id = id;
    }

    public Booking getBooking() {
        return booking;
    }

    public void setBooking(Booking booking) {
        this.booking = booking;
    }

    public Policy getPolicy() {
        return policy;
    }

    public void setPolicy(Policy policy) {
        this.policy = policy;
    }

    
}
