import { amenitiesSchema } from '@renderer/admin/features/amenities/data/schema'
import { z } from 'zod'

export const roomDetailSchema = z.object({
  id: z.number(),
  roomTypeName: z.string(),
  roomTypeDescription: z.string(),
  roomNumber: z.string(),
  floor: z.number(),
  notes: z.string(),
  amenities: z.array(amenitiesSchema),
  rawPrice: z.number(),
  capacity: z.number()
})

export type RoomDetail = z.infer<typeof roomDetailSchema>
