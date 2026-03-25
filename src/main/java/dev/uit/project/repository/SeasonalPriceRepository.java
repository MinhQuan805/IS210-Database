package dev.uit.project.repository;

import dev.uit.project.domain.SeasonalPrice;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;

public interface SeasonalPriceRepository extends JpaRepository<SeasonalPrice, Long> {
    List<SeasonalPrice> findByRoomTypeIdOrderByPriorityDesc(Long roomTypeId);
    List<SeasonalPrice> findByRoomTypeIdAndStartDateLessThanEqualAndEndDateGreaterThanEqual(Long roomTypeId, LocalDate startDate, LocalDate endDate);
}
