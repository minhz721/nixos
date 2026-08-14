{
  config,
  pkgs,
  ...
}: {
  programs.fish.enable = true;

  users.users."leomin" = {
    isNormalUser = true;
    description = "leomin";
    shell = pkgs.fish;
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
    ];
  };
}
