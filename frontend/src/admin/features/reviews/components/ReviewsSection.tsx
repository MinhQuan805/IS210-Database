import { useState, useEffect } from 'react'
import { toast } from 'sonner'
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import { ChevronLeft, ChevronRight } from 'lucide-react'

import type { Review } from '@renderer/admin/features/reviews/data/schema'
import ReviewCard from '@renderer/admin/features/reviews/components/ReviewCard'
import { reviewsApi } from '@renderer/admin/features/reviews/data/api'

const REVIEWS_PER_PAGE = 3

export default function ReviewsSection() {
  const [reviews, setReviews] = useState<Review[] | null>(null)
  const [loading, setLoading] = useState(true)
  const [currentPage, setCurrentPage] = useState(1)

  useEffect(() => {
    async function fetchReviews() {
      try {
        const data = await reviewsApi.approved()
        setReviews(data || [])
      } catch (error) {
        toast.error('Không thể tải danh sách reviews.')
        console.error('Failed to fetch reviews:', error)
      } finally {
        setLoading(false)
      }
    }
    fetchReviews()
  }, [])

  // Logic phân trang
  const totalPages = reviews ? Math.ceil(reviews.length / REVIEWS_PER_PAGE) : 0
  const startIndex = (currentPage - 1) * REVIEWS_PER_PAGE
  const currentReviews = reviews?.slice(startIndex, startIndex + REVIEWS_PER_PAGE)

  if (loading) {
    return (
      <div className="py-20 text-center animate-pulse text-muted-foreground">
        Đang tải đánh giá từ khách hàng...
      </div>
    )
  }

  if (!reviews || reviews.length === 0) return null

  return (
    <section className="py-24 px-4 max-w-7xl mx-auto">
      <div className="flex flex-col lg:flex-row gap-16">
        {/* Sidebar Title - Sticky */}
        <div className="lg:w-1/3 lg:sticky lg:top-28 h-fit">
          <Badge
            variant="outline"
            className="mb-4 border-main text-main px-4 py-1 uppercase tracking-wider"
          >
            Đánh giá thực tế
          </Badge>
          <h2 className="text-5xl font-bold leading-tight mb-6">
            Khách hàng <br />
            <span className="text-main italic">Nói gì?</span>
          </h2>
          <p className="text-muted-foreground text-lg leading-relaxed text-justify">
            Sự hài lòng của bạn là ưu tiên hàng đầu của chúng tôi. Hãy xem những trải nghiệm tuyệt
            vời mà các khách hàng trước đó đã chia sẻ.
          </p>
        </div>

        {/* Content - Review List & Pagination */}
        <div className="lg:w-2/3 flex flex-col gap-6">
          <div className="flex flex-col gap-6 min-h-[600px]">
            {currentReviews?.map((review) => (
              <ReviewCard review={review} key={review.id} />
            ))}
          </div>

          {/* Pagination Controls */}
          {totalPages > 1 && (
            <div className="flex items-center justify-between pt-8 border-t">
              <span className="text-sm text-muted-foreground">
                Trang <strong>{currentPage}</strong> trên <strong>{totalPages}</strong>
              </span>
              <div className="flex gap-2">
                <Button
                  variant="outline"
                  size="icon"
                  onClick={() => setCurrentPage((prev) => Math.max(prev - 1, 1))}
                  disabled={currentPage === 1}
                  className="rounded-full hover:border-main hover:text-main"
                >
                  <ChevronLeft className="w-4 h-4" />
                </Button>
                <Button
                  variant="outline"
                  size="icon"
                  onClick={() => setCurrentPage((prev) => Math.min(prev + 1, totalPages))}
                  disabled={currentPage === totalPages}
                  className="rounded-full hover:border-main hover:text-main"
                >
                  <ChevronRight className="w-4 h-4" />
                </Button>
              </div>
            </div>
          )}
        </div>
      </div>
    </section>
  )
}
