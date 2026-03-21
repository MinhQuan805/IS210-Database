import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger
} from '@/components/ui/accordion'

import { Faq } from '@renderer/admin/features/faqs/data/schema'

export default function FaqsArcodition({
  faqs,
  className = ''
}: {
  faqs: Faq[]
  className?: string
}) {
  return (
    <Accordion type="single" collapsible defaultValue="shipping" className={`w-full ${className}`}>
      {faqs.map((faq) => (
        <AccordionItem value={String(faq.id)}>
          <AccordionTrigger className="space-x-2">{faq.question}</AccordionTrigger>
          <AccordionContent className="text-justify px-5">{faq.answer}</AccordionContent>
        </AccordionItem>
      ))}
    </Accordion>
  )
}
