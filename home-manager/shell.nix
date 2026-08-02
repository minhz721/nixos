{ pkgs, ... }: {
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.starship.enable = true;

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
    '';
    plugins = with pkgs.fishPlugins; [
      { name = "done"; src = done.src; }
      { name = "fzf-fish"; src = fzf-fish.src; }
      { name = "autopair"; src = autopair.src; }
      { name = "bass"; src = bass.src; }
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
      gpo = "git pull origin";
      
      rebuild = "sudo nixos-rebuild switch --flake";
      update = "nix flake update";
      nix-clean = "sudo nix-collect-garbage -d";

    };
  };
}