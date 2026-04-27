import { api } from '@renderer/admin/lib/api'
import type { User, CreateUserRequest, UpdateUserRequest } from './schema'

export type PagedResponse<T> = {
  content: T[]
}

export type UsersListResponse = User[] | PagedResponse<User>

// User API
export const usersApi = {
  list: () => api.get<UsersListResponse>('/admin/users'),
  getById: (id: number) => api.get<User>(`/admin/users/${id}`),
  create: (data: CreateUserRequest) => api.post<User>('/admin/users', data),
  update: (id: number, data: UpdateUserRequest) => api.put<User>(`/admin/users/${id}`, data),
  delete: (id: number) => api.delete<void>(`/admin/users/${id}`)
}
