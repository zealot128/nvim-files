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
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    undo = {},
  },
}
