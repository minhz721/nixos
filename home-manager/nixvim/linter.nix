{...}: {
  programs.nixvim = {
    plugins.lint = {
      enable = true;
      
      # Grouping linters configuration by filetype
      lintersByFt = {
        # Python (Leveraging Ruff via uv backend)
        python = ["ruff"];

        # Shell Scripting
        sh = ["shellcheck"];
        bash = ["shellcheck"];

        # Docker Containers
        dockerfile = ["hadolint"];

        # Nix Expression Language
        nix = ["statix" "deadnix"];

        # SQL Queries
        sql = ["sqlfluff"];
      };

      # Overriding default linter execution strategies to use custom binaries
      linters = {
        ruff = {
          cmd = "uvx";
          args = [ "ruff" "check" "--stdin-filename" "%" "-" ];
        };
      };

      # Automatically trigger linting on file lifecycle events
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
