package dev.uit.project.service;

import org.springframework.stereotype.Service;

import dev.uit.project.domain.Booking;
import dev.uit.project.domain.Payment;
import dev.uit.project.domain.Payment.PaymentStatus;
import dev.uit.project.domain.dto.CreatePaymentRequest;
import dev.uit.project.domain.dto.PaymentDTO;
import dev.uit.project.repository.BookingRepository;
import dev.uit.project.repository.PaymentRepository;
import jakarta.transaction.Transactional;

@Service
public class PaymentService {
    
    PaymentRepository paymentRepository;
    BookingRepository bookingRepository;
    
    public PaymentService(PaymentRepository paymentRepository, BookingRepository bookingRepository) {
        this.paymentRepository = paymentRepository;
        this.bookingRepository = bookingRepository;
    }

    @Transactional
    public PaymentDTO createPayment(CreatePaymentRequest request) {
        Booking booking = bookingRepository.findById(request.getBookingId())
                .orElseThrow(() -> new RuntimeException("Booking not found"));
            
        Payment payment = new Payment();
        payment.setBooking(booking);
        payment.setAmount(request.getAmount());
        payment.setStatus(PaymentStatus.SUCCESS);

        Payment saved = paymentRepository.save(payment);
        return PaymentDTO.fromEntity(saved);
    }
}
