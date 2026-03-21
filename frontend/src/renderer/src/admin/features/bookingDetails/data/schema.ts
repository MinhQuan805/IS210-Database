import {
  bookingHistoryListSchema,
  bookingSchema
} from '@renderer/admin/features/bookings/data/schema'
import { policyListSchema } from '@renderer/admin/features/policies/data/schema'
import { promotionSchema } from '@renderer/admin/features/pricing/data/schema'
import { roomTypeSchema } from '@renderer/admin/features/rooms/data/schema'
import { z } from 'zod'

export const bookingDetailSchema = z.object({
  booking: bookingSchema,
  histories: bookingHistoryListSchema,
  policies: policyListSchema,
  promotions: z.array(promotionSchema),
  roomType: roomTypeSchema
})

export type BookingDetail = z.infer<typeof bookingDetailSchema>
