{ pkgs, ... }: {
  programs.git = {
    enable = true;
    
    userName = "leomin";
    userEmail = "minhtd721@gmail.com";

    extraConfig = {
      init.defaultBranch = "master";
      
      push.autoSetupRemote = true;
      
      color.ui = "auto";
      
      core.editor = "nvim";
    };
  };
}