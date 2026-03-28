package dev.uit.project.service;

import dev.uit.project.domain.Booking;
import dev.uit.project.domain.BookingPromotion;
import dev.uit.project.domain.DailyPrice;
import dev.uit.project.domain.Promotion;
import dev.uit.project.domain.RoomType;
import dev.uit.project.domain.SeasonalPrice;
import dev.uit.project.domain.dto.*;
import dev.uit.project.repository.*;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class PricingService {

    private final SeasonalPriceRepository seasonalPriceRepository;
    private final DailyPriceRepository dailyPriceRepository;
    private final PromotionRepository promotionRepository;
    private final RoomTypeRepository roomTypeRepository;
    private final BookingRepository bookingRepository;

    public PricingService(SeasonalPriceRepository seasonalPriceRepository, DailyPriceRepository dailyPriceRepository,
            PromotionRepository promotionRepository, RoomTypeRepository roomTypeRepository,
            BookingRepository bookingRepository) {
        this.seasonalPriceRepository = seasonalPriceRepository;
        this.dailyPriceRepository = dailyPriceRepository;
        this.promotionRepository = promotionRepository;
        this.roomTypeRepository = roomTypeRepository;
        this.bookingRepository = bookingRepository;
    }

    // Seasonal Pricing
    @Transactional(readOnly = true)
    public List<SeasonalPriceDTO> getAllSeasonalPrices(Long roomTypeId) {
        if (roomTypeId != null) {
            return seasonalPriceRepository.findByRoomTypeIdOrderByPriorityDesc(roomTypeId)
                    .stream().map(SeasonalPriceDTO::fromEntity).toList();
        }
        return seasonalPriceRepository.findAll()
                .stream().map(SeasonalPriceDTO::fromEntity).toList();
    }

    @Transactional
    public SeasonalPriceDTO createSeasonalPrice(Long roomTypeId, String name,
                                                 LocalDate startDate, LocalDate endDate,
                                                 BigDecimal priceMultiplier, Integer priority) {
        RoomType roomType = roomTypeRepository.findById(roomTypeId)
                .orElseThrow(() -> new RuntimeException("Room type not found"));

        SeasonalPrice sp = new SeasonalPrice();
        sp.setRoomType(roomType);
        sp.setName(name);
        sp.setStartDate(startDate);
        sp.setEndDate(endDate);
        sp.setPriceMultiplier(priceMultiplier);
        sp.setPriority(priority != null ? priority : 0);

        return SeasonalPriceDTO.fromEntity(seasonalPriceRepository.save(sp));
    }

    @Transactional
    public void deleteSeasonalPrice(Long id) {
        seasonalPriceRepository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public List<DailyPriceDTO> getDailyPrices(Long roomTypeId, LocalDate startDate, LocalDate endDate) {
        // TH1: Tìm price theo roomTypeId
        if (roomTypeId != null) {
            // TH1.1: Tìm tất cả price theo phạm vi
            if (startDate != null && endDate != null) {
                return dailyPriceRepository.findByRoomTypeIdAndDateBetween(roomTypeId, startDate, endDate)
                    .stream().map(DailyPriceDTO::fromEntity).toList();
            }
            // TH1.2: Tìm tất cả price hiện có
            return dailyPriceRepository.findAll().stream()
                    .filter(dp -> dp.getRoomType().getId().equals(roomTypeId))
                    .map(DailyPriceDTO::fromEntity).toList();
        }

        // TH2: Tìm tất cả price
        // TH2.1: Tìm tất cả price theo phạm vi
        if (startDate != null && endDate != null) {
            return dailyPriceRepository.findAll().stream()
                    .filter(dp -> !dp.getDate().isBefore(startDate) && !dp.getDate().isAfter(endDate))
                    .map(DailyPriceDTO::fromEntity).toList();
        }

        // TH2.2: Tìm tất cả price hiện có
        return dailyPriceRepository.findAll().stream().map(DailyPriceDTO::fromEntity).toList();
    }

    @Transactional(readOnly = true)
    public List<SeasonalPriceDTO> getSeasonalPrices(Long roomTypeId, LocalDate startDate, LocalDate endDate) {
        // TH1: Tìm price theo roomTypeId
        if (roomTypeId != null) {
            // TH1.1: Tìm tất cả price theo phạm vi
            if (startDate != null && endDate != null) {
                return seasonalPriceRepository
                    .findByRoomTypeIdAndStartDateLessThanEqualAndEndDateGreaterThanEqual( roomTypeId, endDate, startDate)
                    .stream().map(SeasonalPriceDTO::fromEntity).toList();
            }
            // TH1.2: Tìm tất cả price hiện có
            return seasonalPriceRepository.findAll().stream()
                    .filter(sp -> sp.getRoomType().getId().equals(roomTypeId))
                    .map(SeasonalPriceDTO::fromEntity)
                    .toList();
        }

        // TH2: Tìm tất cả price
        // TH2.1: Tìm tất cả price theo phạm vi
        if (startDate != null && endDate != null) {
            return seasonalPriceRepository.findAll().stream()
                    .filter(sp ->
                            !sp.getStartDate().isAfter(endDate) &&
                            !sp.getEndDate().isBefore(startDate)
                    )
                    .map(SeasonalPriceDTO::fromEntity)
                    .toList();
        }

        // TH2.2: Tìm tất cả price hiện có
        return seasonalPriceRepository.findAll().stream()
                .map(SeasonalPriceDTO::fromEntity)
                .toList();
    }

    @Transactional(readOnly = true)
    public BigDecimal getDailyPrice(Long roomTypeId, LocalDate date) {
        return dailyPriceRepository
                .findByRoomTypeIdAndDate(roomTypeId, date)
                .map(dp -> dp.getPrice())
                .orElse(null);
    }

    @Transactional(readOnly = true)
    public BigDecimal getSeasonalMultiplier(Long roomTypeId, LocalDate date) {
        return seasonalPriceRepository
                .findByRoomTypeIdAndStartDateLessThanEqualAndEndDateGreaterThanEqual(roomTypeId, date, date)
                .stream()
                .max(Comparator.comparing(SeasonalPrice::getPriority))
                .map(SeasonalPrice::getPriceMultiplier)
                .orElse(null);
    }

    @Transactional
    public DailyPriceDTO setDailyPrice(Long roomTypeId, LocalDate date, BigDecimal price, String reason) {
        RoomType roomType = roomTypeRepository.findById(roomTypeId)
                .orElseThrow(() -> new RuntimeException("Room type not found"));

        DailyPrice dp = dailyPriceRepository.findByRoomTypeIdAndDate(roomTypeId, date)
                .orElse(new DailyPrice());

        dp.setRoomType(roomType);
        dp.setDate(date);
        dp.setPrice(price);
        dp.setReason(reason);

        return DailyPriceDTO.fromEntity(dailyPriceRepository.save(dp));
    }

    // Promotions
    @Transactional(readOnly = true)
    public List<PromotionDTO> getAllPromotions() {
        return promotionRepository.findAll().stream().map(PromotionDTO::fromEntity).toList();
    }

    @Transactional
    public PromotionDTO createPromotion(CreatePromotionRequest request) {
        if (promotionRepository.existsByCode(request.getCode())) {
            throw new RuntimeException("Promotion code already exists: " + request.getCode());
        }

        Promotion promotion = new Promotion();
        promotion.setCode(request.getCode().toUpperCase());
        promotion.setDescription(request.getDescription());
        promotion.setDiscountType(request.getDiscountType());
        promotion.setDiscountValue(request.getDiscountValue());
        promotion.setStartDate(request.getStartDate());
        promotion.setEndDate(request.getEndDate());
        promotion.setMinNights(request.getMinNights());
        promotion.setMaxUses(request.getMaxUses());
        promotion.setUsedCount(0);

        return PromotionDTO.fromEntity(promotionRepository.save(promotion));
    }

    @Transactional
    public PromotionDTO togglePromotion(Long id) {
        Promotion promotion = promotionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Promotion not found with id: " + id));
        return PromotionDTO.fromEntity(promotionRepository.save(promotion));
    }

    @Transactional
    public BigDecimal getRawPrice(Long roomTypeId, LocalDate checkInDate, LocalDate checkOutDate) {

        RoomType roomType = roomTypeRepository.findById(roomTypeId)
                .orElseThrow(() -> new IllegalArgumentException("RoomType not found"));

        BigDecimal basePrice = roomType.getBasePrice() != null ? roomType.getBasePrice() : BigDecimal.ZERO;
        BigDecimal total = BigDecimal.ZERO;

        long days = ChronoUnit.DAYS.between(checkInDate, checkOutDate) + 1;

        for (int i = 0; i < days; i++) {
            LocalDate currDate = checkInDate.plusDays(i);

            // Nếu null thì default
            BigDecimal dailyPrice = Optional.ofNullable(getDailyPrice(roomTypeId, currDate)).orElse(BigDecimal.ZERO);
            BigDecimal seasonalMultiplier = Optional.ofNullable(getSeasonalMultiplier(roomTypeId, currDate)).orElse(BigDecimal.ONE);

            BigDecimal dayPrice = basePrice.add(dailyPrice).multiply(seasonalMultiplier);
            total = total.add(dayPrice);
        }

        return total;
    }

    @Transactional
    public BigDecimal getDiscountAmount(Long bookingId) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new IllegalArgumentException("Booking not found"));

        List<Promotion> bookingPromotions = booking.getPromotions();

        return bookingPromotions.stream()
            .map(Promotion::getDiscountValue)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
    }
}
