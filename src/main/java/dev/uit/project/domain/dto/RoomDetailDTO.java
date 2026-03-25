package dev.uit.project.domain.dto;

import java.math.BigDecimal;
import java.util.List;

import dev.uit.project.domain.Amenity;

public class RoomDetailDTO {
    private String roomTypeName;
    private String roomTypeDescription;
    private String roomNumber;
    private Integer floor;
    private String notes;
    private List<Amenity> amenities;
    private BigDecimal rawPrice;
    private Integer capacity;

    public RoomDetailDTO() {
    }

    
    public RoomDetailDTO(String roomTypeName, String roomTypeDescription, String roomNumber, Integer floor,
            String notes, List<Amenity> amenities, BigDecimal rawPrice, Integer capacity) {
        this.roomTypeName = roomTypeName;
        this.roomTypeDescription = roomTypeDescription;
        this.roomNumber = roomNumber;
        this.floor = floor;
        this.notes = notes;
        this.amenities = amenities;
        this.rawPrice = rawPrice;
        this.capacity = capacity;
    }

    public String getRoomTypeName() {
        return roomTypeName;
    }

    public void setRoomTypeName(String roomTypeName) {
        this.roomTypeName = roomTypeName;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public Integer getFloor() {
        return floor;
    }

    public void setFloor(Integer floor) {
        this.floor = floor;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public List<Amenity> getAmenities() {
        return amenities;
    }

    public void setAmenities(List<Amenity> amenities) {
        this.amenities = amenities;
    }

    public BigDecimal getRawPrice() {
        return rawPrice;
    }

    public void setRawPrice(BigDecimal rawPrice) {
        this.rawPrice = rawPrice;
    }

    public Integer getCapacity() {
        return capacity;
    }

    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }

    public String getRoomTypeDescription() {
        return roomTypeDescription;
    }

    public void setRoomTypeDescription(String roomTypeDescription) {
        this.roomTypeDescription = roomTypeDescription;
    }

}
