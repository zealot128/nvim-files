local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

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

  -- Good: duskfox OceanicNext icy
 -- <Theme> ----------------------------------------
  -- use {
  --   "RRethy/nvim-base16",
  --   config = function()
  --     --vim.cmd "colorscheme base16-ayu-dark"
  --     vim.cmd "colorscheme base16-tomorrow-night-eighties"
  --   end,
  -- }
  --use "cpea2506/one_monokai.nvim"
  --use "lourenci/github-colors"
  --use "projekt0n/github-nvim-theme"
  --use "shaunsingh/nord.nvim"
  use 'navarasu/onedark.nvim'
  use "folke/tokyonight.nvim"
  use "EdenEast/nightfox.nvim"
  use "elianiva/icy.nvim"
  use "marko-cerovac/material.nvim"
  use 'themercorp/themer.lua'
  use "mhartington/oceanic-next"
  use {
    "jayden-chan/base46.nvim" ,
    config = function()
      --require("base46").load_theme { theme = "catppucin", base = "base46" }
      require("base46").load_theme { theme = "pasteldark", base = "base46" }
    end,
  }
  -- </Theme> ----------------------------------------

  -- file explorer
  use "tpope/vim-vinegar"
  use {
    "prichrd/netrw.nvim",
    config = function()
      require("netrw").setup {}
    end,
  }

  use "wsdjeg/vim-fetch"
  use "tpope/vim-surround"

  use {
    "jremmen/vim-ripgrep",
  }
  use {
    "github/copilot.vim",
    setup = function()
      vim.g.copilot_no_tab_map = true
      if vim.env.LOGNAME == "swi" then
        vim.g.copilot_node_command = "/home/local/PDC01/swi/.asdf/installs/nodejs/lts-gallium/bin/node"
      end
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

  use {
    "tpope/vim-tbone",
    config = function()
      vim.keymap.set("v", "<leader>ty", ":Tyank<CR>", { desc = "tmux: Yank selection to clipboard" })
      vim.keymap.set("n", "<leader>tp", ":Tput<CR>", {  desc = "tmux: Paste from clipboard" })
    end,
  }
  use "tpope/vim-eunuch"
  use "tpope/vim-unimpaired"
  use "tpope/vim-repeat"
  use "tpope/vim-bundler"
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
  use {  -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      -- require("indent_blankline").setup {
      --   char = '┊',
      -- }
      vim.opt.termguicolors = true

      vim.keymap.set("n", "<leader>ig", ":IndentBlanklineToggle<CR>", { noremap = true, desc = "Toggle indent guides" })

      vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

      require("indent_blankline").setup {
        char = "",
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
        },
        space_char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
        },
        show_trailing_blankline_indent = false,
      }
    end,
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
    setup = function()
      -- vim.g.neoformat_verbose = 1
      -- use bundle exec rubocop
      vim.g.neoformat_ruby_rubocop = {
        exe = 'bundle',
        args = { 'exec rubocop --auto-correct', '--stdin', '"%:p"', '2>/dev/null', '|', 'sed "1,/^====================$/d"' },
        stdin = 1,
        stderr = 1
      }
    end,
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
      { "debugloop/telescope-undo.nvim" },
    },
    config = function()
      require "plugins.telescope"
      require("telescope").load_extension "undo"
      vim.keymap.set("n", "<C-f>", require("telescope.builtin").find_files, { noremap = true, silent = true, desc = "Telescope: Find files" })
      vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files, { noremap = true, silent = true, desc = "Telescope: Find Files" })
      vim.keymap.set("n", "<C-b>", require('telescope.builtin').buffers, { desc = "Telescope: Find buffers" })

      vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = 'Telescope: [S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Telescope: [S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = 'Telescope: [S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = 'Telescope: [S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Telescope: [S]earch [D]iagnostics' })
      -- See `:help telescope.builtin`
      vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = 'Telescope: [?] Find recently opened files' })
      vim.keymap.set('n', '<leader>km', require('telescope.builtin').keymaps, { desc = 'Telescope keymaps: [K]ey[m]aps [?]' })
      vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = 'Telescope: [ ] Find existing buffers' })
      vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'Telescope: [/] Fuzzily search in current buffer]' })
    end,
    setup = function()
    end,
  }
  use {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    config = function()
      require "plugins.treesitter"
    end,
  }
  use {
    "nvim-treesitter/playground",
    after = "nvim-treesitter",
    commands = "TSPlaygroundToggle",
  }
  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  use {
    'ckolkey/ts-node-action',
    after = 'nvim-treesitter',
    config = function() -- Optional
      require("ts-node-action").setup({})
      vim.keymap.set({ "n" }, "T", require("ts-node-action").node_action, { desc = "Trigger Node Action" })
    end
  }
  use {
    "airblade/vim-rooter",
    config = function()
      vim.g.rooter_patterns =
        { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "ansible.cfg", "*.gemspec" }
      -- Start :Rooter to change Root dir between projects
      vim.g.rooter_manual_only = 1
      vim.keymap.set("n", "<leader>cd", ":Rooter<CR>", { noremap = true, silent = true, desc = "Activate Rooter - move Root directory with buffer" })
    end,
  }
  use {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>dif", ":Gdiffsplit<CR>", { noremap = true, silent = true, desc = "Git: Diff split" })
    end

  }
  use {
    "martineausimon/nvim-lilypond-suite",
    ft = { "lilypond", "ly" },
  }

  if is_bootstrap then
    require('packer').sync()
  end
end)

if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

local goodThemes = {
  "themer_catppuccin",
  "themer_javacafe",
  "themer_sakura",
  "themer_jellybeans",
  -- "themer_monokai_pro",
  "themer_nord",
  "OceanicNext",
}

function RandomTheme()
  vim.cmd("set background=dark")

  math.randomseed(os.time())
  local theme = goodThemes[math.random(#goodThemes)]
  vim.cmd('colorscheme ' .. theme)
  -- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75]]
  -- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B]]
  -- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379]]
  -- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2]]
  -- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF]]
  -- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD]]
end
vim.api.nvim_create_user_command('RandomTheme', 'lua RandomTheme()', {})
-- RandomTheme()
-- vim.cmd('colorscheme themer_catppuccin')


