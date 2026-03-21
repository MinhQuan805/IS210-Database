import { Trash2, Pencil, Birdhouse, ClockFading, ReceiptText, ShieldAlert } from 'lucide-react'

import { Button } from '@/components/ui/button'
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from '@/components/ui/card'
import { Separator } from '@/components/ui/separator'
import { Badge } from '@renderer/components/ui'
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger
} from '@renderer/components/ui/alert-dialog'

import type { BookingStatus } from '@renderer/admin/features/bookings/data/schema'
import { BookingDetail } from '@renderer/admin/features/bookingDetails/data/schema'

function getStatusInfo(status: BookingStatus): { color: string; name: string } {
  switch (status) {
    case 'PENDING':
      return { color: 'slate-500', name: 'ĐANG XỬ LÝ' }
    case 'CONFIRMED':
      return { color: 'emerald-500', name: 'ĐÃ XÁC NHẬN' }
    case 'CHECKED_IN':
      return { color: 'sky-500', name: 'ĐÃ CHECK-IN' }
    case 'CHECKED_OUT':
      return { color: 'sky-500', name: 'ĐÃ CHECK-OUT' }
    case 'CANCELLED':
      return { color: 'red-500', name: 'ĐÃ HỦY' }
  }
}

function StatusBadge({ status }: { status: BookingStatus }) {
  const statusInfo = getStatusInfo(status)
  return <Badge className={`bg-${statusInfo.color}`}>{statusInfo.name}</Badge>
}

export default function BookingDetailCard({ bookingDetail }: { bookingDetail: BookingDetail }) {
  return (
    <Card className="w-full">
      <CardContent className="flex flex-col gap-3">
        {/* Super header */}
        <div className="flex items-center justify-between"></div>

        {/* Header */}
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
          {/* Left side */}
          <div className="flex flex-col gap-1">
            <div>
              <strong>Mã đặt phòng:</strong> {bookingDetail.booking.id}.
            </div>
            <div>
              <strong>Khách hàng:</strong> {bookingDetail.booking.customerName}.
            </div>
            <div>
              <strong>Số phòng:</strong> {bookingDetail.booking.roomNumber}.
            </div>
            <div>
              <strong>Loại phòng:</strong> {bookingDetail.roomType.name}.
            </div>
            <div>
              <strong>Số người:</strong> {bookingDetail.roomType.capacity}.
            </div>
          </div>

          {/* Right side */}
          <div className="flex flex-col gap-1">
            <StatusBadge status={bookingDetail.booking.status} />
            {bookingDetail.roomType.createdAt && (
              <div>
                <strong>Ngày đặt:</strong> {bookingDetail.roomType.createdAt}.
              </div>
            )}
            {bookingDetail.booking.checkInDate && (
              <div>
                <strong>Ngày check-in:</strong> {bookingDetail.booking.checkInDate}.
              </div>
            )}
            {bookingDetail.booking.checkOutDate && (
              <div>
                <strong>Ngày check-out:</strong> {bookingDetail.booking.checkOutDate}.
              </div>
            )}
          </div>
        </div>

        <Separator />

        {/* Footer */}
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
          {/* Left side */}
          <div className="flex flex-col gap-1">
            <strong>Ghi chú: </strong>
            {bookingDetail.booking.specialRequests ?? '(không có)'}
          </div>

          {/* Right side */}
          <div className="flex flex-col gap-1">
            <div>
              <strong>Tổng tiền:</strong> VND{' '}
              <span className="font-extrabold text-2xl">{bookingDetail.booking.totalPrice}</span>.
            </div>
          </div>
        </div>

        {/* Footer */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-2 md:gap-4">
          {/* Amenities */}
          {bookingDetail.roomType.amenities && (
            <AlertDialog>
              <AlertDialogTrigger asChild>
                <Button variant="outline">
                  Xem tiện nghi <Birdhouse />
                </Button>
              </AlertDialogTrigger>
              <AlertDialogContent className="max-w-3xl!">
                <AlertDialogHeader>
                  <AlertDialogTitle>Tiện nghi</AlertDialogTitle>
                  <AlertDialogDescription className="w-full">
                    {bookingDetail.roomType.amenities.map((amenity) => (
                      <dl className="flex items-center justify-between border-b border-muted">
                        <dt>{amenity.icon}</dt>
                        <dd className="text-muted-foreground">{amenity.name}</dd>
                      </dl>
                    ))}
                  </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                  <AlertDialogCancel>Đóng</AlertDialogCancel>
                </AlertDialogFooter>
              </AlertDialogContent>
            </AlertDialog>
          )}

          {/* History */}
          <AlertDialog>
            <AlertDialogTrigger asChild>
              <Button variant="outline">
                Xem lịch sử <ClockFading />
              </Button>
            </AlertDialogTrigger>
            <AlertDialogContent className="max-w-3xl!">
              <AlertDialogHeader>
                <AlertDialogTitle>Lịch sử sửa đổi</AlertDialogTitle>
                <AlertDialogDescription className="w-full">
                  {bookingDetail.histories.map((history) => (
                    <dl className="flex items-center justify-between border-b border-muted">
                      <dt>{history.action}</dt>
                      <dd className="text-muted-foreground text-right">
                        Cập nhật vào {history.timestamp}.
                        <br />
                        Bởi {history.performedBy}.
                      </dd>
                    </dl>
                  ))}
                </AlertDialogDescription>
              </AlertDialogHeader>
              <AlertDialogFooter>
                <AlertDialogCancel>Đóng</AlertDialogCancel>
              </AlertDialogFooter>
            </AlertDialogContent>
          </AlertDialog>

          {/* Promotion */}
          <AlertDialog>
            <AlertDialogTrigger asChild>
              <Button variant="outline">
                Xem khuyến mãi <ReceiptText />
              </Button>
            </AlertDialogTrigger>
            <AlertDialogContent className="max-w-3xl!">
              <AlertDialogHeader>
                <AlertDialogTitle>Khuyến mãi</AlertDialogTitle>
                <AlertDialogDescription className="w-full">
                  {bookingDetail.promotions.map((promotion) => (
                    <dl className="flex items-center justify-between border-b border-muted">
                      <dt>
                        <strong>{promotion.code}</strong>
                        <br />
                        {promotion.description}
                      </dt>
                      <dd className="text-muted-foreground text-right">
                        Hạn dùng {promotion.startDate}-{promotion.endDate}.
                        <br />
                        Đã dùng {promotion.usedCount} / {promotion.maxUses ?? '(?)'}.
                      </dd>
                    </dl>
                  ))}
                </AlertDialogDescription>
              </AlertDialogHeader>
              <AlertDialogFooter>
                <AlertDialogCancel>Đóng</AlertDialogCancel>
              </AlertDialogFooter>
            </AlertDialogContent>
          </AlertDialog>

          {/* Policy */}
          <AlertDialog>
            <AlertDialogTrigger asChild>
              <Button variant="outline">
                Xem chính sách <ShieldAlert />
              </Button>
            </AlertDialogTrigger>
            <AlertDialogContent className="max-w-3xl!">
              <AlertDialogHeader>
                <AlertDialogTitle>Chính sách</AlertDialogTitle>
                <AlertDialogDescription className="w-full">
                  {bookingDetail.policies.map((policy) => (
                    <dl className="flex items-center justify-between border-b border-muted">
                      <dt>
                        <strong>
                          {policy.title} {policy.version}
                        </strong>
                        <br />
                        {policy.content}
                      </dt>
                      <dd className="text-muted-foreground text-right">
                        Cập nhật lúc {policy.updatedAt ?? '?'}.
                        <br />
                        {policy.isActive ? '(Đã áp dụng)' : '(Chưa áp dụng)'}
                      </dd>
                    </dl>
                  ))}
                </AlertDialogDescription>
              </AlertDialogHeader>
              <AlertDialogFooter>
                <AlertDialogCancel>Đóng</AlertDialogCancel>
              </AlertDialogFooter>
            </AlertDialogContent>
          </AlertDialog>
        </div>
      </CardContent>

      {/* Card Footer */}
      {bookingDetail.booking.status == 'PENDING' && (
        <CardFooter>
          <Button variant="outline" className="w-full">
            Sửa check-in/out <Pencil />
          </Button>
          <Button variant="destructive" className="w-full">
            Hủy booking <Trash2 />
          </Button>
        </CardFooter>
      )}
    </Card>
  )
}
