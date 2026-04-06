import { CreatePaymentRequest } from '@renderer/admin/features/payments/data/schema'
import { api } from '@renderer/admin/lib/api'
import { Payment } from 'electron'

export const paymentApi = {
  create: (data: CreatePaymentRequest) => api.post<Payment>(`/admin/payment`, data)
}
