import { forwardRef } from 'react'
import { Bed, Calendar, DollarSign, TrendingUp, Users } from 'lucide-react'
import {
  LineChart,
  Line,
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Legend,
  PieChart,
  Pie,
  Cell
} from 'recharts'
import {
  type OverviewData,
  type TrendItem,
  type OccupancyData,
  type RoomTypeStats,
  type BookingStatusStats,
  type RevenueByRoomType
} from '../data/api'

interface PrintableReportProps {
  startDate: string
  endDate: string
  overview: OverviewData | null
  trends: TrendItem[]
  revenueChartData: TrendItem[]
  occupancy: OccupancyData | null
  roomsByType: RoomTypeStats[]
  bookingsByStatus: BookingStatusStats[]
  revenueByRoomType: RevenueByRoomType[]
}

const COLORS = [
  '#0088FE',
  '#00C49F',
  '#FFBB28',
  '#FF8042',
  '#8884d8',
  '#82ca9d',
  '#ffc658',
  '#ff7300'
]

const formatVND = (val: number) =>
  new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val)

const formatDate = (date: string) => new Date(date).toLocaleDateString('vi-VN')

function getBookingStatusLabel(status: string): string {
  const statusMap: Record<string, string> = {
    PENDING: 'Chờ xử lý',
    CONFIRMED: 'Đã xác nhận',
    CHECKED_IN: 'Đã nhận phòng',
    CHECKED_OUT: 'Đã trả phòng',
    CANCELLED: 'Đã hủy'
  }
  return statusMap[status] || status
}

export const PrintableReport = forwardRef<HTMLDivElement, PrintableReportProps>(
  (
    {
      startDate,
      endDate,
      overview,
      trends,
      revenueChartData,
      occupancy,
      roomsByType,
      bookingsByStatus,
      revenueByRoomType
    },
    ref
  ) => {
    const todayStr = new Date().toLocaleDateString('vi-VN', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    })

    return (
      <div
        ref={ref}
        style={{
          position: 'absolute',
          left: '-9999px',
          top: '-9999px',
          zIndex: -1000,
          background: '#f8fafc'
        }}
      >
        {/* PAGE 1: Overview and Current Occupancy */}
        <div className="printable-page" style={pageStyle}>
          {/* Header */}
          <div style={headerStyle}>
            <div style={{ display: 'flex', justifyContent: 'between', alignItems: 'center' }}>
              <div>
                <h2 style={{ fontSize: '14px', fontWeight: 'bold', color: '#1e3a8a', margin: 0 }}>
                  KHÁCH SẠN LUMINA SUITES
                </h2>
                <p style={{ fontSize: '10px', color: '#64748b', margin: '2px 0 0 0' }}>
                  Địa chỉ: 123 Đường Kha Vạn Cân, Linh Đông, Thủ Đức, TP. HCM
                </p>
              </div>
              <div style={{ textAlign: 'right' }}>
                <span
                  style={{
                    fontSize: '9px',
                    backgroundColor: '#e0f2fe',
                    color: '#0369a1',
                    padding: '3px 8px',
                    borderRadius: '9999px',
                    fontWeight: 'bold'
                  }}
                >
                  BÁO CÁO NỘI BỘ
                </span>
              </div>
            </div>
            <hr style={{ border: '0', borderTop: '2px solid #e2e8f0', margin: '12px 0' }} />
            <div style={{ textAlign: 'center', margin: '15px 0' }}>
              <h1 style={{ fontSize: '24px', fontWeight: '800', color: '#0f172a', margin: 0 }}>
                BÁO CÁO KẾT QUẢ HOẠT ĐỘNG
              </h1>
              <p style={{ fontSize: '12px', color: '#475569', margin: '6px 0 0 0' }}>
                Thời gian báo cáo: Từ {formatDate(startDate)} đến {formatDate(endDate)}
              </p>
            </div>
          </div>

          {/* Section 1: Overview Metrics */}
          <div style={{ marginBottom: '25px' }}>
            <h3 style={sectionTitleStyle}>I. CÁC CHỈ SỐ HOẠT ĐỘNG CHỦ CHỐT</h3>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(5, 1fr)', gap: '10px' }}>
              <MiniOverviewCard
                title="Tổng Số Phòng"
                value={overview?.totalRooms}
                icon={<Bed size={16} color="#0f172a" />}
              />
              <MiniOverviewCard
                title="Tổng Đặt Phòng"
                value={overview?.totalBookings}
                icon={<Calendar size={16} color="#0f172a" />}
              />
              <MiniOverviewCard
                title="Doanh Thu"
                value={overview ? formatVND(overview.totalRevenue) : '—'}
                icon={<DollarSign size={16} color="#0f172a" />}
              />
              <MiniOverviewCard
                title="Công Suất TB"
                value={overview != null ? `${overview.occupancyRate.toFixed(1)}%` : '—'}
                icon={<TrendingUp size={16} color="#0f172a" />}
              />
              <MiniOverviewCard
                title="Khách Hàng"
                value={overview?.totalCustomers}
                icon={<Users size={16} color="#0f172a" />}
              />
            </div>
          </div>

          {/* Section 2: Occupancy Rate Today */}
          <div style={{ marginBottom: '20px' }}>
            <h3 style={sectionTitleStyle}>II. CÔNG SUẤT SỬ DỤNG PHÒNG HÔM NAY</h3>
            {occupancy ? (
              <div
                style={{
                  border: '1px solid #e2e8f0',
                  borderRadius: '8px',
                  padding: '16px',
                  backgroundColor: '#ffffff'
                }}
              >
                <div
                  style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(3, 1fr)',
                    textAlign: 'center',
                    marginBottom: '15px'
                  }}
                >
                  <div>
                    <p style={{ fontSize: '11px', color: '#64748b', margin: '0 0 4px 0' }}>
                      Phòng Đã Sử Dụng
                    </p>
                    <p
                      style={{
                        fontSize: '20px',
                        fontWeight: 'bold',
                        color: '#0f172a',
                        margin: 0
                      }}
                    >
                      {occupancy.occupiedRooms} phòng
                    </p>
                  </div>
                  <div>
                    <p style={{ fontSize: '11px', color: '#64748b', margin: '0 0 4px 0' }}>
                      Tổng Số Phòng
                    </p>
                    <p
                      style={{
                        fontSize: '20px',
                        fontWeight: 'bold',
                        color: '#0f172a',
                        margin: 0
                      }}
                    >
                      {occupancy.totalRooms} phòng
                    </p>
                  </div>
                  <div>
                    <p style={{ fontSize: '11px', color: '#64748b', margin: '0 0 4px 0' }}>
                      Tỷ Lệ Lấp Đầy Hôm Nay
                    </p>
                    <p
                      style={{
                        fontSize: '20px',
                        fontWeight: 'bold',
                        color: '#16a34a',
                        margin: 0
                      }}
                    >
                      {occupancy.occupancyRate.toFixed(1)}%
                    </p>
                  </div>
                </div>

                {/* Progress bar */}
                <div>
                  <div
                    style={{
                      display: 'flex',
                      justifyContent: 'space-between',
                      fontSize: '11px',
                      marginBottom: '4px',
                      color: '#475569'
                    }}
                  >
                    <span>
                      Tiến trình sử dụng: {occupancy.occupiedRooms}/{occupancy.totalRooms} phòng
                    </span>
                    <span style={{ fontWeight: 'bold' }}>{occupancy.occupancyRate.toFixed(1)}%</span>
                  </div>
                  <div
                    style={{
                      height: '10px',
                      width: '100%',
                      borderRadius: '9999px',
                      backgroundColor: '#e2e8f0',
                      overflow: 'hidden'
                    }}
                  >
                    <div
                      style={{
                        height: '100%',
                        borderRadius: '9999px',
                        width: `${Math.min(occupancy.occupancyRate, 100)}%`,
                        backgroundColor:
                          occupancy.occupancyRate >= 80
                            ? '#22c55e'
                            : occupancy.occupancyRate >= 50
                              ? '#eab308'
                              : '#ef4444'
                      }}
                    />
                  </div>
                </div>
              </div>
            ) : (
              <p style={{ fontSize: '12px', color: '#64748b', fontStyle: 'italic' }}>
                Không tìm thấy dữ liệu công suất sử dụng phòng hôm nay.
              </p>
            )}
          </div>

          {/* Footer */}
          <div style={footerStyle}>
            <hr style={{ border: '0', borderTop: '1px solid #e2e8f0', margin: '8px 0' }} />
            <div
              style={{
                display: 'flex',
                justifyContent: 'space-between',
                fontSize: '9px',
                color: '#94a3b8'
              }}
            >
              <span>Ngày xuất bản: {todayStr}</span>
              <span>Trang 1 / 3</span>
            </div>
          </div>
        </div>

        {/* PAGE 2: Booking Trends & Monthly Revenue */}
        <div className="printable-page" style={pageStyle}>
          {/* Header */}
          <div style={headerStyle}>
            <div style={{ display: 'flex', justifyContent: 'between', alignItems: 'center' }}>
              <span style={{ fontSize: '10px', fontWeight: 'bold', color: '#64748b' }}>
                KHÁCH SẠN LUMINA SUITES - BÁO CÁO THỐNG KÊ
              </span>
              <span style={{ fontSize: '9px', color: '#94a3b8' }}>Mẫu số 02/BC-DT</span>
            </div>
            <hr style={{ border: '0', borderTop: '1px solid #e2e8f0', margin: '8px 0' }} />
          </div>

          {/* Section 3: Trends Chart */}
          <div style={{ marginBottom: '25px' }}>
            <h3 style={sectionTitleStyle}>III. XU HƯỚNG ĐẶT PHÒNG VÀ DOANH THU</h3>
            <p style={{ fontSize: '11px', color: '#475569', marginBottom: '10px' }}>
              Biểu đồ dưới đây thể hiện sự biến động của số lượng lượt đặt phòng và tổng doanh thu thu
              được theo thời gian.
            </p>
            <div
              style={{
                backgroundColor: '#ffffff',
                border: '1px solid #e2e8f0',
                borderRadius: '8px',
                padding: '12px',
                display: 'flex',
                justifyContent: 'center'
              }}
            >
              {trends && trends.length > 0 ? (
                <LineChart width={690} height={260} data={trends} margin={{ top: 10, right: 10, left: 10, bottom: 5 }}>
                  <CartesianGrid strokeDasharray="3 3" stroke="#f1f5f9" />
                  <XAxis dataKey="date" tickFormatter={formatDate} fontSize={10} stroke="#64748b" />
                  <YAxis
                    yAxisId="left"
                    fontSize={10}
                    stroke="#8884d8"
                    label={{
                      value: 'Lượt đặt',
                      angle: -90,
                      position: 'insideLeft',
                      style: { textAnchor: 'middle', fill: '#8884d8', fontSize: 10 }
                    }}
                  />
                  <YAxis
                    yAxisId="right"
                    orientation="right"
                    tickFormatter={(v: number) => formatVND(v)}
                    fontSize={9}
                    stroke="#82ca9d"
                    label={{
                      value: 'Doanh thu (VND)',
                      angle: 90,
                      position: 'insideRight',
                      style: { textAnchor: 'middle', fill: '#82ca9d', fontSize: 10 }
                    }}
                  />
                  <Legend wrapperStyle={{ fontSize: '10px', marginTop: '5px' }} />
                  <Line
                    yAxisId="left"
                    type="monotone"
                    dataKey="bookingCount"
                    stroke="#8884d8"
                    strokeWidth={2}
                    dot={false}
                    name="Số lượt đặt phòng"
                    isAnimationActive={false}
                  />
                  <Line
                    yAxisId="right"
                    type="monotone"
                    dataKey="revenue"
                    stroke="#82ca9d"
                    strokeWidth={2}
                    dot={false}
                    name="Doanh thu"
                    isAnimationActive={false}
                  />
                </LineChart>
              ) : (
                <div style={{ height: 260, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94a3b8', fontSize: '12px' }}>
                  Không có dữ liệu xu hướng đặt phòng.
                </div>
              )}
            </div>
          </div>

          {/* Section 4: Revenue Bar Chart */}
          <div style={{ marginBottom: '20px' }}>
            <h3 style={sectionTitleStyle}>IV. BIỂU ĐỒ DOANH THU CHI TIẾT</h3>
            <p style={{ fontSize: '11px', color: '#475569', marginBottom: '10px' }}>
              Biểu đồ cột thể hiện mức doanh thu chi tiết được tổng hợp qua các ngày hoặc các giai đoạn.
            </p>
            <div
              style={{
                backgroundColor: '#ffffff',
                border: '1px solid #e2e8f0',
                borderRadius: '8px',
                padding: '12px',
                display: 'flex',
                justifyContent: 'center'
              }}
            >
              {revenueChartData && revenueChartData.length > 0 ? (
                <BarChart width={690} height={260} data={revenueChartData} margin={{ top: 10, right: 10, left: 10, bottom: 5 }}>
                  <CartesianGrid strokeDasharray="3 3" stroke="#f1f5f9" />
                  <XAxis dataKey="date" tickFormatter={formatDate} fontSize={10} stroke="#64748b" />
                  <YAxis tickFormatter={(v: number) => formatVND(v)} fontSize={9} stroke="#64748b" />
                  <Legend wrapperStyle={{ fontSize: '10px', marginTop: '5px' }} />
                  <Bar dataKey="revenue" fill="#8884d8" radius={[4, 4, 0, 0]} name="Doanh thu phát sinh" isAnimationActive={false} />
                </BarChart>
              ) : (
                <div style={{ height: 260, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94a3b8', fontSize: '12px' }}>
                  Không có dữ liệu doanh thu chi tiết.
                </div>
              )}
            </div>
          </div>

          {/* Footer */}
          <div style={footerStyle}>
            <hr style={{ border: '0', borderTop: '1px solid #e2e8f0', margin: '8px 0' }} />
            <div
              style={{
                display: 'flex',
                justifyContent: 'space-between',
                fontSize: '9px',
                color: '#94a3b8'
              }}
            >
              <span>Ngày xuất bản: {todayStr}</span>
              <span>Trang 2 / 3</span>
            </div>
          </div>
        </div>

        {/* PAGE 3: Room breakdown, Status and Signatures */}
        <div className="printable-page" style={pageStyle}>
          {/* Header */}
          <div style={headerStyle}>
            <div style={{ display: 'flex', justifyContent: 'between', alignItems: 'center' }}>
              <span style={{ fontSize: '10px', fontWeight: 'bold', color: '#64748b' }}>
                KHÁCH SẠN LUMINA SUITES - BÁO CÁO THỐNG KÊ
              </span>
              <span style={{ fontSize: '9px', color: '#94a3b8' }}>Mẫu số 03/BC-P</span>
            </div>
            <hr style={{ border: '0', borderTop: '1px solid #e2e8f0', margin: '8px 0' }} />
          </div>

          {/* Section 5: Room Type Analysis */}
          <div style={{ marginBottom: '20px' }}>
            <h3 style={sectionTitleStyle}>V. THỐNG KÊ VÀ DOANH THU THEO LOẠI PHÒNG</h3>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '15px' }}>
              {/* Pie Chart: Rooms by Type */}
              <div
                style={{
                  backgroundColor: '#ffffff',
                  border: '1px solid #e2e8f0',
                  borderRadius: '8px',
                  padding: '10px'
                }}
              >
                <p style={{ fontSize: '11px', fontWeight: 'bold', margin: '0 0 5px 0', textAlign: 'center', color: '#334155' }}>
                  Phân Bổ Số Lượng Phòng
                </p>
                <div style={{ display: 'flex', justifyContent: 'center' }}>
                  {roomsByType && roomsByType.length > 0 ? (
                    <PieChart width={320} height={200}>
                      <Pie
                        data={roomsByType}
                        cx="50%"
                        cy="50%"
                        labelLine={true}
                        label={({ roomType, count }: any) => `${roomType}: ${count}`}
                        outerRadius={65}
                        fill="#8884d8"
                        dataKey="count"
                        nameKey="roomType"
                        isAnimationActive={false}
                      >
                        {roomsByType.map((_, index) => (
                          <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                        ))}
                      </Pie>
                    </PieChart>
                  ) : (
                    <div style={{ height: 200, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94a3b8', fontSize: '11px' }}>
                      Không có dữ liệu phân bổ phòng.
                    </div>
                  )}
                </div>
              </div>

              {/* Bar Chart: Revenue by Type */}
              <div
                style={{
                  backgroundColor: '#ffffff',
                  border: '1px solid #e2e8f0',
                  borderRadius: '8px',
                  padding: '10px'
                }}
              >
                <p style={{ fontSize: '11px', fontWeight: 'bold', margin: '0 0 5px 0', textAlign: 'center', color: '#334155' }}>
                  Doanh Thu Theo Loại Phòng
                </p>
                <div style={{ display: 'flex', justifyContent: 'center' }}>
                  {revenueByRoomType && revenueByRoomType.length > 0 ? (
                    <BarChart width={320} height={200} data={revenueByRoomType} layout="vertical" margin={{ left: 10, right: 10 }}>
                      <CartesianGrid strokeDasharray="3 3" stroke="#f1f5f9" />
                      <XAxis type="number" tickFormatter={(v) => formatVND(v)} fontSize={8} stroke="#64748b" />
                      <YAxis type="category" dataKey="roomType" width={60} fontSize={8} stroke="#64748b" />
                      <Bar dataKey="revenue" fill="#82ca9d" radius={[0, 4, 4, 0]} name="Doanh thu" isAnimationActive={false} />
                    </BarChart>
                  ) : (
                    <div style={{ height: 200, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94a3b8', fontSize: '11px' }}>
                      Không có dữ liệu doanh thu loại phòng.
                    </div>
                  )}
                </div>
              </div>
            </div>
          </div>

          {/* Section 6: Bookings by Status */}
          <div style={{ marginBottom: '25px' }}>
            <h3 style={sectionTitleStyle}>VI. PHÂN TÍCH TRẠNG THÁI ĐẶT PHÒNG</h3>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '15px' }}>
              {/* Pie Chart: Booking status */}
              <div
                style={{
                  backgroundColor: '#ffffff',
                  border: '1px solid #e2e8f0',
                  borderRadius: '8px',
                  padding: '10px'
                }}
              >
                <p style={{ fontSize: '11px', fontWeight: 'bold', margin: '0 0 5px 0', textAlign: 'center', color: '#334155' }}>
                  Tỷ Lệ Trạng Thái Đặt Phòng
                </p>
                <div style={{ display: 'flex', justifyContent: 'center' }}>
                  {bookingsByStatus && bookingsByStatus.length > 0 ? (
                    <PieChart width={320} height={180}>
                      <Pie
                        data={bookingsByStatus.map((item) => ({
                          ...item,
                          statusLabel: getBookingStatusLabel(item.status)
                        }))}
                        cx="50%"
                        cy="50%"
                        labelLine={true}
                        label={({ statusLabel, percent }: any) => `${statusLabel}: ${(percent * 100).toFixed(0)}%`}
                        outerRadius={60}
                        fill="#8884d8"
                        dataKey="count"
                        nameKey="statusLabel"
                        isAnimationActive={false}
                      >
                        {bookingsByStatus.map((_, index) => (
                          <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                        ))}
                      </Pie>
                    </PieChart>
                  ) : (
                    <div style={{ height: 180, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94a3b8', fontSize: '11px' }}>
                      Không có dữ liệu trạng thái đặt phòng.
                    </div>
                  )}
                </div>
              </div>

              {/* Booking status table */}
              <div
                style={{
                  backgroundColor: '#ffffff',
                  border: '1px solid #e2e8f0',
                  borderRadius: '8px',
                  padding: '10px'
                }}
              >
                <p style={{ fontSize: '11px', fontWeight: 'bold', margin: '0 0 8px 0', color: '#334155' }}>
                  Chi Tiết Số Lượng Đặt Phòng
                </p>
                {bookingsByStatus && bookingsByStatus.length > 0 ? (
                  <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '10px' }}>
                    <thead>
                      <tr style={{ borderBottom: '1px solid #e2e8f0', textAlign: 'left', color: '#475569' }}>
                        <th style={{ padding: '6px 4px', fontWeight: 'bold' }}>Trạng thái</th>
                        <th style={{ padding: '6px 4px', fontWeight: 'bold', textAlign: 'center' }}>Số lượng</th>
                        <th style={{ padding: '6px 4px', fontWeight: 'bold', textAlign: 'right' }}>Tỷ lệ</th>
                      </tr>
                    </thead>
                    <tbody>
                      {(() => {
                        const total = bookingsByStatus.reduce((sum, item) => sum + item.count, 0)
                        return bookingsByStatus.map((item, index) => {
                          const percent = total > 0 ? (item.count / total) * 100 : 0
                          return (
                            <tr key={item.status} style={{ borderBottom: '1px solid #f1f5f9' }}>
                              <td style={{ padding: '6px 4px', display: 'flex', alignItems: 'center', gap: '6px' }}>
                                <span
                                  style={{
                                    display: 'inline-block',
                                    width: '8px',
                                    height: '8px',
                                    borderRadius: '50%',
                                    backgroundColor: COLORS[index % COLORS.length]
                                  }}
                                />
                                {getBookingStatusLabel(item.status)}
                              </td>
                              <td style={{ padding: '6px 4px', textAlign: 'center', fontWeight: '500' }}>
                                {item.count}
                              </td>
                              <td style={{ padding: '6px 4px', textAlign: 'right', color: '#475569' }}>
                                {percent.toFixed(1)}%
                              </td>
                            </tr>
                          )
                        })
                      })()}
                    </tbody>
                  </table>
                ) : (
                  <div style={{ height: 150, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94a3b8', fontSize: '11px' }}>
                    Không có bảng chi tiết đặt phòng.
                  </div>
                )}
              </div>
            </div>
          </div>

          {/* Signatures & Approvals */}
          <div style={{ marginTop: '20px', display: 'flex', justifyContent: 'space-between', fontSize: '11px', padding: '0 20px' }}>
            <div style={{ textAlign: 'center' }}>
              <p style={{ fontWeight: 'bold', margin: '0 0 50px 0', color: '#334155' }}>
                Người Lập Biểu
              </p>
              <p style={{ fontStyle: 'italic', color: '#64748b', margin: 0 }}>
                (Ký, ghi rõ họ tên)
              </p>
            </div>
            <div style={{ textAlign: 'center' }}>
              <p style={{ fontWeight: 'bold', margin: '0 0 50px 0', color: '#334155' }}>
                Giám Đốc Phê Duyệt
              </p>
              <p style={{ fontStyle: 'italic', color: '#64748b', margin: 0 }}>
                (Ký tên và đóng dấu)
              </p>
            </div>
          </div>

          {/* Footer */}
          <div style={footerStyle}>
            <hr style={{ border: '0', borderTop: '1px solid #e2e8f0', margin: '8px 0' }} />
            <div
              style={{
                display: 'flex',
                justifyContent: 'space-between',
                fontSize: '9px',
                color: '#94a3b8'
              }}
            >
              <span>Ngày xuất bản: {todayStr}</span>
              <span>Trang 3 / 3</span>
            </div>
          </div>
        </div>
      </div>
    )
  }
)

PrintableReport.displayName = 'PrintableReport'

/* ---- Sub-components ---- */

function MiniOverviewCard({
  title,
  value,
  icon
}: {
  title: string
  value?: string | number
  icon: React.ReactNode
}) {
  return (
    <div
      style={{
        border: '1px solid #e2e8f0',
        borderRadius: '6px',
        padding: '10px',
        backgroundColor: '#ffffff',
        display: 'flex',
        flexDirection: 'column',
        justifyContent: 'space-between',
        height: '75px'
      }}
    >
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <span style={{ fontSize: '10px', fontWeight: '500', color: '#475569' }}>{title}</span>
        {icon}
      </div>
      <div style={{ fontSize: '14px', fontWeight: 'bold', color: '#0f172a', marginTop: '5px' }}>
        {value ?? '—'}
      </div>
    </div>
  )
}

/* ---- Styling styles ---- */

const pageStyle: React.CSSProperties = {
  width: '794px',
  height: '1123px',
  padding: '40px',
  boxSizing: 'border-box',
  backgroundColor: '#f8fafc',
  color: '#0f172a',
  fontFamily: 'Inter, sans-serif',
  display: 'flex',
  flexDirection: 'column',
  justifyContent: 'space-between',
  position: 'relative',
  pageBreakAfter: 'always',
  boxShadow: '0 0 10px rgba(0, 0, 0, 0.05)'
}

const headerStyle: React.CSSProperties = {
  flexShrink: 0
}

const footerStyle: React.CSSProperties = {
  flexShrink: 0,
  marginTop: 'auto'
}

const sectionTitleStyle: React.CSSProperties = {
  fontSize: '12px',
  fontWeight: '800',
  color: '#1e3a8a',
  borderLeft: '3px solid #2563eb',
  paddingLeft: '8px',
  margin: '0 0 10px 0',
  textTransform: 'uppercase',
  letterSpacing: '0.05em'
}
