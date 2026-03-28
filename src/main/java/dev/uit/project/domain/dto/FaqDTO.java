package dev.uit.project.domain.dto;

import java.time.LocalDateTime;



import dev.uit.project.domain.Faq;

public class FaqDTO {
    private Long id;
    private String question;
    private String answer;
    private Integer isActive;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public FaqDTO(Long id, String question, String answer, Integer isActive, LocalDateTime createdAt,
            LocalDateTime updatedAt) {
        this.id = id;
        this.question = question;
        this.answer = answer;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public static FaqDTO fromEntity(Faq faq) {
        return new FaqDTO(faq.getId(), faq.getQuestion(), faq.getAnswer(), faq.getIsActive(), faq.getCreatedAt(), faq.getUpdatedAt());
    }

    public Long getId() {
        return id;
    }

    public String getQuestion() {
        return question;
    }

    public String getAnswer() {
        return answer;
    }

    public Integer getIsActive() {
        return isActive;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public void setIsActive(Integer isActive) {
        this.isActive = isActive;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    
}
