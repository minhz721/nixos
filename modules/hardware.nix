{ pkgs, ... }:

{
  # 1. Firmware & Kernel Tweaks (Ryzen 5 4600G - Zen 2 + Vega 7 iGPU)
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  boot.kernelParams = [
    "usbcore.autosuspend=-1"
    "amd_pstate=active"
  ];

  # 2. Power Profiles & Performance (Balanced / Performance)
  services.power-profiles-daemon.enable = true;
  programs.gamemode.enable = true;

  # 3. Memory & ZRAM Optimization
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 100;
    "vm.page-cluster" = 0;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_ratio" = 10;
    "vm.dirty_background_ratio" = 5;
  };

  # 4. Storage: TRIM định kỳ cho NVMe/SSD
  services.fstrim.enable = true;

  # 5. Graphics: Vega 7 iGPU
  hardware.amdgpu.initrd.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # 6. Networking & Firewall (LocalSend)
  networking.hostName = "leomin";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
  };

  # 7. Audio (PipeWire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  # 8. Bluetooth & Blueman
  boot.kernelModules = [ "uhid" ];
  hardware.bluetooth = {
    enable = true;
    settings.General = {
      JustWorksRepairing = "confirm";
      Experimental = true;
      KernelExperimental = true;
    };
  };
  services.blueman.enable = true;

  # 9. Security & Authentication
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # 10. Storage & File Systems
  # udisks2 + gvfs lo automount cho file manager;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  programs.dconf.enable = true;

  # 11. Prevent unintended sleep/shutdown from keyboard knob (Xinmeng M75)
  services.logind.settings = {
    Login = {
      HandlePowerKey = "ignore";
      HandlePowerKeyLongPress = "ignore";
    };
  };

  systemd.settings.Manager.DefaultTimeoutStopSec = "15s";
}
