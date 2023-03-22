-- Save on enter
vim.api.nvim_exec(
[[
  nnoremap <silent><expr> <CR> &buftype is# '' ? ":w\<CR>" : "\<CR>"
]], false)

vim.keymap.set('n', '<leader>fm', ':Neoformat<CR>')
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[LSP]: Open [C]ode [A]ction' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[LSP]: Rename item under cursor' })

local function openDirOfFile()
   local file = vim.fn.resolve(vim.fn.expand "%:h")
   local cmd = ":e " .. file
   print(cmd)

   vim.cmd(cmd)
end
vim.keymap.set('n', '-', openDirOfFile, { desc = 'Open files directory' })


local function CopyRspecForLine()
   local row = vim.fn.line "."
   local file = vim.fn.expand "%"
   local testcommand = "R " .. file .. ":" .. row
   print(testcommand)
   local tmuxcmd = "echo '" .. testcommand .. "' | tmux loadb -"
   local _error = vim.fn.system(tmuxcmd)
   return testcommand
end

local function CopyRealPath()
   local file = vim.fn.resolve(vim.fn.expand "%:p")
   local testcommand = "echo " .. file
   local tmuxcmd = testcommand .. " | tmux loadb -"
   print(file)
   local _error = vim.fn.system(tmuxcmd)
   return testcommand
end
vim.keymap.set('n', '<leader>rr', CopyRspecForLine, { desc = 'Copy [R]spec with `R` spring exec' })
vim.keymap.set('n', '<leader>rp', CopyRealPath, { desc = 'Copy [R]eal [P]ath of current file (real-path)' })

-- map("n", "<F3>", ":nohls<CR>")
-- map("n", "<F2>", ":set invpaste paste?<CR>")
-- map("n", "<F7>", ":ALEFix<CR>")
vim.keymap.set('n', '<Esc>', ":noh <CR>", { desc = 'Clear search highlights' })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)


-- cnoreabbrev W w in lua:
vim.api.nvim_exec(
[[
  cnoreabbrev W w
]], false)
vim.api.nvim_exec(
[[
  cnoreabbrev E e
]], false)


-- check if vim.lsp.buf.formatting is available
if vim.lsp.buf.formatting then
  vim.keymap.set('n', '<leader>ff', vim.lsp.buf.formatting, { desc = '[LSP]: Format buffer' })
end

