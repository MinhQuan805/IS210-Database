import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger
} from '@/components/ui/dialog'
import { ScrollArea } from '@/components/ui/scroll-area'
import { ClipboardList } from 'lucide-react'
import type { Policy } from '@renderer/admin/features/policies/data/schema'
import { Button } from '@renderer/components/ui'

export function PoliciesDialog({ policies }: { policies: Policy[] }) {
  return (
    <Dialog>
      <DialogTrigger asChild>
        <Button
          variant="outline"
          className="flex items-center gap-2 hover:opacity-80 transition-opacity"
        >
          <ClipboardList className="size-4" /> Điều khoản & chính sách
        </Button>
      </DialogTrigger>

      {/* Thêm h-[80vh] hoặc tương đương để cố định khung hình */}
      <DialogContent className="max-w-2xl h-[80vh] flex flex-col p-0 overflow-hidden">
        <DialogHeader className="p-6 pb-2">
          <DialogTitle className="flex items-center gap-2 text-2xl font-bold text-primary text-center">
            <ClipboardList className="size-6" />
            ĐIỀU KHOẢN & CHÍNH SÁCH
          </DialogTitle>
        </DialogHeader>

        {/* ScrollArea cần h-full và nằm trong một div wrapper có flex-1 */}
        <div className="flex-1 overflow-hidden px-6 pb-6">
          <ScrollArea className="h-full pr-4">
            <div className="flex flex-col gap-1 py-2">
              {!policies.length && (
                <p className="text-sm text-muted-foreground italic">(Không có chính sách)</p>
              )}

              {policies.map((policy, i) => (
                <div key={policy.id || i} className="group relative flex gap-4 pb-8 last:pb-0">
                  {/* Timeline Line */}
                  {i !== policies.length - 1 && (
                    <span
                      className="absolute left-[11px] top-6 h-full w-[2px] bg-muted group-hover:bg-blue-400/30 transition-colors"
                      aria-hidden="true"
                    />
                  )}

                  {/* Timeline Dot */}
                  <div className="relative flex h-6 w-6 flex-none items-center justify-center bg-background">
                    <div className="h-2.5 w-2.5 rounded-full bg-blue-600 ring-4 ring-blue-100" />
                  </div>

                  {/* Content */}
                  <div className="flex-auto space-y-2">
                    <div className="flex flex-wrap items-center justify-between gap-2">
                      <div className="flex items-center gap-2">
                        <span className="inline-flex items-center rounded bg-slate-100 px-1.5 py-0.5 text-[10px] font-bold text-slate-600 ring-1 ring-inset ring-slate-500/20 uppercase">
                          {policy.type.replace('_', ' ')}
                        </span>
                        <h4 className="text-sm font-bold leading-6 text-foreground">
                          {policy.title}
                        </h4>
                      </div>

                      {policy.updatedAt && (
                        <div className="flex items-center gap-1 text-[10px] text-muted-foreground uppercase font-medium">
                          v<span>{policy.version}</span>
                        </div>
                      )}
                    </div>

                    <div className="text-sm text-muted-foreground leading-relaxed bg-slate-50/50 p-4 rounded-md border border-slate-100">
                      <div className="prose prose-sm max-w-none whitespace-pre-wrap text-justify">
                        {policy.content}
                      </div>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </ScrollArea>
        </div>
      </DialogContent>
    </Dialog>
  )
}
