return {
  {
    "sbdchd/neoformat",
    cmd = "Neoformat",
    init = function()
      -- vim.g.neoformat_verbose = 1
      --bundle exec rubocop
      vim.g.neoformat_ruby_rubocop = {
        exe = 'bundle',
        args = { 'exec rubocop --auto-correct', '--stdin', '"%:p"', '2>/dev/null', '|',
          'sed "1,/^====================$/d"' },
        stdin = 1,
        stderr = 1
      }

      vim.g.neoformat_enabled_eruby = { "erbformat", "htmlbeautifier" }
      vim.g.neoformat_eruby_erbformat = { exe = "erb-format", args = { "--stdin" }, stdin = 1 }
      vim.g.neoformat_eruby_htmlbeautifier = { exe = "htmlbeautifier", args = { "--keep-blank-lines", '1' }, stdin = 1 }
    end,
  }
}
