return {
  {
    "sbdchd/neoformat",
    cmd = "Neogformat",
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
    end,
  }
}
