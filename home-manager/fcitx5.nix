{pkgs, ...}: {
  xdg.configFile."fcitx5/config" = {
    force = true;
    text = ''
      [Hotkey/TriggerKeys]
      0=CTRL+SPACE
    '';
  };
}
