import { History, Clock, User } from 'lucide-react'

import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { BookingHistory } from '@renderer/admin/features/bookings/data/schema'

export default function HistoryCard({ history }: { history: BookingHistory[] }) {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center justify-between">
          <div className="font-bold leading-tight text-main text-2xl">LỊCH SỬ CHỈNH SỬA</div>
          <History className="size-10" />
        </CardTitle>
      </CardHeader>
      <CardContent className="flex flex-col gap-1">
        {history.map((h, i) => (
          <div key={i} className="group relative flex gap-4 pb-6 last:pb-0">
            {/* Đường kẻ dọc nối các bước */}
            {i !== history.length - 1 && (
              <span
                className="absolute left-[11px] top-6 h-full w-[2px] bg-muted group-hover:bg-primary/30 transition-colors"
                aria-hidden="true"
              />
            )}

            {/* Điểm nút Timeline */}
            <div className="relative flex h-6 w-6 flex-none items-center justify-center bg-background">
              <div className="h-2 w-2 rounded-full bg-primary ring-4 ring-muted" />
            </div>

            {/* Nội dung chi tiết */}
            <div className="flex-auto space-y-1">
              <div className="flex items-center justify-between gap-x-4">
                <p className="text-sm font-bold leading-6 text-foreground">{h.action}</p>
                <div className="flex items-center gap-1 text-[10px] text-muted-foreground uppercase">
                  <Clock className="w-3 h-3" />
                  <span>{h.timestamp}</span>
                </div>
              </div>

              {h.notes && (
                <p className="text-sm italic text-muted-foreground bg-muted/30 p-2 rounded-sm border-l-2 border-muted">
                  "{h.notes}"
                </p>
              )}

              <div className="flex items-center gap-1 text-xs text-muted-foreground pt-1">
                <User className="w-3 h-3" />
                <span>
                  Thực hiện bởi:{' '}
                  <span className="font-medium text-foreground/80">
                    {h.performedBy ?? '(hệ thống)'}.
                  </span>
                </span>
              </div>
            </div>
          </div>
        ))}
      </CardContent>
    </Card>
  )
}
