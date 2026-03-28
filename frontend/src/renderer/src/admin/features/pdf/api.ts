import { api } from '@renderer/admin/lib/api'

export const pdfApi = {
  info: (bookingId: number, filename: string = 'LS-BOOKING-INFO') =>
    api.download(`/export/booking/${bookingId}/info`, `${filename}-${bookingId}`),

  invoice: (bookingId: number, filename: string = 'LS-BOOKING-INVOICE') =>
    api.download(`/export/booking/${bookingId}/invoice`, `${filename}-${bookingId}`)
}
