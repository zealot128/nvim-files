return {
  {   -- Add indentation guides even on blank lines
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
        exclude = { filetypes = { "ruby", "javascript" } },
        whitespace = {
          highlight = highlight,
          remove_blankline_trail = false,
        },
        scope = { enabled = false },
      }
    end,
  }
}
