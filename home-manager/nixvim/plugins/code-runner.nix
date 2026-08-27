{pkgs, ...}: let
  code-runner = pkgs.writeShellScriptBin "code-runner" ''
    set -e

    file="$1"

    if [ -z "$file" ]; then
      echo "Error: No file specified"
      exit 1
    fi

    if [ ! -f "$file" ]; then
      echo "Error: File does not exist: $file"
      exit 1
    fi

    case "$file" in

      *.js)
        echo "▶ Running JavaScript: $file"
        exec ${pkgs.nodejs}/bin/node "$file"
        ;;

      *.ts)
        echo "▶ Running TypeScript: $file"
        exec ${pkgs.tsx}/bin/tsx "$file"
        ;;

      *.py)
        echo "▶ Running Python: $file"
        exec ${pkgs.python3}/bin/python3 "$file"
        ;;

      *.rs)
        echo "▶ Compiling Rust: $file"

        binary="/tmp/nvim-rust-$(basename "$file" .rs)-$$"

        cleanup() {
          rm -f "$binary"
        }

        trap cleanup EXIT

        ${pkgs.rustc}/bin/rustc "$file" -o "$binary"

        echo "▶ Running Rust"
        "$binary"
        ;;

      *)
        echo "Error: Unsupported file type"
        echo "Supported: .js .ts .py .rs"
        exit 1
        ;;

    esac
  '';
in {
  programs.nixvim = {
    extraPackages = [
      code-runner
    ];

    keymaps = [
      {
        key = "<leader>rr";
        mode = "n";

        action = "<cmd>execute 'botright 15split | terminal code-runner ' .. shellescape(expand('%:p'))<CR>";

        options = {
          desc = "Run current file";
          silent = true;
        };
      }
    ];
  };
}
