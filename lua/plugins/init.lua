return {
  {
    "tpope/vim-tbone",
    config = function()
      vim.keymap.set("v", "<leader>ty", ":Tyank<CR>", { desc = "tmux: Yank selection to clipboard" })
      vim.keymap.set("n", "<leader>tp", ":Tput<CR>", { desc = "tmux: Paste from clipboard" })
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      require("oil").setup({
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
      })
    end,
  },
  "wsdjeg/vim-fetch",
  "tpope/vim-surround",
  {
    "jremmen/vim-ripgrep",
    config = function()
      -- add <leader>rg
      vim.keymap.set("n", "<leader>rg", ":Rg ", { noremap = true, silent = true, desc = "Ripgrep" })
    end,
  },
  {
    "tpope/vim-tbone",
    config = function()
      vim.keymap.set("v", "<leader>ty", ":Tyank<CR>", { desc = "tmux: Yank selection to clipboard" })
      vim.keymap.set("n", "<leader>tp", ":Tput<CR>", { desc = "tmux: Paste from clipboard" })
    end,
  },
  "wsdjeg/vim-fetch",
  "tpope/vim-surround",
  "jremmen/vim-ripgrep",
  "tpope/vim-eunuch",
  "tpope/vim-unimpaired",
  "tpope/vim-repeat",
  {
    "tpope/vim-bundler",
    cmd = "Bopen",
    --ft = { "ruby" },
  },
  "chaoren/vim-wordmotion",
  "slim-template/vim-slim",
  "isobit/vim-caddyfile",
  {
    "lmeijvogel/vim-yaml-helper",
    config = function()
      vim.g["vim_yaml_helper#always_get_root"] = 0
      vim.g["vim_yaml_helper#auto_display_path"] = 0
    end,
    ft = { "yaml", "yaml.ansible" },
  },
  -- {
  --   "terrortylor/nvim-comment",
  --   config = function()
  --     require("nvim_comment").setup()
  --   end,
  -- },
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
  -- {
  --   "martineausimon/nvim-lilypond-suite",
  --   ft = { "lilypond", "ly" },
  -- },
  "tpope/vim-eunuch",
  "tpope/vim-unimpaired",
  "tpope/vim-repeat",
  {
    "tpope/vim-bundler",
    cmd = "Bopen",
    --ft = { "ruby" },
  },
  "chaoren/vim-wordmotion",
  {
    "lmeijvogel/vim-yaml-helper",
    config = function()
      vim.g["vim_yaml_helper#always_get_root"] = 0
      vim.g["vim_yaml_helper#auto_display_path"] = 0
    end,
    ft = { "yaml", "yaml.ansible" },
  },
  {
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup()
    end,
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
  -- {
  --   'MeanderingProgrammer/markdown.nvim',
  --   name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
  --   dependencies = { 'nvim-treesitter/nvim-treesitter' },
  --   config = function()
  --     require('render-markdown').setup({})
  --   end,
  -- },
  {
		"mireq/large_file",
		config = function()
			require("large_file").setup()
		end
	},
  -- {
  --   "martineausimon/nvim-lilypond-suite",
  --   ft = { "lilypond", "ly" },
  -- },
}
