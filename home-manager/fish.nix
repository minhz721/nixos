{pkgs, ...}: {
  # ============================================================
  # CLI tools
  # ============================================================
  home.packages = with pkgs; [
    fzf
    fd
    ripgrep
    zoxide
    curl
  ];

  # ============================================================
  # Eza - modern replacement for ls
  # ============================================================
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };

  # ============================================================
  # Starship - shell prompt
  # ============================================================
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$character";
      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
      };
      git_branch = {
        format = "[$branch]($style) ";
      };
      git_status = {
        format = "[$all_status$ahead_behind]($style) ";
      };
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
    };
  };

  # ============================================================
  # Fish
  # ============================================================
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting

      # zoxide
      zoxide init fish | source
    '';

    plugins = with pkgs.fishPlugins; [
      # Notify when command finishes
      {
        name = "done";
        src = done.src;
      }

      # FZF integration
      {
        name = "fzf-fish";
        src = fzf-fish.src;
      }

      # Auto close brackets and quotes
      {
        name = "autopair";
        src = autopair.src;
      }

      # Run Bash commands/scripts from Fish
      {
        name = "bass";
        src = bass.src;
      }
    ];

    # ==========================================================
    # Aliases
    # ==========================================================
    shellAliases = {
      # --------------------------------------------------------
      # Files
      # --------------------------------------------------------

      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      lt = "eza --tree";
      l = "eza -lah --git --icons";

      # --------------------------------------------------------
      # Git
      # --------------------------------------------------------
      g = "git";
      ga = "git add";
      gaa = "git add --all";
      gc = "git commit -m";
      gp = "git push";
      ggf = "git push --force-with-lease";
      gst = "git status";
      gl = "git log --oneline --graph --decorate";
      gcan = "git commit --amend --no-edit";
      gpo = "git pull origin";
      gco = "git checkout";

      # Stash
      gs = "git stash";
      gsa = "git stash apply";
      gsl = "git stash list";
      gsp = "git stash pop";
      gsc = "git stash clear";

      # Lazygit
      lg = "lazygit";

      # --------------------------------------------------------
      # NixOS
      # --------------------------------------------------------
      rebuild = "sudo nixos-rebuild switch --flake";
      flake-update = "nix flake update";
      nix-clean = "sudo nix-collect-garbage -d";
    };
  };
}
