{ pkgsUnstable, ... }: {
  programs.nixvim = {
    plugins.lint = {
      enable = true;
      lintersByFt = {
        python = [ "ruff" ];
        bash = [ "shellcheck" ];
        sh = [ "shellcheck" ];
      };
      linters = {
        ruff.cmd = "${pkgsUnstable.ruff}/bin/ruff";
        shellcheck.cmd = "${pkgsUnstable.shellcheck}/bin/shellcheck";
      };
    };

    autoCmd = [
      {
        event = [
          "BufEnter"
          "BufWritePost"
        ];
        callback.__raw = ''
          function()
            require("lint").try_lint()
          end
        '';
      }
    ];
  };
}
