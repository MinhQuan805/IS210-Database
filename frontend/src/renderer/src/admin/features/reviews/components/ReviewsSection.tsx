import { useState, useEffect } from 'react'
import { toast } from 'sonner'

import type { Review } from '@renderer/admin/features/reviews/data/schema'
import ReviewCard from '@renderer/admin/features/reviews/components/ReviewCard'

import { reviewsApi } from '@renderer/admin/features/reviews/data/api'

export default function ReviewsSection() {
  const [reviews, setReviews] = useState<Review[] | null>(null)

  useEffect(() => {
    async function fetchReviews() {
      try {
        const data = await reviewsApi.approved()
        setReviews(data || [])
      } catch (error) {
        toast.error('Không thể tải danh sách reviews.')
        console.error('Failed to fetch reviews:', error)
      }
    }

    fetchReviews()
  }, [])

  return (
    <>
      {reviews && (
        <section>
          <h2 className="text-5xl text-main font-semibold leading-normal">Reviews</h2>
          <div className="flex flex-col gap-2">
            {reviews.map((review) => (
              <ReviewCard review={review} key={review.id} />
            ))}
          </div>
        </section>
      )}
    </>
  )
}
