import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger
} from '@/components/ui/accordion'
import { Faq } from '@renderer/admin/features/faqs/data/schema'
import { HelpCircle } from 'lucide-react' // Thêm icon để chuyên nghiệp hơn

export default function FaqsArcodition({
  faqs,
  className = ''
}: {
  faqs: Faq[]
  className?: string
}) {
  return (
    <Accordion type="single" collapsible className={`w-full space-y-4 ${className}`}>
      {faqs.map((faq) => (
        <AccordionItem
          key={faq.id}
          value={String(faq.id)}
          className="border border-slate-200 rounded-xl px-4 transition-all hover:border-main/50 data-[state=open]:border-main/50 data-[state=open]:shadow-sm"
        >
          <AccordionTrigger className="text-left font-medium text-lg py-2 hover:no-underline hover:text-main transition-colors">
            <div className="flex items-center gap-3">
              <HelpCircle className="w-5 h-5 text-main shrink-0" />
              <span>{faq.question}</span>
            </div>
          </AccordionTrigger>
          <AccordionContent className="text-slate-600 leading-relaxed border-t border-slate-100 mt-2">
            <div className="pl-8">{faq.answer}</div>
          </AccordionContent>
        </AccordionItem>
      ))}
    </Accordion>
  )
}
