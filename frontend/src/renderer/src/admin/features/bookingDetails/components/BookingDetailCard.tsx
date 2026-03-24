import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'

import { BookingDetail } from '@renderer/admin/features/bookingDetails/data/schema'
import BookingsCard from '@renderer/admin/features/bookingDetails/components/BookingsCard'
import HistoryCard from '@renderer/admin/features/bookingDetails/components/HistoryCard'
import PromotionsCard from '@renderer/admin/features/bookingDetails/components/PromotionsCard'
import PaymentsCard from '@renderer/admin/features/bookingDetails/components/PaymentsCard'
import PoliciesCard from '@renderer/admin/features/bookingDetails/components/PoliciesCard'
import AmenitiesCard from '@renderer/admin/features/bookingDetails/components/AmenitiesCard'

export default function BookingDetailCard({ bookingDetail }: { bookingDetail: BookingDetail }) {
  return (
    <Tabs defaultValue="booking" className="w-full">
      <TabsList>
        <TabsTrigger value="booking">Hóa đơn</TabsTrigger>
        <TabsTrigger value="history">LS chỉnh sửa</TabsTrigger>
        <TabsTrigger value="payments">LS thanh toán</TabsTrigger>
        <TabsTrigger value="promotions">Khuyến mãi</TabsTrigger>
        <TabsTrigger value="policies">Chính sách</TabsTrigger>
        <TabsTrigger value="amenities">Tiện nghi</TabsTrigger>
      </TabsList>

      <TabsContent value="booking">
        <BookingsCard
          customerName={bookingDetail.customerName}
          customerEmail={bookingDetail.customerEmail}
          checkInDate={bookingDetail.checkInDate}
          checkOutDate={bookingDetail.checkOutDate}
          totalPrice={bookingDetail.totalPrice}
          rawPrice={bookingDetail.rawPrice}
          discountAmount={bookingDetail.discountAmount}
          status={bookingDetail.status}
          specialRequests={bookingDetail.specialRequests}
          roomNumber={bookingDetail.roomNumber}
          floor={bookingDetail.floor}
        />
      </TabsContent>

      <TabsContent value="history">
        <HistoryCard history={bookingDetail.history} />
      </TabsContent>

      <TabsContent value="payments">
        <PaymentsCard payments={bookingDetail.payments} />
      </TabsContent>

      <TabsContent value="promotions">
        <PromotionsCard promotions={bookingDetail.promotions} />
      </TabsContent>

      <TabsContent value="policies">
        <PoliciesCard policies={bookingDetail.policies} />
      </TabsContent>

      <TabsContent value="amenities">
        <AmenitiesCard amenities={bookingDetail.amenities} />
      </TabsContent>
    </Tabs>
  )
}
