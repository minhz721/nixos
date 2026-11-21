{inputs, ...}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./options.nix
    ./keymaps.nix
    ./autocmds.nix
    ./colorscheme.nix
    ./lsp.nix
    ./linter.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = false;
    nixpkgs.source = inputs.nixpkgs;

    performance = {
      byteCompileLua = {
        enable = true;
        nvimRuntime = true;
        plugins = true;
      };
    };

    plugins.lz-n.enable = true;
  };
}
