package dev.uit.project.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import dev.uit.project.domain.ChatConversation;

public interface ChatConversationRepository extends JpaRepository<ChatConversation, Long> {
}
