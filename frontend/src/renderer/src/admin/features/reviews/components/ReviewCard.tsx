import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'

import UserAvatar from '@renderer/admin/components/layout/UserAvatar'
import StarRating from '@renderer/admin/features/reviews/components/StarRating'
import ImageList from '@renderer/components/ui/ImageList'

import type { Review } from '@renderer/admin/features/reviews/data/schema'

export default function ReviewCard({ review }: { review: Review }) {
  return (
    <Card className="w-full pb-1">
      <CardHeader>
        <CardTitle className="flex flex-col md:flex-row justify-between">
          <UserAvatar
            user={{
              name: review.user.username,
              email: review.user.email,
              avatar: ''
            }}
          />
          <CardDescription className="flex flex-col">
            {review.createdAt && (
              <div>
                Tạo ngày: <span className="font-normal">{review.createdAt}.</span>
              </div>
            )}
            {review.updatedAt && (
              <div>
                Sửa lần cuối: <span className="font-normal">{review.updatedAt}.</span>
              </div>
            )}
          </CardDescription>
        </CardTitle>
      </CardHeader>
      <CardContent className="flex flex-col">
        <div className="text-justify mt">{review.content}</div>
        <StarRating rating={review.rating} className="mt-5" />
        <ImageList images={review.images} className="mt-5" />
      </CardContent>
    </Card>
  )
}
