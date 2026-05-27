import { api } from '@renderer/admin/lib/api'
import { Review } from '@renderer/admin/features/reviews/data/schema'

export const reviewsApi = {
  list: () => api.get<Review[]>('/reviews'),
  approved: () => api.get<Review[]>('/reviews/approved')
}
