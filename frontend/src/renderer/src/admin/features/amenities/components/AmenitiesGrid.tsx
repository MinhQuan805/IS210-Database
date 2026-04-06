import { Badge } from '@/components/ui/badge'
import { Card, CardContent } from '@/components/ui/card'
import { Amenity } from '@renderer/admin/features/amenities/data/schema'
import * as Icons from 'lucide-react' // Giả sử icon lưu dạng tên như "Wifi", "Coffee"

export default function AmenitiesGrid({
  amenities,
  className = ''
}: {
  amenities: Amenity[]
  className?: string
}) {
  // Nhóm tiện nghi theo Category
  const grouped = amenities.reduce(
    (acc, item) => {
      if (!acc[item.category]) acc[item.category] = []
      acc[item.category].push(item)
      return acc
    },
    {} as Record<string, Amenity[]>
  )

  return (
    <div className={`space-y-12 ${className}`}>
      {Object.entries(grouped).map(([category, items]) => (
        <div key={category} className="space-y-6">
          <div className="flex items-center gap-4">
            <h3 className="text-xl font-bold uppercase tracking-wider text-main">{category}</h3>
            <div className="h-[2px] flex-1 bg-gradient-to-r from-main/20 to-transparent" />
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4">
            {items.map((amenity) => {
              return (
                <Card
                  key={amenity.id}
                  className="group hover:border-main transition-all duration-300 hover:shadow-md"
                >
                  <CardContent className="flex gap-4">
                    <div className="w-12 h-12 rounded-2xl bg-main/5 flex items-center justify-center text-main group-hover:bg-main group-hover:text-white transition-colors duration-300">
                      <Badge>{amenity.icon}</Badge>
                    </div>
                    <div className="flex-1 space-y-1">
                      <h4 className="font-semibold text-lg">{amenity.name}</h4>
                      <p className="text-sm text-muted-foreground line-clamp-2 leading-relaxed">
                        {amenity.description}
                      </p>
                    </div>
                  </CardContent>
                </Card>
              )
            })}
          </div>
        </div>
      ))}
    </div>
  )
}
