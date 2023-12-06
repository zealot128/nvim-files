local colors = {
  baby_pink = "#fca2aa",
  base00 = "#131a21",
  base01 = "#2c333a",
  base02 = "#31383f",
  base03 = "#40474e",
  base04 = "#4f565d",
  base05 = "#ced4df",
  base06 = "#d3d9e4",
  base07 = "#b5bcc9",
  base08 = "#ef8891",
  base09 = "#EDA685",
  base0A = "#f5d595",
  base0B = "#9ce5c0",
  base0C = "#abb9e0",
  base0D = "#a3b8ef",
  base0E = "#c2a2e3",
  base0F = "#e88e9b",
  black = "#131a21",
  black2 = "#1a2128",
  blue = "#99aee5",
  cyan = "#b5c3ea",
  dark_purple = "#b696d7",
  darker_black = "#10171e",
  folder_bg = "#99aee5",
  green = "#9fe8c3",
  grey = "#363d44",
  grey_fg = "#4e555c",
  grey_fg2 = "#51585f",
  light_grey = "#545b62",
  lightbg = "#222930",
  lightbg2 = "#1d242b",
  line = "#20272e",
  nord_blue = "#9aa8cf",
  one_bg = "#1e252c",
  one_bg2 = "#2a3138",
  one_bg3 = "#363d44",
  orange = "#EDA685",
  pink = "#fca2af",
  pmenu_bg = "#ef8891",
  purple = "#c2a2e3",
  red = "#ef8891",
  statusline_bg = "#181f26",
  sun = "#fbdf9a",
  teal = "#92dbb6",
  vibrant_green = "#9ce5c0",
  white = "#b5bcc9",
  yellow = "#fbdf90"
}
return {
  {
    "jayden-chan/base46.nvim",
    config = function()
      --require("base46").load_theme { theme = "catppucin", base = "base46" }
      require("base46").load_theme { theme = "pasteldark", base = "base46" }
      -- local colors = require("base46").get_colors("base46", "pasteldark")
      vim.api.nvim_set_hl(0, '@type', { fg=colors.red })
    end,
  }
}
