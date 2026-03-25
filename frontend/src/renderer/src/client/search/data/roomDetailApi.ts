import { api } from '@/admin/lib/api'
import { RoomDetail } from '@renderer/client/search/data/roomDetailSchema'

export const roomDetailApi = {
  list: (params: { checkInDate: string; checkOutDate: string; capacity: number }) =>
    api.get<RoomDetail[]>(
      `/admin/rooms/availability/detail?checkInDate=${params.checkInDate}&checkOutDate=${params.checkOutDate}&capacity=${params.capacity}`
    )
}
