import { api } from '@/admin/lib/api'
import { BookingDetail } from '@renderer/admin/features/bookingDetails/data/schema'

export const bookingDetailApi = {
  list: (params: { id: number; email: string }) =>
    api.get<BookingDetail>(
      `/bookings/${params.id}/detail?email=${encodeURIComponent(params.email)}`
    )
}
