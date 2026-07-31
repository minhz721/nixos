{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
    '';

    shellAliases = {
      # Git shortcuts
      g = "git";
      gaa = "git add";
      gc = "git commit -m";
      gp = "git push";
      gl = "git log --oneline --graph --decorate";
      gcan = "git commit --amend";
      ggf = "git push -f";
      
      nix-rebuild = "sudo nixos-rebuild switch --flake";
      update = "nix flake update";
      clean = "sudo nix-collect-garbage -d";

    };
  };
}