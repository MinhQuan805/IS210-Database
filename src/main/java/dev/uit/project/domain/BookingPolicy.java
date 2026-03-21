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
}
