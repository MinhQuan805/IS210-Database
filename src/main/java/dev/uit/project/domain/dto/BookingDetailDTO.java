package dev.uit.project.domain.dto;

import java.util.List;

import dev.uit.project.domain.Amenity;
import dev.uit.project.domain.Booking;
import dev.uit.project.domain.BookingHistory;
import dev.uit.project.domain.Policy;
import dev.uit.project.domain.Promotion;
import dev.uit.project.domain.RoomType;

public class BookingDetailDTO {
    private Booking booking;
    private List<BookingHistory> histories;
    private List<Policy> policies;
    private List<Promotion> promotions;
    private RoomType roomType;
    
    public BookingDetailDTO() {
    }

    public BookingDetailDTO(Booking booking, List<BookingHistory> histories, List<Policy> policies,
            List<Promotion> promotions, RoomType roomType) {
        this.booking = booking;
        this.histories = histories;
        this.policies = policies;
        this.promotions = promotions;
        this.roomType = roomType;
    }

    public Booking getBooking() {
        return booking;
    }

    public void setBooking(Booking booking) {
        this.booking = booking;
    }

    public List<BookingHistory> getHistories() {
        return histories;
    }

    public void setHistories(List<BookingHistory> histories) {
        this.histories = histories;
    }

    public List<Policy> getPolicies() {
        return policies;
    }

    public void setPolicies(List<Policy> policies) {
        this.policies = policies;
    }

    public List<Promotion> getPromotions() {
        return promotions;
    }

    public void setPromotions(List<Promotion> promotions) {
        this.promotions = promotions;
    }

    public RoomType getRoomType() {
        return roomType;
    }

    public void setRoomType(RoomType roomType) {
        this.roomType = roomType;
    }
}
