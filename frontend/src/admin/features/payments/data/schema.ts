import { z } from 'zod'

export const paymentStatusSchema = z.union([
  z.literal('SUCCESS'),
  z.literal('PENDING'),
  z.literal('FAILED')
])

export type PaymentStatus = z.infer<typeof paymentStatusSchema>

export const paymentSchema = z.object({
  id: z.number(),
  amount: z.number(),
  paymentDate: z.number(),
  status: paymentStatusSchema
})

export type Payment = z.infer<typeof paymentSchema>

export const createPaymentRequestSchema = z.object({
  bookingId: z.number(),
  amount: z.number()
})

export type CreatePaymentRequest = z.infer<typeof createPaymentRequestSchema>
