import { useEffect, useState } from 'react'
import { toast } from 'sonner'

import { amenitiesApi } from '@renderer/admin/features/amenities/data/api'
import AmenitiesArcodition from './AmenitiesArcodition'
import { Amenity } from '@renderer/admin/features/amenities/data/schema'

export default function AmenitiesSection() {
  const [amenities, setAmenities] = useState<Amenity[] | null>(null)

  useEffect(() => {
    async function fetchAmenities() {
      try {
        const data = await amenitiesApi.list()
        setAmenities(data || [])
      } catch (error) {
        toast.error('Không thể tải danh sách tiện nghi.')
        console.error('Failed to fetch amenities:', error)
      }
    }

    fetchAmenities()
  }, [])

  return (
    <>
      {amenities && (
        <section>
          <div className="grid grid-cols-1 lg:grid-cols-4 gap-8 items-start">
            <h2 className="text-5xl text-main font-semibold leading-normal">Tiện nghi</h2>
            <AmenitiesArcodition
              amenities={amenities}
              className="lg:col-span-3 pl-5 border-l-5 border-main"
            />
          </div>
        </section>
      )}
    </>
  )
}
