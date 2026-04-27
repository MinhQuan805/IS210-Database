package dev.uit.project.domain.dto;

import java.math.BigDecimal;

import jakarta.validation.constraints.NotNull;

public class CreatePaymentRequest {
    @NotNull(message = "Booking ID is required")
    private Long bookingId;

    @NotNull(message = "Amount is required")
    private BigDecimal amount;

    public CreatePaymentRequest(@NotNull(message = "Booking ID is required") Long bookingId,
            @NotNull(message = "Amount is required") BigDecimal amount) {
        this.bookingId = bookingId;
        this.amount = amount;
    }

    public Long getBookingId() {
        return bookingId;
    }

    public void setBookingId(Long bookingId) {
        this.bookingId = bookingId;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    
}
