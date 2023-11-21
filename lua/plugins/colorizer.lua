return {
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      local colorizer = require "colorizer"
      colorizer.setup({ "*" }, {
        RGB = true,           -- #RGB hex codes
        RRGGBB = true,        -- #RRGGBB hex codes
        names = false,        -- "Name" codes like Blue
        RRGGBBAA = false,     -- #RRGGBBAA hex codes
        rgb_fn = true,        -- CSS rgb() and rgba() functions
        hsl_fn = true,        -- CSS hsl() and hsla() functions
        css = true,           -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false,       -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        mode = "background",  -- Set the display mode.
      })
      vim.cmd "ColorizerReloadAllBuffers"
    end,
  }
}
