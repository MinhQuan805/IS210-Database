package dev.uit.project.domain.dto;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import dev.uit.project.domain.ChatConversation;

public class ChatConversationDTO {

    private Long id;
    private String sessionId;
    private Long userId;
    private String userName;
    private String status;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime createdAt;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime updatedAt;
    private ChatMessageDTO lastMessage;

    public ChatConversationDTO() {
    }

    public static ChatConversationDTO fromEntity(ChatConversation conversation) {
        ChatConversationDTO dto = new ChatConversationDTO();
        dto.setId(conversation.getId());
        dto.setSessionId(conversation.getSessionId());
        if (conversation.getUser() != null) {
            dto.setUserId(conversation.getUser().getId());
            dto.setUserName(conversation.getUser().getFirstName() + " " + conversation.getUser().getLastName());
        }
        dto.setStatus(conversation.getStatus());
        dto.setCreatedAt(conversation.getCreatedAt());
        dto.setUpdatedAt(conversation.getUpdatedAt());
        if (conversation.getMessages() != null && !conversation.getMessages().isEmpty()) {
            dto.setLastMessage(ChatMessageDTO.fromEntity(
                conversation.getMessages().get(conversation.getMessages().size() - 1)
            ));
        }

        return dto;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public ChatMessageDTO getLastMessage() {
        return lastMessage;
    }

    public void setLastMessage(ChatMessageDTO lastMessage) {
        this.lastMessage = lastMessage;
    }
}
