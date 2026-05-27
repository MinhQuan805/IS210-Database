import { api } from '@renderer/admin/lib/api'
import { Amenity } from '@renderer/admin/features/amenities/data/schema'

export const amenitiesApi = {
  list: () => api.get<Amenity[]>('/amenities')
}
