local colors = require "colors"

local icon_styles = {
  default = {
    left = "",
    right = " ",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },
  arrow = {
    left = "",
    right = "",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },

  block = {
    left = " ",
    right = " ",
    main_icon = "   ",
    vi_mode_icon = "  ",
    position_icon = "  ",
  },

  round = {
    left = "",
    right = "",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },

  slant = {
    left = " ",
    right = " ",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },
}
-- statusline style
local user_statusline_style = "default"
local statusline_style = icon_styles[user_statusline_style]
-- show short statusline on small screens
local shortline = false

local mode_colors = {
  ["n"] = { "NORMAL", colors.red },
  ["no"] = { "N-PENDING", colors.red },
  ["i"] = { "INSERT", colors.dark_purple },
  ["ic"] = { "INSERT", colors.dark_purple },
  ["t"] = { "TERMINAL", colors.green },
  ["v"] = { "VISUAL", colors.cyan },
  ["V"] = { "V-LINE", colors.cyan },
  [""] = { "V-BLOCK", colors.cyan },
  ["R"] = { "REPLACE", colors.orange },
  ["Rv"] = { "V-REPLACE", colors.orange },
  ["s"] = { "SELECT", colors.nord_blue },
  ["S"] = { "S-LINE", colors.nord_blue },
  [""] = { "S-BLOCK", colors.nord_blue },
  ["c"] = { "COMMAND", colors.pink },
  ["cv"] = { "COMMAND", colors.pink },
  ["ce"] = { "COMMAND", colors.pink },
  ["r"] = { "PROMPT", colors.teal },
  ["rm"] = { "MORE", colors.teal },
  ["r?"] = { "CONFIRM", colors.teal },
  ["!"] = { "SHELL", colors.green },
}

local chad_mode_hl = function()
  return {
    fg = mode_colors[vim.fn.mode()][2],
    bg = colors.one_bg,
  }
end

local comps = {
  main_icon = {
    provider = statusline_style.main_icon,
    hl = {
      fg = colors.statusline_bg,
      bg = colors.nord_blue,
    },

    right_sep = { str = statusline_style.right, hl = {
      fg = colors.nord_blue,
      bg = colors.lightbg,
    } },
  },
  file = {
    provider = function()
      local path = vim.fn.expand "%"
      local filename = vim.fn.expand "%:t"
      local extension = vim.fn.expand "%:e"
      local icon = require("nvim-web-devicons").get_icon(filename, extension)
      if icon == nil then
        icon = " "
      end
      return " " .. icon .. " " .. path .. " "
    end,
    enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
    end,
    hl = {
      fg = colors.white,
      bg = colors.lightbg,
    },

    right_sep = { str = statusline_style.right, hl = { fg = colors.lightbg, bg = colors.lightbg2 } },
  },

  project = {
    provider = function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      return "  " .. dir_name .. " "
    end,

    enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 80
    end,

    hl = {
      fg = colors.grey_fg2,
      bg = colors.lightbg2,
    },
    right_sep = {
      str = statusline_style.right,
      hi = {
        fg = colors.lightbg2,
        bg = colors.statusline_bg,
      },
    },
  },
  git = {
    added = {
      provider = "git_diff_added",
      hl = {
        fg = colors.grey_fg2,
        bg = colors.statusline_bg,
      },
      icon = " ",
    },
    modified = {
      provider = "git_diff_changed",
      hl = {
        fg = colors.grey_fg2,
        bg = colors.statusline_bg,
      },
      icon = "   ",
    },
    removed = {
      provider = "git_diff_removed",
      hl = {
        fg = colors.grey_fg2,
        bg = colors.statusline_bg,
      },
      icon = "  ",
    },
  },
  diagnostics = {
    errors = {
      provider = "diagnostic_errors",
      enabled = function()
        return vim.diagnostic.severity.ERROR
      end,

      hl = { fg = colors.red },
      icon = "  ",
    },

    warnings = {
      provider = "diagnostic_warnings",
      enabled = function()
        return vim.diagnostic.severity.WARNING
      end,
      hl = { fg = colors.yellow },
      icon = "  ",
    },

    hints = {
      provider = "diagnostic_hints",
      enabled = function()
        return vim.diagnostic.severity.HINT
      end,
      hl = { fg = colors.grey_fg2 },
      icon = "  ",
    },

    info = {
      provider = "diagnostic_info",
      enabled = function()
        return vim.diagnostic.severity.INFO
      end,
      hl = { fg = colors.green },
      icon = "  ",
    },
  },
  lsp = {
    progress = {
      provider = function()
        local Lsp = vim.lsp.util.get_progress_messages()[1]

        if Lsp then
          local msg = Lsp.message or ""
          local percentage = Lsp.percentage or 0
          local title = Lsp.title or ""
          local spinners = {
            "",
            "",
            "",
          }

          local success_icon = {
            "",
            "",
            "",
          }

          local ms = vim.loop.hrtime() / 1000000
          local frame = math.floor(ms / 120) % #spinners

          if percentage >= 70 then
            return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
          end

          return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
        end

        return ""
      end,
      enabled = shortline or function(winid)
        return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 80
      end,
      hl = { fg = colors.green },
    },

    active = {
      provider = "lsp_client_names",
      enabled = shortline or function(winid)
        return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
      end,
      hl = { fg = colors.grey_fg2, bg = colors.statusline_bg },
    },
  },
  branch = {
    provider = "git_branch",
    enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
    end,
    hl = {
      fg = colors.grey_fg2,
      bg = colors.statusline_bg,
    },
    icon = "  ",
  },

  divider = {
    provider = " " .. statusline_style.left,
    hl = {
      fg = colors.one_bg2,
      bg = colors.statusline_bg,
    },
  },
  mode = {
    color = {
      provider = statusline_style.left,
      hl = function()
        return {
          fg = mode_colors[vim.fn.mode()][2],
          bg = colors.one_bg2,
        }
      end,
    },
    icon = {
      provider = statusline_style.vi_mode_icon,
      hl = function()
        return {
          fg = colors.statusline_bg,
          bg = mode_colors[vim.fn.mode()][2],
        }
      end,
    },
  },
  mode_hl = {
    provider = function()
      return " " .. mode_colors[vim.fn.mode()][1] .. " "
    end,
    hl = chad_mode_hl,
  },
  position = {
    color = {
      provider = statusline_style.left,
      enabled = shortline or function(winid)
        return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
      end,
      hl = {
        fg = colors.grey,
        bg = colors.one_bg,
      },
    },
    icon_color = {
      provider = statusline_style.left,
      enabled = shortline or function(winid)
        return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
      end,
      hl = {
        fg = colors.green,
        bg = colors.grey,
      },
    },

    icon = {
      provider = statusline_style.position_icon,
      enabled = shortline or function(winid)
        return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
      end,
      hl = {
        fg = colors.black,
        bg = colors.green,
      },
    },

    percent = {
      provider = function()
        local current_line = vim.fn.line "."
        local total_line = vim.fn.line "$"

        if current_line == 1 then
          return " Top "
        elseif current_line == vim.fn.line "$" then
          return " Bot "
        end
        local result, _ = math.modf((current_line / total_line) * 100)
        return " " .. result .. "%% "
      end,

      enabled = shortline or function(winid)
        return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
      end,

      hl = {
        fg = colors.green,
        bg = colors.one_bg,
      },
    },
    lno = {
      provider = "position",
      left_sep = " ",
      hl = {
        fg = colors.green,
        bg = colors.one_bg,
      },
    },
  },
}

local components = {
  active = {
    {
      comps.main_icon,
      comps.file,
      comps.project,
      comps.git.added,
      comps.git.modified,
      comps.git.removed,
      comps.diagnostics.errors,
      comps.diagnostics.warnings,
      comps.diagnostics.hints,
      comps.diagnostics.info,
    },
    {},
    {
      comps.lsp.progress,
      comps.lsp.active,
      comps.branch,
      comps.divider,
      comps.mode.color,
      comps.mode.icon,
      comps.mode_hl,
      comps.position.color,
      comps.position.icon_color,
      comps.position.icon,
      comps.position.percent,
      comps.position.lno,
    },
  },
  inactive = {
    {
      comps.file,
      comps.project,
    },
  },
}

require("feline").setup {
  colors = {
    bg = colors.statusline_bg,
    fg = colors.fg,
  },
  components = components,
  properties = {
    force_inactive = {
      filetypes = {
        "NvimTree",
        "dbui",
        "packer",
        "startify",
        "fugitive",
        "fugitiveblame",
      },
      buftypes = { "terminal" },
      bufnames = {},
    },
  },
}
