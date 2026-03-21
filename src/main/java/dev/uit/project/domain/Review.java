package dev.uit.project.domain;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "reviews")
public class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "review_seq")
    @SequenceGenerator(name = "review_seq", sequenceName = "REVIEW_SEQ", allocationSize = 1)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(nullable = false, precision = 2, scale = 1)
    private BigDecimal rating;

    @Column(columnDefinition = "CLOB")
    private String content;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private ReviewStatus status;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    @JsonFormat(pattern = "dd-MM-yyyy")
    private LocalDateTime createdAt;

    @ElementCollection
    @CollectionTable(name = "review_images", joinColumns = @JoinColumn(name = "review_id"))
    @Column(name = "image_url", length = 500, nullable = false)
    private List<String> images = new ArrayList<>();

    

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



    public void setStatus(ReviewStatus status) {
        this.status = status;
    }



    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }



    public void setImages(List<String> images) {
        this.images = images;
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



    public ReviewStatus getStatus() {
        return status;
    }



    public LocalDateTime getCreatedAt() {
        return createdAt;
    }



    public List<String> getImages() {
        return images;
    }



    public enum ReviewStatus {
        PENDING,
        APPROVED,
        REJECTED
    }
}
