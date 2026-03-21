import { z } from 'zod'

import { userSchema } from '@renderer/admin/features/users/data/schema'

export const ReviewStatusSchema = z.union([
  z.literal('PENDING'),
  z.literal('APPROVED'),
  z.literal('REJECTED')
])

export type ReviewStatus = z.infer<typeof ReviewStatusSchema>

export const ReviewSchema = z.object({
  id: z.number(),
  user: userSchema,
  rating: z.number(),
  content: z.string(),
  status: ReviewStatusSchema,
  images: z.array(z.string()),
  createdAt: z.string().nullable().optional(),
  updatedAt: z.string().nullable().optional()
})

export type Review = z.infer<typeof ReviewSchema>
