package dev.uit.project.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import dev.uit.project.domain.dto.ReviewDTO;
import dev.uit.project.service.ReviewService;

@RestController
@RequestMapping("/api/reviews")
@CrossOrigin(origins = "*")
public class ReviewController {
    private final ReviewService reviewService;

    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @GetMapping
    public ResponseEntity<List<ReviewDTO>> getReviews() {
        return ResponseEntity.ok(reviewService.getAllReviews());
    }

    @GetMapping("/approved")
    public ResponseEntity<List<ReviewDTO>> getApprovedReviews() {
        return ResponseEntity.ok(reviewService.getAllApprovedReviews());
    }
}
