import { useState, useEffect, useRef, useMemo } from 'react'
import { Search, MoreVertical, Send, Trash2, Smile } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { ScrollArea } from '@/components/ui/scroll-area'
import { Avatar, AvatarFallback } from '@/components/ui/avatar'
import { Client } from '@stomp/stompjs'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger
} from '@/components/ui/dropdown-menu'
import { toast } from 'sonner'

export interface ChatConversationDTO {
  id: number;
  sessionId: string;
  userId?: number;
  userName?: string;
  status: string;
  createdAt: string;
  updatedAt: string;
  lastMessage?: ChatMessageDTO;
}

export interface ChatMessageDTO {
  id?: number;
  chatConversationId: number;
  senderType: string;
  adminId?: number;
  adminName?: string;
  content: string;
  createdAt?: string;
}

export function Messages() {
  const [conversations, setConversations] = useState<ChatConversationDTO[]>([])
  const [activeConvId, setActiveConvId] = useState<number | null>(null)
  const [messages, setMessages] = useState<ChatMessageDTO[]>([])
  const [inputText, setInputText] = useState('')
  const [searchTerm, setSearchTerm] = useState('')

  const clientRef = useRef<Client | null>(null)
  const messagesEndRef = useRef<HTMLDivElement>(null)

  const fetchConversations = async () => {
    try {
      const res = await fetch('http://127.0.0.1:8080/api/chats/conversations')
      const data = await res.json()
      if (Array.isArray(data)) {
        setConversations(data)
        if (data.length > 0 && !activeConvId) {
          setActiveConvId(data[0].id)
        }
      } else {
        setConversations([])
      }
    } catch (e) {
      console.error('Failed to load conversations', e)
    }
  }

  useEffect(() => {
    fetchConversations()
    const interval = setInterval(fetchConversations, 10000)
    return () => clearInterval(interval)
  }, [activeConvId])

  useEffect(() => {
    if (!activeConvId) return

    const fetchMessages = async () => {
      try {
        const res = await fetch(`http://127.0.0.1:8080/api/chats/conversations/${activeConvId}/messages`)
        const data = await res.json()
        if (Array.isArray(data)) {
          setMessages(data)
        } else {
          setMessages([])
        }
        setTimeout(() => messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' }), 100)
      } catch (e) {
        console.error('Failed to load messages', e)
      }
    }
    fetchMessages()

    const client = new Client({
      brokerURL: 'ws://127.0.0.1:8080/ws',
      reconnectDelay: 5000,
    })

    client.onConnect = function () {
      client.subscribe(`/topic/chat/${activeConvId}`, (message) => {
        if (message.body) {
          const msg = JSON.parse(message.body)
          // Handle broadcasted message
          setMessages((prev) => {
            // Check if message already exists (e.g. if we get it via socket and list fetch overlap)
            if (msg.id && prev.some(m => m.id === msg.id)) return prev;
            return [...prev, msg]
          })
          setTimeout(() => messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' }), 100)
        }
      })
    }
    client.activate()
    clientRef.current = client

    return () => {
      if (clientRef.current) {
        clientRef.current.deactivate()
      }
    }
  }, [activeConvId])

  const filteredConversations = useMemo(() => {
    if (!searchTerm.trim()) return conversations;
    const lower = searchTerm.toLowerCase();
    return conversations.filter(c =>
      (c.userName && c.userName.toLowerCase().includes(lower)) ||
      c.sessionId.toLowerCase().includes(lower) ||
      (c.lastMessage && c.lastMessage.content.toLowerCase().includes(lower))
    );
  }, [conversations, searchTerm]);

  const handleSendMessage = (e?: React.FormEvent) => {
    if (e) e.preventDefault();
    if (!inputText.trim() || !activeConvId) return;

    if (clientRef.current && clientRef.current.connected) {
      const msg: ChatMessageDTO = {
        chatConversationId: activeConvId,
        senderType: 'ADMIN',
        adminId: 1, // Dummy admin ID
        content: inputText,
      };
      clientRef.current.publish({
        destination: '/app/chat',
        body: JSON.stringify(msg),
      });
      setInputText('');
    }
  };

  const handleDeleteConversation = async (id: number) => {
    if (!confirm('Are you sure you want to delete this conversation?')) return;
    try {
      const res = await fetch(`http://127.0.0.1:8080/api/chats/conversations/${id}`, {
        method: 'DELETE'
      });
      if (res.ok) {
        toast.success('Conversation deleted');
        setConversations(prev => prev.filter(c => c.id !== id));
        if (activeConvId === id) setActiveConvId(null);
      }
    } catch (e) {
      toast.error('Failed to delete conversation');
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
      toast.error('Failed to delete message');
    }
  };

  const activeConv = conversations.find(c => c.id === activeConvId)

  return (
    <div className="flex h-[calc(100vh-theme(spacing.16))] gap-4 p-4 md:p-6 bg-slate-50/50 dark:bg-slate-950/50">
      {/* Left Sidebar */}
      <div className="flex w-80 flex-col rounded-2xl bg-white dark:bg-slate-900 shadow-sm border dark:border-slate-800">
        <div className="p-4">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-xl font-bold dark:text-white">Chats</h2>
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="ghost" size="icon" className="h-8 w-8 text-muted-foreground">
                  <MoreVertical className="h-5 w-5" />
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end">
                <DropdownMenuItem onClick={fetchConversations}>Refresh List</DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </div>
          <div className="relative">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
            <Input
              placeholder="Search..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="pl-9 bg-gray-50/50 dark:bg-slate-800/50 border-gray-200 dark:border-slate-700 dark:text-white"
            />
          </div>
        </div>

        <ScrollArea className="flex-1 px-3">
          <div className="flex flex-col gap-1 pb-4">
            {filteredConversations.map((conv) => (
              <div key={conv.id} className="relative group">
                <button
                  onClick={() => setActiveConvId(conv.id)}
                  className={`flex w-full items-center gap-3 rounded-xl p-3 text-left transition-colors hover:bg-muted/50 dark:hover:bg-slate-800/50 ${activeConvId === conv.id ? 'bg-muted/50 dark:bg-slate-800/50' : ''
                    }`}
                >
                  <div className="relative">
                    <Avatar className="h-12 w-12 border border-slate-100 dark:border-slate-700">
                      <AvatarFallback className="bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-400 font-medium">
                        {conv.userName ? conv.userName.substring(0, 2).toUpperCase() : 'G'}
                      </AvatarFallback>
                    </Avatar>
                  </div>
                  <div className="flex-1 overflow-hidden">
                    <div className="font-semibold text-sm truncate dark:text-white">{conv.userName || `Guest (${conv.sessionId.substring(0, 6)})`}</div>
                    <div className="text-xs text-muted-foreground truncate mt-0.5">
                      {conv.lastMessage?.content || 'No messages yet'}
                    </div>
                  </div>
                  <div className="text-[11px] text-muted-foreground whitespace-nowrap self-start mt-1">
                    {conv.updatedAt ? new Date(conv.updatedAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) : ''}
                  </div>
                </button>
                <button
                  onClick={() => handleDeleteConversation(conv.id)}
                  className="absolute right-2 top-2 mt-6 opacity-0 group-hover:opacity-100 transition-opacity p-1 text-red-500 hover:bg-red-50 dark:hover:bg-red-950/30 rounded-md"
                >
                  <Trash2 size={14} />
                </button>
              </div>
            ))}
            {filteredConversations.length === 0 && (
              <div className="text-center text-sm text-muted-foreground mt-10">
                {searchTerm ? 'No results found' : 'No conversations yet'}
              </div>
            )}
          </div>
        </ScrollArea>
      </div>

      {/* Main Chat Area */}
      <div className="flex flex-1 flex-col rounded-2xl bg-white dark:bg-slate-900 shadow-sm border dark:border-slate-800 overflow-hidden">
        {activeConv ? (
          <>
            {/* Header */}
            <div className="flex items-center justify-between border-b dark:border-slate-800 px-6 py-4">
              <div className="flex items-center gap-3">
                <div className="relative">
                  <Avatar className="h-10 w-10 border border-slate-100 dark:border-slate-700">
                    <AvatarFallback className="bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-400 font-medium">
                      {activeConv.userName ? activeConv.userName.substring(0, 2).toUpperCase() : 'G'}
                    </AvatarFallback>
                  </Avatar>
                </div>
                <h2 className="font-semibold text-sm dark:text-white">{activeConv.userName || `Guest (${activeConv.sessionId.substring(0, 6)})`}</h2>
              </div>
              <div className="flex items-center gap-2">
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button variant="ghost" size="icon" className="text-muted-foreground hover:text-foreground h-9 w-9">
                      <MoreVertical className="h-4 w-4" />
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent align="end">
                    <DropdownMenuItem onClick={() => handleDeleteConversation(activeConv.id)} className="text-red-600">
                      Delete Conversation
                    </DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
              </div>
            </div>

            {/* Messages */}
            <ScrollArea className="flex-1 p-6">
              <div className="flex flex-col gap-6">
                {Array.isArray(messages) && messages.map((msg, index) => {
                  const isAdmin = msg.senderType === 'ADMIN';

                  return isAdmin ? (
                    <div key={msg.id || index} className="flex items-start gap-3 flex-row-reverse group">
                      <div className="flex flex-col gap-1 max-w-[70%] items-end relative">
                        <div className="rounded-2xl rounded-tr-none bg-blue-600 px-4 py-3 text-[14px] text-white shadow-sm">
                          {msg.content}
                        </div>
                        <div className="flex items-center gap-2 mt-1">
                          <span className="text-[11px] text-muted-foreground">
                            {msg.createdAt ? new Date(msg.createdAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) : ''}
                          </span>
                          {msg.id && (
                            <button
                              onClick={() => handleDeleteMessage(msg.id!)}
                              className="opacity-0 group-hover:opacity-100 transition-opacity text-red-400 hover:text-red-500"
                            >
                              <Trash2 size={12} />
                            </button>
                          )}
                        </div>
                      </div>
                    </div>
                  ) : (
                    <div key={msg.id || index} className="flex items-start gap-3 group">
                      <Avatar className="h-8 w-8 border border-slate-100 dark:border-slate-700 shrink-0">
                        <AvatarFallback className="bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-400 font-medium text-xs">
                          {activeConv.userName ? activeConv.userName.substring(0, 2).toUpperCase() : 'G'}
                        </AvatarFallback>
                      </Avatar>
                      <div className="flex flex-col gap-1 max-w-[70%] relative">
                        <div className="rounded-2xl rounded-tl-none bg-slate-100 dark:bg-slate-800 px-4 py-3 text-[14px] text-slate-700 dark:text-slate-200 shadow-sm border dark:border-slate-700">
                          {msg.content}
                        </div>
                        <div className="flex items-center gap-2 mt-1">
                          <span className="text-[11px] text-muted-foreground">
                            {msg.createdAt ? new Date(msg.createdAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) : ''}
                          </span>
                          {msg.id && (
                            <button
                              onClick={() => handleDeleteMessage(msg.id!)}
                              className="opacity-0 group-hover:opacity-100 transition-opacity text-red-400 hover:text-red-500"
                            >
                              <Trash2 size={12} />
                            </button>
                          )}
                        </div>
                      </div>
                    </div>
                  )
                })}
                <div ref={messagesEndRef} />
              </div>
            </ScrollArea>

            {/* Input Area */}
            <div className="border-t dark:border-slate-800 p-4 px-6 bg-white dark:bg-slate-900 flex items-center gap-3">
              <form onSubmit={handleSendMessage} className="flex-1 flex gap-2">
                <Input
                  placeholder="Type a message"
                  value={inputText}
                  onChange={(e) => setInputText(e.target.value)}
                  className="border-0 bg-gray-50 dark:bg-slate-800 focus-visible:ring-1 focus-visible:ring-blue-500 px-4 shadow-none text-[15px] rounded-full dark:text-white"
                />
                <Button type="submit" disabled={!inputText.trim()} size="icon" className="bg-blue-600 hover:bg-blue-700 rounded-full h-10 w-10 shrink-0 shadow-sm">
                  <Send className="h-4 w-4" />
                </Button>
              </form>
            </div>
          </>
        ) : (
          <div className="flex flex-1 items-center justify-center text-muted-foreground dark:text-slate-500">
            <div className="text-center">
              <div className="mb-4 flex justify-center">
                <div className="p-4 rounded-full bg-slate-100 dark:bg-slate-800">
                  <Smile className="h-10 w-10" />
                </div>
              </div>
              <p>Select a conversation to start chatting</p>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
