# macos-hyprlock — SDDM theme

An SDDM login theme built to match this Hyprlock config: same wallpaper,
blurred + dimmed, a big translucent 24-hour clock, and a small pill-shaped
password field with no border, floating below center.

## What maps to what

| Hyprlock | This theme |
|---|---|
| `background.path` | `theme.conf` → `background` |
| `blur_passes` / `blur_size` | `theme.conf` → `blurMax` (blur radius, Qt has no separate "passes") |
| `brightness = 0.75` | `theme.conf` → `brightness = -0.25` (Qt's MultiEffect brightness is an offset, not a multiplier) |
| `contrast = 0.9` | `theme.conf` → `contrast = -0.10` |
| `noise = 0.02` | not replicated — there's no cheap equivalent in Qt Quick without shipping a noise texture. Visually minor; safe to skip. |
| clock `label{}` | the centered `Text` — font, size, color, and offset all read from `theme.conf` |
| `input-field{}` pill | the translucent `Rectangle` + `TextInput`, dot character instead of hyprlock's dot-grid renderer |

The username label is present but **off by default** (`showUsername=false`)
since your hyprlock config doesn't show one either — it's a single-user lock
screen look. Flip it on in `theme.conf` if you'd like a small name above the
password field.

## Install

```bash
sudo mkdir -p /usr/share/sddm/themes/macos-hyprlock
sudo cp -r ./* /usr/share/sddm/themes/macos-hyprlock/
```

Make sure the wallpaper is readable by the `sddm` user (the greeter runs as
that user, not you):

```bash
sudo chmod o+r /home/archie/Pictures/wallpapers/mac/macos6.jpg
sudo chmod o+x /home/archie/Pictures /home/archie/Pictures/wallpapers /home/archie/Pictures/wallpapers/mac
```

Or simpler: copy the wallpaper straight into the theme folder and point
`background=` in `theme.conf` at that local copy instead — no permission
juggling needed.

Then set it as the active theme, in `/etc/sddm.conf` or a drop-in under
`/etc/sddm.conf.d/`:

```ini
[Theme]
Current=macos-hyprlock
```

Test without logging out, in a nested window:

```bash
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/macos-hyprlock
```

(use `sddm-greeter` instead of `sddm-greeter-qt6` if your distro ships the
Qt5 greeter binary — see the note below).

## Qt5 fallback

This theme uses `QtQuick.Effects` (`MultiEffect`), which needs the Qt6
greeter (Qt 6.5+). If your SDDM is still Qt5-based, swap the import and the
blur block in `Main.qml`:

```qml
import Qt5Compat.GraphicalEffects   // or QtGraphicalEffects 1.0 on plain Qt5
...
FastBlur {
    anchors.fill: bg
    source: bg
    radius: root.blurMax
}
// then layer a semi-transparent black Rectangle on top for the dim,
// since Qt5's GraphicalEffects has no single brightness/contrast node
// as convenient as MultiEffect.
```

## Tweaking

Everything visual — blur amount, dim amount, clock font/size/color/position,
pill size/rounding/color/position — lives in `theme.conf`. No need to touch
the QML unless you want to change structure/behavior.
