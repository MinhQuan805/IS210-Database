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

- Các file phải đưc sắp xếp từ trước theo thứ tự từ điển.
- Các file chỉ được khởi chạy khi không volume `hotel-data`.
- Ở đầu file đều phải chuyển user và PDB đúng như cấu hình trên: `ALTER SESSION SET CONTAINER = FREEPDB1; ALTER SESSION SET CURRENT_SCHEMA = hotel;`.

### Tạo và chạy container

Path ở máy Bảo:

```sh
docker run --name hotel-db -p 1521:1521 -e ORACLE_PASSWORD=Admin123 -v hotel-data:/opt/oracle/oradata -v "D:/UNI DOCS/Hotel/docker/initdb":/docker-entrypoint-initdb.d --health-cmd="healthcheck.sh" gvenzl/oracle-free:23-slim
```

Path ở máy Quân:

```sh
docker run --name hotel-db -p 1521:1521 -e ORACLE_PASSWORD=Admin123 -v hotel-data:/opt/oracle/oradata -v "D:/Work/Project Personal/Hotel/docker/initdb":/docker-entrypoint-initdb.d --health-cmd="healthcheck.sh" gvenzl/oracle-free:23-slim
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
