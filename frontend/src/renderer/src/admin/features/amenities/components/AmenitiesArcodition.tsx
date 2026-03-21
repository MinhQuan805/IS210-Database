import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger
} from '@/components/ui/accordion'

import { Badge } from '@/components/ui/badge'

import { Amenity } from '@renderer/admin/features/amenities/data/schema'

export default function AmenitiesArcodition({
  amenities,
  className = ''
}: {
  amenities: Amenity[]
  className?: string
}) {
  return (
    <Accordion type="single" collapsible defaultValue="shipping" className={`w-full ${className}`}>
      {amenities.map((amenity) => (
        <AccordionItem value={String(amenity.id)}>
          <AccordionTrigger className="space-x-2">
            <Badge variant="secondary" className="hover:no-underline!">
              {amenity.icon.toUpperCase()}
            </Badge>{' '}
            {amenity.name}
          </AccordionTrigger>
          <AccordionContent className="text-justify px-5">{amenity.description}</AccordionContent>
        </AccordionItem>
      ))}
    </Accordion>
  )
}
