package dev.uit.project.domain;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;



import java.time.LocalDateTime;

@Entity
@Table(name = "booking_history")
public class BookingHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "booking_history_seq")
    @SequenceGenerator(name = "booking_history_seq", sequenceName = "BOOKING_HISTORY_SEQ", allocationSize = 1)
    private Long id;

    @com.fasterxml.jackson.annotation.JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "booking_id", nullable = false)
    private Booking booking;

    @Column(nullable = false, length = 50)
    @Enumerated(EnumType.STRING)
    private BookingAction action;

    @Column(name = "performed_by", length = 100)
    @Enumerated(EnumType.STRING)
    private BookingActor performedBy;

    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime timestamp;

    @Column(length = 500)
    private String notes;

    public enum BookingAction {
        CREATED,
        CONFIRMED,
        CANCELLED,
        UPDATED
    }

    public enum BookingActor {
        SYSTEM,
        ADMIN,
        CUSTOMER
    }


    public BookingHistory() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Booking getBooking() {
        return booking;
    }

    public void setBooking(Booking booking) {
        this.booking = booking;
    }

    public BookingAction getAction() {
        return action;
    }

    public void setAction(BookingAction action) {
        this.action = action;
    }

    public BookingActor getPerformedBy() {
        return performedBy;
    }

    public void setPerformedBy(BookingActor performedBy) {
        this.performedBy = performedBy;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
