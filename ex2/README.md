# EX2

Khi mở app lên thì trong app có đủ các loại quảng cáo của Google Admobs (dùng id test của google cung cấp): banner, native, reward, app open, … (+0.75 điểm vào GK). Ngoài Google Admobs thì SV được phép cài đặt thêm thư viện quảng cáo của bên khác (ưu tiên Việt Nam) sao cho nếu Google Admobs không hiển thị được quảng cáo thì sẽ hiện quảng cáo của bên khác. Nếu không làm hết các quảng cáo cũng được, nhưng nhớ nói rõ là đã gắn được các loại quảng cáo nào.

## Các ghi chú

- Package sử dụng
    + google_mobile_ads
- Các loại ad đã có
    + Banner (test ad)
    + Interstitial (test ad)
    + Rewarded (test ad)
- Các chỉnh sửa liên quan tới native
    + Đã thêm thẻ meta-data của admod trong file AndroidManifest.xml
    + Thêm signingConfig trong build.gradle và key.properties để build app release
- Hạn chế
    + Chưa xử lý exception hoàn chỉnh
    + Giao diện chưa được trau chuốt
