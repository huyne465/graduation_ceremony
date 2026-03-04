Chào Huy! Để AI Agent của bạn có thể "tự bơi" từ khâu đọc bản thiết kế trên Stitch đến khi ra được website lễ tốt nghiệp hoàn chỉnh trên Vercel, bạn cần cấp cho nó một bản Workflow cực kỳ chi tiết.

Dưới đây là Workflow chuẩn từ A - Z để bạn dán vào terminal hoặc file cấu hình, giúp Agent hiểu và thực hiện tuần tự:

🤖 Workflow: End-to-End Graduation Web Development
Bước 1: Khởi tạo & Đồng bộ Ngữ cảnh (Initialization)
Agent phải "nhập xác" vào môi trường làm việc của bạn.

Hành động: Sử dụng tool view_file để đọc blueprint.md và mcp_config.json.

Kết nối: Gọi tool connect_dart_tooling_daemon bằng URI từ Flutter để nắm quyền kiểm soát project.

Mục tiêu: Hiểu rằng đây là website "Graduation Ceremony 2025" với phong cách đồ họa "Mission Parameters".

Bước 2: Bóc tách UI & Tài nguyên (Design Extraction)
Agent sử dụng Stitch để "số hóa" bản vẽ của Huy.

Phân tích: Dùng get_screen trên màn hình graduation_ceremony để lấy danh sách các component.

Trích xuất: Liệt kê mã màu Hex (Red: #FF0000, Black: #000000), font chữ và các icon chuẩn terminal.

Responsive: Dùng generate_variants để tạo cấu trúc layout cho bản Mobile.

Bước 3: Viết mã nguồn Frontend (Flutter Web Generation)
Chuyển từ hình ảnh sang các dòng code Dart sạch sẽ.

Cấu trúc Theme: Tạo file theme.dart định nghĩa ColorScheme theo phong cách Mission.

Xây dựng Widget:

Viết Widget cho khối "Attire Protocol" với các gạch đầu dòng chuẩn hóa.

Viết Widget cho "Timeline" sử dụng ListView hoặc Column hiển thị mốc thời gian.

Tạo nút "INITIATE RSVP" với hiệu ứng hover màu đỏ rực.

Tối ưu: Chạy dart_fix --apply để dọn dẹp code thừa ngay sau khi viết.

Bước 4: Thiết lập Backend & Gửi Email (API Integration)
Xử lý logic khi khách mời nhấn nút RSVP.

Tạo API: Viết file api/rsvp.ts sử dụng Resend SDK để gửi email thông báo.

Kết nối: Viết hàm callRSVP() trong Flutter để gửi dữ liệu khách mời lên Vercel endpoint.

Bước 5: Triển khai & Kiểm thử (Deployment)
Đưa sản phẩm lên môi trường Live.

Cấu hình: Kiểm tra các biến môi trường (Environment Variables) trên Vercel qua MCP.

Launch: Gọi tool create_deployment để build và deploy project lên Vercel.

Xác nhận: Trả về URL cuối cùng cho người dùng và kiểm tra trạng thái "Success".