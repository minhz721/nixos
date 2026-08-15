# 1. Cấu hình NixOS Host
```
{pkgs, ...}: {
  # Enable the virt-manager GUI application
  programs.virt-manager.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # Allow USB redirection support (optional)
  virtualisation.spiceUSBRedirection.enable = true;

  # Add your regular user to the libvirtd group
  users.users.leomin.extraGroups = ["libvirtd"];

  environment.systemPackages = with pkgs; [ 
    dnsmasq 
    spice-gtk
    spice
  ];

  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };

 
}
```
Check `virtiofsd`:
```
which virtiofsd
```
Kết quả mong đợi:

```text
/run/current-system/sw/bin/virtiofsd
```
Kiểm tra libvirt:

```bash
systemctl status libvirtd
```

---

# 2. Tạo folder cần share
Ví dụ share folder:

```text
/home/leomin/Share
```

Tạo folder:

```bash
mkdir -p ~/Share
```

Có thể test:

```bash
echo "Hello from NixOS" > ~/Share/test.txt
```

---

# 3. Cấu hình VirtioFS trong virt-manager

Mở:

```text
virt-manager
```

Chọn Arch Linux VM:

```text
Open
→ Show virtual hardware
→ Add Hardware
→ Filesystem
```

Cấu hình:

```text
Driver:       virtiofs
Source path:  /home/leomin/Share
Target path:  hostshare
```

Ví dụ:

```text
Source path:
    /home/leomin/Share

Target path:
    hostshare
```

### Lưu ý

`Target path` là **VirtioFS mount tag**, không phải đường dẫn `/mnt/...` trong Arch.

Sau khi thêm Filesystem, shutdown VM rồi boot lại.

---

### Mount VirtioFS trong Arch Linux

Trong Arch guest:

```bash
sudo mkdir -p /mnt/hostshare
```

Mount thử:

```bash
sudo mount -t virtiofs hostshare /mnt/hostshare
```

Kiểm tra:

```bash
ls -la /mnt/hostshare
```

Nếu thấy:

```text
test.txt
```

thì VirtioFS đã hoạt động.

Test từ Arch:

```bash
echo "Hello from Arch" | sudo tee /mnt/hostshare/arch.txt
```

Trên NixOS:

```bash
ls ~/Share
```

Bạn sẽ thấy:

```text
arch.txt
test.txt
```

---


# 4. Clipboard 2 chiều với SPICE

VirtioFS chỉ dùng để share file/folder.

Để copy/paste text giữa:

```text
NixOS Host ↔ Arch Guest
```

cần sử dụng **SPICE + spice-vdagent**.

## 4.1. Kiểm tra Display

Trong virt-manager:

```text
Arch VM
→ Show virtual hardware
→ Display
```

Display nên sử dụng:

```text
Type: SPICE
```

---

# 5. Thêm SPICE Channel

Trong virt-manager:

```text
Add Hardware
→ Channel
```

Cấu hình:

```text
Type: spicevmc
Name: com.redhat.spice.0
```

Kết quả sẽ tương tự:

```text
Channel
    Type: spicevmc
    Name: com.redhat.spice.0
```

Channel này cho phép SPICE agent trong Arch giao tiếp với host.

---

# 6. Cài spice-vdagent trong Arch

Trong Arch Linux:

```bash
sudo pacman -S spice-vdagent
```

Enable service:

```bash
sudo systemctl enable --now spice-vdagentd
```

Kiểm tra:

```bash
systemctl status spice-vdagentd
```

Nếu service đang chạy:

```text
Active: active (running)
```

thì agent đã hoạt động.

---