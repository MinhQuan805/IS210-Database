package dev.uit.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import dev.uit.project.domain.Review.ReviewStatus;
import dev.uit.project.domain.dto.ReviewDTO;
import dev.uit.project.repository.ReviewRepository;
import jakarta.transaction.Transactional;

@Service
public class ReviewService {
    private final ReviewRepository ReviewRepository;

    public ReviewService(ReviewRepository ReviewRepository) {
        this.ReviewRepository = ReviewRepository;
    }

    @Transactional
    public List<ReviewDTO> getAllReviews(){
        return ReviewRepository.findAll().stream().map(ReviewDTO::fromEntity).toList();
    }

    @Transactional
    public List<ReviewDTO> getAllApprovedReviews() {
        return ReviewRepository.findAll().stream()
            .filter(r -> r.getStatus() == ReviewStatus.APPROVED)
            .map(ReviewDTO::fromEntity)
            .toList();
}
}
