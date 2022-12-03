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
   },
   matchup = {
      enable = false,
   },
   context_commentstring = {
     enable = true
   }
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
