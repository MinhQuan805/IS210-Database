package dev.uit.project.domain.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import dev.uit.project.domain.Booking.BookingStatus;

public class BookingDetailDTO {
    private Long id;
    @JsonFormat(pattern = "dd-MM-yyyy")
    private LocalDate checkInDate;
    @JsonFormat(pattern = "dd-MM-yyyy")
    private LocalDate checkOutDate;
    private BigDecimal totalPrice;
    private BigDecimal rawPrice;
    private BigDecimal discountAmount;
    private BookingStatus status;
    private String specialRequests;
    private String roomNumber;
    private Integer floor;
    private List<PaymentDTO> payments;
    private List<BookingHistoryDTO> history;
    private List<PromotionDTO> promotions;
    private List<PolicyDTO> policies;
    private List<AmenityDTO> amenities;
    
    public BookingDetailDTO() {
    }

    public BookingDetailDTO(Long id, LocalDate checkInDate, LocalDate checkOutDate, BigDecimal totalPrice,
            BigDecimal rawPrice, BigDecimal discountAmount, BookingStatus status, String specialRequests,
            String roomNumber, Integer floor, List<PaymentDTO> payments, List<BookingHistoryDTO> history,
            List<PromotionDTO> promotions, List<PolicyDTO> policies, List<AmenityDTO> amenities) {
        this.id = id;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.totalPrice = totalPrice;
        this.rawPrice = rawPrice;
        this.discountAmount = discountAmount;
        this.status = status;
        this.specialRequests = specialRequests;
        this.roomNumber = roomNumber;
        this.floor = floor;
        this.payments = payments;
        this.history = history;
        this.promotions = promotions;
        this.policies = policies;
        this.amenities = amenities;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDate getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(LocalDate checkInDate) {
        this.checkInDate = checkInDate;
    }

    public LocalDate getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(LocalDate checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public BigDecimal getRawPrice() {
        return rawPrice;
    }

    public void setRawPrice(BigDecimal rawPrice) {
        this.rawPrice = rawPrice;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BookingStatus getStatus() {
        return status;
    }

    public void setStatus(BookingStatus status) {
        this.status = status;
    }

    public String getSpecialRequests() {
        return specialRequests;
    }

    public void setSpecialRequests(String specialRequests) {
        this.specialRequests = specialRequests;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public Integer getFloor() {
        return floor;
    }

    public void setFloor(Integer floor) {
        this.floor = floor;
    }

    public List<PaymentDTO> getPayments() {
        return payments;
    }

    public void setPayments(List<PaymentDTO> payments) {
        this.payments = payments;
    }

    public List<BookingHistoryDTO> getHistory() {
        return history;
    }

    public void setHistory(List<BookingHistoryDTO> history) {
        this.history = history;
    }

    public List<PromotionDTO> getPromotions() {
        return promotions;
    }

    public void setPromotions(List<PromotionDTO> promotions) {
        this.promotions = promotions;
    }

    public List<PolicyDTO> getPolicies() {
        return policies;
    }

    public void setPolicies(List<PolicyDTO> policies) {
        this.policies = policies;
    }

    public List<AmenityDTO> getAmenities() {
        return amenities;
    }

    public void setAmenities(List<AmenityDTO> amenities) {
        this.amenities = amenities;
    }

    
}
