import { api } from '@renderer/admin/lib/api'
import type {
  Room,
  RoomType,
  RoomStatus,
  CreateRoomTypeRequest,
  CreateRoomRequest,
  BulkCreateRoomRequest
} from './schema'

// Room Types API
export const roomTypesApi = {
  list: () => api.get<RoomType[]>('/admin/room-types'),
  create: (data: CreateRoomTypeRequest) => api.post<RoomType>('/admin/room-types', data),
  update: (id: number, data: CreateRoomTypeRequest) =>
    api.put<RoomType>(`/admin/room-types/${id}`, data),
  delete: (id: number) => api.delete<void>(`/admin/room-types/${id}`)
}

// Rooms API
export const roomsApi = {
  list: async (params: { roomTypeId?: number; status?: RoomStatus }): Promise<Room[]> => {
    const searchParams = new URLSearchParams()
    if (params.roomTypeId) searchParams.append('roomTypeId', String(params.roomTypeId))
    if (params.status) searchParams.append('status', params.status)
    const data = await api.get<Room[] | { content: Room[] }>(`/admin/rooms?${searchParams.toString()}`)
    if (Array.isArray(data)) return data
    if (data && Array.isArray(data.content)) return data.content
    return []
  },
  getById: (id: number) => api.get<Room>(`/admin/rooms/${id}`),
  create: (data: CreateRoomRequest) => api.post<Room>('/admin/rooms', data),
  bulkCreate: (data: BulkCreateRoomRequest) => api.post<Room[]>('/admin/rooms/bulk', data),
  update: (id: number, data: CreateRoomRequest) => api.put<Room>(`/admin/rooms/${id}`, data),
  delete: (id: number) => api.delete<void>(`/admin/rooms/${id}`),
  updateStatus: (id: number, status: RoomStatus) =>
    api.put<Room>(`/admin/rooms/${id}/status?status=${status}`, {}),
  available: (checkIn: string, checkOut: string, capacity: number = 1000) =>
    api.get<Room[]>(
      `/admin/rooms/availability?checkInDate=${checkIn}&checkOutDate=${checkOut}&capacity=${capacity}`
    )
}
