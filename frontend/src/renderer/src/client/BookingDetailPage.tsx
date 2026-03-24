import { toast } from 'sonner'

import { z } from 'zod'
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'

import { Search } from 'lucide-react'

import { Card, CardContent, CardHeader } from '@/components/ui/card'
import { Skeleton } from '@/components/ui/skeleton'

import { Label } from '@/components/ui/label'
import { Input } from '@/components/ui/input'
import { Button } from '@/components/ui/button'

import BookingDetailCard from '@renderer/admin/features/bookingDetails/components/BookingDetailCard'
import { bookingDetailApi } from '@renderer/admin/features/bookingDetails/data/bookingDetailApi'
import { useState } from 'react'
import { BookingDetail } from '@renderer/admin/features/bookingDetails/data/schema'

const formSchema = z.object({
  customer_email: z.string().min(1, 'Email là bắt buộc').email('Email không hợp lệ'),
  booking_id: z.number('ID không hợp lệ').min(1, 'Mã hóa đơn là bắt buộc')
})

type FormValues = z.infer<typeof formSchema>

export default function BookingDetailPage() {
  const [bookingDetails, setBookingDetails] = useState<BookingDetail | null>(null)
  const [loading, setLoading] = useState<boolean>(false)

  const {
    register,
    handleSubmit,
    formState: { errors }
  } = useForm<FormValues>({
    resolver: zodResolver(formSchema)
  })

  const onSubmit = async (formVals: FormValues) => {
    try {
      setLoading(true)
      setBookingDetails(null)

      const data = await bookingDetailApi.list({
        id: formVals.booking_id,
        email: formVals.customer_email
      })

      if (!data) toast.error('Không tìm thấy đơn đặt phòng nào!')
      else setBookingDetails(data)
    } catch (error) {
      toast.error('Không tìm thấy đơn đặt phòng nào!')
      console.log('Failed to fetch booking details: ', error)
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="mt-10 space-y-10 px-20">
      <div className="flex flex-col items-center justify-center">
        <h2 className="text-5xl mb-8 text-main font-semibold leading-relaxed">Tra cứu đặt phòng</h2>

        <form onSubmit={handleSubmit(onSubmit)} className="flex flex-col gap-2">
          <div className="flex gap-2">
            {/* Booking ID */}
            <div className="flex flex-col gap-1">
              <Label htmlFor="booking_id">Mã đặt phòng</Label>
              <Input
                id="booking_id"
                placeholder="1"
                {...register('booking_id', { valueAsNumber: true })}
              />
              {errors.booking_id && (
                <span className="text-red-500 text-sm">{errors.booking_id.message}</span>
              )}
            </div>

            {/* Email */}
            <div className="flex flex-col gap-1">
              <Label htmlFor="customer_email">Email KH</Label>
              <Input
                id="customer_email"
                placeholder="abc@example.com"
                {...register('customer_email')}
              />
              {errors.customer_email && (
                <span className="text-red-500 text-sm">{errors.customer_email.message}</span>
              )}
            </div>
          </div>

          {/* Button */}
          <Button type="submit" className="flex items-center gap-1">
            Tra cứu <Search className="w-4 h-4" />
          </Button>
        </form>
      </div>
      {loading ? (
        <Card className="w-full">
          <CardHeader>
            <Skeleton className="h-4 w-2/3" />
            <Skeleton className="h-4 w-1/2" />
          </CardHeader>
          <CardContent>
            <Skeleton className="aspect-video w-full" />
          </CardContent>
        </Card>
      ) : (
        bookingDetails && (
          <>
            <BookingDetailCard bookingDetail={bookingDetails} />
            {bookingDetails.status === 'PENDING' && (
              <div className="flex item-center justify-evenly">
                <Button variant="outline">Chỉnh sửa</Button>
                <Button variant="destructive">Hủy</Button>
                <Button variant="default">Thanh toán ngay</Button>
              </div>
            )}
          </>
        )
      )}
    </div>
  )
}
