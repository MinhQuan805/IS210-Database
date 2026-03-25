package dev.uit.project.service;

import java.time.LocalDate;
import java.util.Comparator;
import java.util.List;

import org.springframework.stereotype.Service;

import dev.uit.project.domain.dto.RoomDTO;
import dev.uit.project.domain.dto.RoomDetailDTO;
import dev.uit.project.domain.dto.RoomTypeDTO;

import org.springframework.transaction.annotation.Transactional;

@Service
public class RoomDetailService {
    private final RoomService roomService;
    private final PricingService pricingService;

    public RoomDetailService(RoomService roomService, PricingService pricingService) {
        this.roomService = roomService;
        this.pricingService = pricingService;
    }

    @Transactional(readOnly = true)
    public List<RoomDetailDTO> getAvailableRoomDetails(LocalDate checkInDate, LocalDate checkOutDate, Integer capacity) {
        List<RoomDTO> roomDTOs = roomService.getAvailableRooms(checkInDate, checkOutDate, capacity);

        List<RoomDetailDTO> roomDetailDTOs = roomDTOs
            .stream()
            .map(roomDTO -> {
                RoomTypeDTO roomTypeDTO = roomService.getRoomTypeByRoomId(roomDTO.getId());

                return new RoomDetailDTO(
                    roomDTO.getRoomTypeName(),
                    roomTypeDTO.getDescription(),
                    roomDTO.getRoomNumber(),
                    roomDTO.getFloor(),
                    roomDTO.getNotes(),
                    roomTypeDTO.getAmenities(),
                    pricingService.getRawPrice(roomDTO.getRoomTypeId(), checkInDate, checkOutDate),
                    roomTypeDTO.getCapacity()
                );
            })
            .sorted(Comparator
                .comparing(RoomDetailDTO::getCapacity)
                .thenComparing(RoomDetailDTO::getRawPrice))
            .toList();

        return roomDetailDTOs;
    }
}
