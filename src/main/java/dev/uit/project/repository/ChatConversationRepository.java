package dev.uit.project.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import dev.uit.project.domain.ChatConversation;

public interface ChatConversationRepository extends JpaRepository<ChatConversation, Long> {
    
    @Query("SELECT c FROM ChatConversation c WHERE c.user.id = :userId ORDER BY c.updatedAt DESC")
    List<ChatConversation> findByUserId(@Param("userId") Long userId);
    
    java.util.Optional<ChatConversation> findBySessionId(String sessionId);
}
