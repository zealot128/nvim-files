return {
  {
    'brenoprata10/nvim-highlight-colors',
    event = "BufRead",
    config = function()
      require('nvim-highlight-colors').setup {
        render = 'background', -- 'foreground' | 'background' | 'first_column'
        enable_named_colors = true, -- Enable highlighting of named colors
        enable_tailwind = true, -- Enable highlighting of Tailwind CSS classes
        enable_hsl = true,
        enable_hex_colors = true, -- Enable highlighting of hex colors
        enable_rgb_colors = true, -- Enable highlighting of rgb colors
      }
    end,
  }
  -- {
  --   "norcalli/nvim-colorizer.lua",
  --   event = "BufRead",
  --   config = function()
  --     local colorizer = require "colorizer"
  --     colorizer.setup({ "*" }, {
  --       RGB = true,           -- #RGB hex codes
  --       RRGGBB = true,        -- #RRGGBB hex codes
  --       names = false,        -- "Name" codes like Blue
  --       RRGGBBAA = false,     -- #RRGGBBAA hex codes
  --       rgb_fn = true,        -- CSS rgb() and rgba() functions
  --       hsl_fn = true,        -- CSS hsl() and hsla() functions
  --       css = true,           -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  --       css_fn = false,       -- Enable all CSS *functions*: rgb_fn, hsl_fn
  --       -- Available modes: foreground, background
  --       mode = "background",  -- Set the display mode.
  --     })
  --     vim.cmd "ColorizerReloadAllBuffers"
  --   end,
  -- }
}
