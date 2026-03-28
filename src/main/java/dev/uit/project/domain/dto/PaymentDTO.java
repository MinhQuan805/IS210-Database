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

    public PaymentDTO() {
    }

    public static PaymentDTO fromEntity(Payment payment) {
        PaymentDTO dto = new PaymentDTO();
        dto.setId(payment.getId());
        dto.setAmount(payment.getAmount());
        dto.setPaymentDate(payment.getPaymentDate());
        dto.setStatus(payment.getStatus());
        return dto;
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

    
}
