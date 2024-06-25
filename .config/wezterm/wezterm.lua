local wezterm = require("wezterm")
local mappings = require("mappings")

return {
  -- general
  default_cursor_style = "SteadyBlock",
  color_scheme = "Gruvbox dark, medium (base16)",
  send_composed_key_when_left_alt_is_pressed = false,
  send_composed_key_when_right_alt_is_pressed = true,
  window_close_confirmation = "NeverPrompt",

  -- font
  font = wezterm.font("JetBrains Mono", { weight = "Medium" }),
  font_size = 15,
  line_height = 2.0,

  -- tab bar
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_max_width = 999999,

  -- window
  -- window_background_opacity = 0.93,
  window_decorations = "RESIZE",
  window_padding = {
    left = 38,
    right = 38,
    top = 38,
    bottom = 38,
  },

  -- panes
  inactive_pane_hsb = {
    brightness = 0.80,
  },

  -- key bindings
  leader = mappings.leader,
  keys = mappings.keys,
  key_tables = mappings.key_tables,

  force_reverse_video_cursor = true,

  colors = {
    -- gruvbox tab_bar
    tab_bar = {
      -- The color of the strip that goes along the top of the window
      -- (does not apply when fancy tab bar is in use)
      background = "#282828",
      active_tab = {
        bg_color = "#32302f",
        fg_color = "#d5c4a1",
      },
      inactive_tab = {
        bg_color = "#282828",
        fg_color = "#a89984",
      },
      new_tab = {
        bg_color = "#282828",
        fg_color = "#a89984",
      },
    },
  },
}
