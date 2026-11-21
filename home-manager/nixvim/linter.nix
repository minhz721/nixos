{
  programs.nixvim = {
    plugins.lint = {
      enable = true;

      # Linters mapped by filetype
      lintersByFt = {
        python = [ "ruff" ];
        sh = [ "shellcheck" ];
        bash = [ "shellcheck" ];
        nix = [
          "statix"
          "deadnix"
        ];
      };

      # Trigger linting on file events
      autoCmd = {
        callback.__raw = ''
          function()
            require("lint").try_lint()
          end
        '';
        event = [
          "BufEnter"
          "BufWritePost"
          "InsertLeave"
        ];
      };
    };
  };
}
