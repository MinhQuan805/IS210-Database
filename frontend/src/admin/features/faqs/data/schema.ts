import { z } from 'zod'

export const faqSchema = z.object({
  id: z.number(),
  question: z.string(),
  answer: z.string(),
  isActive: z.boolean(),
  createdAt: z.string().nullable().optional(),
  updatedAt: z.string().nullable().optional()
})

export type Faq = z.infer<typeof faqSchema>
