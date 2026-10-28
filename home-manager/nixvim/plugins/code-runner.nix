{ pkgs, ... }: let
  # Custom lightweight code execution script tailored for bun and uv backends
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
        echo "▶ Executing JavaScript via Bun: $file"
        exec ${pkgs.bun}/bin/bun run "$file"
        ;;

      *.ts)
        echo "▶ Executing TypeScript via Bun: $file"
        exec ${pkgs.bun}/bin/bun run "$file"
        ;;

      *.py)
        echo "▶ Executing Python via UV backend: $file"
        exec ${pkgs.uv}/bin/uv run "$file"
        ;;

      *.rs)
        echo "▶ Compiling Rust source: $file"
        binary="/tmp/nvim-rust-$(basename "$file" .rs)-$$"

        cleanup() {
          rm -f "$binary"
        }
        trap cleanup EXIT

        ${pkgs.rustc}/bin/rustc "$file" -o "$binary"

        echo "▶ Launching Rust binary"
        "$binary"
        ;;

      *)
        echo "Error: Unsupported file type extension"
        echo "Supported matrix: .js .ts .py .rs"
        exit 1
        ;;
    esac
  '';
in {
  programs.nixvim = {
    # Expose the updated shell runner package directly inside Nixvim path environment
    extraPackages = [
      code-runner
    ];

    # Keyboard trigger configurations for smooth terminal execution toggles
    keymaps = [
      {
        key = "<leader>rr";
        mode = "n";
        action = "<cmd>execute 'botright 15split | terminal code-runner ' .. shellescape(expand('%:p'))<CR>";
        options = {
          desc = "Run current file in horizontal split";
          silent = true;
        };
      }
    ];
  };
}
