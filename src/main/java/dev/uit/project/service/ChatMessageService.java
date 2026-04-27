package dev.uit.project.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dev.uit.project.domain.ChatConversation;
import dev.uit.project.domain.ChatMessage;
import dev.uit.project.domain.User;
import dev.uit.project.domain.dto.ChatMessageDTO;
import dev.uit.project.repository.ChatConversationRepository;
import dev.uit.project.repository.ChatMessageRepository;
import dev.uit.project.repository.UserRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatMessageService {
    private static final int UNREAD = 0;
    private static final int READ = 1;

    private final ChatMessageRepository chatMessageRepository;
    private final ChatConversationRepository chatConversationRepository;
    private final UserRepository userRepository;

    @Transactional(readOnly = true)
    public Page<ChatMessageDTO> getAllChatMessage(Long chatConversationId) {
        Specification<ChatMessage> spec = Specification.where((root, query, cb) -> cb.conjunction());
        if (chatConversationId != null) {
            spec = spec.and((root, query, cb) -> cb.equal(root.get("chatConversation").get("id"), chatConversationId));
        }
        return chatMessageRepository.findAll(spec, Pageable.unpaged()).map(ChatMessageDTO::fromEntity);
    }

    @Transactional(readOnly = true)
    public List<ChatMessageDTO> getMessagesByConversation(Long chatConversationId) {
        if (chatConversationId == null) {
            throw new RuntimeException("Chat conversation id is required");
        }
        return chatMessageRepository.findByChatConversationIdOrderByCreatedAtAsc(chatConversationId)
                .stream().map(ChatMessageDTO::fromEntity).toList();
    }

    @Transactional(readOnly = true)
    public Page<ChatMessageDTO> getMessagesByConversation(Long chatConversationId, Pageable pageable) {
        if (chatConversationId == null) {
            throw new RuntimeException("Chat conversation id is required");
        }
        Pageable resolvedPageable = pageable == null ? Pageable.unpaged() : pageable;
        return chatMessageRepository.findByChatConversationId(chatConversationId, resolvedPageable)
                .map(ChatMessageDTO::fromEntity);
    }

    @Transactional(readOnly = true)
    public ChatMessageDTO getLastMessage(Long chatConversationId) {
        if (chatConversationId == null) {
            throw new RuntimeException("Chat conversation id is required");
        }
        return chatMessageRepository.findTopByChatConversationIdOrderByCreatedAtDesc(chatConversationId)
                .map(ChatMessageDTO::fromEntity)
                .orElse(null);
    }

    @Transactional
    public ChatMessageDTO saveMessage(ChatMessageDTO request) {
        ChatConversation conversation = chatConversationRepository.findById(request.getChatConversationId())
                .orElseThrow(() -> new RuntimeException("Chat conversation not found"));

        ChatMessage newMessage = new ChatMessage();
        newMessage.setChatConversation(conversation);
        newMessage.setSenderType(request.getSenderType());
        
        if ("ADMIN".equals(request.getSenderType())) {
            if (request.getAdminId() != null) {
                User admin = userRepository.findById(request.getAdminId())
                        .orElseThrow(() -> new RuntimeException("Admin not found"));
                newMessage.setAdmin(admin);
            }
        }
        newMessage.setContent(request.getContent());
        return ChatMessageDTO.fromEntity(chatMessageRepository.save(newMessage));
    }

    @Transactional
    public ChatMessageDTO markAsRead(Long messageId) {
        ChatMessage message = chatMessageRepository.findById(messageId)
                .orElseThrow(() -> new RuntimeException("Chat message not found with id: " + messageId));
        if (message.getIsRead() == null || message.getIsRead() == UNREAD) {
            message.setIsRead(READ);
            message.setReadAt(LocalDateTime.now());
        }
        return ChatMessageDTO.fromEntity(chatMessageRepository.save(message));
    }

    @Transactional
    public List<ChatMessageDTO> markConversationAsRead(Long chatConversationId, String readerType) {
        if (chatConversationId == null || readerType == null) {
            throw new RuntimeException("Chat conversation id and reader type are required");
        }

        String targetSenderType = "CLIENT".equals(readerType) ? "ADMIN" : "CLIENT";

        List<ChatMessage> messages = chatMessageRepository
                .findByChatConversationIdAndSenderTypeAndIsReadOrderByCreatedAtAsc(chatConversationId, targetSenderType, UNREAD);
        if (messages.isEmpty()) {
            return List.of();
        }

        LocalDateTime readAt = LocalDateTime.now();
        for (ChatMessage message : messages) {
            message.setIsRead(READ);
            message.setReadAt(readAt);
        }

        return chatMessageRepository.saveAll(messages)
                .stream().map(ChatMessageDTO::fromEntity).toList();
    }

    @Transactional(readOnly = true)
    public long countUnread(Long chatConversationId, String readerType) {
        if (chatConversationId == null || readerType == null) {
            throw new RuntimeException("Chat conversation id and reader type are required");
        }
        String targetSenderType = "CLIENT".equals(readerType) ? "ADMIN" : "CLIENT";
        return chatMessageRepository.countByChatConversationIdAndSenderTypeAndIsRead(chatConversationId, targetSenderType, UNREAD);
    }

    @Transactional(readOnly = true)
    public long countUnreadByReaderType(String readerType) {
        if (readerType == null) {
            throw new RuntimeException("Reader type is required");
        }
        String targetSenderType = "CLIENT".equals(readerType) ? "ADMIN" : "CLIENT";
        return chatMessageRepository.countBySenderTypeAndIsRead(targetSenderType, UNREAD);
    }

    @Transactional
    public void deleteMessage(Long messageId) {
        if (!chatMessageRepository.existsById(messageId)) {
            throw new RuntimeException("Chat message not found with id: " + messageId);
        }
        chatMessageRepository.deleteById(messageId);
    }

    @Transactional
    public void deleteConversation(Long conversationId) {
        ChatConversation conversation = chatConversationRepository.findById(conversationId)
                .orElseThrow(() -> new RuntimeException("Chat conversation not found with id: " + conversationId));
        // Delete all messages first if not using cascade delete
        chatMessageRepository.deleteByChatConversationId(conversationId);
        chatConversationRepository.delete(conversation);
    }

    @Transactional(readOnly = true)
    public Page<ChatMessageDTO> searchMessages(Long chatConversationId, String keyword, Pageable pageable) {
        if (chatConversationId == null) {
            throw new RuntimeException("Chat conversation id is required");
        }

        Pageable resolvedPageable = pageable == null ? Pageable.unpaged() : pageable;
        if (keyword == null || keyword.isBlank()) {
            return chatMessageRepository.findByChatConversationId(chatConversationId, resolvedPageable)
                    .map(ChatMessageDTO::fromEntity);
        }

        return chatMessageRepository
                .findByChatConversationIdAndContentContainingIgnoreCase(chatConversationId, keyword, resolvedPageable)
                .map(ChatMessageDTO::fromEntity);
    }

    @Transactional(readOnly = true)
    public List<dev.uit.project.domain.dto.ChatConversationDTO> getConversationsByUserId(Long userId) {
        return chatConversationRepository.findByUserId(userId)
                .stream().map(dev.uit.project.domain.dto.ChatConversationDTO::fromEntity).toList();
    }
    
    @Transactional(readOnly = true)
    public List<dev.uit.project.domain.dto.ChatConversationDTO> getAllConversations() {
        return chatConversationRepository.findAll()
                .stream().map(dev.uit.project.domain.dto.ChatConversationDTO::fromEntity).toList();
    }

    @Transactional
    public dev.uit.project.domain.dto.ChatConversationDTO getOrCreateConversation(String sessionId, Long userId) {
        if (sessionId == null) {
            throw new IllegalArgumentException("Session ID must not be null");
        }
        return chatConversationRepository.findBySessionId(sessionId)
                .map(dev.uit.project.domain.dto.ChatConversationDTO::fromEntity)
                .orElseGet(() -> {
                    ChatConversation conversation = new ChatConversation();
                    conversation.setSessionId(sessionId);
                    if (userId != null) {
                        User u1 = userRepository.findById(userId).orElse(null);
                        conversation.setUser(u1);
                    }
                    return dev.uit.project.domain.dto.ChatConversationDTO.fromEntity(chatConversationRepository.save(conversation));
                });
    }
}
