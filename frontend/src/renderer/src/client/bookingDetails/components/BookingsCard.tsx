import { ReceiptText } from 'lucide-react'

import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Separator } from '@renderer/components/ui'
import { Badge } from '@renderer/components/ui'

import { BookingStatus } from '@renderer/admin/features/bookings/data/schema'

type BookingCardProps = {
  customerName: string
  customerEmail: string
  checkInDate: string
  checkOutDate: string
  totalPrice: number
  rawPrice: number
  discountAmount: number
  status: BookingStatus
  specialRequests: string | null | undefined
  roomNumber: string
  floor: number
}

const getStatusVariant = (status) => {
  switch (status) {
    case 'CONFIRMED':
      return 'default'
    case 'PENDING':
      return 'outline'
    case 'CANCELLED':
      return 'destructive'
    default:
      return 'secondary'
  }
}
function getStatusName(status: BookingStatus) {
  switch (status) {
    case 'PENDING':
      return 'ĐANG CHỜ XÁC NHẬN'
    case 'CONFIRMED':
      return 'ĐÃ XÁC NHẬN'
    case 'CHECKED_IN':
      return 'ĐÃ CHECK-IN'
    case 'CHECKED_OUT':
      return 'ĐÃ CHECK-OUT'
    case 'CANCELLED':
      return 'ĐÃ HỦY'
  }
}

export default function BookingsCard({
  customerName,
  customerEmail,
  checkInDate,
  checkOutDate,
  totalPrice,
  rawPrice,
  discountAmount,
  status,
  specialRequests,
  roomNumber,
  floor
}: BookingCardProps) {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center justify-between">
          <div className="font-bold leading-tight text-main text-2xl">THÔNG TIN ĐẶT PHÒNG</div>
          <ReceiptText className="size-10" />
        </CardTitle>
      </CardHeader>
      <CardContent className="text-sm text-muted-foreground space-y-4">
        {/* Thông tin khách hàng */}
        <div className="flex justify-between items-start">
          <div>
            <p className="text-xs font-semibold text-muted-foreground uppercase">Khách hàng</p>
            <p className="font-bold text-lg leading-none">{customerName.toUpperCase()}</p>
            <p className="text-sm text-muted-foreground">{customerEmail}</p>
          </div>
          <Badge variant={getStatusVariant(status)}>{getStatusName(status)}</Badge>
        </div>

        <Separator />

        {/* Thông tin lưu trú */}
        <div className="grid grid-cols-2 gap-4 text-sm">
          <div>
            <p className="text-muted-foreground">Ngày nhận phòng: </p>
            <p className="font-medium">{checkInDate}</p>
          </div>
          <div>
            <p className="text-muted-foreground">Số phòng / Tầng: </p>
            <p className="font-medium">
              Phòng {roomNumber} - Tầng {floor}
            </p>
          </div>
          <div>
            <p className="text-muted-foreground">Ngày trả phòng: </p>
            <p className="font-medium">{checkOutDate}</p>
          </div>
        </div>

        {/* Ghi chú & Yêu cầu đặc biệt */}
        <div className="bg-muted/50 p-3 rounded-md text-xs space-y-2">
          {status === 'PENDING' && (
            <p className="text-orange-600 font-medium">
              ⚠️ Lưu ý: Vui lòng thanh toán trước ngày {checkInDate} để giữ chỗ.
            </p>
          )}
          <p>
            <span className="font-semibold">Yêu cầu đặc biệt:</span>{' '}
            {specialRequests ?? '(không có)'}
          </p>
        </div>

        <Separator />

        {/* Chi tiết thanh toán */}
        <div className="space-y-1.5">
          <div className="flex justify-between text-sm">
            <span className="text-muted-foreground">Giá gốc</span>
            <span>{rawPrice.toLocaleString()} VND</span>
          </div>
          <div className="flex justify-between text-sm text-red-500 italic">
            <span>Giảm giá</span>
            <span>- {discountAmount.toLocaleString()} VND</span>
          </div>
          <Separator className="my-2" />
          <div className="flex justify-between items-center pt-1">
            <span className="font-bold text-base">Tổng cộng</span>
            <span className="text-2xl font-black text-primary font-mono">
              {totalPrice.toLocaleString()} <small className="text-xs font-normal">VND</small>
            </span>
          </div>
        </div>

        {/* Action */}
        {status == 'PENDING' && <div className="flex items-center justify-center"></div>}
      </CardContent>
    </Card>
  )
}
