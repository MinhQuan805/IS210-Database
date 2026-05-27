import { amenitiesSchema } from '@renderer/admin/features/amenities/data/schema'
import {
  bookingHistorySchema,
  bookingStatusSchema
} from '@renderer/admin/features/bookings/data/schema'
import { paymentSchema } from '@renderer/admin/features/payments/data/schema'
import { policySchema } from '@renderer/admin/features/policies/data/schema'
import { promotionSchema } from '@renderer/admin/features/pricing/data/schema'
import { z } from 'zod'

export const bookingDetailSchema = z.object({
  id: z.number(),
  customerName: z.string(),
  customerEmail: z.string(),
  checkInDate: z.string(),
  checkOutDate: z.string(),
  totalPrice: z.number(),
  rawPrice: z.number(),
  discountAmount: z.number(),
  status: bookingStatusSchema,
  specialRequests: z.string().nullable().optional(),
  roomNumber: z.string(),
  floor: z.number(),
  payments: z.array(paymentSchema),
  history: z.array(bookingHistorySchema),
  promotions: z.array(promotionSchema),
  policies: z.array(policySchema),
  amenities: z.array(amenitiesSchema)
})

export type BookingDetail = z.infer<typeof bookingDetailSchema>
