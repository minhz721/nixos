{ pkgs, ... }:

{
  # 1. Firmware & Kernel Tweaks (Tối ưu cho PC AMD)
  hardware.enableAllFirmware = true;
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
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_ratio" = 10;
    "vm.dirty_background_ratio" = 5;
  };

  # 4. I/O Scheduler Optimization NVMe & SSD
  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/scheduler}="none"
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="mq-deadline"
  '';

  # 5. Graphics, AMD GPU & Hardware Video Acceleration (VA-API / Vulkan)
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
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
  services.pulseaudio.enable = false;
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
    powerOnBoot = true;
    settings = {
      General = {
        Privacy = "off";
        JustWorksRepairing = "confirm";
        FastConnectable = false;
        Experimental = true;
        KernelExperimental = true;
      };
      Policy = {
        AutoEnable = true;
      };
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
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;
  programs.dconf.enable = true;

  # 11. Prevent unintended sleep/shutdown from keyboard knob (Xinmeng M75)
  services.logind.settings = {
    Login = {
      HandlePowerKey = "ignore";
      HandlePowerKeyLongPress = "ignore";
    };
  };
}
