import { useState, useEffect, useRef } from 'react';
import { Client } from '@stomp/stompjs';
import { MessageCircle, X, Send, User, ChevronDown, RefreshCw, Minus, Trash2 } from 'lucide-react';
import { Button } from './ui/button';
import { ScrollArea } from './ui/scroll-area';
import { toast } from 'sonner';

export interface Message {
  id?: number;
  chatConversationId: number;
  senderType: string;
  adminId?: number;
  adminName?: string;
  content: string;
  createdAt?: string;
}

export function ChatWidget() {
  const [isOpen, setIsOpen] = useState(false);
  const [messages, setMessages] = useState<Message[]>([]);
  const [inputText, setInputText] = useState('');
  const [conversationId, setConversationId] = useState<number | null>(null);

  const clientRef = useRef<Client | null>(null);
  const messagesEndRef = useRef<HTMLDivElement>(null);

  const fetchMessages = async (id: number) => {
    try {
      const msgRes = await fetch(`http://127.0.0.1:8080/api/chats/conversations/${id}/messages`);
      const msgs = await msgRes.json();
      if (Array.isArray(msgs)) {
        setMessages(msgs);
      }
    } catch (e) {
      console.error('Failed to load messages:', e);
    }
  };

  const initChat = async () => {
    let sessionId = localStorage.getItem('chatSessionId');
    if (!sessionId) {
      sessionId = crypto.randomUUID();
      localStorage.setItem('chatSessionId', sessionId);
    }

    try {
      const res = await fetch(`http://127.0.0.1:8080/api/chats/conversations?sessionId=${sessionId}`, {
        method: 'POST'
      });
      const data = await res.json();

      if (data && data.id) {
        setConversationId(data.id);
        await fetchMessages(data.id);

        if (clientRef.current) {
            clientRef.current.deactivate();
        }

        const client = new Client({
          brokerURL: 'ws://127.0.0.1:8080/ws',
          reconnectDelay: 5000,
        });

        client.onConnect = function () {
          client.subscribe(`/topic/chat/${data.id}`, (message) => {
            if (message.body) {
              const msg: Message = JSON.parse(message.body);
              setMessages((prev) => {
                if (msg.id && prev.some(m => m.id === msg.id)) return prev;
                return [...prev, msg];
              });
            }
          });
        };

        client.activate();
        clientRef.current = client;
      }
    } catch (e) {
      console.error('Failed to init chat:', e);
    }
  };

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages]);

  useEffect(() => {
    if (isOpen) {
      initChat();
    }
    return () => {
      if (clientRef.current) {
        clientRef.current.deactivate();
      }
    };
  }, [isOpen]);

  const handleSendMessage = (e: React.FormEvent) => {
    e.preventDefault();
    if (!inputText.trim() || !conversationId) return;

    if (clientRef.current && clientRef.current.connected) {
      const msg: Message = {
        chatConversationId: conversationId,
        senderType: 'CLIENT',
        content: inputText,
      };
      clientRef.current.publish({
        destination: '/app/chat',
        body: JSON.stringify(msg),
      });
      setInputText('');
    }
  };

  const handleDeleteMessage = async (id: number) => {
    try {
      const res = await fetch(`http://127.0.0.1:8080/api/chats/messages/${id}`, {
        method: 'DELETE'
      });
      if (res.ok) {
        setMessages(prev => prev.filter(m => m.id !== id));
      }
    } catch (e) {
      console.error('Failed to delete message');
    }
  };

  const handleClearChat = async () => {
    if (!conversationId) return;
    if (!confirm('Clear all chat history?')) return;
    
    try {
      const res = await fetch(`http://127.0.0.1:8080/api/chats/conversations/${conversationId}`, {
        method: 'DELETE'
      });
      if (res.ok) {
        setMessages([]);
        setConversationId(null);
        initChat(); // Re-initialize to get a new conversation
      }
    } catch (e) {
      console.error('Failed to clear chat');
    }
  };

  if (!isOpen) {
    return (
      <Button
        onClick={() => setIsOpen(true)}
        className="fixed bottom-6 right-6 h-14 w-14 rounded-full shadow-lg"
        size="icon"
      >
        <MessageCircle className="h-6 w-6" />
      </Button>
    );
  }

  return (
    <div className="fixed bottom-6 right-6 z-50 flex h-[500px] w-[350px] flex-col overflow-hidden rounded-xl border bg-background shadow-xl">
      {/* Header */}
      <div className="flex items-center justify-between bg-[#545454] p-3 text-white">
        <div className="flex items-center gap-2">
          <div className="flex h-8 w-8 items-center justify-center rounded-full bg-[#fed100] text-black font-bold">
            <span className="text-xs">Ad</span>
          </div>
          <div>
            <h3 className="font-semibold text-[15px] leading-none text-white">LUMINA SUITES</h3>
          </div>
        </div>
        <div className="flex gap-2">
          <Button variant="ghost" size="icon" onClick={() => conversationId && fetchMessages(conversationId)} className="h-7 w-7 text-white hover:bg-white/20 rounded-md bg-white/10">
            <RefreshCw size={14} />
          </Button>
          <Button variant="ghost" size="icon" onClick={handleClearChat} className="h-7 w-7 text-white hover:bg-white/20 rounded-md bg-white/10">
            <Trash2 size={14} />
          </Button>
          <Button variant="ghost" size="icon" onClick={() => setIsOpen(false)} className="h-7 w-7 text-white hover:bg-white/20 rounded-md bg-white/10">
            <Minus size={16} />
          </Button>
        </div>
      </div>

      {/* Messages */}
      <ScrollArea className="flex-1 p-4 bg-muted/30">
        <div className="flex flex-col gap-3">
          <div className="flex gap-2">
            <div className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-[#fed100] text-black mt-1">
              <span className="text-[8px] font-bold">Ad</span>
            </div>
            <div className="flex flex-col gap-2 w-full">
              <div className="self-start rounded-2xl bg-[#f2f2f2] px-4 py-3 text-[15px] text-gray-800 max-w-[90%] shadow-sm">
                Em rất sẵn lòng hỗ trợ Anh/Chị 😊
              </div>
            </div>
          </div>

          {Array.isArray(messages) && messages.map((msg, index) => {
            const isMe = msg.senderType === 'CLIENT';
            return (
              <div
                key={msg.id || index}
                className={`flex max-w-[85%] flex-col gap-1 group relative ${isMe ? 'self-end' : 'self-start'}`}
              >
                <div className={`px-4 py-2 text-sm shadow-sm ${isMe
                  ? 'rounded-2xl rounded-tr-none bg-primary text-primary-foreground'
                  : 'rounded-2xl rounded-tl-none bg-muted text-gray-800'
                  }`}>
                  <span>{msg.content}</span>
                </div>
                
                <div className={`flex items-center gap-2 mt-1 ${isMe ? 'flex-row-reverse' : ''}`}>
                    <span className="text-[10px] opacity-70">
                      {msg.createdAt ? new Date(msg.createdAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) : new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                    </span>
                    {msg.id && (
                        <button 
                          onClick={() => handleDeleteMessage(msg.id!)}
                          className="opacity-0 group-hover:opacity-100 transition-opacity text-red-400 hover:text-red-500"
                        >
                          <Trash2 size={10} />
                        </button>
                    )}
                </div>
              </div>
            );
          })}
          <div ref={messagesEndRef} />
        </div>
      </ScrollArea>

      {/* Input */}
      <div className="bg-white p-3 pt-2">
        <form onSubmit={handleSendMessage} className="relative flex items-center">
          <input
            type="text"
            value={inputText}
            onChange={(e) => setInputText(e.target.value)}
            placeholder="Nhập tin nhắn..."
            className="w-full rounded-full border border-gray-300 bg-white pl-4 pr-12 py-3 text-[15px] focus:border-gray-400 focus:outline-none"
          />
          <button type="submit" className="absolute right-2 top-1/2 -translate-y-1/2 flex h-9 w-9 items-center justify-center rounded-full text-white bg-primary hover:bg-primary/90 disabled:bg-gray-300" disabled={!inputText.trim()}>
            <Send className="h-5 w-5" />
          </button>
        </form>
      </div>
    </div>
  );
}
