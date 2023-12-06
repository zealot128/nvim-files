-- inner line / outer line text objects
vim.keymap.set('o', 'il', ':<c-u>normal! $v^<cr>', { silent = true })
vim.keymap.set('x', 'il', ':<c-u>normal! $v^<cr>', { silent = true })
vim.keymap.set('x', 'al', ':<c-u>normal! $v0<cr>', { silent = true })
vim.keymap.set('o', 'al', ':<c-u>normal! $v0<cr>', { silent = true })

-- inner / outer block text objects
local chars = { '_', '.', ':', ',', ';', '|', '/', '\\', '*', '+', '%', '`', '?' }
for _,char in ipairs(chars) do
  for _,mode in ipairs({ 'x', 'o' }) do
    vim.api.nvim_set_keymap(mode, "i" .. char, string.format(':<C-u>normal! T%svt%s<CR>', char, char, char), { noremap = true, silent = true })
    vim.api.nvim_set_keymap(mode, "a" .. char, string.format(':<C-u>normal! F%svf%s<CR>', char, char, char), { noremap = true, silent = true })
  end
end


