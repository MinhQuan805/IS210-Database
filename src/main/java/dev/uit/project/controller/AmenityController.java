package dev.uit.project.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import dev.uit.project.domain.dto.AmenityDTO;
import dev.uit.project.service.AmenityService;

@RestController
@RequestMapping("/api/amenities")
@CrossOrigin(origins = "*")
public class AmenityController {
    private final AmenityService amenityService;

    public AmenityController(AmenityService amenityService) {
        this.amenityService = amenityService;
    }

    @GetMapping
    public ResponseEntity<List<AmenityDTO>> getAmenities() {
        return ResponseEntity.ok(amenityService.getAllAmenities());
    }
}
