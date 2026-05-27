import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Promotion } from '@renderer/admin/features/pricing/data/schema'
import { Tag, Calendar } from 'lucide-react'

export default function PromotionsCard({ promotions }: { promotions: Promotion[] }) {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center justify-between">
          <div className="font-bold leading-tight text-main text-2xl">DANH SÁCH KHUYẾN MÃI</div>
          <Tag className="size-10" />
        </CardTitle>
      </CardHeader>
      <CardContent className="flex flex-col gap-1">
        {!promotions.length && '(Không có)'}
        {promotions.map((p, i) => (
          <div key={i} className="group relative flex gap-4 pb-6 last:pb-0">
            {/* Đường kẻ dọc nối các thẻ khuyến mãi */}
            {i !== promotions.length - 1 && (
              <span
                className="absolute left-[11px] top-6 h-full w-[2px] bg-muted group-hover:bg-orange-400/30 transition-colors"
                aria-hidden="true"
              />
            )}

            {/* Điểm nút Timeline - Icon Khuyến mãi */}
            <div className="relative flex h-6 w-6 flex-none items-center justify-center bg-background">
              <div className="h-2 w-2 rounded-full bg-orange-500 ring-4 ring-orange-100" />
            </div>

            {/* Nội dung chi tiết Khuyến mãi */}
            <div className="flex-auto space-y-2">
              <div className="flex items-center justify-between gap-x-4">
                <div className="flex items-center gap-2">
                  <span className="inline-flex items-center rounded-md bg-orange-50 px-2 py-1 text-xs font-bold text-orange-700 ring-1 ring-inset ring-orange-700/10 uppercase tracking-wider">
                    {p.code}
                  </span>
                  <p className="text-sm font-bold leading-6 text-foreground">
                    Giảm{' '}
                    {typeof p.discountValue === 'number'
                      ? `${p.discountValue.toLocaleString()}`
                      : p.discountValue}
                  </p>
                </div>

                <div className="flex items-center gap-1 text-[10px] text-muted-foreground uppercase font-medium">
                  <Calendar className="w-3 h-3" />
                  <span>
                    {p.startDate} - {p.endDate}
                  </span>
                </div>
              </div>

              {p.description && (
                <p className="text-sm text-muted-foreground leading-relaxed italic">
                  {p.description}
                </p>
              )}

              <div className="border-b border-dashed border-muted pt-2" />
            </div>
          </div>
        ))}
      </CardContent>
    </Card>
  )
}
