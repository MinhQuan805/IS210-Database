# Hướng dẫn sử dụng database trong Docker

## Thông tin cơ bản

- Container name: `hotel-db`:
- Port: `1521` (dùng để kết nối với database).
- Volume: `hotel-data`.
- Hostname: `localhost`.
- PDB (Service name): `FREEPDB1`.

Cả bên trong và bên ngoài container đều dùng chung port.

**Các table đều được tạo trong schema sau**:

- Username: `hotel`.
- Password: `Admin123`.

## Hướng dẫn sử dụng

Lưu ý:

1 - Trước khi dùng phải kích hoạt Docker engine (mở Docker Desktop).

2 - Đường dẫn thư mục chứa các file `.sql` khởi tạo: `D:/UNI DOCS/Hotel/docker/initdb`.

- Các file được sắp xếp theo thứ tự logic.
- Các file chỉ được khởi chạy khi không có volume `hotel-data`.
- Ở đầu file đều phải chuyển user và PDB đúng như cấu hình trên: `ALTER SESSION SET CONTAINER = FREEPDB1; ALTER SESSION SET CURRENT_SCHEMA = hotel;`.

### Tạo và chạy container

Path ở máy Bảo:

```sh
docker run --name hotel-db -p 1521:1521 -e ORACLE_PASSWORD=Admin123 -v hotel-data:/opt/oracle/oradata -v "D:/UNI DOCS/IS210-Database-main/docker/initdb":/docker-entrypoint-initdb.d --health-cmd="healthcheck.sh" gvenzl/oracle-free:23-slim
```

Path ở máy Quân:

```sh
docker run --name hotel-db -p 1521:1521 -e ORACLE_PASSWORD=Admin123 -v hotel-data:/opt/oracle/oradata -v "D:/Work/Project Personal/IS210-Database/docker/initdb:/docker-entrypoint-initdb.d" --health-cmd="healthcheck.sh" gvenzl/oracle-free:23-slim
```

Database đã khởi tạo xong sẽ thấy thông báo: `DATABASE IS READY TO USE!`.

### Xóa container và volume

```sh
docker rm -f hotel-db
docker volume rm hotel-data
```

### Đăng nhập vào database

```sh
docker exec -it hotel-db sqlplus hotel/Admin123//localhost:1521/FREEPDB1
```

Lệnh test:

```sql
SELECT * FROM users;
```

## Hướng dẫn kết nối và chạy code SQL trong Oracle SQL Developer

Để kết nối Oracle SQL Developer với database Oracle đang chạy trong Docker container, bạn làm theo các bước sau:

### 1. Tạo kết nối mới (New Connection)

1. Mở **Oracle SQL Developer**.
2. Nhấn nút **`+` (New Connection...)** ở góc trên bên trái cửa sổ _Connections_.
3. Nhập thông tin kết nối như sau:
   - **Name**: `Hotel_DB` (hoặc tên bất kỳ bạn muốn)
   - **Database Type**: `Oracle`
   - **Username**: `hotel`
   - **Password**: `Admin123` (Tích chọn **Save Password**)
   - **Connection Type**: `Basic`
   - **Role**: `default`
   - **Hostname**: `localhost`
   - **Port**: `1521`
   - **Service name**: Tích chọn mục này và điền `FREEPDB1` (⚠️ **Quan trọng**: Phải chọn **Service name** chứ _không_ dùng **SID**).
4. Nhấn nút **Test** ở góc dưới. Nếu hiển thị trạng thái `Status: Success` thì nhấn **Save** rồi **Connect**.

### 2. Chạy code SQL trong SQL Developer

Sau khi kết nối thành công, một Worksheet mới sẽ hiển thị. Bạn có thể chạy code bằng các cách sau:

- **Chạy từng câu lệnh (Run Statement)**:
  - Đặt con trỏ chuột tại câu lệnh SQL (Ví dụ: `SELECT * FROM users;`).
  - Nhấn nút ▶️ (**Run Statement**) trên thanh công cụ hoặc bấm tổ hợp phím `Ctrl + Enter`.
- **Chạy toàn bộ file/script (Run Script)**:
  - Viết/Dán đoạn code SQL vào Worksheet.
  - Nhấn nút 📄▶️ (**Run Script**) trên thanh công cụ hoặc bấm phím `F5`.
- **Mở và chạy file `.sql` có sẵn**:
  - Vào **File** -> **Open...** và chọn file SQL (ví dụ: các file trong thư mục `docker/initdb`).
  - Chọn connection `Hotel_DB` ở góc trên bên phải của file vừa mở.
  - Nhấn `F5` hoặc nút **Run Script** để thực thi toàn bộ file.
