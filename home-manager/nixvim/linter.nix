{
  programs.nixvim.plugins.lint = {
    enable = true;
    lintersByFt = {
      # Python
      python = [
        "ruff"
      ];

      # Nix
      nix = [
        "statix"
        "deadnix"
      ];

      # Bash
      bash = [
        "shellcheck"
      ];

      # Docker
      docker = [
        "hadolint"
      ];

      # Lua
      lua = [
        "luacheck"
      ];
    };
  };
}
