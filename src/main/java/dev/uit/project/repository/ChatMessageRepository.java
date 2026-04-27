package dev.uit.project.repository;

import dev.uit.project.domain.ChatMessage;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;
import java.util.Optional;

public interface ChatMessageRepository extends JpaRepository<ChatMessage, Long>, JpaSpecificationExecutor<ChatMessage> {
    List<ChatMessage> findByChatConversationIdOrderByCreatedAtAsc(Long chatConversationId);

    Page<ChatMessage> findByChatConversationId(Long chatConversationId, Pageable pageable);

    Page<ChatMessage> findByChatConversationIdAndContentContainingIgnoreCase(Long chatConversationId, String content,
                                                                             Pageable pageable);

    Optional<ChatMessage> findTopByChatConversationIdOrderByCreatedAtDesc(Long chatConversationId);

    List<ChatMessage> findByChatConversationIdAndSenderTypeAndIsReadOrderByCreatedAtAsc(Long chatConversationId,
                                                                                         String senderType,
                                                                                         Integer isRead);

    long countByChatConversationIdAndSenderTypeAndIsRead(Long chatConversationId, String senderType, Integer isRead);

    long countBySenderTypeAndIsRead(String senderType, Integer isRead);

    void deleteByChatConversationId(Long chatConversationId);
}
