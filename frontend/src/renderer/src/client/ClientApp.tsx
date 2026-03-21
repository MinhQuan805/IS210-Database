import { ArrowRight } from 'lucide-react'

import { Link } from 'react-router-dom'

import { Button } from '@/components/ui/button'

import AmenitiesSection from '@renderer/admin/features/amenities/components/AmentitiesSection'
import FaqsSection from '@renderer/admin/features/faqs/components/FaqsSection'
import ReviewsSection from '@renderer/admin/features/reviews/components/ReviewsSection'

import vd from '../assets/park_hyatt_saigon_mast.webm'
import img from '../assets/SAIPH-P0730-Exterior-View.16x9.webp'

export function ClientApp() {
  return (
    <div>
      {/* HERO VIDEO */}
      <div className="relative w-full">
        {/* Header overlay */}
        <div className="absolute top-0 left-0 w-full bg-black/50 backdrop-blur-md py-3 z-40 flex flex-col items-center justify-center">
          <div className=" text-white tracking-wide font-semibold px-5 border-b border-t border-white">
            ★★★★★
          </div>
        </div>

        {/* Video */}
        <video src={vd} className="w-full" autoPlay muted loop playsInline />
      </div>

      {/* Sections */}
      <div className="space-y-10 px-20">
        {/* LEADIN SECTION */}
        <section className="max-w-6xl mx-auto grid md:grid-cols-2 gap-8 py-16">
          <div className="flex flex-col justify-center gap-4">
            <h2 className="text-5xl mb-8 text-main font-semibold">
              Khách sạn hàng đầu tại Thành phố Hồ Chí Minh
            </h2>

            <p className="text-muted-foreground leading-relaxed text-justify">
              Khám phá chuẩn mực sang trọng mang dấu ấn riêng tại LS, được khắc họa qua thiết kế
              tinh tế và tiện nghi hiện đại. Thưởng thức những nhà hàng đẳng cấp quốc tế và tận
              hưởng không gian spa yên bình.
            </p>

            <div className="flex gap-3">
              <Link to="/search/">
                <Button>
                  Tìm phòng <ArrowRight />
                </Button>
              </Link>
            </div>
          </div>

          <div>
            <img src={img} className="rounded-xl object-cover w-full h-[350px]" />
          </div>
        </section>

        <AmenitiesSection />

        <FaqsSection />

        <ReviewsSection />
      </div>
    </div>
  )
}
