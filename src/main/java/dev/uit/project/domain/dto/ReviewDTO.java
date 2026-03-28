package dev.uit.project.domain.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;



import dev.uit.project.domain.Review;
import dev.uit.project.domain.Review.ReviewStatus;
import dev.uit.project.domain.User;

public class ReviewDTO {
    private Long id;
    private User user;
    private BigDecimal rating;
    private String content;
    private Review.ReviewStatus status;
    private LocalDateTime createdAt;
    private List<String> images;
    
    public ReviewDTO(Long id, User user, BigDecimal rating, String content, ReviewStatus status,
            LocalDateTime createdAt, List<String> images) {
        this.id = id;
        this.user = user;
        this.rating = rating;
        this.content = content;
        this.status = status;
        this.createdAt = createdAt;
        this.images = images;
    }

    public static ReviewDTO fromEntity(Review review) {
        return new ReviewDTO(review.getId(), review.getUser(), review.getRating(), review.getContent(), review.getStatus(), review.getCreatedAt(), review.getImages());
    }

    public Long getId() {
        return id;
    }

    public User getUser() {
        return user;
    }

    public BigDecimal getRating() {
        return rating;
    }

    public String getContent() {
        return content;
    }

    public Review.ReviewStatus getStatus() {
        return status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public List<String> getImages() {
        return images;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setRating(BigDecimal rating) {
        this.rating = rating;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setStatus(Review.ReviewStatus status) {
        this.status = status;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    
}
