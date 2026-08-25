{pkgs, ...}: {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "leomin";
        email = "minhtd721@gmail.com";
      };
      init = {
        defaultBranch = "master";
      };
      push = {
        autoSetupRemote = true;
      };
      color = {
        ui = "auto";
      };
      core = {
        editor = "nvim";
      };
    };
  };
}
