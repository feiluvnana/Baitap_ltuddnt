# EX3

Sử dụng kèm với công nghệ Google Apps Script xây dựng ứng dụng cho phép người dùng upload ảnh avatar lên Google drive của người phát triển ứng dụng. Hàm Google Apps scripts sẽ trả về link đến image đó trên Google drive. Lần sau vào ứng dụng thì người dùng sẽ được nhìn thấy ảnh avatar do mình up lên. (+ 1.5 điểm).

## Các ghi chú

- Package sử dụng:
    + dio
    + image_picker
    + shared_preferences
- Google App Script được deploy tại https://script.google.com/macros/s/AKfycbxJiKdEhc_ii0czdNhA6XDkNpmnfkWHWaOaq2hfBozgVpBa3YGJ4a4mohe3vM8jXmLU/exec
- Các chỉnh sửa liên quan tới native
    + Thêm quyền truy cập internet vào file AndroidManifest.xml
    + Thêm signingConfig trong build.gradle và key.properties để build app release
- Luồng hoạt động với Google App Script
    1. Ứng dụng thực hiện HTTP Request với phương thức POST tới đường dẫn mà GAS được deploy
    2. App Script tiến hành lấy các tham số và thực hiện thêm file vào Drive, đồng thời trả về 2 đường link. Một là link drive, và 2 là link để download ảnh.
    3. Ứng dụng tiến hành lưu 2 đường link vào shared_preferences để có thể có dữ liệu khi mở app lần sau, đồng thời cập nhật ảnh trong ứng dụng.
- Hạn chế
    + Chưa xử lý exception hoàn chỉnh
    + Giao diện chưa được trau chuốt
