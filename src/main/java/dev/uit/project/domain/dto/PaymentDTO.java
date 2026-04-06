package dev.uit.project.domain.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import dev.uit.project.domain.Payment;
import dev.uit.project.domain.Payment.PaymentStatus;

public class PaymentDTO {
    private Long id;
    private BigDecimal amount;
    private LocalDateTime paymentDate;
    private PaymentStatus status;
    private BookingDTO booking;

    public PaymentDTO() {
    }

    public PaymentDTO(Long id, BigDecimal amount, LocalDateTime paymentDate, PaymentStatus status, BookingDTO booking) {
        this.id = id;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.status = status;
        this.booking = booking;
    }

    public static PaymentDTO fromEntity(Payment payment) {
        return new PaymentDTO(
            payment.getId(),
            payment.getAmount(),
            payment.getPaymentDate(),
            payment.getStatus(),
            BookingDTO.fromEntity(payment.getBooking())
        );
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public LocalDateTime getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(LocalDateTime paymentDate) {
        this.paymentDate = paymentDate;
    }

    public PaymentStatus getStatus() {
        return status;
    }

    public void setStatus(PaymentStatus status) {
        this.status = status;
    }

    public BookingDTO getBooking() {
        return booking;
    }

    public void setBooking(BookingDTO booking) {
        this.booking = booking;
    }

    
}
