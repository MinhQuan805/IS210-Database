package dev.uit.project.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dev.uit.project.domain.Amenity;
import dev.uit.project.domain.Booking;
import dev.uit.project.domain.BookingHistory;
import dev.uit.project.domain.BookingHistory.BookingAction;
import dev.uit.project.domain.BookingHistory.BookingActor;
import dev.uit.project.domain.BookingPolicy;
import dev.uit.project.domain.BookingPolicyId;
import dev.uit.project.domain.Customer;
import dev.uit.project.domain.Policy;
import dev.uit.project.domain.Room;
import dev.uit.project.domain.RoomType;
import dev.uit.project.domain.dto.AmenityDTO;
import dev.uit.project.domain.dto.BookingDTO;
import dev.uit.project.domain.dto.BookingDetailDTO;
import dev.uit.project.domain.dto.BookingHistoryDTO;
import dev.uit.project.domain.dto.CreateBookingRequest;
import dev.uit.project.domain.dto.PaymentDTO;
import dev.uit.project.domain.dto.PolicyDTO;
import dev.uit.project.domain.dto.PromotionDTO;
import dev.uit.project.domain.dto.UpdateBookingRequest;
import dev.uit.project.repository.AmenityRepository;
import dev.uit.project.repository.BookingHistoryRepository;
import dev.uit.project.repository.BookingPolicyRepository;
import dev.uit.project.repository.BookingRepository;
import dev.uit.project.repository.CustomerRepository;
import dev.uit.project.repository.PolicyRepository;
import dev.uit.project.repository.RoomRepository;
import dev.uit.project.repository.RoomTypeRepository;

@Service
public class BookingService {

    private final BookingRepository bookingRepository;
    private final BookingHistoryRepository bookingHistoryRepository;
    private final CustomerRepository customerRepository;
    private final RoomRepository roomRepository;
    private final RoomTypeRepository roomTypeRepository;
    private final AmenityRepository amenityRepository;
    private final PolicyRepository policyRepository;
    private final BookingPolicyRepository bookingPolicyRepository;
    private final PricingService pricingService;

    public BookingService(BookingRepository bookingRepository, BookingHistoryRepository bookingHistoryRepository,
            CustomerRepository customerRepository, RoomRepository roomRepository, RoomTypeRepository roomTypeRepository,
            AmenityRepository amenityRepository, PolicyRepository policyRepository,
            BookingPolicyRepository bookingPolicyRepository, PricingService pricingService) {
        this.bookingRepository = bookingRepository;
        this.bookingHistoryRepository = bookingHistoryRepository;
        this.customerRepository = customerRepository;
        this.roomRepository = roomRepository;
        this.roomTypeRepository = roomTypeRepository;
        this.amenityRepository = amenityRepository;
        this.policyRepository = policyRepository;
        this.bookingPolicyRepository = bookingPolicyRepository;
        this.pricingService = pricingService;
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
    public BookingDTO createBooking(CreateBookingRequest request, BookingActor performedBy) {
        Customer customer = customerRepository.findById(request.getCustomerId())
                .orElseThrow(() -> new RuntimeException("Customer not found"));
        Room room = roomRepository.findById(request.getRoomId())
                .orElseThrow(() -> new RuntimeException("Room not found"));

        Booking booking = new Booking();
        booking.setCustomer(customer);
        booking.setRoom(room);
        booking.setCheckInDate(request.getCheckInDate());
        booking.setCheckOutDate(request.getCheckOutDate());
        booking.setRawPrice(pricingService.getRawPrice(room.getRoomType().getId(), request.getCheckInDate(), request.getCheckOutDate()));
        booking.setTotalPrice(BigDecimal.ZERO); // Để tạm, trigger tính lại sau
        booking.setDiscountAmount(BigDecimal.ZERO); // Để tạm, trigger tính lại sau
        booking.setStatus(Booking.BookingStatus.PENDING);
        booking.setSpecialRequests(request.getSpecialRequests());

        Booking saved = bookingRepository.save(booking);
        addHistory(saved, BookingAction.CREATED, performedBy, "Đã đặt phòng");

        // Gán tất cả policy cho bookings

        List<Policy> policies = policyRepository.findAll();

        List<BookingPolicy> bookingPolicies = policies.stream()
            .map(policy -> {
                BookingPolicyId bpId = new BookingPolicyId(saved.getId(), policy.getId());
                return new BookingPolicy(bpId, saved, policy);
            })
            .collect(Collectors.toList());

        bookingPolicyRepository.saveAll(bookingPolicies);

        return BookingDTO.fromEntity(saved);
    }

    @Transactional
    public BookingDTO confirmBooking(Long id, BookingActor performedBy) {
        Booking booking = bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found with id: " + id));

        if (booking.getStatus() != Booking.BookingStatus.PENDING) {
            throw new RuntimeException("Only PENDING bookings can be confirmed");
        }

        booking.setStatus(Booking.BookingStatus.CONFIRMED);
        Booking saved = bookingRepository.save(booking);
        addHistory(saved, BookingAction.CONFIRMED, performedBy, "Đã xác nhận đặt phòng");

        return BookingDTO.fromEntity(saved);
    }

    @Transactional
    public BookingDTO cancelBooking(Long id, String reason, BookingActor performedBy) {
        Booking booking = bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found with id: " + id));

        if (booking.getStatus() == Booking.BookingStatus.CHECKED_OUT ||
                booking.getStatus() == Booking.BookingStatus.CANCELLED) {
            throw new RuntimeException("Cannot cancel a booking that is already " + booking.getStatus());
        }

        booking.setStatus(Booking.BookingStatus.CANCELLED);
        Booking saved = bookingRepository.save(booking);
        addHistory(saved, BookingAction.CANCELLED, performedBy, reason != null ? reason : "Đã hủy đặt phòng");

        // Set room back to available
        Room room = booking.getRoom();
        if (room.getStatus() == Room.RoomStatus.RESERVED) {
            room.setStatus(Room.RoomStatus.AVAILABLE);
            roomRepository.save(room);
        }

        return BookingDTO.fromEntity(saved);
    }

    @Transactional
    public BookingDTO updateBooking(Long id, UpdateBookingRequest request, BookingActor performedBy) {
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
        addHistory(saved, BookingAction.UPDATED, performedBy, "Đã cập nhật thông tin đặt phòng");

        return BookingDTO.fromEntity(saved);
    }

    @Transactional
    public BookingDTO checkInBooking(Long id, BookingActor performedBy) {
        Booking booking = bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found with id: " + id));

        booking.setStatus(Booking.BookingStatus.CHECKED_IN);
        Booking saved = bookingRepository.save(booking);
        addHistory(saved, BookingAction.UPDATED, performedBy, "Đã nhận phòng đặt phòng");

        return BookingDTO.fromEntity(saved);
    }

    @Transactional
    public BookingDTO checkOutBooking(Long id, BookingActor performedBy) {
        Booking booking = bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found with id: " + id));

        booking.setStatus(Booking.BookingStatus.CHECKED_OUT);
        Booking saved = bookingRepository.save(booking);
        addHistory(saved, BookingAction.UPDATED, performedBy, "Đã trả phòng đặt phòng");

        return BookingDTO.fromEntity(saved);
    }

    @Transactional
    public void deleteBooking(Long id) {
        Booking booking = bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found with id: " + id));
        bookingRepository.delete(booking);
    }

    @Transactional(readOnly = true)
    public List<BookingHistoryDTO> getBookingHistory(Long bookingId) {
        return bookingHistoryRepository.findByBookingIdOrderByTimestampDesc(bookingId)
                .stream().map(BookingHistoryDTO::fromEntity).toList();
    }

    private void addHistory(Booking booking, BookingAction action, BookingActor performedBy, String notes) {
        BookingHistory history = new BookingHistory();
        history.setBooking(booking);
        history.setAction(action);
        history.setPerformedBy(performedBy);
        history.setNotes(notes);
        bookingHistoryRepository.save(history);
    }

    @Transactional(readOnly = true)
    public BookingDetailDTO getBookingDetail(Long bookingId, String email) {
        Booking booking = bookingRepository
            .findByIdAndCustomerEmail(bookingId, email)
            .orElseThrow(() -> new RuntimeException("Booking not found"));

        RoomType roomType = roomTypeRepository
            .findByBookingId(bookingId)
            .orElseThrow(() -> new RuntimeException("Room type not found"));
        
        List<Amenity> amenities = amenityRepository
            .findByBookingId(bookingId);
        
        BookingDetailDTO dto = new BookingDetailDTO();

        dto.setId(booking.getId());
        dto.setCheckInDate(booking.getCheckInDate());
        dto.setCheckOutDate(booking.getCheckOutDate());
        dto.setTotalPrice(booking.getTotalPrice());
        dto.setRawPrice(booking.getRawPrice());
        dto.setDiscountAmount(booking.getDiscountAmount());
        dto.setStatus(booking.getStatus());
        dto.setSpecialRequests(booking.getSpecialRequests());

        dto.setCustomerName(booking.getCustomer().getFullName());
        dto.setCustomerEmail(booking.getCustomer().getEmail());

        dto.setRoomNumber(booking.getRoom().getRoomNumber());
        dto.setFloor(booking.getRoom().getFloor());

        dto.setAmenities(
            amenities.stream()
                .map(AmenityDTO::fromEntity)
                .toList()
        );

        dto.setHistory(
            booking.getHistory().stream()
                .map(BookingHistoryDTO::fromEntity)
                .toList()
        );

        dto.setPayments(
            booking.getPayments().stream()
                .map(PaymentDTO::fromEntity)
                .toList()  
        );

        dto.setPromotions(
            booking.getPromotions().stream()
                .map(PromotionDTO::fromEntity)
                .toList()
        );

        dto.setPolicies(
            booking.getPolicies().stream()
                .map(PolicyDTO::fromEntity)
                .toList()
        );

        return dto;
    }
}
