package dev.uit.project.controller.admin;

import dev.uit.project.domain.Booking;
import dev.uit.project.domain.BookingHistory.BookingActor;
import dev.uit.project.domain.dto.*;
import dev.uit.project.service.BookingService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin/bookings")
@CrossOrigin(origins = "*")
public class BookingController {

    private final BookingService bookingService;

    public BookingController(BookingService bookingService) {
        this.bookingService = bookingService;
    }

    @GetMapping
    public ResponseEntity<Page<BookingDTO>> getAllBookings(
            @RequestParam(required = false) Booking.BookingStatus status,
            @RequestParam(required = false) Long customerId,
            @RequestParam(required = false) LocalDate startDate,
            @RequestParam(required = false) LocalDate endDate,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(required = false) Integer size,
            @RequestParam(defaultValue = "createdAt") String sortBy,
            @RequestParam(defaultValue = "DESC") String sortDirection) {
        Sort.Direction direction = sortDirection.equalsIgnoreCase("ASC") ? Sort.Direction.ASC : Sort.Direction.DESC;
        Sort sort = Sort.by(direction, sortBy);
        Pageable pageable;
        
        if (size == null || size <= 0) {
            pageable = Pageable.unpaged();
        } else {
            pageable = PageRequest.of(page, size, sort);
        }
        return ResponseEntity.ok(bookingService.getAllBookings(status, customerId, startDate, endDate, pageable));
    }

    @GetMapping("/{id}")
    public ResponseEntity<BookingDTO> getBookingById(@PathVariable Long id) {
        return ResponseEntity.ok(bookingService.getBookingById(id));
    }

    @PostMapping
    public ResponseEntity<BookingDTO> createBooking(@RequestHeader("Client-Type") BookingActor clientType,
                                                    @Valid @RequestBody CreateBookingRequest request) {
        return ResponseEntity.ok(bookingService.createBooking(request, clientType));
    }

    @PutMapping("/{id}/confirm")
    public ResponseEntity<BookingDTO> confirmBooking(@RequestHeader("Client-Type") BookingActor clientType,
                                                    @PathVariable Long id) {
        return ResponseEntity.ok(bookingService.confirmBooking(id, clientType));
    }

    @PutMapping("/{id}/cancel")
    public ResponseEntity<BookingDTO> cancelBooking(@RequestHeader("Client-Type") BookingActor clientType,
                                                    @PathVariable Long id,
                                                     @RequestBody(required = false) Map<String, String> body) {
        String reason = body != null ? body.get("reason") : null;
        return ResponseEntity.ok(bookingService.cancelBooking(id, reason, clientType));
    }

    @PutMapping("/{id}")
    public ResponseEntity<BookingDTO> updateBooking(@RequestHeader("Client-Type") BookingActor clientType,
                                                    @PathVariable Long id,
                                                     @Valid @RequestBody UpdateBookingRequest request) {
        return ResponseEntity.ok(bookingService.updateBooking(id, request, clientType));
    }

    @GetMapping("/{id}/history")
    public ResponseEntity<List<BookingHistoryDTO>> getBookingHistory(@PathVariable Long id) {
        return ResponseEntity.ok(bookingService.getBookingHistory(id));
    }
}
