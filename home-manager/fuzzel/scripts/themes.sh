#!/usr/bin/env bash

# List of available themes displayed in Control Center
THEME_LIST=(
	"Catppuccin Mocha"
	"Noctalia Dark"
	"Rosé Pine"
	"Nord"
	"Everforest Dark"
	"Kanagawa"
	"Gruvbox Dark"
)

# Load palette variables for a given theme name
load_theme_palette() {
	case "$1" in
	"Catppuccin Mocha")
		bg="#1e1e2e"
		surface="#313244"
		overlay="#585b70"
		muted="#6c7086"
		fg="#cdd6f4"
		subtext="#bac2de"
		accent="#cba6f7"
		border_alt="#b4befe"
		yellow="#f9e2af"
		blue="#89b4fa"
		green="#a6e3a1"
		teal="#94e2d5"
		red="#f38ba8"
		;;
	"Noctalia Dark")
		bg="#121217"
		surface="#1c1c24"
		overlay="#2e2e3a"
		muted="#71717a"
		fg="#f4f4f6"
		subtext="#a1a1aa"
		accent="#f4f4f6"
		border_alt="#e4e4e7"
		yellow="#fde047"
		blue="#60a5fa"
		green="#4ade80"
		teal="#2dd4bf"
		red="#f87171"
		;;
	"Rosé Pine")
		bg="#191724"
		surface="#26233a"
		overlay="#403d52"
		muted="#6e6a86"
		fg="#e0def4"
		subtext="#908caa"
		accent="#c4a7e7"
		border_alt="#ebbcba"
		yellow="#f6c177"
		blue="#9ccfd8"
		green="#31748f"
		teal="#ebbcba"
		red="#eb6f92"
		;;
	"Nord")
		bg="#2e3440"
		surface="#3b4252"
		overlay="#4c566a"
		muted="#616e88"
		fg="#eceff4"
		subtext="#d8dee9"
		accent="#88c0d0"
		border_alt="#81a1c1"
		yellow="#ebcb8b"
		blue="#81a1c1"
		green="#a3be8c"
		teal="#8fbcbb"
		red="#bf616a"
		;;
	"Everforest Dark")
		bg="#2d353b"
		surface="#3d484d"
		overlay="#4f585e"
		muted="#859289"
		fg="#d3c6aa"
		subtext="#9da9a0"
		accent="#a7c080"
		border_alt="#83c092"
		yellow="#dbbc7f"
		blue="#7fbbb3"
		green="#a7c080"
		teal="#83c092"
		red="#e67e80"
		;;
	"Kanagawa")
		bg="#1f1f28"
		surface="#2a2a37"
		overlay="#363646"
		muted="#727169"
		fg="#dcd7ba"
		subtext="#c8c093"
		accent="#957fb8"
		border_alt="#7e9cd8"
		yellow="#e6c384"
		blue="#7e9cd8"
		green="#98bb6c"
		teal="#7aa89f"
		red="#e46876"
		;;
	"Gruvbox Dark")
		bg="#282828"
		surface="#3c3836"
		overlay="#504945"
		muted="#928374"
		fg="#ebdbb2"
		subtext="#d5c4a1"
		accent="#d3869b"
		border_alt="#fabd2f"
		yellow="#fabd2f"
		blue="#83a598"
		green="#b8bb26"
		teal="#8ec07c"
		red="#fb4934"
		;;
	*)
		return 1
		;;
	esac
}
