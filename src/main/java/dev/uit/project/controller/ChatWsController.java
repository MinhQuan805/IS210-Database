package dev.uit.project.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import dev.uit.project.domain.dto.ChatMessageDTO;
import dev.uit.project.service.ChatMessageService;

@Controller
public class ChatWsController {

    private final SimpMessagingTemplate messagingTemplate;
    private final ChatMessageService chatMessageService;

    public ChatWsController(SimpMessagingTemplate messagingTemplate, ChatMessageService chatMessageService) {
        this.messagingTemplate = messagingTemplate;
        this.chatMessageService = chatMessageService;
    }

    @MessageMapping("/chat")
    public void processMessage(@Payload ChatMessageDTO chatMessageDTO) {
        ChatMessageDTO savedMsg = chatMessageService.saveMessage(chatMessageDTO);
        
        // Broadcast to anyone listening on this conversation topic
        messagingTemplate.convertAndSend("/topic/chat/" + savedMsg.getChatConversationId(), savedMsg);
    }
}
