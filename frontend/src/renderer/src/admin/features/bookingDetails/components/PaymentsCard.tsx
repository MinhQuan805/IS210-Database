import { History, Clock } from 'lucide-react'

import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Payment } from '@renderer/admin/features/payments/data/schema'

export default function PaymentsCard({ payments }: { payments: Payment[] }) {
  const successPayments = payments.filter((p) => p.status === 'SUCCESS')
  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center justify-between">
          <div className="font-bold leading-tight text-main text-2xl">LỊCH SỬ THANH TOÁN</div>
          <History className="size-10" />
        </CardTitle>
      </CardHeader>
      <CardContent className="flex flex-col gap-1">
        {successPayments.map((p, i) => (
          <div key={i} className="group relative flex gap-4 pb-6 last:pb-0">
            {/* Đường kẻ dọc nối các bước */}
            {i !== successPayments.length - 1 && (
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
                <div className="flex items-center gap-1 text-[10px] text-muted-foreground uppercase">
                  <Clock className="w-3 h-3" />
                  <span>{p.paymentDate}</span>
                </div>
              </div>

              <p className="text-sm italic text-muted-foreground bg-muted/30 p-2 rounded-sm border-l-2 border-muted">
                {p.amount} VND
              </p>
            </div>
          </div>
        ))}
      </CardContent>
    </Card>
  )
}
