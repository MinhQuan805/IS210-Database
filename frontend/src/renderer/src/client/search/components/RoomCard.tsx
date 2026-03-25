import { RoomDetail } from '@renderer/client/search/data/roomDetailSchema'
import { Badge, Button, Card, CardContent } from '@renderer/components/ui'
import { MapPin, Users, Sparkles, Info, CircleQuestionMark } from 'lucide-react'

export default function RoomCard({ rooms }: { rooms: RoomDetail[] }) {
  return (
    <div className="flex flex-col gap-6 p-4">
      {rooms.map((room, index) => (
        <Card
          key={index}
          className="overflow-hidden border-none shadow-lg hover:shadow-xl transition-shadow duration-300"
        >
          <CardContent className="p-0 flex flex-col md:flex-row min-h-[220px]">
            {/* PHẦN TRÁI: THÔNG TIN PHÒNG */}
            <div className="w-full md:w-[30%] p-6 bg-primary text-primary-foreground flex flex-col justify-between relative">
              <div>
                <div className="flex items-center gap-2 mb-2 opacity-80">
                  <MapPin size={16} />
                  <span className="text-xs uppercase tracking-widest font-semibold">Vị trí</span>
                </div>
                <h2 className="text-4xl font-black mb-1">{room.roomNumber}</h2>
                <p className="text-lg font-medium opacity-90 italic">Tầng {room.floor}</p>
              </div>

              <div className="mt-4 flex items-center gap-4">
                <div className="flex items-center gap-1">
                  <Users size={18} />
                  <span className="font-bold">{room.capacity} người.</span>
                </div>
              </div>
            </div>

            {/* PHẦN GIỮA: LOẠI PHÒNG & TIỆN ÍCH */}
            <div className="w-full md:w-[50%] p-6 flex flex-col justify-between bg-white border-r border-dashed border-slate-200 relative">
              <div>
                <div className="flex justify-between items-start mb-2">
                  <h3 className="text-xl font-bold text-slate-800">{room.roomTypeName}</h3>
                  <Badge
                    variant="secondary"
                    className="bg-emerald-100 text-emerald-700 hover:bg-emerald-100"
                  >
                    PHÒNG TRỐNG
                  </Badge>
                </div>
                <p className="text-sm text-slate-500 line-clamp-2 mb-4 italic">
                  "{room.roomTypeDescription}"
                </p>

                <div className="flex flex-wrap gap-2">
                  {room.amenities.slice(0, 5).map((amt) => (
                    <Badge
                      key={amt.id}
                      variant="outline"
                      className="flex items-center gap-1 text-[10px] py-0 px-2"
                    >
                      <Sparkles size={10} className="text-blue-500" />
                      <span className="text-muted-foreground">{amt.name}</span>
                    </Badge>
                  ))}
                  {room.amenities.length > 5 && (
                    <span className="text-xs text-muted-foreground">
                      +{room.amenities.length - 5} khác...
                    </span>
                  )}
                </div>
              </div>

              {room.notes.length && (
                <div className="mt-4 pt-4 border-t border-slate-100 flex items-center gap-2 text-slate-500 italic">
                  <Info size={14} />
                  <span className="text-xs">{room.notes}</span>
                </div>
              )}
            </div>

            {/* PHẦN PHẢI: CHI PHÍ & NÚT ĐẶT */}
            <div className="w-full md:w-[20%] p-6 flex flex-col justify-center items-center bg-slate-50 text-center">
              <div className="mb-4">
                <span
                  className="text-xs text-slate-400 block uppercase font-bold tracking-tighter"
                  title="Tính từ lúc check-in đến lúc check-out"
                >
                  Giá gốc
                </span>
                <span className="text-2xl font-black text-slate-900">
                  {new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(
                    room.rawPrice
                  )}
                </span>
              </div>
              <Button className="w-full">ĐẶT NGAY!</Button>
            </div>
          </CardContent>
        </Card>
      ))}
    </div>
  )
}
