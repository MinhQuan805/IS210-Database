package dev.uit.project.domain.dto;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import dev.uit.project.domain.ChatMessage;

public class ChatMessageDTO {

    private Long id;
    private Long chatConversationId;
    private String senderType; // 'CLIENT' or 'ADMIN'
    private Long adminId;
    private String adminName;
    private String content;
    private Integer isRead;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime readAt;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime createdAt;

    public ChatMessageDTO() {
    }

    public static ChatMessageDTO fromEntity(ChatMessage message) {
        ChatMessageDTO dto = new ChatMessageDTO();
        dto.setId(message.getId());
        dto.setChatConversationId(message.getChatConversation().getId());
        dto.setSenderType(message.getSenderType());
        if (message.getAdmin() != null) {
            dto.setAdminId(message.getAdmin().getId());
            dto.setAdminName(message.getAdmin().getFirstName() + " " + message.getAdmin().getLastName());
        }
        dto.setContent(message.getContent());
        dto.setIsRead(message.getIsRead());
        dto.setReadAt(message.getReadAt());
        dto.setCreatedAt(message.getCreatedAt());
        return dto;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getChatConversationId() {
        return chatConversationId;
    }

    public void setChatConversationId(Long chatConversationId) {
        this.chatConversationId = chatConversationId;
    }

    public String getSenderType() {
        return senderType;
    }

    public void setSenderType(String senderType) {
        this.senderType = senderType;
    }

    public Long getAdminId() {
        return adminId;
    }

    public void setAdminId(Long adminId) {
        this.adminId = adminId;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getIsRead() {
        return isRead;
    }

    public void setIsRead(Integer isRead) {
        this.isRead = isRead;
    }

    public LocalDateTime getReadAt() {
        return readAt;
    }

    public void setReadAt(LocalDateTime readAt) {
        this.readAt = readAt;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
