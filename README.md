# CRM Project

Dự án CRM với Backend sử dụng Spring Boot, Frontend sử dụng Electron.js + React, và Database là Oracle.

## Yêu cầu hệ thống

### Backend

- Java JDK 25.
- Maven 3.8+.
- Oracle Database 19c +.

### Frontend

- Node.js 18+ và npm.

## Hướng dẫn cài đặt và sử dụng

### Cài đặt Oracle Database

Yêu cầu:

- Oracle 19c.
- Port: `1521` (dùng để kết nối với database).
- Username: `sys` / `system`.
- Password: `Admin123`.
- PDB: `FREEPDB1`.

Trong dự án có sẵn Docker database tại `docker/initdb/`.
Tài liệu hướng dẫn sử dụng: [docs/docker.md](/docs/docker.md).

### Cài đặt và chạy Backend

(Các lệnh sau chạy ở thư mục gốc của dự án)

#### 1. Cấu hình kết nối với Database

Mở file `src/main/resources/application.properties` và cập nhật thông tin kết nối Oracle (nếu cần):

```properties
spring.datasource.url=jdbc:oracle:thin:@//localhost:1521/orcl
spring.datasource.username=system
spring.datasource.password=Admin123
```

#### 2. Cài đặt và chạy Backend

**Tải dependencies**:

```bash
mvnw clean install
```

**Chạy server**:

```bash
mvnw spring-boot:run
```

```bash
mvn spring-boot:run
```

Backend sẽ chạy tại: **http://localhost:8080**. Khi truy cập vào sẽ thấy thông báo `API is running`.

**Tắt server**: Gửi abort `Ctrl` `C`.

### Cài đặt và chạy Frontend

(Các lệnh sau chạy ở thư mục `frontend/` của dự án)

**Tải dependencies**:

```bash
npm install
```

**Mở môi trường development**:

```bash
npm run dev
```

**Tắt server**: Gửi abort `Ctrl` `C`.

## Các lệnh khác

### Preview (Production mode)

```bash
npm start
```

### Build TypeScript

```bash
npm run typecheck
```

### Lint code

```bash
npm run lint
```

### Format code

```bash
npm run format
```

### Build ứng dụng cho production

```bash
# Build tất cả (không đóng gói)
npm run build:unpack

# Build cho Windows
npm run build:win

# Build cho macOS
npm run build:mac

# Build cho Linux
npm run build:linux
```

## Cấu hình API trong Frontend

Đảm bảo frontend đang trỏ đúng đến backend URL. Kiểm tra file cấu hình API (thường trong `src/renderer/src/lib/` hoặc config):

```typescript
const API_BASE_URL = "http://localhost:8080";
```

## 📁 Cấu trúc thư mục

```
hotel/
├── frontend/               # Electron + React frontend
│   ├── src/
│   │   ├── main/          # Electron main process
│   │   ├── preload/       # Preload scripts
│   │   └── renderer/      # React app
│   └── package.json
├── src/
│   └── main/
│       ├── java/          # Spring Boot backend
│       │   └── dev/uit/project/
│       ├── resources/     # Cấu hình
│       │   └── application.properties
│       └── sql/           # SQL scripts
├── pom.xml                # Maven config
└── database-init          # Chứa các file .sql khởi tạo database ở lần chạy đầu tiên, bao gồm dữ liệu
```

## ⚠️ Xử lý lỗi thường gặp

### Backend không kết nối được Oracle

- Kiểm tra Oracle service đang chạy
- Verify connection string trong `application.properties`
- Kiểm tra firewall/port 1521

### Frontend không gọi được API

- Đảm bảo backend đang chạy trên port 8080
- Kiểm tra CORS configuration trong Spring Boot
- Verify API URL trong frontend config

### Maven build failed

- Đảm bảo Java 25 đã được cài đặt: `java -version`
- Set JAVA_HOME environment variable
- Clear Maven cache: `mvnw clean`

### npm install failed

- Xóa `node_modules` và `package-lock.json`
- Chạy lại `npm install`
- Thử với Node.js phiên bản khác nếu gặp lỗi

## 📝 Ghi chú

- Backend mặc định chạy trên port **8080**
- Oracle Database mặc định trên port **1521**
- Ứng dụng sử dụng Spring Security (có thể cần authentication)
- Frontend sử dụng React Router cho navigation
- Database schema sẽ tự động được tạo/cập nhật khi khởi động backend
