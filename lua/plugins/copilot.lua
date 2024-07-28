return {
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
         vim.g.copilot_node_command = "/home/swi/.asdf/installs/nodejs/18.12.1/bin/node"
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
}
