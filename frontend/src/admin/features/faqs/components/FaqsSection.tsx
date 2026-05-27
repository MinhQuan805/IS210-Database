import { useEffect, useState } from 'react'
import { toast } from 'sonner'
import { faqsApi } from '@renderer/admin/features/faqs/data/api'
import FaqsArcodition from '@renderer/admin/features/faqs/components/FaqsArcodition'
import { Faq } from '@renderer/admin/features/faqs/data/schema'
import { Badge } from '@/components/ui/badge' // Đảm bảo đúng path

export default function FaqsSection() {
  const [faqs, setFaqs] = useState<Faq[] | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function fetchFaqs() {
      try {
        const data = await faqsApi.active()
        setFaqs(data || [])
      } catch (error) {
        toast.error('Không thể tải danh sách FAQs.')
        console.error('Failed to fetch FAQs:', error)
      } finally {
        setLoading(false)
      }
    }
    fetchFaqs()
  }, [])

  if (loading)
    return (
      <div className="py-20 text-center animate-pulse text-muted-foreground">
        Đang tải câu hỏi...
      </div>
    )
  if (!faqs || faqs.length === 0) return null

  return (
    <section className="py-24 px-4 max-w-7xl mx-auto">
      <div className="flex flex-col lg:flex-row gap-16">
        {/* Sidebar Title - Sticky logic giống Amenities */}
        <div className="lg:w-1/3 lg:sticky lg:top-28 h-fit">
          <Badge
            variant="outline"
            className="mb-4 border-main text-main px-4 py-1 uppercase tracking-wider"
          >
            Hỗ trợ khách hàng
          </Badge>
          <h2 className="text-5xl font-bold leading-tight mb-6">
            <span className="text-main italic">FAQs</span>
          </h2>
          <p className="text-muted-foreground text-lg leading-relaxed text-justify">
            Mọi thắc mắc của bạn về dịch vụ, quy trình đặt phòng và các chính sách đều được giải đáp
            chi tiết tại đây.
          </p>
        </div>

        {/* Content - FAQ List */}
        <div className="lg:w-2/3">
          <FaqsArcodition faqs={faqs} />
        </div>
      </div>
    </section>
  )
}
