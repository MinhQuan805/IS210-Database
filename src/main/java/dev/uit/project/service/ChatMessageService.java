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
        User sender = userRepository.findById(request.getSenderId())
                .orElseThrow(() -> new RuntimeException("Sender not found"));
        User recipient = userRepository.findById(request.getRecipientId())
                .orElseThrow(() -> new RuntimeException("Recipient not found"));

        ChatMessage newMessage = new ChatMessage();
        newMessage.setChatConversation(conversation);
        newMessage.setSender(sender);
        newMessage.setRecipient(recipient);
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
    public List<ChatMessageDTO> markConversationAsRead(Long chatConversationId, Long readerId) {
        if (chatConversationId == null || readerId == null) {
            throw new RuntimeException("Chat conversation id and reader id are required");
        }

        List<ChatMessage> messages = chatMessageRepository
                .findByChatConversationIdAndRecipientIdAndIsReadOrderByCreatedAtAsc(chatConversationId, readerId, UNREAD);
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
    public long countUnread(Long chatConversationId, Long recipientId) {
        if (chatConversationId == null || recipientId == null) {
            throw new RuntimeException("Chat conversation id and recipient id are required");
        }
        return chatMessageRepository.countByChatConversationIdAndRecipientIdAndIsRead(chatConversationId, recipientId,
                UNREAD);
    }

    @Transactional(readOnly = true)
    public long countUnreadByRecipient(Long recipientId) {
        if (recipientId == null) {
            throw new RuntimeException("Recipient id is required");
        }
        return chatMessageRepository.countByRecipientIdAndIsRead(recipientId, UNREAD);
    }

    @Transactional
    public void deleteMessage(Long messageId) {
        if (!chatMessageRepository.existsById(messageId)) {
            throw new RuntimeException("Chat message not found with id: " + messageId);
        }
        chatMessageRepository.deleteById(messageId);
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
}
