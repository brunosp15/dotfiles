hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
    master = {
        new_status = "master",
    },
    scrolling = {
        fullscreen_on_one_column = true,
    },
    misc = {
        force_default_wallpaper = -1,  -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
        disable_splash_rendering = true,
    },
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        -- kb_options = "caps:swapescape",
        kb_rules = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})
