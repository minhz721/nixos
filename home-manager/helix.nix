{
  pkgs,
  lib,
  ...
}: {
  programs.helix = {
    enable = true;
    defaultEditor = false;

    themes = {
      catppuccin_mocha = {
        "inherits" = "catppuccin_mocha";

        # TODO / FIXME / NOTE / HACK
        "comment.note" = {
          fg = "#89b4fa";
          modifiers = ["bold"];
        };
        "comment.warning" = {
          fg = "#f9e2af";
          modifiers = ["bold"];
        };
        "comment.error" = {
          fg = "#f38ba8";
          modifiers = ["bold"];
        };

        "special" = {
          fg = "#f9e2af";
          modifiers = ["bold"];
        };
        "markup.heading.marker" = {
          fg = "#f38ba8";
          modifiers = ["bold"];
        };
      };
    };

    settings = {
      theme = "catppuccin_mocha";

      editor = {
        line-number = "relative";
        cursorline = true;
        auto-format = true;
        bufferline = "multiple";
        mouse = true;

        auto-pairs = {
          "(" = ")";
          "[" = "]";
          "{" = "}";
          "\"" = "\"";
          "'" = "'";
        };

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };

        indent-guides = {
          render = true;
          character = "│";
        };
      };

      # Custom Keybindings (Using comma ',' as Leader Key)
      keys.normal = {
        "tab" = ":buffer-next";
        "S-tab" = ":buffer-previous";
        "C-s" = ":w";
        "C-a" = ["goto_file_start" "select_all"];
        # Quick actions with comma ','
        "," = {
          w = ":w"; # Save file (,w)
          q = ":q"; # Quit (,q)
          f = "file_picker"; # Open file picker (,f)
          b = "buffer_picker"; # Open buffer picker (,b)
          s = "symbol_picker"; # Search symbols (,s)
          
          # Lazygit
          g = ":sh tmux display-popup -d \"#{pane_current_path}\" -w 90% -h 90% -E lazygit";
        };

        # Swap space to clear secondary selections (original comma behavior)
        space = "remove_primary_selection";
      };

      keys.insert = {
        "C-s" = ":w";
        "C-a" = ["goto_file_start" "select_all"];
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          scope = "source.nix";
          auto-format = true;
          formatter = {command = "alejandra";};
        }
        {
          name = "lua";
          scope = "source.lua";
          language-servers = ["lua-language-server"];
          auto-format = true;
          formatter = {
            command = "stylua";
            args = ["-"];
          };
        }
        # TypeScript & TSX
        {
          name = "typescript";
          language-servers = [ "vtsls" ];
          auto-format = true;
        }
        {
          name = "tsx";
          language-servers = [ "vtsls" ];
          auto-format = true;
        }

        # JavaScript & JSX
        {
          name = "javascript";
          language-servers = [ "vtsls" ];
          auto-format = true;
        }
        {
          name = "jsx";
          language-servers = [ "vtsls" ];
          auto-format = true;
        }
        {
          name = "html";
          scope = "text.html.basic";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath"];
          };
        }
        {
          name = "css";
          scope = "source.css";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath"];
          };
        }
        {
          name = "json";
          scope = "source.json";
          language-servers = ["vscode-json-language-server"];
          auto-format = true;
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath"];
          };
        }
        {
          name = "yaml";
          scope = "source.yaml";
          language-servers = ["yaml-language-server"];
          auto-format = true;
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath"];
          };
        }
        {
          name = "svelte";
          scope = "source.svelte";
          language-servers = ["svelteserver"];
          auto-format = true;
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath"];
          };
        }
        {
          name = "python";
          scope = "source.python";
          language-servers = ["pyright"];
          auto-format = true;
          formatter = {
            command = "ruff";
            args = ["format" "--stdin-filename"];
          };
        }
        {
          name = "bash";
          scope = "source.bash";
          language-servers = ["bash-language-server"];
          auto-format = true;
          formatter = {
            command = "shfmt";
            args = ["-i" "2"];
          };
        }
        {
          name = "dockerfile";
          scope = "source.dockerfile";
          language-servers = ["docker-langserver"];
        }
        {
          name = "rust";
          scope = "source.rust";
          auto-format = true;
        }
        {
          name = "markdown";
          scope = "text.html.markdown";
          language-servers = ["marksman"];
          auto-format = true;
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath"];
          };
        }
        {
          name = "sql";
          scope = "source.sql";
          language-servers = ["sqls"];
          auto-format = true;
          formatter = {
            command = "sqlfluff";
            args = ["fix" "-"];
          };
        }
      ];

      language-server.vtsls = {
        command = "vtsls";
        args = [ "--stdio" ];
      };
    };
  };
}