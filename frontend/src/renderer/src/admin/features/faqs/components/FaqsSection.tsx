import { useEffect, useState } from 'react'
import { toast } from 'sonner'

import { faqsApi } from '@renderer/admin/features/faqs/data/api'
import FaqsArcodition from '@renderer/admin/features/faqs/components/FaqsArcodition'
import { Faq } from '@renderer/admin/features/faqs/data/schema'

export default function FaqsSection() {
  const [faqs, setFaqs] = useState<Faq[] | null>(null)

  useEffect(() => {
    async function fetchAmenities() {
      try {
        const data = await faqsApi.active()
        setFaqs(data || [])
      } catch (error) {
        toast.error('Không thể tải danh sách FAQs.')
        console.error('Failed to fetch FAQs:', error)
      }
    }

    fetchAmenities()
  }, [])

  return (
    <>
      {faqs && (
        <section>
          <div className="grid grid-cols-1 lg:grid-cols-4 gap-8 items-start">
            <h2 className="text-5xl mb-8 text-main font-semibold">FAQs</h2>
            <FaqsArcodition faqs={faqs} className="lg:col-span-3 pl-5 border-l-5 border-main" />
          </div>
        </section>
      )}
    </>
  )
}
