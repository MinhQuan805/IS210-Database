import { Card, CardContent, CardTitle, CardHeader } from '@/components/ui/card'
import { Amenity } from '@renderer/admin/features/amenities/data/schema'
import AmenitiesGrid from '@renderer/admin/features/amenities/components/AmenitiesGrid'
import { Birdhouse } from 'lucide-react'

export default function AmenitiesCard({ amenities }: { amenities: Amenity[] }) {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center justify-between">
          <div className="font-bold leading-tight text-main text-2xl">DANH SÁCH TIỆN NGHI</div>
          <Birdhouse className="size-10" />
        </CardTitle>
      </CardHeader>
      <CardContent className="flex flex-col gap-1">
        {!amenities.length && '(Không có)'}
        <AmenitiesGrid amenities={amenities} />
      </CardContent>
    </Card>
  )
}
