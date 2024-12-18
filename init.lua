vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.completeopt = "menuone,noselect"
vim.opt.autoread = true
vim.opt.wrap = true
vim.opt.includeexpr = [[substitute(v:fname, '^[/\~@]\+', '', '')]]
vim.opt.cmdheight = 1
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.foldlevelstart = 5
vim.g.mapleader = "\\"
vim.g.mapleader = " "
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,full"
vim.opt.gdefault = true
vim.opt.wildignorecase = true

-- set signcolumn=yes
vim.opt.signcolumn = "yes"

vim.opt.mouse = ""

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
require("components.keymaps")
require("components.autocommands")
require("components.text-objects")
require("components.clipboard")
