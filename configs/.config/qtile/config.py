# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, qtile, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration, RectDecoration

# ---------- Decorations ----------
powerline = {
    "decorations": [PowerLineDecoration(path="arrow_right")]
}

powerline_right = {
    "decorations": [PowerLineDecoration(path="arrow_left")]
}

rect = {
    "decorations": [RectDecoration(use_widget_background=True, radius=10, filled=True, clip=True)]
}

# ---------- Helper Functions ----------
@lazy.function
def resize_floating_window(qtile, width: int = 0, height: int = 0):
    w = qtile.current_window
    if w is not None and w.floating:
        w.cmd_set_size_floating(w.width + width, w.height + height)

# ---------- Basic Settings ----------
mod = "mod4"
terminal = guess_terminal()

# ---------- Colors ----------
colors = {
    "aqua": "#8EC07C",
    "pink": "#e2619f",
    "purple": "#2E1A47",
    "green": "#446054",
    "blue": "#27537b",
    "light_blue": "#6786A6",
    "red": "#F56476",
    "mauve": "#AC6588",
    "magenta": "#A41167",
}

# ---------- Autostart ----------
@hook.subscribe.startup_once
def autostart():
    qtile.spawn("nitrogen --restore")

# ---------- Keybindings ----------
keys = [
    # Floating resize
    Key([mod], "v", resize_floating_window(width=-20, height=-20), desc="Decrease floating window size"),
    Key([mod], "b", resize_floating_window(width=20, height=20), desc="Increase floating window size"),

    # Navigation
    Key([mod], "j", lazy.layout.left(), desc="Focus left"),
    Key([mod], "l", lazy.layout.right(), desc="Focus right"),
    Key([mod], "k", lazy.layout.down(), desc="Focus down"),
    Key([mod], "i", lazy.layout.up(), desc="Focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Next window"),

    # Move windows
    Key([mod, "shift"], "j", lazy.layout.shuffle_left(), desc="Move window left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window right"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "i", lazy.layout.shuffle_up(), desc="Move window up"),

    # Resize windows
    Key([mod, "control"], "j", lazy.layout.grow_left(), desc="Grow left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow right"),
    Key([mod, "control"], "k", lazy.layout.grow_down(), desc="Grow down"),
    Key([mod, "control"], "i", lazy.layout.grow_up(), desc="Grow up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset window sizes"),

    # Layout & window management
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle split"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Next layout"),
    Key([mod], "w", lazy.window.kill(), desc="Close window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Quit Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn command"),
    Key([mod], "m", lazy.window.toggle_maximize(), desc="maximize"),
    Key([mod, "shift"], "m", lazy.window.toggle_minimize(), desc="minimize"),
    # Apps
    Key(["mod1"], "b", lazy.spawn("librewolf"), desc="Browser"),
    Key(["mod1"], "t", lazy.spawn("kitty"), desc="Kitty terminal"),
    Key(["mod1"], "e", lazy.spawn("emacsclient -c"), desc="Emacs"),
    Key(["mod1"], "v", lazy.spawn("alacritty -e vim"), desc="Vim"),
    Key(["mod1"], "k", lazy.spawn("krita"), desc="Krita"),
    Key(["mod1"], "d", lazy.spawn("vesktop"), desc="Discord"),
    Key(["mod1"], "s", lazy.spawn("flameshot gui"), desc="Screenshot"),

    # Rofi menus
    Key(["mod1"], "tab", lazy.spawn("rofi -show window -show-icons"), desc="Alt+Tab"),
    Key([mod], "s", lazy.spawn("rofi -show drun -show-icons"), desc="App launcher"),

    # Media keys
    Key([], "XF86AudioMute", lazy.spawn("pamixer -t")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer -d 1 -u")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer -i 1 -u")),

    # Brightness
    Key([], "XF86MonBrightnessDown", lazy.spawn("light -U 1")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("light -A 1")),
]

# Wayland VTs
for vt in range(1, 8):
    keys.append(
        Key(["control", "mod1"], f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}")
    )

# ---------- Groups ----------
groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(), desc=f"Switch to group {i.name}"),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True), desc=f"Move to group {i.name}")
    ])

# ---------- Layouts ----------
layout_theme = {
    "border_width": 3,
    "margin": 4,
    "border_focus": "#F56476",
    "border_normal": "#DFBBB1",
}

layouts = [
    layout.Columns(**layout_theme),
    layout.Max(**layout_theme),
]

# ---------- Widgets ----------
widget_defaults = dict(
    font="Fira Code",
    fontsize=12,
    padding=5,
    background="#120114"
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.StatusNotifier(icon_size=16, background=colors["purple"], padding=10, **powerline_right),
                widget.Spacer(length=bar.STRETCH),
                widget.Clock(format=" %d %b | %H:%M", background=colors["green"],
                             mouse_callbacks={'Button1': lambda: qtile.cmd_spawn('gsimplecal')}, **rect),
                widget.Spacer(length=bar.STRETCH, **powerline),
                widget.Wlan(interface="wlp2s0", format="󰤨  {essid}", disconnected_message="󰖪",
                            background=colors["aqua"], padding=8, mouse_callbacks={"Button1": lazy.spawn("iwgtk")}, **powerline),
                widget.CPU(background=colors["light_blue"], format='{freq_current}GHz {load_percent}% 󰍛 ', **powerline),
                widget.PulseVolume(fmt='{} 󰕾', background=colors["pink"], **powerline),
                widget.Backlight(backlight_name="intel_backlight", format='{percent:2.0%} 󰌵',
                                 background=colors["red"], **powerline),
                widget.Battery(format='{percent:2.0%} 󰁹', full_short_text="100% 󰁹", background=colors["mauve"], **powerline),
                widget.KeyboardLayout(configured_keyboards=['be', 'us'], fmt='{} 󰌌 ', background=colors["magenta"]),
            ],
            18,
        ),
    ),
]

# ---------- Mouse ----------
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

# ---------- Behavior ----------
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True

# Wayland input rules
wl_input_rules = None
wl_xcursor_theme = None
wl_xcursor_size = 24

wmname = "LG3D"
