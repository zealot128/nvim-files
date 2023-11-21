return {
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
          prompt_prefix = "   ",
          selection_caret = "  ",
          color_devicons = true,
          use_less = true,
          sort_mru = true,
          entry_prefix = "  ",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
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
        extensions = {
          buffers = {
            buffers = true,
            sort_mru = true,
          },
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          undo = {},
        },
      }
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
}
