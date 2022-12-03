require("packer").startup(function(use)
  use "wbthomason/packer.nvim" -- Package manager

  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      require "plugins.lspconfig"
    end,
  }

  use { -- Theme
    "RRethy/nvim-base16",
    config = function()
      vim.cmd "colorscheme base16-ayu-dark"
    end,
  }

  use "tpope/vim-vinegar"
  use "wsdjeg/vim-fetch"
  use "tpope/vim-surround"
  use {
    "jremmen/vim-ripgrep",
  }
  use {
    "github/copilot.vim",
    setup = function()
      vim.g.copilot_no_tab_map = true
    end,
    config = function()
      vim.api.nvim_exec(
        [[
      imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
      ]],
        true
      )
    end,
  }

  use "tpope/vim-tbone"
  use "tpope/vim-eunuch"
  use "tpope/vim-unimpaired"
  -- use 'tpope/vim-vinegar'
  use "tpope/vim-repeat"
  use "chaoren/vim-wordmotion"
  use "slim-template/vim-slim"
  use {
    "lmeijvogel/vim-yaml-helper",
    config = function()
      vim.g["vim_yaml_helper#always_get_root"] = 0
      vim.g["vim_yaml_helper#auto_display_path"] = 0
    end,
  }
  use {
    "tpope/vim-rails",
    setup = function()
      require "plugins.vim-rails"
    end,
  }
  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      local colorizer = require "colorizer"
      colorizer.setup({ "*" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn

        -- Available modes: foreground, background
        mode = "background", -- Set the display mode.
      })
      vim.cmd "ColorizerReloadAllBuffers"
    end,
  }
  -- git stuff
  use {
    "lewis6991/gitsigns.nvim",
    opt = true,
    config = function()
      local gitsigns = require "gitsigns"
      gitsigns.setup {
        keymaps = {
          -- Default keymap options
          buffer = true,
          noremap = true,
          ["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
          ["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },
          ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
          ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
          ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
          ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
          ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line()<CR>',
        },
        numhl = false,

        sign_priority = 5,
        signs = {
          add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
          change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
          changedelete = { hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr" },
          delete = { hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr" },
          topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
        },

        status_formatter = nil, -- Use default
        watch_gitdir = {
          interval = 100,
        },
      }
    end,
  }

  use {
    "hrsh7th/nvim-cmp",
    config = function()
      require "plugins.nvim-cmp"
    end,
  }
  use "hrsh7th/cmp-nvim-lua"
  use {
    "hrsh7th/cmp-nvim-lsp",
    after = "cmp-nvim-lua",
  }
  use {
    "hrsh7th/cmp-buffer",
    after = "cmp-nvim-lsp",
  }
  use {
    "kyazdani42/nvim-web-devicons",
  }
  use {
    "feline-nvim/feline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require "plugins.feline"
    end,
  }
  use {
    "sbdchd/neoformat",
    cmd = "Neoformat",
  }
  use {
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup()
    end,
  }
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
      },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      local telescope = require "telescope"
      telescope.setup {
        pickers = {
          find_files = {
            disable_devicons = true,
            previewer = false,
          },
          buffers = {
            disable_devicons = true,
            previewer = false,
          },
          colorscheme = {
            enable_preview = true,
          },
        },
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          file_sorter = require("telescope.sorters").get_fuzzy_file,
          file_ignore_patterns = {},
          generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        },
      }
    end,
    setup = function() end,
  }
  use {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    config = function()
      require "plugins.treesitter"
    end,
  }
  use {
    "airblade/vim-rooter",
    config = function()
      vim.g.rooter_patterns =
        { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "ansible.cfg", "*.gemspec" }
      -- Start :Rooter to change Root dir between projects
      vim.g.rooter_manual_only = 1
    end,
  }
  use {
    "tpope/vim-fugitive",
  }
end)
