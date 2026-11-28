{ pkgs, ... }: {
  home.sessionPath = [
    "$HOME/.bun/bin"
  ];

  # Eza
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };

  # Starship
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

  # Fish
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      zoxide init fish | source
    '';
    plugins = with pkgs.fishPlugins; [
      {
        name = "done";
        src = done.src;
      }
      {
        name = "fzf-fish";
        src = fzf-fish.src;
      }
      {
        name = "autopair";
        src = autopair.src;
      }
      {
        name = "sponge";
        src = sponge.src;
      }
      {
        name = "puffer";
        src = puffer.src;
      }
      {
        name = "bass";
        src = bass.src;
      }
    ];
    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      lt = "eza --tree";
      l = "eza -lah --git --icons";

      lg = "lazygit";
      ld = "lazydocker";
      lsql = "lazysql";

      rebuild = "sudo nixos-rebuild switch --flake";
      flake-update = "nix flake update";
      nix-clean = "sudo nix-collect-garbage -d";
      nhos = "nh os switch";
      nhca = "nh clean all";
    };

    # Abbreviations expand while typing, so history keeps the full command.
    shellAbbrs = {
      g = "git";
      ga = "git add";
      gaa = "git add --all";
      gcm = "git commit -m";
      gp = "git push";
      gpf = "git push -f";
      gst = "git status";
      gl = "git log --oneline --graph --decorate";
      gcan = "git commit --amend --no-edit";
      gpo = "git pull origin";
      gco = "git checkout";

      gs = "git stash";
      gsa = "git stash apply";
      gsl = "git stash list";
      gsp = "git stash pop";
      gsc = "git stash clear";
    };
  };

  # Git
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "leomin";
        email = "minhtd721@gmail.com";
      };
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
      color.ui = "auto";
    };
  };
}
