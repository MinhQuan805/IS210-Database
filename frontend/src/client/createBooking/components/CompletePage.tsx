import { pdfApi } from '@renderer/admin/features/pdf/api'
import {
  Button,
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter
} from '@renderer/components/ui'

import { CheckCheck, Download } from 'lucide-react'
import { Link } from 'react-router-dom'
import { toast } from 'sonner'

interface CompleteDialogProps {
  bookingId: number
  open: boolean
}

export default function CompleteDialog({ bookingId, open }: CompleteDialogProps) {
  async function handleDownloadInfo() {
    try {
      // Đổi thành toast.loading hoặc toast.info sẽ hợp lý hơn là toast.error khi đang tìm kiếm
      toast.info('Đang chuẩn bị filen...')
      await pdfApi.info(bookingId)
    } catch (err) {
      toast.error('Tải file bị lỗi! Hãy thử lại.')
      console.error(err)
    }
  }

  return (
    <Dialog open={open}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader className="flex flex-col items-center justify-center">
          <div className="rounded-full bg-green-100 p-3 mb-2">
            <CheckCheck className="size-12 text-green-600" />
          </div>
          <DialogTitle className="text-xl text-center">Đặt phòng thành công!</DialogTitle>
          <DialogDescription className="text-center pt-2">
            Chúng tôi đã gửi phiếu thông tin cho bạn. Nếu quá trình tải file tự động bị lỗi, bạn có
            thể bấm vào nút bên dưới để tải lại thủ công.
          </DialogDescription>
        </DialogHeader>

        <DialogFooter className="mt-4 w-full flex items-center justify-evenly">
          <Link to="/">
            <Button variant="outline">Về trang chủ</Button>
          </Link>

          <Button onClick={handleDownloadInfo} className="flex gap-2">
            <Download className="size-4" />
            Tải phiếu đặt phòng
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  )
}
