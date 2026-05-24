import { api } from '@renderer/admin/lib/api'
import type { Customer, CustomerStats, CustomerBooking, CreateCustomerRequest } from './schema'

// Spring Page response type
type PageResponse<T> = {
  content: T[]
  totalElements: number
  totalPages: number
  size: number
  number: number
}

export const customersApi = {
  list: async (keyword?: string): Promise<Customer[]> => {
    const params = keyword ? `?search=${encodeURIComponent(keyword)}` : ''
    const data = await api.get<Customer[] | PageResponse<Customer>>(`/admin/customers${params}`)
    // Handle both array and Page response
    if (Array.isArray(data)) return data
    if (data && Array.isArray(data.content)) return data.content
    return []
  },

  getById: (id: number) => api.get<Customer>(`/admin/customers/${id}`),

  getByEmail: (email: string) => api.get<Customer>(`/admin/customers/byemail/${email}`),

  create: (data: CreateCustomerRequest) => api.post<Customer>('/admin/customers', data),

  update: (id: number, data: CreateCustomerRequest) =>
    api.put<Customer>(`/admin/customers/${id}`, data),

  delete: (id: number) => api.delete<void>(`/admin/customers/${id}`),

  getStats: (id: number) => api.get<CustomerStats>(`/admin/customers/${id}/stats`),

  getBookings: (id: number) => api.get<CustomerBooking[]>(`/admin/customers/${id}/bookings`),

  exists: (email: string) => api.get<boolean>(`/admin/customers/exists/${email}`)
}
