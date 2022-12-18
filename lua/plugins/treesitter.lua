require'nvim-treesitter.configs'.setup {
   ensure_installed = {
      "dockerfile",
      "comment",
      "graphql",
      "bash",
      "hcl",
      "javascript",
      "json",
      "lua",
      "markdown",
      "ruby",
      "scss",
      "typescript",
      "yaml",
   },
   highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = true,
   },
   incremental_selection = {
     enable = true,
     keymaps = {
       init_selection = '<c-space>',
       node_incremental = '<c-space>',
       scope_incremental = '<c-s>',
       node_decremental = '<c-backspace>',
     },
   },
   matchup = {
      enable = false,
   },
   context_commentstring = {
     enable = true
   },
    textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.vue.install_info.url = "https://github.com/zealot128/tree-sitter-vue.git"
-- parser_config.vue.install_info.url = "/home/local/PDC01/swi/OpenSource/tree-sitter-vue"
-- parser_config.vue.install_info.url = "/home/local/PDC01/swi/OpenSource/tree-sitter-vue"
parser_config.pug = {
   install_info = {
      url = "https://github.com/zealot128/tree-sitter-pug", -- local path or git repo
      -- url = "/Users/stefan/LocalProjects/tree-sitter-pug",
      -- url = "/home/local/PDC01/swi/OpenSource/tree-sitter-pug",
      -- url = "https://github.com/zealot128/tree-sitter-pug", -- local path or git repo
      files = { "src/parser.c", "src/scanner.cc" },
   },
   -- filetype = "pug", -- if filetype does not agrees with parser name
   -- used_by = { "vue" }, -- additional filetypes that use this parser
}
