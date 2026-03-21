import { z } from 'zod'

export const amenitiesSchema = z.object({
  id: z.number(),
  name: z.string(),
  icon: z.string(),
  category: z.string(),
  description: z.string()
})

export type Amenity = z.infer<typeof amenitiesSchema>
