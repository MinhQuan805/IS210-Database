package dev.uit.project.controller;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import dev.uit.project.domain.Booking;
import dev.uit.project.domain.Customer;
import dev.uit.project.domain.Room;
import dev.uit.project.domain.Booking.BookingStatus;
import dev.uit.project.domain.BookingHistory.BookingAction;
import dev.uit.project.repository.BookingRepository;
import dev.uit.project.repository.CustomerRepository;
import dev.uit.project.repository.RoomRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/admin/concurrency-demo")
@RequiredArgsConstructor
public class ConcurrencyDemoController {
    
    private final RoomRepository roomRepository;
    private final BookingRepository bookingRepository;
    private final CustomerRepository customerRepository;

    /**
     * DEMO DOUBLE BOOKING / LOST UPDATE
     * KHÔNG DÙNG LOCK
     */
    @PostMapping("/lost-update/no-lock")
    @Transactional
    public ResponseEntity<String> lostUpdateNoLock(
            @RequestParam Long customerId
    ) throws Exception {

        Long roomId = 7L;

        LocalDate checkIn = LocalDate.of(2026, 6, 1);
        LocalDate checkOut = LocalDate.of(2026, 6, 5);

        System.out.println(Thread.currentThread().getName()
                + " START TRANSACTION");

        boolean booked = bookingRepository.existsOverlappingBooking(
                roomId,
                checkIn,
                checkOut
        );

        System.out.println(Thread.currentThread().getName()
                + " CHECK ROOM = " + booked);

        if (booked) {
            return ResponseEntity.badRequest()
                    .body("ROOM ALREADY BOOKED");
        }

        // delay để transaction khác chen vào
        Thread.sleep(10000);

        Customer customer = customerRepository.findById(customerId)
                .orElseThrow();

        Room room = roomRepository.findById(roomId)
                .orElseThrow();

        Booking booking = new Booking();

        booking.setCustomer(customer);
        booking.setRoom(room);

        booking.setCheckInDate(checkIn);
        booking.setCheckOutDate(checkOut);

        booking.setStatus(BookingStatus.CONFIRMED);

        booking.setRawPrice(BigDecimal.valueOf(1000));
        booking.setDiscountAmount(BigDecimal.ZERO);
        booking.setTotalPrice(BigDecimal.valueOf(1000));

        bookingRepository.save(booking);

        System.out.println(Thread.currentThread().getName()
                + " BOOKING CREATED");

        return ResponseEntity.ok("BOOKED SUCCESSFULLY");
    }

    /**
     * DEMO ROW-LEVEL LOCKING
     * DÙNG PESSIMISTIC WRITE
     */
    @PostMapping("/lost-update/with-lock")
    @Transactional
    public ResponseEntity<String> lostUpdateWithLock(
            @RequestParam Long customerId
    ) throws Exception {

        Long roomId = 8L;

        LocalDate checkIn = LocalDate.of(2026, 6, 1);
        LocalDate checkOut = LocalDate.of(2026, 6, 5);

        System.out.println(Thread.currentThread().getName()
                + " WAITING FOR LOCK");

        // SELECT ... FOR UPDATE
        Room room = roomRepository.findByIdForUpdate(roomId);

        System.out.println(Thread.currentThread().getName()
                + " ACQUIRED LOCK");

        boolean booked = bookingRepository.existsOverlappingBooking(
                roomId,
                checkIn,
                checkOut
        );

        System.out.println(Thread.currentThread().getName()
                + " CHECK ROOM = " + booked);

        if (booked) {
            return ResponseEntity.badRequest()
                    .body("ROOM ALREADY BOOKED");
        }

        // giữ lock để transaction khác phải wait
        Thread.sleep(10000);

        Customer customer = customerRepository.findById(customerId)
                .orElseThrow();

        Booking booking = new Booking();

        booking.setCustomer(customer);
        booking.setRoom(room);

        booking.setCheckInDate(checkIn);
        booking.setCheckOutDate(checkOut);

        booking.setStatus(BookingStatus.CONFIRMED);

        booking.setRawPrice(BigDecimal.valueOf(1000));
        booking.setDiscountAmount(BigDecimal.ZERO);
        booking.setTotalPrice(BigDecimal.valueOf(1000));

        bookingRepository.save(booking);

        System.out.println(Thread.currentThread().getName()
                + " BOOKING CREATED");

        return ResponseEntity.ok("BOOKED SUCCESSFULLY");
    }

}