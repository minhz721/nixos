{
  programs.nixvim = {
    plugins.lint = {
      enable = true;

      lintersByFt = {
        python = [
          "ruff"
        ];

        nix = [
          "statix"
          "deadnix"
        ];

        bash = [
          "shellcheck"
        ];
      };
    };
  };
}