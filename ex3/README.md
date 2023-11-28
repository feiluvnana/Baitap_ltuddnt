# EX3

Sử dụng kèm với công nghệ Google Apps Script xây dựng ứng dụng cho phép người dùng upload ảnh avatar lên Google drive của người phát triển ứng dụng. Hàm Google Apps scripts sẽ trả về link đến image đó trên Google drive. Lần sau vào ứng dụng thì người dùng sẽ được nhìn thấy ảnh avatar do mình up lên. (+ 1.5 điểm).

## Getting Started

- Package sử dụng:
    + dio
    + image_picker
    + shared_preferences
- Google App Script được deploy tại https://script.google.com/macros/s/AKfycbxJiKdEhc_ii0czdNhA6XDkNpmnfkWHWaOaq2hfBozgVpBa3YGJ4a4mohe3vM8jXmLU/exec
- Các chỉnh sửa liên quan tới native
    + Thêm quyền truy cập internet vào file AndroidManifest.xml
    + Thêm signingConfig trong build.gradle và key.properties để build app release
