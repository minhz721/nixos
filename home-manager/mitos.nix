{
  config,
  pkgs,
  inputs,
  ...
}:
let
  biomeConfigDir = "${config.xdg.configHome}/biome";
  flakePath = "${config.home.homeDirectory}/nixos";
  hostName = config.home.username;
in
{
  home.packages = [
    inputs.mitos.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  xdg.configFile."mitos/config.toml".text = ''
    theme = "dark_plus"

    [editor]
    line-number = "relative"
    cursorline = true
    color-modes = true
    true-color = true
    # popup-border = "all"

    [editor.completion]
    trigger-delay = 5

    [editor.inline-completion]
    trigger-delay = 10

    [editor.files.auto-save]
    focus-lost = true
    after-delay.enable = true
    after-delay.timeout = 3000

    [editor.bufferline]
    show = "multiple"

    [editor.indent-guides]
    render = true

    [editor.soft-wrap]
    enable = true
    wrap-at-text-width = false

    [editor.rainbow-brackets]
    enable = true

    [editor.lsp]
    display-progress-messages = true
    auto-signature-help = true
    display-inlay-hints = true
    snippets = true

    [editor.inline-diagnostics]
    cursor-line = "warning"
    max-diagnostics = 5

    [editor.statusline.mode]
    normal = "NORMAL"
    insert = "INSERT"
    select = "SELECT"

    [keys.normal]
    tab = ":buffer-next"
    "S-tab" = ":buffer-previous"
    "C-a" = "select_all"
    "C-s" = [":write", "normal_mode"]
    "C-c" = ":clipboard-yank"
    "C-v" = ":clipboard-paste-after"
    "C-A-down" = ["extend_line_below", "yank", "paste_after"]
    "C-A-up" = ["extend_line_below", "yank", "paste_before"]
    "C-z" = "undo"
    "C-S-r" = "redo"
    "C-S-z" = "redo"
    "C-x" = ["goto_line_start", "extend_to_line_bounds", "delete_selection"]

    [keys.normal.","]
    "w" = ":write"
    "q" = ":quit"
    "f" = "file_picker"
    "g" = ":sh lazygit"
    "b" = "buffer_picker"
    "s" = "symbol_picker"
    "/" = "toggle_comments"
    "r" = ":reload"

    [keys.insert]
    "C-a" = "select_all"
    "C-s" = [":write", "normal_mode"]
    "C-c" = ":clipboard-yank"
    "C-v" = ":clipboard-paste-after"
    "C-A-down" = ["normal_mode", "extend_line_below", "yank", "paste_after", "insert_mode"]
    "C-A-up" = ["normal_mode", "extend_line_below", "yank", "paste_before", "insert_mode"]
    "C-z" = ["normal_mode", "undo", "insert_mode"]
    "C-S-z" = ["normal_mode", "redo", "insert_mode"]
    "C-S-r" = ["normal_mode", "redo", "insert_mode"]
    "C-x" = ["normal_mode", "goto_line_start", "extend_to_line_bounds", "delete_selection", "insert_mode"]
    "tab" = "insert_tab"
    "S-tab" = "unindent"

    [keys.select]
    "C-a" = "select_all"
    "C-s" = [":write", "normal_mode"]
    "C-c" = ":clipboard-yank"
    "C-v" = ":clipboard-paste-after"
    "C-A-down" = ["yank", "paste_after"]
    "C-A-up" = ["yank", "paste_before"]
    "C-z" = "undo"
    "C-S-r" = "redo"
    "C-S-z" = "redo"
    "C-x" = ["delete_selection"]
  '';

  xdg.configFile."mitos/languages.toml".text = ''
    [language-server.vtsls]
    command = "vtsls"
    args = ["--stdio"]

    [language-server.biome]
    command = "biome"
    args = ["lsp-proxy", "--config-path", "${biomeConfigDir}"]

    [language-server.emmet-lsp]
    command = "emmet-language-server"
    args = ["--stdio"]

    [language-server.emmet-lsp.config]
    showAbbreviationSuggestions = true
    showExpandedAbbreviation = "always"
    showSuggestionsAsSnippets = true

    [language-server.emmet-lsp.config.includeLanguages]
    jsx = "javascriptreact"
    tsx = "typescriptreact"

    [language-server.ty]
    command = "ty"
    args = ["server"]

    [language-server.ruff]
    command = "ruff"
    args = ["server"]

    [language-server.bash-language-server]
    command = "bash-language-server"
    args = ["start"]

    [language-server.taplo]
    command = "taplo"
    args = ["lsp", "stdio"]

    [language-server.nixd]
    command = "nixd"

    [language-server.nixd.config.nixd]
    formatting.command = ["nixfmt"]

    [language-server.nixd.config.nixd.options]
    nixos.expr = '(builtins.getFlake "${flakePath}").nixosConfigurations.${hostName}.options'
    home-manager.expr = '(builtins.getFlake "${flakePath}").nixosConfigurations.${hostName}.options.home-manager.users.type.getSubOptions []'

    [language-server.rust-analyzer.config]
    check = { command = "clippy", extraArgs = ["--all-targets"] }
    cargo = { allFeatures = true, buildScripts.enable = true }
    procMacro.enable = true

    [language-server.rust-analyzer.config.inlayHints]
    bindingModeHints.enable = true
    closingBraceHints.enable = true
    closureReturnTypeHints.enable = "with_block"
    discriminantHints.enable = "fieldless"
    lifetimeElisionHints.enable = "skip_trivial"
    typeHints.enable = true

    [[language]]
    name = "typescript"
    language-servers = ["vtsls", "biome"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "biome", args = ["format", "--stdin-file-path", "%{buffer_name}", "--config-path", "${biomeConfigDir}"] }

    [[language]]
    name = "tsx"
    language-servers = ["vtsls", "biome", "emmet-lsp"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "biome", args = ["format", "--stdin-file-path", "%{buffer_name}", "--config-path", "${biomeConfigDir}"] }

    [[language]]
    name = "javascript"
    language-servers = ["vtsls", "biome"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "biome", args = ["format", "--stdin-file-path", "%{buffer_name}", "--config-path", "${biomeConfigDir}"] }

    [[language]]
    name = "jsx"
    language-servers = ["vtsls", "biome", "emmet-lsp"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "biome", args = ["format", "--stdin-file-path", "%{buffer_name}", "--config-path", "${biomeConfigDir}"] }

    [[language]]
    name = "css"
    scope = "source.css"
    language-servers = ["vscode-css-language-server", "biome", "emmet-lsp"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "biome", args = ["format", "--stdin-file-path", "%{buffer_name}", "--config-path", "${biomeConfigDir}"] }

    [[language]]
    name = "json"
    scope = "source.json"
    language-servers = ["vscode-json-language-server", "biome"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "biome", args = ["format", "--stdin-file-path", "%{buffer_name}", "--config-path", "${biomeConfigDir}"] }

    [[language]]
    name = "html"
    scope = "text.html.basic"
    language-servers = ["vscode-html-language-server", "emmet-lsp"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "biome", args = ["format", "--stdin-file-path", "%{buffer_name}", "--config-path", "${biomeConfigDir}"] }

    [[language]]
    name = "bash"
    scope = "source.bash"
    language-servers = ["bash-language-server"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "shfmt", args = ["-i", "0"] }

    [[language]]
    name = "python"
    auto-format = true
    language-servers = ["ty", "ruff"]
    indent = { tab-width = 4, unit = "    " }
    formatter = { command = "ruff", args = ["format", "--stdin-filename", "%{buffer_name}", "-"] }

    [[language]]
    name = "rust"
    scope = "source.rust"
    language-servers = ["rust-analyzer"]
    auto-format = true
    indent = { tab-width = 4, unit = "    " }
    formatter = { command = "rustfmt" }

    [[language]]
    name = "nix"
    scope = "source.nix"
    language-servers = ["nixd"]
    auto-format = true
    indent = { tab-width = 2, unit = "  " }
    formatter = { command = "nixfmt" }

    [[language]]
    name = "yaml"
    scope = "source.yaml"
    auto-format = true
    indent = { tab-width = 2, unit = "  " }
    formatter = { command = "biome", args = ["format", "--stdin-file-path", "%{buffer_name}", "--config-path", "${biomeConfigDir}"] }

    [[language]]
    name = "toml"
    scope = "source.toml"
    language-servers = ["taplo"]
    auto-format = true
    indent = { tab-width = 2, unit = "  " }
    formatter = { command = "taplo", args = ["fmt", "-"] }
  '';
}
