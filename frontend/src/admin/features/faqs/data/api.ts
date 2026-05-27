import { api } from '@renderer/admin/lib/api'
import { Faq } from '@renderer/admin/features/faqs/data/schema'

export const faqsApi = {
  list: () => api.get<Faq[]>('/faqs'),
  active: () => api.get<Faq[]>('/faqs/active')
}
