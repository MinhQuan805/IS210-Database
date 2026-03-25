import { Search } from 'lucide-react'

import { format } from 'date-fns'

import { z } from 'zod'
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'

import { useState } from 'react'
import {
  Button,
  Card,
  CardContent,
  CardHeader,
  Input,
  Label,
  Skeleton
} from '@renderer/components/ui'
import { toast } from 'sonner'
import { RoomDetail } from '@renderer/client/search/data/roomDetailSchema'
import RoomCard from '@renderer/client/search/components/RoomCard'
import { roomDetailApi } from '@renderer/client/search/data/roomDetailApi'
import { DatePicker } from '@renderer/components/ui/date-picker'
import CheckInOutPicker from '@renderer/components/checkinout-picker'

const formSchema = z.object({
  checkInDate: z.date(),
  checkOutDate: z.date(),
  capacity: z.number('Dữ liệu không hợp lệ').min(0, 'Dữ liệu không hợp lệ')
})

type FormValues = z.infer<typeof formSchema>

export default function BookingDetailPage() {
  const [rooms, setRooms] = useState<RoomDetail[] | null>(null)
  const [loading, setLoading] = useState<boolean>(false)

  const form = useForm<FormValues>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      checkInDate: new Date(),
      checkOutDate: new Date(),
      capacity: 4
    }
  })

  const onSubmit = async (formVals: FormValues) => {
    try {
      setLoading(true)
      setRooms(null)

      const data = await roomDetailApi.list({
        checkInDate: format(formVals.checkInDate, 'dd-MM-yyyy'),
        checkOutDate: format(formVals.checkOutDate, 'dd-MM-yyyy'),
        capacity: formVals.capacity
      })

      if (!data) toast.error('Không tìm thấy phòng phù hợp!')
      else setRooms(data)
    } catch (error) {
      toast.error('Không tìm thấy phòng phù hợp!')
      console.log('Failed to fetch rooms: ', error)
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="mt-10 space-y-10 px-20">
      <div className="flex flex-col items-center justify-center">
        <h2 className="text-5xl mb-8 text-main font-semibold leading-relaxed">Đặt phòng</h2>

        {/* Form */}
        <form onSubmit={form.handleSubmit(onSubmit)} className="flex gap-1 items-end">
          <CheckInOutPicker
            defaultValue={{
              checkIn: form.getValues().checkInDate,
              checkOut: form.getValues().checkOutDate
            }}
            onChange={(v) => {
              ;(form.setValue('checkInDate', v.checkIn ?? new Date()),
                form.setValue('checkOutDate', v.checkOut ?? new Date()))
            }}
          />

          <div className="flex flex-col gap-1">
            <Label htmlFor="capacity">Số người ở</Label>
            <Input
              id="capacity"
              {...form.register('capacity', {
                valueAsNumber: true
              })}
            ></Input>
            {form.formState.errors.capacity && (
              <span className="text-red-500 text-sm">{form.formState.errors.capacity.message}</span>
            )}
          </div>

          <Button type="submit" className="flex items-center gap-1">
            Tìm phòng <Search className="w-4 h-4" />
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
        rooms && <RoomCard rooms={rooms} />
      )}
    </div>
  )
}
