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

import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;

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

    @PersistenceContext
    private EntityManager entityManager;

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
        Room room = roomRepository.findById(request.getRoomId())
                .orElseThrow(() -> new RuntimeException("Room not found"));
        Long roomTypeId = room.getRoomType().getId();
        String promotionCode = normalizePromotionCode(request.getPromotionCode());

        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("hotel.sp_create_booking");
        query.registerStoredProcedureParameter("p_customer_id", Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_room_type_id", Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_check_in_date", java.sql.Date.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_check_out_date", java.sql.Date.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_promotion_code", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_special_requests", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("o_booking_id", Long.class, ParameterMode.OUT);

        try {
            query.setParameter("p_customer_id", request.getCustomerId());
            query.setParameter("p_room_type_id", roomTypeId);
            query.setParameter("p_check_in_date", java.sql.Date.valueOf(request.getCheckInDate()));
            query.setParameter("p_check_out_date", java.sql.Date.valueOf(request.getCheckOutDate()));
            query.setParameter("p_promotion_code", promotionCode);
            query.setParameter("p_special_requests", request.getSpecialRequests());

            query.execute();
        } catch (Exception ex) {
            throw mapStoredProcedureException(ex);
        }
        Long bookingId = (Long) query.getOutputParameterValue("o_booking_id");

        Booking saved = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Failed to find created booking with id: " + bookingId));
        return BookingDTO.fromEntity(saved);
    }

    @Transactional
    public BookingDTO confirmBooking(Long id, BookingActor performedBy) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("hotel.sp_update_booking_status");
        query.registerStoredProcedureParameter("p_booking_id", Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_new_status", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_performed_by", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_notes", String.class, ParameterMode.IN);

        query.setParameter("p_booking_id", id);
        query.setParameter("p_new_status", "CONFIRMED");
        query.setParameter("p_performed_by", performedBy.name());
        query.setParameter("p_notes", "Đã xác nhận đặt phòng");
        query.execute();

        Booking saved = bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found with id: " + id));
        return BookingDTO.fromEntity(saved);
    }

    @Transactional
    public BookingDTO cancelBooking(Long id, String reason, BookingActor performedBy) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("hotel.sp_update_booking_status");
        query.registerStoredProcedureParameter("p_booking_id", Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_new_status", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_performed_by", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_notes", String.class, ParameterMode.IN);

        query.setParameter("p_booking_id", id);
        query.setParameter("p_new_status", "CANCELLED");
        query.setParameter("p_performed_by", performedBy.name());
        query.setParameter("p_notes", reason != null ? reason : "Đã hủy đặt phòng");
        query.execute();

        Booking saved = bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found with id: " + id));
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
        if (request.getCheckInDate() != null)
            booking.setCheckInDate(request.getCheckInDate());
        if (request.getCheckOutDate() != null)
            booking.setCheckOutDate(request.getCheckOutDate());
        if (request.getTotalPrice() != null)
            booking.setTotalPrice(request.getTotalPrice());
        if (request.getSpecialRequests() != null)
            booking.setSpecialRequests(request.getSpecialRequests());

        Booking saved = bookingRepository.save(booking);
        addHistory(saved, BookingAction.UPDATED, performedBy, "Đã cập nhật thông tin đặt phòng");

        return BookingDTO.fromEntity(saved);
    }

    @Transactional
    public BookingDTO checkInBooking(Long id, BookingActor performedBy) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("hotel.sp_process_check_in");
        query.registerStoredProcedureParameter("p_booking_id", Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_performed_by", String.class, ParameterMode.IN);

        query.setParameter("p_booking_id", id);
        query.setParameter("p_performed_by", performedBy.name());
        query.execute();

        Booking saved = bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found with id: " + id));
        return BookingDTO.fromEntity(saved);
    }

    @Transactional
    public BookingDTO checkOutBooking(Long id, BookingActor performedBy) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("hotel.sp_process_check_out");
        query.registerStoredProcedureParameter("p_booking_id", Long.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_performed_by", String.class, ParameterMode.IN);

        query.setParameter("p_booking_id", id);
        query.setParameter("p_performed_by", performedBy.name());
        query.execute();

        Booking saved = bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found with id: " + id));
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
                        .toList());

        dto.setHistory(
                booking.getHistory().stream()
                        .map(BookingHistoryDTO::fromEntity)
                        .toList());

        dto.setPayments(
                booking.getPayments().stream()
                        .map(PaymentDTO::fromEntity)
                        .toList());

        dto.setPromotions(
                booking.getPromotions().stream()
                        .map(PromotionDTO::fromEntity)
                        .toList());

        dto.setPolicies(
                booking.getPolicies().stream()
                        .map(PolicyDTO::fromEntity)
                        .toList());

        return dto;
    }

    private String normalizePromotionCode(String promotionCode) {
        if (promotionCode == null) {
            return null;
        }
        String trimmed = promotionCode.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private RuntimeException mapStoredProcedureException(Exception ex) {
        String message = null;
        Throwable current = ex;
        while (current != null) {
            if (current.getMessage() != null) {
                message = current.getMessage();
            }
            current = current.getCause();
        }

        String oracleMessage = extractOracleMessage(message);
        if (oracleMessage != null && !oracleMessage.isEmpty()) {
            return new RuntimeException(oracleMessage);
        }
        if (message != null && !message.isEmpty()) {
            return new RuntimeException(message);
        }
        return new RuntimeException("Không thể tạo đặt phòng. Vui lòng thử lại.");
    }

    private String extractOracleMessage(String message) {
        if (message == null) {
            return null;
        }
        int oraIndex = message.indexOf("ORA-");
        if (oraIndex == -1) {
            return null;
        }
        String oraPart = message.substring(oraIndex);
        int newlineIndex = oraPart.indexOf('\n');
        if (newlineIndex != -1) {
            oraPart = oraPart.substring(0, newlineIndex);
        }
        int colonIndex = oraPart.indexOf(':');
        if (colonIndex != -1 && colonIndex + 1 < oraPart.length()) {
            return oraPart.substring(colonIndex + 1).trim();
        }
        return oraPart.trim();
    }
}
