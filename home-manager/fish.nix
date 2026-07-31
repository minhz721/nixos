{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
    '';
    plugins = [
      # 1. Instruct Home Manager to install Fisher itself
      {
        name = "fisher";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "fisher";
          rev = "main";
          sha256 = "sha256-U1yd8m56YrHXrJFkU8xaOglulOGV0iBvwjU/bdf8tqA=";
        };
      }
      
      # z
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }
    ];


    shellAliases = {
      # Git shortcuts
      g = "git";
      gaa = "git add";
      gc = "git commit -m";
      gp = "git push";
      gst = "git status";
      gl = "git log --oneline --graph --decorate";
      gcan = "git commit --amend --no-edit";
      ggf = "git push -f";
      
      rebuild = "sudo nixos-rebuild switch --flake";
      update = "nix flake update";
      nix-clean = "sudo nix-collect-garbage -d";

    };
  };
}