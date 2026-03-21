package dev.uit.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import dev.uit.project.domain.dto.AmenityDTO;
import dev.uit.project.repository.AmenityRepository;
import jakarta.transaction.Transactional;

@Service
public class AmenityService {
    private final AmenityRepository amenityRepository;

    public AmenityService(AmenityRepository amenityRepository) {
        this.amenityRepository = amenityRepository;
    }

    @Transactional
    public List<AmenityDTO> getAllAmenities(){
        return amenityRepository.findAll().stream().map(AmenityDTO::fromEntity).toList();
    }
}
