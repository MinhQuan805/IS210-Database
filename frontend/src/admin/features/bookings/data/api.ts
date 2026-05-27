import { api } from '@renderer/admin/lib/api'
import type { Booking, BookingHistory, BookingStatus, CreateBookingRequest } from './schema'

const ADMIN_HEADERS = { 'Client-Type': 'ADMIN' }

export const bookingsApi = {
  list: async (params: { status?: BookingStatus; startDate?: string; endDate?: string }): Promise<Booking[]> => {
    const searchParams = new URLSearchParams()
    if (params.status) searchParams.append('status', params.status)
    if (params.startDate) searchParams.append('startDate', params.startDate)
    if (params.endDate) searchParams.append('endDate', params.endDate)
    const qs = searchParams.toString()
    const data = await api.get<Booking[] | { content: Booking[] }>(`/admin/bookings${qs ? `?${qs}` : ''}`)
    if (Array.isArray(data)) return data
    if (data && Array.isArray(data.content)) return data.content
    return []
  },
  getById: (id: number) => api.get<Booking>(`/admin/bookings/${id}`),

  create: (data: CreateBookingRequest) =>
    api.post<Booking>('/admin/bookings', data, ADMIN_HEADERS),

  update: (id: number, data: CreateBookingRequest) =>
    api.put<Booking>(`/admin/bookings/${id}`, data, ADMIN_HEADERS),

  delete: (id: number) => api.delete<void>(`/admin/bookings/${id}`),

  confirm: (id: number) => api.put<Booking>(`/admin/bookings/${id}/confirm`, {}, ADMIN_HEADERS),

  checkIn: (id: number) => api.put<Booking>(`/admin/bookings/${id}/check-in`, {}, ADMIN_HEADERS),

  checkOut: (id: number) => api.put<Booking>(`/admin/bookings/${id}/check-out`, {}, ADMIN_HEADERS),

  cancel: (id: number) => api.put<Booking>(`/admin/bookings/${id}/cancel`, {}, ADMIN_HEADERS),
  getHistory: (id: number) => api.get<BookingHistory[]>(`/admin/bookings/${id}/history`)
}
