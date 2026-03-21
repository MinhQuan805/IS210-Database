package dev.uit.project.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import dev.uit.project.domain.dto.BookingDetailDTO;
import dev.uit.project.service.BookingService;

@RestController
@RequestMapping("/api/bookings")
@CrossOrigin(origins = "*")
public class BookingDetailController {
    private final BookingService bookingService;

    public BookingDetailController(BookingService bookingService) {
        this.bookingService = bookingService;
    }

    @GetMapping("/{id}/detail")
    public ResponseEntity<BookingDetailDTO> getBookingDetail(@PathVariable Long id, @RequestParam String email) {
        return ResponseEntity.ok(bookingService.getBookingDetail(id, email));
    }
}
