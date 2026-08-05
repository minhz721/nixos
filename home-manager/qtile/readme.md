# How to Get WM_CLASS for Floating Windows in Qtile

This guide explains how to accurately find the `wm_class` or `title` properties of any application on Linux (X11) to force it into **Floating Mode** inside the Qtile Window Manager.

---

## 🛠 Step 1: Use the `xprop` Tool

This is the fastest and most reliable method for Xorg-based systems.

1. Open your terminal and run the following command:

   ```bash
   xprop WM_CLASS
   ```

2. Your mouse cursor will turn into a **crosshair (+)**.
3. Click directly on the application window you want to make float.

4. Read the output generated in your terminal. It will look like this:
   ```bash
   WM_CLASS(STRING) = "spotify", "Spotify"
   ```
   > 📌 **Note:** You can use either the lowercase string (`"spotify"`) or the capitalized string (`"Spotify"`) for your configuration.

---

## ⚙️ Step 2: Update Your Qtile Configuration

Open your Qtile configuration file at `~/.config/qtile/config.py`. Locate the `floating_layout` section and add your application using the `Match` class:

```python
from libqtile import layout
from libqtile.config import Match # Ensure this is imported at the top

floating_layout = layout.Floating(
    float_rules=[
        # Keep default system float rules
        *layout.Floating.default_float_rules,

        # Add your custom applications here using the fetched wm_class
        Match(wm_class="spotify"),
        Match(wm_class="pavucontrol"),
        Match(wm_class="blueman-manager"),
    ]
)
```

---

## ⌨️ Pro Tip: Toggle Floating Mode via Hotkey

If you want to manually toggle any focused window between floating and tiling modes, add this shortcut to your `keys` list inside `config.py`:

```python
Key([mod, "shift"], "space", lazy.window.toggle_floating(), desc="Toggle floating mode")
```

---

## 🔄 Apply Changes

Save your `config.py` file and restart Qtile using your default reload keybinding (usually `Super + Ctrl + R`), or run this terminal command:

```bash
qtile cmd-obj -o cmd -f restart
```
