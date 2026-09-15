------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@60",
    position = "960x1080",
    scale    = 1,
})

hl.monitor({
    output   = "HDMI-A-2",
    mode     = "1920x1080@60",
    position = "0x0",
    scale    = 1,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@60",
    position = "1920x0",
    scale    = 1,
})




---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "alacritty"
local fileManager = "thunar"
local menu        = "rofi"
local browser     = "firefox"


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("AQ_DRM_DEVICES", "/dev/dri/card1:/dev/dri/card0")


-----------------------
---- PERMISSIONS -----
-----------------------

hl.permission(
    "/usr/(bin|local/bin)/hyprpm",
    "plugin",
    "allow"
)


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 12,

        border_size = 2,

        col = {
            active_border = "rgba(88c0d0ff)",
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing = false,

        layout = "dwindle",

        snap = {
            enabled = true,
            window_gap = 10,
            monitor_gap = 10,
            respect_gaps = true,
        },
    },
    
    render = {
    	direct_scanout = false
    },
    cursor = {
    	no_hardware_cursors = true
    },


    decoration = {
        rounding = 8,
        rounding_power = 2,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 3,
            noise = 0.02,
            vibrancy = 0.1696,
        },
    },


    animations = {
        enabled = true,
    },


    dwindle = {
        preserve_split = true,
    },


    master = {
        new_status = "master",
    },


    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = false,
    },
})


---------------------
---- ANIMATIONS -----
---------------------

hl.curve("easeOutQuint", {
    type = "bezier",
    points = {{0.23, 1}, {0.32, 1}}
})

hl.curve("easeInOutCubic", {
    type = "bezier",
    points = {{0.65, 0.05}, {0.36, 1}}
})

hl.curve("linear", {
    type = "bezier",
    points = {{0, 0}, {1, 1}}
})

hl.curve("almostLinear", {
    type = "bezier",
    points = {{0.5, 0.5}, {0.75, 1}}
})

hl.curve("quick", {
    type = "bezier",
    points = {{0.15, 0}, {0.1, 1}}
})


hl.animation({
    leaf = "global",
    enabled = true,
    speed = 10,
    bezier = "default"
})

hl.animation({
    leaf = "border",
    enabled = true,
    speed = 5.39,
    bezier = "easeOutQuint"
})

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 4.79,
    bezier = "easeOutQuint"
})

hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 4.1,
    bezier = "easeOutQuint",
    style = "popin 87%"
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 1.49,
    bezier = "linear",
    style = "popin 87%"
})

hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 1.73,
    bezier = "almostLinear"
})

hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 1.46,
    bezier = "almostLinear"
})

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 3.03,
    bezier = "quick"
})

hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 3.81,
    bezier = "easeOutQuint"
})

hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 4,
    bezier = "easeOutQuint",
    style = "fade"
})

hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 1.5,
    bezier = "linear",
    style = "fade"
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 1.0,
    bezier = "easeOutQuint",
    style = "slide"
})

hl.animation({
    leaf = "workspacesIn",
    enabled = true,
    speed = 1.0,
    bezier = "easeOutQuint",
    style = "slide"
})

hl.animation({
    leaf = "workspacesOut",
    enabled = true,
    speed = 1.0,
    bezier = "easeOutQuint",
    style = "slide"
})

hl.animation({
    leaf = "zoomFactor",
    enabled = true,
    speed = 7,
    bezier = "quick"
})
---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "gb",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,

        sensitivity = 0,

        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.3,
        },
    },
})


----------------
---- DEVICE ----
----------------

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- HyprLock
hl.bind(
    mainMod .. " + CTRL + L",
    hl.dsp.exec_cmd("hyprlock")
)

-- Screenshots
hl.bind(
    mainMod .. " + CTRL + P",
    hl.dsp.exec_cmd('grim -g "$(slurp)"')
)

hl.bind(
    mainMod .. " + SHIFT + P",
    hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy')
)

-- Applications

hl.bind(
    mainMod .. " + Q",
    hl.dsp.exec_cmd(terminal)
)

hl.bind(
    mainMod .. " + E",
    hl.dsp.exec_cmd(fileManager)
)

hl.bind(
    mainMod .. " + F",
    hl.dsp.exec_cmd(browser)
)

hl.bind(
    mainMod .. " + SPACE",
    hl.dsp.exec_cmd(
    	"rofi -show drun -theme ~/.local/share/rofi/themes/custom-spotlight.rasi"
    )
)

hl.bind(
    mainMod .. " + P",
    hl.dsp.exec_cmd("spotify-launcher")
)

hl.bind(
    mainMod .. " + L",
    hl.dsp.exec_cmd(
        "firefox -P borderless --new-window https://claude.ai/new"
    )
)

hl.bind(
    mainMod .. " + CTRL + RETURN",
    hl.dsp.exec_cmd(
        "~/.local/bin/random-wallpaper"
    )
)

hl.bind(
    mainMod .. " + CTRL + B",
    hl.dsp.exec_cmd(
        "~/.local/bin/bt-toggle.sh"
    )
)

-- Window actions

hl.bind(
    mainMod .. " + C",
    hl.dsp.window.close()
)

hl.bind(
    mainMod .. " + O",
    hl.dsp.window.pseudo()
)

hl.bind(
    mainMod .. " + J",
    hl.dsp.layout("togglesplit")
)


-- Toggle floating

hl.bind(
    mainMod .. " + SHIFT + T",
    hl.dsp.window.float({
        action = "toggle"
    })
)


-- Focus movement

hl.bind(
    mainMod .. " + left",
    hl.dsp.focus({direction = "left"})
)

hl.bind(
    mainMod .. " + right",
    hl.dsp.focus({direction = "right"})
)

hl.bind(
    mainMod .. " + up",
    hl.dsp.focus({direction = "up"})
)

hl.bind(
    mainMod .. " + down",
    hl.dsp.focus({direction = "down"})
)


-- Workspaces

for i = 1, 10 do
    local key = i == 10 and "0" or tostring(i)
    
    hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1", default = (i == 1) })
    
    hl.bind(
        mainMod .. " + " .. key,
        hl.dsp.focus({
            workspace = i
        })
    )

    hl.bind(
        mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({
            workspace = i
        })
    )
end

for i = 11, 15 do
    local key = i == 20 and "0" or tostring(i-10)

    hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1", default = (i == 1) })
    
    hl.bind(
        mainMod .. " + CTRL + " .. key,
        hl.dsp.focus({
            workspace = i
        })
    )

    hl.bind(
        mainMod .. " + SHIFT + CTRL + " .. key,
        hl.dsp.window.move({
            workspace = i
        })
    )
end

-- 16-20

for i = 16, 20 do
    local key = i == 20 and "0" or tostring(i-10)

    hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-2", default = (i == 1) })

    hl.bind(
        mainMod .. " + CTRL + " .. key,
        hl.dsp.focus({
            workspace = i
        })
    )

    hl.bind(
        mainMod .. " + SHIFT + CTRL + " .. key,
        hl.dsp.window.move({
            workspace = i
        })
    )
end

-- Move workspace between monitors

hl.bind(
    mainMod .. " + ALT + LEFT",
    hl.dsp.exec_cmd(
        "hyprctl dispatch movecurrentworkspacetomonitor l"
    )
)

hl.bind(
    mainMod .. " + ALT + RIGHT",
    hl.dsp.exec_cmd(
        "hyprctl dispatch movecurrentworkspacetomonitor r"
    )
)

hl.bind(
    mainMod .. " + ALT + UP",
    hl.dsp.exec_cmd(
        "hyprctl dispatch movecurrentworkspacetomonitor u"
    )
)

hl.bind(
    mainMod .. " + ALT + DOWN",
    hl.dsp.exec_cmd(
        "hyprctl dispatch movecurrentworkspacetomonitor d"
    )
)


-- Special workspaces

hl.bind(
    mainMod .. " + S",
    hl.dsp.workspace.toggle_special("S")
)

hl.bind(
    mainMod .. " + SHIFT + S",
    hl.dsp.window.move({
        workspace = "special:S"
    })
)

hl.bind(
    mainMod .. " + D",
    hl.dsp.workspace.toggle_special("D")
)

hl.bind(
    mainMod .. " + SHIFT + D",
    hl.dsp.window.move({
        workspace = "special:D"
    })
)

hl.bind(
    mainMod .. " + A",
    hl.dsp.workspace.toggle_special("A")
)

hl.bind(
    mainMod .. " + SHIFT + A",
    hl.dsp.window.move({
        workspace = "special:A"
    })
)


-- Workspace scrolling

hl.bind(
    mainMod .. " + mouse_down",
    hl.dsp.focus({
        workspace = "e+1"
    })
)

hl.bind(
    mainMod .. " + mouse_up",
    hl.dsp.focus({
        workspace = "e-1"
    })
)

hl.bind(
    mainMod .. " + TAB",
    hl.dsp.focus({
        workspace = "e+1"
    })
)

hl.bind(
    mainMod .. " + GRAVE",
    hl.dsp.focus({
        workspace = "e-1"
    })
)


-- Mouse movement

hl.bind(
    mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    {
        mouse = true
    }
)

hl.bind(
    mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    {
        mouse = true
    }
)


-- Brightness / volume keys

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd(
        "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
    ),
    {
        locked = true,
        repeating = true
    }
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd(
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ),
    {
        locked = true,
        repeating = true
    }
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd(
        "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ),
    {
        locked = true,
        repeating = true
    }
)

hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd(
        "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ),
    {
        locked = true,
        repeating = true
    }
)

hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd(
        "brightnessctl -e4 -n2 set 5%+"
    ),
    {
        locked = true,
        repeating = true
    }
)

hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd(
        "brightnessctl -e4 -n2 set 5%-"
    ),
    {
        locked = true,
        repeating = true
    }
)


-- Media

hl.bind(
    "XF86AudioNext",
    hl.dsp.exec_cmd("playerctl next"),
    {
        locked = true
    }
)

hl.bind(
    "XF86AudioPause",
    hl.dsp.exec_cmd("playerctl play-pause"),
    {
        locked = true
    }
)

hl.bind(
    "XF86AudioPlay",
    hl.dsp.exec_cmd("playerctl play-pause"),
    {
        locked = true
    }
)

hl.bind(
    "XF86AudioPrev",
    hl.dsp.exec_cmd("playerctl previous"),
    {
        locked = true
    }
)

-------------------
---- AUTOSTART ----
-------------------

-- Enable these if you want them again.
hl.on("hyprland.start", function()
     hl.exec_cmd("waybar")
     hl.exec_cmd("hypridle")
     hl.exec_cmd("hyprpaper")
     hl.exec_cmd("sleep 1 && ~/.local/bin/random-wallpaper")
     hl.exec_cmd("wl-gammarelay")
     hl.exec_cmd("hyprshell daemon")
     hl.exec_cmd("quickshell -p ~/.config/quickshell/qs-hyprview")
end)


----------------
---- GESTURES --
----------------

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.gesture({
    fingers = 3,
    direction = "up",
    action = function()
        hl.exec_cmd("quickshell ipc -p ~/.config/quickshell/qs-hyprview call expose open smartgrid")
    end
})

hl.gesture({
    fingers = 3,
    direction = "down",
    action = function()
        hl.exec_cmd("quickshell ipc -p ~/.config/quickshell/qs-hyprview call expose close")
    end
})


------------------------------
---- SPECIAL WORKSPACES -----
------------------------------

hl.workspace_rule({
    workspace = "special:A",
    gaps_out = 20,
    on_created_empty = "true",
})

hl.workspace_rule({
    workspace = "special:S",
    gaps_out = 20,
    on_created_empty = "true",
})

hl.workspace_rule({
    workspace = "special:D",
    gaps_out = 20,
    on_created_empty = "true",
})


-------------------------
---- WINDOW RULES ------
-------------------------

-- Special workspace floating windows

hl.window_rule({
    name = "special-float-A",

    match = {
        workspace = "special:A",
    },

    float = true,
    center = true,
    size = "70% 70%",
})


hl.window_rule({
    name = "special-float-S",

    match = {
        workspace = "special:S",
    },

    float = true,
    center = true,
    size = "70% 70%",
})


hl.window_rule({
    name = "special-float-D",

    match = {
        workspace = "special:D",
    },

    float = true,
    center = true,
    size = "70% 70%",
})


-------------------------
---- LAYER RULES -------
-------------------------

hl.layer_rule({
    name = "rofi-blur",

    match = {
        namespace = "rofi",
    },

    blur = true,
    dim_around = true,
})


hl.layer_rule({
    name = "quickshell-expose-dim",

    match = {
        namespace = "quickshell:expose",
    },

    dim_around = true,
})


-------------------------
---- OTHER WINDOW RULES -
-------------------------

-- Ignore maximize requests

hl.window_rule({
    name = "ignore-maximize",

    match = {
        class = ".*",
    },

    suppress_event = "maximize",
})


-- Fix XWayland dragging issues

hl.window_rule({
    name = "fix-xwayland-drag",

    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})


-------------------------
---- OPTIONAL EXEC -----
-------------------------

-- Restore these if needed:

-- hl.on("hyprland.start", function()
--     hl.exec_cmd("wl-gammarelay")
--     hl.exec_cmd("hyprpaper")
--     hl.exec_cmd("waybar")
-- end)
