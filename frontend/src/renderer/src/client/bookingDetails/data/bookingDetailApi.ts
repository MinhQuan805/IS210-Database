import { api } from '@renderer/admin/lib/api'
import { BookingDetail } from '@renderer/client/bookingDetails/data/schema'

export const bookingDetailApi = {
  list: (params: { id: number; email: string }) =>
    api.get<BookingDetail>(
      `/bookings/${params.id}/detail?email=${encodeURIComponent(params.email)}`
    )
}
