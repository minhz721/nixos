{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.mitos.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  xdg.configFile."mitos/config.toml".text = ''
    theme = "dark_plus"

    [editor]
    line-number = "relative"

    [editor.completion]
    trigger-delay = 5

    [editor.inline-completion]
    trigger-delay = 10

    [editor.files.auto-save]
    focus-lost = true
    after-delay.enable = true
    after-delay.timeout = 3000 # milliseconds

    [editor.spelling]
    languages = ["en_US"]

    [editor.bufferline]
    show = "multiple"

    [editor.indent-guides]
    render = true

    [editor.soft-wrap]
    wrap-at-text-width = true

    [editor.rainbow-brackets]
    enable = true

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
    "C-x" = ["goto_line_start", "extend_to_line_bounds", "delete_selection"]

    [keys.normal.","]
    "w" = ":write"
    "q" = ":quit"
    "f" = "file_picker"
    "b" = "buffer_picker"
    "s" = "symbol_picker"
    "/" = "toggle_comments"

    [keys.insert]
    "C-a" = "select_all"
    "C-s" = [":write", "normal_mode"]
    "C-c" = ":clipboard-yank"
    "C-v" = ":clipboard-paste-after"
    "C-A-down" = ["normal_mode", "extend_line_below", "yank", "paste_after", "insert_mode"]
    "C-A-up" = ["normal_mode", "extend_line_below", "yank", "paste_before", "insert_mode"]
    "C-z" = ["normal_mode", "undo", "insert_mode"]
    "C-S-z" = ["normal_mode", "redo", "insert_mode"]
    "C-x" = ["normal_mode", "goto_line_start", "extend_to_line_bounds", "delete_selection", "insert_mode"]

    [keys.select]
    "C-a" = "select_all"
    "C-s" = [":write", "normal_mode"]
    "C-c" = ":clipboard-yank"
    "C-v" = ":clipboard-paste-after"
    "C-A-down" = ["yank", "paste_after"]
    "C-A-up" = ["yank", "paste_before"]
    "C-z" = "undo"
    "C-S-r" = "redo"
    "C-x" = ["delete_selection"]
  '';

  xdg.configFile."mitos/languages.toml".text = ''
    [language-server.vtsls]
    command = "vtsls"
    args = ["--stdio"]

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

    [language-server.taplo]
    command = "taplo"
    args = ["lsp", "stdio"]

    [[language]]
    name = "kdl"
    scope = "source.kdl"
    file-types = ["kdl"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "kdlfmt", args = ["format", "-"] }

    [[language]]
    name = "nix"
    scope = "source.nix"
    language-servers = ["nixd"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "alejandra" }

    [[language]]
    name = "typescript"
    language-servers = ["vtsls"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "prettier", args = ["--stdin-filepath", "%{buffer_name}"] }

    [[language]]
    name = "tsx"
    language-servers = ["vtsls", "emmet-lsp"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "prettier", args = ["--stdin-filepath", "%{buffer_name}"] }

    [[language]]
    name = "javascript"
    language-servers = ["vtsls"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "prettier", args = ["--stdin-filepath", "%{buffer_name}"] }

    [[language]]
    name = "jsx"
    language-servers = ["vtsls", "emmet-lsp"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "prettier", args = ["--stdin-filepath", "%{buffer_name}"] }

    [[language]]
    name = "html"
    scope = "text.html.basic"
    language-servers = ["vscode-html-language-server", "emmet-lsp"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "prettier", args = ["--stdin-filepath", "%{buffer_name}"] }

    [[language]]
    name = "css"
    scope = "source.css"
    language-servers = ["vscode-css-language-server", "emmet-lsp"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "prettier", args = ["--stdin-filepath", "%{buffer_name}"] }

    [[language]]
    name = "json"
    scope = "source.json"
    language-servers = ["vscode-json-language-server"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "prettier", args = ["--stdin-filepath", "%{buffer_name}"] }

    [[language]]
    name = "yaml"
    scope = "source.yaml"
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "prettier", args = ["--stdin-filepath", "%{buffer_name}"] }

    [[language]]
    name = "toml"
    scope = "source.toml"
    language-servers = ["taplo"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "taplo", args = ["fmt", "-"] }

    [[language]]
    name = "python"
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "ruff", args = ["format", "-"] }
    language-servers = ["ty", "ruff"]

    [[language]]
    name = "bash"
    scope = "source.bash"
    language-servers = ["bash-language-server"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "shfmt", args = ["-i", "2"] }

    [[language]]
    name = "rust"
    scope = "source.rust"
    language-servers = ["rust-analyzer"]
    auto-format = true
    indent = { tab-width = 4, unit = "\t" }
    formatter = { command = "rustfmt" }
  '';
}
