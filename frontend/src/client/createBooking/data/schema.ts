import { createCustomerSchema } from '@renderer/admin/features/customers/data/schema'
import { z } from 'zod'

export const createBookingSchema = z
  .object({
    customer: createCustomerSchema,
    promotionCode: z.string().trim().optional(),
    specialRequests: z.string(),
    isAcceptPolicies: z.boolean()
  })
  .refine((data) => data.isAcceptPolicies === true, {
    message: 'Bạn phải đồng ý để tiếp tục',
    path: ['isAcceptPolicies']
  })

export type CreateBooking = z.infer<typeof createBookingSchema>
