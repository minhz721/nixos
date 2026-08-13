# Hướng Dẫn Cấu Hình Virt-Manager Trên NixOS (Share Clipboard & Folder)

Tài liệu này hướng dẫn chi tiết cách thiết lập **Virt-Manager** trên hệ điều hành **NixOS** hỗ trợ đồng bộ bộ nhớ tạm (Clipboard Sharing) và chia sẻ dữ liệu (Folder Sharing) qua giao thức `VirtioFS` tốc độ cao.

---

## Bước 1: Thêm Cấu Hình Vào Hệ Thống

1. Sao chép nội dung file `virt-manager.nix` vào thư mục cấu hình của bạn.
2. Mở file cấu hình tổng của hệ thống bằng quyền root:
   ```bash
   sudo nano /etc/nixos/configuration.nix
   ```
3. Khai báo import file này vào bên trong block `imports = [ ... ];` chính:
   ```nix
   imports = [
     ./hardware-configuration.nix
     ./virt-manager.nix # Thêm dòng này để gọi cấu hình máy ảo
   ];
   ```
4. **Quan trọng:** Mở file `virt-manager.nix` ra, tìm dòng `users.users.your_username.extraGroups` và đổi chữ `your_username` thành **tên đăng nhập chính xác** của bạn trên NixOS.

---

## Bước 2: Áp Dụng Cấu Hình Hệ Thống

Chạy lệnh sau để hệ thống tự động tải gói phần mềm và kích hoạt dịch vụ nền:
```bash
sudo nixos-rebuild switch
```

**Lưu ý:** Sau khi lệnh chạy hoàn tất, bạn **bắt buộc phải khởi động lại máy tính** hoặc Đăng xuất (Log out) rồi Đăng nhập lại để quyền truy cập nhóm hệ thống `libvirtd` có hiệu lực trên tài khoản user của bạn.

---

## Bước 3: Thiết Lập Phần Cứng Trong Giao Diện Virt-Manager

Mở ứng dụng **Virtual Machine Manager** lên. Hãy chắc chắn rằng máy ảo của bạn đã được **Tắt hẳn (Shutdown)** trước khi chỉnh sửa phần cứng:

### 1. Đồng bộ Bộ nhớ tạm (Clipboard) & Tự co giãn màn hình
* Bấm vào biểu tượng bóng đèn màu vàng (**Show virtual hardware details**).
* Chọn mục **Display Spice**: Đảm bảo mục *Type* đang để là `Spice server`.
* Chọn mục **Channel spice**: Đảm bảo mục *Type* là `Spice agent`. Nếu danh sách phần cứng của bạn chưa có mục này, hãy chọn *Add Hardware* -> *Channel* -> Chọn Name là `com.redhat.spice.0`.
* Chọn mục **Video**: Chuyển đổi Model sang `QXL` hoặc `Virtio` (để máy ảo tự động thay đổi độ phân giải theo kích thước cửa sổ bạn kéo giãn).

### 2. Thiết lập Thư mục Chia sẻ (Folder Sharing)
* Bấm vào nút **Add Hardware** ở góc dưới cùng bên trái cửa sổ cấu hình phần cứng máy ảo.
* Chọn mục **Filesystem** từ danh sách bên trái.
* Thiết lập các thông số chính xác như sau:
  * **Driver:** Chọn `VirtioFS` (Đây là driver có hiệu năng tốt và tối ưu nhất hiện tại).
  * **Source Path:** Bấm nút *Browse* chọn đường dẫn tới thư mục thực tế trên máy NixOS của bạn (Ví dụ: `/home/ten_ban/Shared`).
  * **Target Path:** Nhập một chuỗi ký tự liền nhau không dấu làm thẻ định danh để hệ điều hành khách gọi tới (Ví dụ: `host_share`).
* Bấm **Finish** để lưu lại thiết lập.

---

## Bước 4: Cấu Hình Bên Trong Máy Ảo (Guest OS)

Khi bật máy ảo lên, bạn cần cài driver tương ứng cho từng hệ điều hành để kích hoạt các tính năng:

### A. Nếu Máy Ảo Là Windows (10 / 11)
1. **Bật Clipboard & Tự đổi độ phân giải:** Truy cập vào trang chủ Spice tại đường dẫn [spice-space.org/download.html](https://spice-space.org), tìm mục **Windows binaries** và tải gói cài đặt **spice-guest-tools** (định dạng `.exe`). Tiến hành chạy cài đặt bình thường và khởi động lại máy ảo Windows.
2. **Nhận diện Thư mục chia sẻ (VirtioFS):**
   * Tải và cài đặt thư viện hệ thống [WinFsp](https://winfsp.dev) trên Windows trước.
   * Tải file ISO chứa Driver ảo hóa chính thức từ dự án Fedora: [virtio-win.iso](https://fedorapeople.org).
   * Gắn file ISO này vào ổ đĩa CD ảo của máy ảo, truy cập vào ổ đĩa đó, tìm thư mục `virtio-fs` và chạy cài đặt dịch vụ tương ứng với phiên bản Windows của bạn. Thư mục chia sẻ sẽ tự động xuất hiện thành một ổ đĩa mạng trong mục **This PC**.

### B. Nếu Máy Ảo Là Linux (Ubuntu / Debian / Fedora...)
Mở cửa sổ Terminal ngay bên trong hệ điều hành máy ảo và chạy các lệnh tương ứng:

1. **Cài đặt gói Clipboard (Spice Agent):**
   ```bash
   # Dành cho hệ điều hành Ubuntu / Debian / Linux Mint:
   sudo apt update && sudo apt install spice-vdagent -y

   # Dành cho hệ điều hành Fedora / RHEL:
   sudo dnf install spice-vdagent -y
   ```
2. **Gắn Thư mục chia sẻ vào hệ thống (Mount):**
   Tạo một thư mục trống bên trong máy ảo và dùng lệnh `mount` để liên kết tới thẻ `Target Path` (ở đây ví dụ là `host_share`) mà bạn đã đặt ở Bước 3:
   ```bash
   sudo mkdir -p /mnt/shared
   sudo mount -t virtiofs host_share /mnt/shared
   ```
   *Để thư mục này tự động gắn mỗi khi bật máy ảo Linux mà không cần gõ lại lệnh, hãy thêm dòng sau vào cuối file `/etc/fstab` của máy ảo:*
   ```text
   host_share  /mnt/shared  virtiofs  defaults  0  0
   ```
