# 1. NixOS Host Configuration

```nix
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

```bash
which virtiofsd
```

Expected output:

```text
/run/current-system/sw/bin/virtiofsd
```

Check libvirt status:

```bash
systemctl status libvirtd
```

---

# 2. Create the Shared Folder

Example shared folder path:

```text
/home/leomin/Share
```

Create the directory:

```bash
mkdir -p ~/Share
```

Test file creation:

```bash
echo "Hello from NixOS" > ~/Share/test.txt
```

---

# 3. Configure VirtioFS in virt-manager

Launch `virt-manager`:

```bash
virt-manager
```

Select your Arch Linux VM:

```text
Open
→ Show virtual hardware
→ Add Hardware
→ Filesystem
```

Configuration:

```text
Driver:       virtiofs
Source path:  /home/leomin/Share
Target path:  hostshare
```

For example:

```text
Source path:
    /home/leomin/Share

Target path:
    hostshare
```

### Note

The `Target path` is the **VirtioFS mount tag**, not a directory path like `/mnt/...` inside Arch.

After adding the Filesystem hardware, shut down the VM and boot it back up.

---

### Mount VirtioFS in Arch Linux

Inside the Arch guest:

```bash
sudo mkdir -p /mnt/hostshare
```

Test mounting:

```bash
sudo mount -t virtiofs hostshare /mnt/hostshare
```

Verify the share:

```bash
ls -la /mnt/hostshare
```

If you see `test.txt`, VirtioFS is working properly.

Test writing from Arch:

```bash
echo "Hello from Arch" | sudo tee /mnt/hostshare/arch.txt
```

Check on the NixOS host:

```bash
ls ~/Share
```

You should see both files:

```text
arch.txt
test.txt
```

---

# 4. Bidirectional Clipboard with SPICE

VirtioFS is only used for sharing files and folders.

To copy and paste text between:

```text
NixOS Host ↔ Arch Guest
```

you must use **SPICE + spice-vdagent**.

## 4.1. Check Display

In `virt-manager`:

```text
Arch VM
→ Show virtual hardware
→ Display
```

The Display type should be set to:

```text
Type: SPICE
```

---

# 5. Add SPICE Channel

In `virt-manager`:

```text
Add Hardware
→ Channel
```

Configuration:

```text
Type: spicevmc
Name: com.redhat.spice.0
```

The result should look like:

```text
Channel
    Type: spicevmc
    Name: com.redhat.spice.0
```

This channel allows the SPICE agent inside Arch to communicate with the host.

---

# 6. Install spice-vdagent in Arch

Inside Arch Linux:

```bash
sudo pacman -S spice-vdagent
```

Enable and start the service:

```bash
sudo systemctl enable --now spice-vdagentd
```

Check status:

```bash
systemctl status spice-vdagentd
```

If the service state is:

```text
Active: active (running)
```

then the agent is active and running.
