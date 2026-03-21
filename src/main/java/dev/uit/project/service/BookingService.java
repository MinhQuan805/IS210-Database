package dev.uit.project.service;

import dev.uit.project.domain.*;
import dev.uit.project.domain.dto.*;
import dev.uit.project.repository.*;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
public class BookingService {

    private final BookingRepository bookingRepository;
    private final BookingHistoryRepository bookingHistoryRepository;
    private final CustomerRepository customerRepository;
    private final RoomRepository roomRepository;
    private final RoomTypeRepository roomTypeRepository;
    private final PromotionRepository promotionRepository;
    private final PolicyRepository policyRepository;

    public BookingService(BookingRepository bookingRepository, BookingHistoryRepository bookingHistoryRepository,
            CustomerRepository customerRepository, RoomRepository roomRepository, RoomTypeRepository roomTypeRepository,
            PromotionRepository promotionRepository, PolicyRepository policyRepository) {
        this.bookingRepository = bookingRepository;
        this.bookingHistoryRepository = bookingHistoryRepository;
        this.customerRepository = customerRepository;
        this.roomRepository = roomRepository;
        this.roomTypeRepository = roomTypeRepository;
        this.promotionRepository = promotionRepository;
        this.policyRepository = policyRepository;
    }

    @Transactional(readOnly = true)
    public Page<BookingDTO> getAllBookings(Booking.BookingStatus status, Long customerId,
                                           LocalDate startDate, LocalDate endDate,
                                           Pageable pageable) {
        Specification<Booking> spec = Specification.where((root, query, cb) -> cb.conjunction());

        if (status != null) {
            spec = spec.and((root, query, cb) -> cb.equal(root.get("status"), status));
        }
        if (customerId != null) {
            spec = spec.and((root, query, cb) -> cb.equal(root.get("customer").get("id"), customerId));
        }
        if (startDate != null) {
            spec = spec.and((root, query, cb) -> cb.greaterThanOrEqualTo(root.get("checkInDate"), startDate));
        }
        if (endDate != null) {
            spec = spec.and((root, query, cb) -> cb.lessThanOrEqualTo(root.get("checkOutDate"), endDate));
        }

        return bookingRepository.findAll(spec, pageable).map(BookingDTO::fromEntity);
    }

    @Transactional(readOnly = true)
    public BookingDTO getBookingById(Long id) {
        Booking booking = bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found with id: " + id));
        return BookingDTO.fromEntity(booking);
    }

    @Transactional
    public BookingDTO createBooking(CreateBookingRequest request) {
        Customer customer = customerRepository.findById(request.getCustomerId())
                .orElseThrow(() -> new RuntimeException("Customer not found"));
        Room room = roomRepository.findById(request.getRoomId())
                .orElseThrow(() -> new RuntimeException("Room not found"));
        Booking booking = new Booking();
        booking.setCustomer(customer);
        booking.setRoom(room);
        booking.setCheckInDate(request.getCheckInDate());
        booking.setCheckOutDate(request.getCheckOutDate());
        booking.setTotalPrice(request.getTotalPrice());
        booking.setStatus(Booking.BookingStatus.PENDING);
        booking.setSpecialRequests(request.getSpecialRequests());

        Booking saved = bookingRepository.save(booking);
        addHistory(saved, "CREATED", "system", "Booking created");

        return BookingDTO.fromEntity(saved);
    }

    @Transactional
    public BookingDTO confirmBooking(Long id) {
        Booking booking = bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found with id: " + id));

        if (booking.getStatus() != Booking.BookingStatus.PENDING) {
            throw new RuntimeException("Only PENDING bookings can be confirmed");
        }

        booking.setStatus(Booking.BookingStatus.CONFIRMED);
        Booking saved = bookingRepository.save(booking);
        addHistory(saved, "CONFIRMED", "admin", "Booking confirmed");

        return BookingDTO.fromEntity(saved);
    }

    @Transactional
    public BookingDTO cancelBooking(Long id, String reason) {
        Booking booking = bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found with id: " + id));

        if (booking.getStatus() == Booking.BookingStatus.CHECKED_OUT ||
                booking.getStatus() == Booking.BookingStatus.CANCELLED) {
            throw new RuntimeException("Cannot cancel a booking that is already " + booking.getStatus());
        }

        booking.setStatus(Booking.BookingStatus.CANCELLED);
        Booking saved = bookingRepository.save(booking);
        addHistory(saved, "CANCELLED", "admin", reason != null ? reason : "Booking cancelled");

        // Set room back to available
        Room room = booking.getRoom();
        if (room.getStatus() == Room.RoomStatus.RESERVED) {
            room.setStatus(Room.RoomStatus.AVAILABLE);
            roomRepository.save(room);
        }

        return BookingDTO.fromEntity(saved);
    }

    @Transactional
    public BookingDTO updateBooking(Long id, UpdateBookingRequest request) {
        Booking booking = bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found with id: " + id));

        if (request.getRoomId() != null) {
            Room newRoom = roomRepository.findById(request.getRoomId())
                    .orElseThrow(() -> new RuntimeException("Room not found"));
            booking.setRoom(newRoom);
        }
        if (request.getCheckInDate() != null) booking.setCheckInDate(request.getCheckInDate());
        if (request.getCheckOutDate() != null) booking.setCheckOutDate(request.getCheckOutDate());
        if (request.getTotalPrice() != null) booking.setTotalPrice(request.getTotalPrice());
        if (request.getSpecialRequests() != null) booking.setSpecialRequests(request.getSpecialRequests());

        Booking saved = bookingRepository.save(booking);
        addHistory(saved, "UPDATED", "admin", "Booking details updated");

        return BookingDTO.fromEntity(saved);
    }

    @Transactional(readOnly = true)
    public List<BookingHistoryDTO> getBookingHistory(Long bookingId) {
        return bookingHistoryRepository.findByBookingIdOrderByTimestampDesc(bookingId)
                .stream().map(BookingHistoryDTO::fromEntity).toList();
    }

    private void addHistory(Booking booking, String action, String performedBy, String notes) {
        BookingHistory history = new BookingHistory();
        history.setBooking(booking);
        history.setAction(action);
        history.setPerformedBy(performedBy);
        history.setNotes(notes);
        bookingHistoryRepository.save(history);
    }

    @Transactional(readOnly = true)
    public BookingDetailDTO getBookingDetail(Long bookingId, String email) {

        // 1. Booking (core)
        Booking booking = bookingRepository
                .getHalfBookingDetail(bookingId, email)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

        // 2. History
        List<BookingHistory> histories = bookingHistoryRepository.findByBookingId(bookingId);

        // 3. Policy
        List<Policy> policies = policyRepository.findByBookingId(bookingId);

        // 4. Promotion
       List<Promotion> promotions = promotionRepository.findByBookingId(bookingId);

        // 5. Amenity (từ RoomType)
        RoomType roomType = roomTypeRepository
                .findWithAmenities(booking.getRoom().getRoomType().getId())
                .orElseThrow();

        // 6. Assemble
        BookingDetailDTO dto = new BookingDetailDTO();
        dto.setBooking(booking);
        dto.setHistories(histories);
        dto.setPolicies(policies);
        dto.setPromotions(promotions);
        dto.setRoomType(roomType);

        return dto;
    }
}
