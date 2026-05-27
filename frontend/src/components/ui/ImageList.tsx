import { useState } from 'react'
import { X, ArrowLeft, ArrowRight, Ellipsis } from 'lucide-react'

export default function ImageList({
  images,
  className = ''
}: {
  images: string[]
  className?: string
}) {
  const [currentIndex, setCurrentIndex] = useState<number | null>(null)

  const maxImages = 15
  const visibleImages = images.slice(0, maxImages)

  const open = (index: number) => {
    setCurrentIndex(index)
  }

  const close = () => setCurrentIndex(null)

  const next = (e?: React.MouseEvent) => {
    e?.stopPropagation()
    if (currentIndex === null) return
    setCurrentIndex((currentIndex + 1) % images.length)
  }

  const prev = (e?: React.MouseEvent) => {
    e?.stopPropagation()
    if (currentIndex === null) return
    setCurrentIndex((currentIndex - 1 + images.length) % images.length)
  }

  return (
    <>
      {/* GRID */}
      <div className={`grid grid-cols-5 gap-2 ${className}`}>
        {visibleImages.map((src, index) => {
          const isLast = index === maxImages - 1 && images.length > maxImages

          return (
            <div
              key={index}
              className="relative cursor-pointer overflow-hidden rounded-lg"
              onClick={() => open(index)}
            >
              <img src={src} className="w-full h-full object-cover" />

              {/* Ellipsis overlay */}
              {isLast && (
                <div className="absolute inset-0 bg-black/60 flex items-center justify-center">
                  <Ellipsis className="text-white w-8 h-8" />
                </div>
              )}
            </div>
          )
        })}
      </div>

      {/* POPUP */}
      {currentIndex !== null && (
        <div
          className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50"
          onClick={close}
        >
          {/* CLOSE BUTTON */}
          <button
            className="absolute top-4 left-4 text-white"
            onClick={(e) => {
              e.stopPropagation()
              close()
            }}
          >
            <X size={28} />
          </button>

          {/* LEFT */}
          <button className="absolute left-4 text-white" onClick={prev}>
            <ArrowLeft size={40} />
          </button>

          {/* IMAGE */}
          <img
            src={images[currentIndex]}
            className="max-h-[80%] max-w-[80%] object-contain"
            onClick={(e) => e.stopPropagation()}
          />

          {/* RIGHT */}
          <button className="absolute right-4 text-white" onClick={next}>
            <ArrowRight size={40} />
          </button>
        </div>
      )}
    </>
  )
}
