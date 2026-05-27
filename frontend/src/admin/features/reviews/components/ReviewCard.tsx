import { Card, CardContent } from '@/components/ui/card'
import UserAvatar from '@renderer/admin/components/layout/UserAvatar'
import StarRating from '@renderer/admin/features/reviews/components/StarRating'
import ImageList from '@renderer/components/ui/ImageList'
import type { Review } from '@renderer/admin/features/reviews/data/schema'
import { CalendarDays } from 'lucide-react'

export default function ReviewCard({ review }: { review: Review }) {
  return (
    <Card className="border-none border-1 border-muted-foreground shadow transition-colors duration-300">
      <CardContent className="p-2 px-4">
        <div className="flex flex-col gap-4">
          {/* Header: Info & Rating */}
          <div className="flex flex-col sm:flex-row justify-between items-start gap-4">
            <UserAvatar
              user={{
                name: review.user.username,
                email: review.user.email,
                avatar: ''
              }}
            />
            <div className="flex flex-col sm:items-end gap-1">
              <StarRating rating={review.rating} />
              <div className="flex items-center gap-1.5 text-xs text-muted-foreground">
                <CalendarDays className="w-3 h-3" />
                <span>{review.createdAt}</span>
              </div>
            </div>
          </div>

          {/* Body: Content */}
          <div className="text-muted-foreground leading-relaxed text-justify italic">
            {review.content}
          </div>

          {/* Footer: Images */}
          {review.images && review.images.length > 0 && (
            <div className="pt-2">
              <ImageList images={review.images} />
            </div>
          )}
        </div>
      </CardContent>
    </Card>
  )
}
