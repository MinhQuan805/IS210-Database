import { zodResolver } from '@hookform/resolvers/zod'
import { bookingsApi } from '@renderer/admin/features/bookings/data/api'
import { Booking } from '@renderer/admin/features/bookings/data/schema'
import { customersApi } from '@renderer/admin/features/customers/data/api'
import { Customer } from '@renderer/admin/features/customers/data/schema'
import { pdfApi } from '@renderer/admin/features/pdf/api'
import { policiesApi } from '@renderer/admin/features/policies/data/api'
import { Policy } from '@renderer/admin/features/policies/data/schema'
import { PoliciesDialog } from '@renderer/client/createBooking/components/PoliciesDialog'
import { createBookingSchema, CreateBooking } from '@renderer/client/createBooking/data/schema'
import {
  Button,
  Checkbox,
  Dialog,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
  Input
} from '@renderer/components/ui'
import {
  AlertDialog,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle
} from '@renderer/components/ui/alert-dialog'
import { Textarea } from '@renderer/components/ui/textarea'
import { format } from 'date-fns'
import { Calendar, CreditCard, Globe, Mail, MapPin, Phone, User } from 'lucide-react'
import { useEffect, useState } from 'react'
import { useForm } from 'react-hook-form'
import { toast } from 'sonner'

type CreateBookingPageProps = {
  open: boolean
  onOpenChange: (open: boolean) => void
  setBooking: (booking: Booking) => void
  roomId: number
  checkInDate: Date
  checkOutDate: Date
}

export default function CreateBookingPage({
  open,
  onOpenChange,
  setBooking,
  roomId,
  checkInDate,
  checkOutDate
}: CreateBookingPageProps) {
  const form = useForm<CreateBooking>({
    resolver: zodResolver(createBookingSchema),
    defaultValues: {
      customer: {
        firstName: '',
        lastName: '',
        email: '',
        phone: '',
        idNumber: '',
        nationality: '',
        dateOfBirth: '',
        address: '',
        notes: '',
        isVIP: false
      },
      specialRequests: '',
      isAcceptPolicies: false
    }
  })

  const [policies, setPolicies] = useState<Policy[] | null>(null)

  const [openConfirmBox, setOpenConfirmBox] = useState<boolean>(false)

  const [customer, setCustomer] = useState<Customer | undefined>(undefined)

  // Lấy policies
  useEffect(() => {
    async function fetchPolicies() {
      try {
        const data = await policiesApi.list()
        setPolicies(data)
      } catch (err) {
        console.log('Failed to fetch policies: ', err)
        toast.error('Lỗi! Hãy thử lại sau.')
      }
    }
    fetchPolicies()
  }, [])

  async function handleConfirmInfo(data: CreateBooking) {
    try {
      toast.info('Đang kiểm tra thông tin ...')
      const isExists = await customersApi.exists(data.customer.email)

      if (!isExists) handleCreateCustomer()
      else setOpenConfirmBox(isExists)
    } catch (err) {
      toast.error('Lỗi! Hãy thử lại sau.')
      console.log(err)
    }
  }

  async function handleGetExistingCustomer() {
    try {
      toast.info('Đang tìm thông tin khách hàng ...')
      const customer = await customersApi.getByEmail(form.getValues().customer.email)
      setCustomer(customer)
    } catch (err) {
      toast.error('Lỗi! Hãy thử lại sau.')
      console.log(err)
    }
  }

  async function handleCreateCustomer() {
    try {
      toast.info('Đang lưu thông tin khách hàng ...')
      const customer = await customersApi.create(form.getValues().customer)
      setCustomer(customer)
    } catch (err) {
      toast.error('Lưu thông tin thất bại! Hãy thử lại sau.')
      console.log(err)
    }
  }

  // Booking khi xác định đc customers

  useEffect(() => {
    async function handleCreateBooking() {
      try {
        if (!customer || !policies) return

        toast.info('Đang đặt phòng ...')

        const booking = await bookingsApi.create({
          customerId: customer.id,
          roomId,
          checkInDate: format(checkInDate, 'yyyy-MM-dd'),
          checkOutDate: format(checkOutDate, 'yyyy-MM-dd'),
          specialRequests: form.getValues().specialRequests
        })

        onOpenChange(false)
        setBooking(booking)

        pdfApi.info(booking.id)
      } catch (err) {
        toast.error('Đặt phòng thất bại! Hãy thử lại sau.')
        console.log(err)
      }
    }

    handleCreateBooking()
  }, [customer, policies])

  return (
    <>
      <Dialog open={open} onOpenChange={onOpenChange}>
        <DialogContent className="max-w-2xl overflow-y-auto max-h-[90vh]">
          <DialogHeader>
            <DialogTitle className="text-xl font-bold flex items-center gap-2">
              <User className="w-5 h-5" /> Nhập thông tin của bạn
            </DialogTitle>
          </DialogHeader>

          <Form {...form}>
            <form
              className="space-y-6"
              onSubmit={(e) => {
                e.preventDefault()
                form.handleSubmit(handleConfirmInfo)(e)
              }}
            >
              {/* Hàng 1: Họ và Tên */}
              <div className="grid grid-cols-2 gap-4">
                <FormField
                  control={form.control}
                  name="customer.firstName"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>
                        Họ <span className="text-red-400">*</span>
                      </FormLabel>
                      <FormControl>
                        <Input placeholder="Nguyễn" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                <FormField
                  control={form.control}
                  name="customer.lastName"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>
                        Tên <span className="text-red-400">*</span>
                      </FormLabel>
                      <FormControl>
                        <Input placeholder="Văn A" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>

              {/* Hàng 2: Email và SĐT */}
              <div className="grid grid-cols-2 gap-4">
                <FormField
                  control={form.control}
                  name="customer.email"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="flex items-center gap-2">
                        <Mail className="w-4 h-4" /> Email <span className="text-red-400">*</span>
                      </FormLabel>
                      <FormControl>
                        <Input type="email" placeholder="example@gmail.com" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                <FormField
                  control={form.control}
                  name="customer.phone"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="flex items-center gap-2">
                        <Phone className="w-4 h-4" /> SĐT
                      </FormLabel>
                      <FormControl>
                        <Input placeholder="090..." {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>

              {/* Hàng 3: CMND và Quốc tịch */}
              <div className="grid grid-cols-2 gap-4">
                <FormField
                  control={form.control}
                  name="customer.idNumber"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="flex items-center gap-2">
                        <CreditCard className="w-4 h-4" /> Số CMND/CCCD
                      </FormLabel>
                      <FormControl>
                        <Input placeholder="..." {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                <FormField
                  control={form.control}
                  name="customer.nationality"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="flex items-center gap-2">
                        <Globe className="w-4 h-4" /> Quốc tịch
                      </FormLabel>
                      <FormControl>
                        <Input placeholder="Việt Nam" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>

              {/* Hàng 4: Ngày sinh và Địa chỉ */}
              <div className="grid grid-cols-2 gap-4">
                <FormField
                  control={form.control}
                  name="customer.dateOfBirth"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="flex items-center gap-2">
                        <Calendar className="w-4 h-4" /> Ngày sinh
                      </FormLabel>
                      <FormControl>
                        <Input type="date" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                <FormField
                  control={form.control}
                  name="customer.address"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="flex items-center gap-2">
                        <MapPin className="w-4 h-4" /> Địa chỉ
                      </FormLabel>
                      <FormControl>
                        <Input placeholder="Số nhà, tên đường..." {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>

              {/* Special Requests — đưa vào FormField để validation hoạt động */}
              <FormField
                control={form.control}
                name="specialRequests"
                render={({ field }) => (
                  <FormItem>
                    <FormControl>
                      <Textarea placeholder="Yêu cầu đặc biệt ..." {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <FormField
                control={form.control}
                name="isAcceptPolicies"
                render={({ field }) => (
                  <FormItem className="flex flex-col gap-2">
                    <div className="flex items-center gap-2">
                      <FormControl>
                        <Checkbox checked={field.value} onCheckedChange={field.onChange} />
                      </FormControl>
                      <FormLabel>Tôi đồng ý với các chính sách của khách sạn</FormLabel>
                    </div>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <div className="flex flex-col gap-2">
                {policies && <PoliciesDialog policies={policies} />}
                <Button type="submit" className="flex-1">
                  ĐẶT PHÒNG NGAY!
                </Button>
              </div>
            </form>
          </Form>

          <DialogFooter className="text-justify">
            Quý khách vui lòng liên hệ với khách sạn qua hotline bên dưới / đến quầy lễ tân để được
            tư vấn giảm giá.
            <div className="mt-5 text-muted-foreground italic text-justify"></div>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Confirm box */}
      <AlertDialog open={openConfirmBox} onOpenChange={setOpenConfirmBox}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Xác nhận thông tin khách hàng</AlertDialogTitle>
            <AlertDialogDescription>
              Chúng tôi nhận thấy rằng những thông tin bạn vừa cung cấp trùng với một khách hàng
              trước đó. Nếu đó không phải là bạn, vui lòng sửa lại thông tin cho phù hợp.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <Button variant="outline" onClick={() => setOpenConfirmBox(false)}>
              Sửa lại thông tin
            </Button>
            <Button
              onClick={() => {
                setOpenConfirmBox(false)
                handleGetExistingCustomer()
              }}
            >
              Xác nhận thông tin
            </Button>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </>
  )
}
