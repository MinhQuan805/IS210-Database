package dev.uit.project.controller.admin;

import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import dev.uit.project.domain.dto.ChatConversationDTO;
import dev.uit.project.domain.dto.ChatMessageDTO;
import dev.uit.project.service.ChatMessageService;

@RestController
@RequestMapping("/api/chats")
@CrossOrigin(origins = "*")
public class ChatMessageController {
    private final ChatMessageService chatMessageService;

    public ChatMessageController(ChatMessageService chatMessageService) {
        this.chatMessageService = chatMessageService;
    }

    @GetMapping("/conversations/user/{userId}")
    public ResponseEntity<List<ChatConversationDTO>> getUserConversations(@PathVariable Long userId) {
        return ResponseEntity.ok(chatMessageService.getConversationsByUserId(userId));
    }

    @GetMapping("/conversations/{conversationId}/messages")
    public ResponseEntity<List<ChatMessageDTO>> getConversationMessages(@PathVariable Long conversationId) {
        return ResponseEntity.ok(chatMessageService.getMessagesByConversation(conversationId));
    }

    @GetMapping("/conversations")
    public ResponseEntity<List<ChatConversationDTO>> getAllConversations() {
        return ResponseEntity.ok(chatMessageService.getAllConversations());
    }

    @PostMapping("/conversations")
    public ResponseEntity<ChatConversationDTO> getOrCreateConversation(@RequestParam String sessionId, @RequestParam(required = false) Long userId) {
        return ResponseEntity.ok(chatMessageService.getOrCreateConversation(sessionId, userId));
    }

    @DeleteMapping("/conversations/{id}")
    public ResponseEntity<Void> deleteConversation(@PathVariable Long id) {
        chatMessageService.deleteConversation(id);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/messages/{id}")
    public ResponseEntity<Void> deleteMessage(@PathVariable Long id) {
        chatMessageService.deleteMessage(id);
        return ResponseEntity.noContent().build();
    }
}
