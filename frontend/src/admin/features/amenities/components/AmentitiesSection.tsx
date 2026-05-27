import { useEffect, useState } from 'react'
import { toast } from 'sonner'

import { amenitiesApi } from '@renderer/admin/features/amenities/data/api'
import AmenitiesGrid from '@renderer/admin/features/amenities/components/AmenitiesGrid'
import { Amenity } from '@renderer/admin/features/amenities/data/schema'
import { Badge } from '@renderer/components/ui'

export default function AmenitiesSection() {
  const [amenities, setAmenities] = useState<Amenity[] | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function fetchAmenities() {
      try {
        const data = await amenitiesApi.list()
        setAmenities(data || [])
      } catch (error) {
        toast.error('Không thể tải danh sách tiện nghi.')
      } finally {
        setLoading(false)
      }
    }
    fetchAmenities()
  }, [])

  if (loading) return <div className="py-20 text-center">Đang tải...</div>

  return (
    <section className="py-20 px-4 max-w-7xl mx-auto">
      <div className="flex flex-col lg:flex-row gap-16">
        {/* Sidebar Title - Sticky on Scroll */}
        <div className="lg:w-1/4 lg:sticky lg:top-24 h-fit">
          <Badge variant="outline" className="mb-4 border-main text-main px-4 py-1">
            Dịch vụ của chúng tôi
          </Badge>
          <h2 className="text-5xl font-bold text-slate-900 leading-tight mb-6">
            Tiện nghi <br />
            <span className="text-main italic uppercase whitespace-nowrap">Đẳng cấp</span>
          </h2>
          <p className="text-muted-foreground text-lg leading-relaxed text-justify">
            Chúng tôi cung cấp đầy đủ các trang thiết bị hiện đại nhất để đảm bảo trải nghiệm của
            bạn luôn tuyệt vời.
          </p>
        </div>

        {/* Content */}
        <div className="lg:w-3/4">{amenities && <AmenitiesGrid amenities={amenities} />}</div>
      </div>
    </section>
  )
}
