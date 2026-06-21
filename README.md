# Supabase Keep Alive Cron Job

Repository độc lập chạy GitHub Actions định kỳ để giữ cho các dự án Supabase (Free Tier) không bị tự động tạm dừng (pause) do không hoạt động (inactivity).

## Cách hoạt động

1. **Ping cơ sở dữ liệu:** Định kỳ mỗi 3 ngày (cấu hình trong `.github/workflows/keep-alive.yml`), GitHub Actions sẽ chạy một tiến trình gửi yêu cầu truy vấn REST API đến Supabase database.
2. **Chống khoá Cron:** Tự động ghi đè ngày giờ hiện tại vào file `heartbeat.txt` và commit ngược lại repo. Điều này giúp repo luôn có hoạt động mới, ngăn GitHub tự động tắt lịch chạy `cron` sau 60 ngày.

## Hướng dẫn thiết lập

### Bước 1: Thêm Secrets trên GitHub
Để bảo mật thông tin và mã khoá dự án của bạn:
1. Vào mục **Settings** (ở thanh menu phía trên của repository này).
2. Chọn **Secrets and variables** > **Actions** từ menu bên trái.
3. Chọn nút **New repository secret**.
4. Thêm các cặp key tương ứng cho dự án của bạn:
   - **`PROJECT_1_URL`**: Đường dẫn URL của dự án Supabase (Ví dụ: `https://xxxxxxxxxxxxxx.supabase.co`).
   - **`PROJECT_1_ANON_KEY`**: Mã Anon Key (công khai) của dự án.

### Bước 2: Kích hoạt chạy thủ công (Tuỳ chọn để kiểm tra)
1. Vào tab **Actions** của repository.
2. Chọn workflow **Keep Supabase Alive**.
3. Bấm nút **Run workflow** -> Chọn branch `main` và bấm nút chạy.
4. Kiểm tra lịch sử log để đảm bảo kết nối trả về mã `200` (Success).

### Bước 3: Thêm nhiều dự án khác (Nếu có)
Nếu bạn có nhiều dự án Supabase khác nhau cần giữ hoạt động, hãy chỉnh sửa file `.github/workflows/keep-alive.yml`, sao chép phần `Ping Supabase REST API` và tạo thêm biến secrets (ví dụ: `PROJECT_2_URL`, `PROJECT_2_ANON_KEY`, ...).
