mapfile -t rows < <(
  swaymsg -t get_tree | jq -r '
    recurse(.nodes[]?, .floating_nodes[]?)
    | select((.type == "con" or .type == "floating_con") and .pid != null)
    | "\(.id)\t\(.app_id // .window_properties.class // "unknown") — \((.name // "Unnamed") | gsub("[\\t\\n]"; " "))"
  '
)

if [ "${#rows[@]}" -eq 0 ]; then
  exit 0
fi

choice=$(
  printf '%s\n' "${rows[@]#*$'\t'}" |
    fuzzel --dmenu --index --lines=10 --minimal-lines --prompt "Window: "
) || exit 0

id="${rows[$choice]%%$'\t'*}"
swaymsg "[con_id=$id] focus"
