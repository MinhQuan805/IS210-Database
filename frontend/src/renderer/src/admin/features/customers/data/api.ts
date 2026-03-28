import { api } from '@renderer/admin/lib/api'
import type { Customer, CustomerStats, CustomerBooking, CreateCustomerRequest } from './schema'

export const customersApi = {
  list: (keyword?: string) => {
    const params = keyword ? `?keyword=${encodeURIComponent(keyword)}` : ''
    return api.get<Customer[]>(`/admin/customers${params}`)
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
