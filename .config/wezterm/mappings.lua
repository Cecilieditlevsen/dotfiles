local wezterm = require("wezterm")
local act = wezterm.action

return {
  leader = { key = "Space", mods = "SHIFT" },

  keys = {
    -- clears the scrollback and viewport leaving the prompt line the new first line.
    {
      key = 'r',
      mods = 'CMD',
      action = act.ClearScrollback 'ScrollbackAndViewport',
    },

    -- add new panes.
    {
      key = "d",
      mods = "CMD",
      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "d",
      mods = "CMD|SHIFT",
      action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
    },

    -- closes current pane
    {
      key = "w",
      mods = "CMD",
      action = act.CloseCurrentPane({ confirm = false }),
    },

    -- focus next pane
    {
      key = "k",
      mods = "CMD",
      action = act.ActivatePaneDirection 'Next'
    },

    -- focus previous pane
    {
      key = "j",
      mods = "CMD",
      action = act.ActivatePaneDirection 'Prev'
    },

    -- resize panes
    { key = "-", mods = "CTRL", action = act.AdjustPaneSize({ "Right", 5 }) },
    { key = "=", mods = "CTRL", action = act.AdjustPaneSize({ "Left", 5 }) },

    -- focus panes by index
    { key = '1', mods = 'CTRL', action = act.ActivatePaneByIndex(0) },
    { key = '2', mods = 'CTRL', action = act.ActivatePaneByIndex(1) },
    { key = '3', mods = 'CTRL', action = act.ActivatePaneByIndex(2) },
  },
}
