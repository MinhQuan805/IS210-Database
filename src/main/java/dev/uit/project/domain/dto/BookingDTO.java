package dev.uit.project.domain.dto;

import dev.uit.project.domain.Booking;
import dev.uit.project.domain.BookingHistory;
import dev.uit.project.domain.Payment;
import dev.uit.project.domain.Policy;
import dev.uit.project.domain.Promotion;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

public class BookingDTO {
    private Long id;
    private Long customerId;
    private String customerName;
    private String customerEmail;
    private Long roomId;
    private String roomNumber;
    private String roomTypeName;
    @JsonFormat(pattern = "dd-MM-yyyy")
    private LocalDate checkInDate;
    @JsonFormat(pattern = "dd-MM-yyyy")
    private LocalDate checkOutDate;
    private BigDecimal totalPrice;
    private BigDecimal rawPrice;
    private BigDecimal discountAmount;
    private Booking.BookingStatus status;
    private String specialRequests;
    private List<Payment> payments;
    private List<BookingHistory> history;
    private List<Policy> policies;
    private List<Promotion> promotions;
    @JsonFormat(pattern = "dd-MM-yyyy")
    private LocalDateTime createdAt;

    public BookingDTO() {
    }

    public static BookingDTO fromEntity(Booking booking) {
        BookingDTO dto = new BookingDTO();
        dto.setId(booking.getId());
        dto.setCustomerId(booking.getCustomer().getId());
        dto.setCustomerName(booking.getCustomer().getFirstName() + " " + booking.getCustomer().getLastName());
        dto.setCustomerEmail(booking.getCustomer().getEmail());
        dto.setRoomId(booking.getRoom().getId());
        dto.setRoomNumber(booking.getRoom().getRoomNumber());
        dto.setRoomTypeName(booking.getRoom().getRoomType().getName());
        dto.setCheckInDate(booking.getCheckInDate());
        dto.setCheckOutDate(booking.getCheckOutDate());
        dto.setTotalPrice(booking.getTotalPrice());
        dto.setRawPrice(booking.getRawPrice());
        dto.setDiscountAmount(booking.getDiscountAmount());
        dto.setStatus(booking.getStatus());
        dto.setSpecialRequests(booking.getSpecialRequests());
        dto.setPayments(booking.getPayments());
        dto.setHistory(booking.getHistory());
        dto.setPolicies(booking.getPolicies());
        dto.setPromotions(booking.getPromotions());
        dto.setCreatedAt(booking.getCreatedAt());
        return dto;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public Long getRoomId() {
        return roomId;
    }

    public void setRoomId(Long roomId) {
        this.roomId = roomId;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getRoomTypeName() {
        return roomTypeName;
    }

    public void setRoomTypeName(String roomTypeName) {
        this.roomTypeName = roomTypeName;
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

    public Booking.BookingStatus getStatus() {
        return status;
    }

    public void setStatus(Booking.BookingStatus status) {
        this.status = status;
    }

    public String getSpecialRequests() {
        return specialRequests;
    }

    public void setSpecialRequests(String specialRequests) {
        this.specialRequests = specialRequests;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public List<Payment> getPayments() {
        return payments;
    }

    public void setPayments(List<Payment> payments) {
        this.payments = payments;
    }

    public List<BookingHistory> getHistory() {
        return history;
    }

    public void setHistory(List<BookingHistory> history) {
        this.history = history;
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
    
}
