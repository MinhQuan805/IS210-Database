import { Policy } from '@renderer/admin/features/policies/data/schema'

import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { ClipboardList, History } from 'lucide-react'

export default function PoliciesCard({ policies }: { policies: Policy[] }) {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center justify-between">
          <div className="font-bold leading-tight text-main text-2xl">CHÍNH SÁCH ĐẶT PHÒNG</div>
          <ClipboardList className="size-10" />
        </CardTitle>
        <CardContent className="flex flex-col gap-1">
          {!policies.length && (
            <p className="text-sm text-muted-foreground italic tracking-tight">
              (Không có chính sách)
            </p>
          )}

          {policies.map((policy, i) => (
            <div key={i} className="group relative flex gap-4 pb-8 last:pb-0">
              {/* Đường kẻ dọc nối các chính sách */}
              {i !== policies.length - 1 && (
                <span
                  className="absolute left-[11px] top-6 h-full w-[2px] bg-muted group-hover:bg-blue-400/30 transition-colors"
                  aria-hidden="true"
                />
              )}

              {/* Điểm nút Timeline - Icon phân loại */}
              <div className="relative flex h-6 w-6 flex-none items-center justify-center bg-background">
                <div className="h-2 w-2 rounded-full bg-blue-600 ring-4 ring-blue-100" />
              </div>

              {/* Nội dung chi tiết Policy */}
              <div className="flex-auto space-y-2">
                <div className="flex items-center justify-between gap-x-4">
                  <div className="flex flex-wrap items-center gap-2">
                    {/* Tag loại chính sách */}
                    <span className="inline-flex items-center rounded bg-slate-100 px-1.5 py-0.5 text-[10px] font-bold text-slate-600 ring-1 ring-inset ring-slate-500/20 uppercase">
                      {policy.type.replace('_', ' ')}
                    </span>
                    <h4 className="text-sm font-bold leading-6 text-foreground">{policy.title}</h4>
                    <span className="text-[10px] text-muted-foreground bg-muted px-1.5 rounded-full">
                      v{policy.version}
                    </span>
                  </div>

                  {policy.updatedAt && (
                    <div className="flex items-center gap-1 text-[10px] text-muted-foreground uppercase font-medium whitespace-nowrap">
                      <History className="w-3 h-3" />
                      <span>
                        Cập nhật: {new Date(policy.updatedAt).toLocaleDateString('vi-VN')}
                      </span>
                    </div>
                  )}
                </div>

                {/* Nội dung chính sách */}
                <div className="text-sm text-muted-foreground leading-relaxed bg-slate-50/50 p-3 rounded-md border border-slate-100">
                  <div className="prose prose-sm max-w-none line-clamp-3 group-hover:line-clamp-none transition-all duration-300">
                    {policy.content}
                  </div>
                </div>
              </div>
            </div>
          ))}
        </CardContent>
      </CardHeader>
    </Card>
  )
}
