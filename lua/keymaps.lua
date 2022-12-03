local map = function(mode, keys, cmd, opt)
   local options = { noremap = true, silent = true }
   if opt then
      options = vim.tbl_extend("force", options, opt)
   end

   -- all valid modes allowed for mappings
   -- :h map-modes
   local valid_modes = {
      [""] = true,
      ["n"] = true,
      ["v"] = true,
      ["s"] = true,
      ["x"] = true,
      ["o"] = true,
      ["!"] = true,
      ["i"] = true,
      ["l"] = true,
      ["c"] = true,
      ["t"] = true,
   }

   -- helper function for M.map
   -- can gives multiple modes and keys
   local function map_wrapper(mode, lhs, rhs, options)
      if type(lhs) == "table" then
         for _, key in ipairs(lhs) do
            map_wrapper(mode, key, rhs, options)
         end
      else
         if type(mode) == "table" then
            for _, m in ipairs(mode) do
               map_wrapper(m, lhs, rhs, options)
            end
         else
            if valid_modes[mode] and lhs and rhs then
               vim.api.nvim_set_keymap(mode, lhs, rhs, options)
            else
               mode, lhs, rhs = mode or "", lhs or "", rhs or ""
               print("Cannot set mapping [ mode = '" .. mode .. "' | key = '" .. lhs .. "' | cmd = '" .. rhs .. "' ]")
            end
         end
      end
   end

   map_wrapper(mode, keys, cmd, options)
end

vim.g.mapleader = "\\"
vim.opt.wildignorecase = true
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,full"
vim.opt.gdefault = true
vim.opt.wildignorecase = true
-- Save on enter
vim.api.nvim_exec(
[[
  nnoremap <silent><expr> <CR> &buftype is# '' ? ":w\<CR>" : "\<CR>"
]], false)

map("n", "<leader>fm", ":Neoformat <CR>")
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>'")
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")

function openDirOfFile()
   local file = vim.fn.resolve(vim.fn.expand "%:h")
   local cmd = ":e " .. file
   print(cmd)

   vim.cmd(cmd)
end
map("n", "-", [[<cmd>lua openDirOfFile()<CR>]])


function CopyRspecForLine()
   local row = vim.fn.line "."
   local file = vim.fn.expand "%"
   local testcommand = "R " .. file .. ":" .. row
   print(testcommand)
   local tmuxcmd = "echo '" .. testcommand .. "' | tmux loadb -"
   local _error = vim.fn.system(tmuxcmd)
   return testcommand
end

function CopyRealPath()
   local file = vim.fn.resolve(vim.fn.expand "%:p")
   local testcommand = "echo " .. file
   local tmuxcmd = testcommand .. " | tmux loadb -"
   print(file)
   local _error = vim.fn.system(tmuxcmd)
   return testcommand
end
map("n", "<leader>rr", "<cmd>lua CopyRspecForLine()<CR>")
map("n", "<leader>rp", "<cmd>lua CopyRealPath()<CR>")
map("n", "<F3>", ":nohls<CR>")
map("n", "<F2>", ":set invpaste paste?<CR>")
-- map("n", "<F7>", ":ALEFix<CR>")
map("n", "<C-f>", [[:Telescope find_files<CR>]])
map("n", "<C-p>", [[:Telescope find_files<CR>]])
map("n", "<C-b>", [[:Telescope buffers<CR>]])

map("n", "<Esc>", ":noh <CR>")
