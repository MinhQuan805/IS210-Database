# Quy tắc sử dụng dữ liệu

## Định dạng dữ liệu ngày / tháng (datetime)

- Tại client: `Date` `dd-MM-yyyy`.
- Tại server: `LocalDatetime` `yyyy-MM-dd`.
- Tại database: `TIMESTAMP` (không quan trọng định dạng).

## Dữ liệu của booking_history

- `notes`: Mô tả thay đổi, viết theo cú pháp: `Đã <tên thao tác> đặt phòng`.

## API

- Đều bắt đầu từ segment: `/api/`.
- Header luôn có 2 trường sau:
  - `'Content-Type': 'application/json'`.
  - `'Client-Type'`: Mặc định là `CUSTOMER`. Trường này dùng để xác định chủ thể gọi API (dùng cho booking_history). Kiểu dữ liệu tương ứng trong server/client là `BookingActor`. Trường dữ liệu tương ứng trong database là `performed_by`.

## Phân công chức năng

**Các chức năng được được đảm nhiệm bởi database triggers**:

- Cập nhật `rooms.status` (`trg_booking_room_status`).
- Cập nhật `bookings.status` thành `CONFIRMED` khi thanh toán đủ, đồng thời ghi nhận vào `booking_history` (`trg_payment_confirm_booking`).
- Quản lý sử dụng `promotions.used_count` (`trg_bpromo_biu`).
- Tính `bookings.total_price` (`trg_total_price`).

**Các chức năng được được đảm nhiệm bởi server**:

- CRUD trên các bảng.
- Xuất PDF phiếu hóa đơn và thông tin đặt phòng (`pdfService`).
- Tính `raw_price` và `discount_amount` (`pricingSerivce`).

# Quy trình nghiệp vụ

## Công thức tính giá đặt phòng

Đơn vị tính: VND.

$$\text{total\_price}=\text{raw\_price}-\text{discount\_amount}$$

Trong đó:

- $\text{raw\_price}$: Giá tiền thô.
- $\text{discount\_amount}$: Giá tiền được giảm.

$$\text{raw\_price}=\sum_{i=1}^n{(\text{base\_price}+\text{daily\_price}_j)\times\text{seasonal\_multiplier}_k}$$

Trong đó:

- $n$: Tổng số ngày sử dụng phòng, tính từ check-in đến check-out.
- $\text{base\_price}$: Giá sử dụng phòng cơ bản.
- $\text{daily\_price}_j$: Chi phí tăng thêm vào ngày $j$, $j$ thuộc khoảng thời gian sử dụng phòng.
- $\text{seasonal\_multiplier}_k$: Hệ số tăng thêm theo mùa $k$, $k$ có phần giao nhau với khoảng thời gian sử dụng phòng. Nếu có giao nhau nhiều $\text{seasonal\_multiplier}_k$ thì dùng $\text{seasonal\_multiplier}_k$ nào có priority cao nhất.

## Đối với khách hàng

## Đối với khách hàng đã đăng ký tài khoản

## Đối với quản lý và nhân viên khách sạn
