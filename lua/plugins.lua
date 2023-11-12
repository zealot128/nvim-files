local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      require "plugins.lspconfig"
    end,
    dependencies = {},
  },
  -- your lsp config or other stuff
  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      require "plugins.nvim-cmp"
    end,
  },
  {
    "feline-nvim/feline.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require "plugins.feline"
    end,
  },

  -- file explorer
  "tpope/vim-vinegar",
  {
    "prichrd/netrw.nvim",
    config = function()
      require("netrw").setup {}
    end,
  },
  "wsdjeg/vim-fetch",
  "tpope/vim-surround",
  "jremmen/vim-ripgrep",
  {
    "github/copilot.vim",
    init = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_filetypes = {
        yaml = 1,
        markdown = 1,
        ["yaml.ansible"] = 1
      }
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
  },
  "tpope/vim-eunuch",
  "tpope/vim-unimpaired",
  "tpope/vim-repeat",
  {
    "tpope/vim-bundler",
    ft = { "ruby" },
  },
  "chaoren/vim-wordmotion",
  "slim-template/vim-slim",
  {
    "lmeijvogel/vim-yaml-helper",
    config = function()
      vim.g["vim_yaml_helper#always_get_root"] = 0
      vim.g["vim_yaml_helper#auto_display_path"] = 0
    end,
    ft = { "yaml", "yaml.ansible" },
  },
  {
    "tpope/vim-rails",
    ft = { "ruby" },
    init = function()
      require "plugins.vim-rails"
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      local colorizer = require "colorizer"
      colorizer.setup({ "*" }, {
        RGB = true,          -- #RGB hex codes
        RRGGBB = true,       -- #RRGGBB hex codes
        names = false,       -- "Name" codes like Blue
        RRGGBBAA = false,    -- #RRGGBBAA hex codes
        rgb_fn = true,       -- CSS rgb() and rgba() functions
        hsl_fn = true,       -- CSS hsl() and hsla() functions
        css = true,          -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false,      -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        mode = "background", -- Set the display mode.
      })
      vim.cmd "ColorizerReloadAllBuffers"
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
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

        status_formatter = nil, --default
        watch_gitdir = {
          interval = 100,
        },
      }
    end,
  },
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.opt.termguicolors = true

      vim.keymap.set("n", "<leader>ig", ":IndentBlanklineToggle<CR>", { noremap = true, desc = "Toggle indent guides" })
      vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

      local highlight = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        -- "Whitespace",
      }
      require("ibl").setup {
        indent = { highlight = highlight, char = "" },
        whitespace = {
          highlight = highlight,
          remove_blankline_trail = false,
        },
        scope = { enabled = false },
      }
    end,
  },
  {
    "sbdchd/neoformat",
    cmd = "Neoformat",
    setup = function()
      -- vim.g.neoformat_verbose = 1
      --bundle exec rubocop
      vim.g.neoformat_ruby_rubocop = {
        exe = 'bundle',
        args = { 'exec rubocop --auto-correct', '--stdin', '"%:p"', '2>/dev/null', '|',
          'sed "1,/^====================$/d"' },
        stdin = 1,
        stderr = 1
      }
    end,
  },
  {
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup()
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      { "nvim-lua/plenary.nvim" },
      { "debugloop/telescope-undo.nvim" },
    },
    config = function()
      require "plugins.telescope"
      require("telescope").load_extension "undo"
      vim.keymap.set("n", "<C-f>", require("telescope.builtin").find_files,
        { noremap = true, silent = true, desc = "Telescope: Find files" })
      vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files,
        { noremap = true, silent = true, desc = "Telescope: Find Files" })
      vim.keymap.set("n", "<C-b>", require('telescope.builtin').buffers, { desc = "Telescope: Find buffers" })

      vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = 'Telescope: [S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Telescope: [S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string,
        { desc = 'Telescope: [S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep,
        { desc = 'Telescope: [S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics,
        { desc = 'Telescope: [S]earch [D]iagnostics' })
      -- See `:help telescope.builtin`
      vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles,
        { desc = 'Telescope: [?] Find recently opened files' })
      vim.keymap.set('n', '<leader>km', require('telescope.builtin').keymaps,
        { desc = 'Telescope keymaps: [K]ey[m]aps [?]' })
      vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers,
        { desc = 'Telescope: [ ] Find existing buffers' })
      vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'Telescope: [/] Fuzzily search in current buffer]' })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    config = function()
      require "plugins.treesitter"
    end,
  },
  {
    "nvim-treesitter/playground",
    after = "nvim-treesitter",
    cmd = "TSPlaygroundToggle",
  },
  { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = "BufRead",
  },
  {
    'ckolkey/ts-node-action',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = "BufRead",
    config = function() -- Optional
      require("ts-node-action").setup({})
      vim.keymap.set({ "n" }, "T", require("ts-node-action").node_action, { desc = "Trigger Node Action" })
    end
  },
  {
    "airblade/vim-rooter",
    config = function()
      vim.g.rooter_patterns =
      { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "ansible.cfg", "*.gemspec" }
      -- Start :Rooter to change Root dir between projects
      vim.g.rooter_manual_only = 1
      vim.keymap.set("n", "<leader>cd", ":Rooter<CR>",
        { noremap = true, silent = true, desc = "Activate Rooter - move Root directory with buffer" })
    end,
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>dif", ":Gdiffsplit<CR>", { noremap = true, silent = true, desc = "Git: Diff split" })
    end
  },
  {
    "martineausimon/nvim-lilypond-suite",
    ft = { "lilypond", "ly" },
  },
  {
    "jayden-chan/base46.nvim",
    config = function()
      --require("base46").load_theme { theme = "catppucin", base = "base46" }
      require("base46").load_theme { theme = "pasteldark", base = "base46" }
    end,
  }

})
