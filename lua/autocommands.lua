vim.api.nvim_exec(
   [[
  augroup yaml
    autocmd Filetype yaml set fdm=indent
    autocmd BufRead,BufNewFile *de.yml silent setl spell spelllang=de
  augroup END
]],
   false
)
vim.api.nvim_exec(
   [[
  augroup jsopen
   au BufNewFile,BufRead app/javascript/*.js setl path+=app/javascript/,node_modules
   au BufNewFile,BufRead app/javascript/*.js setl isfname+=@-@
   au BufNewFile,BufRead app/javascript/*.js setl suffixesadd+=.vue,.json,.scss,.svelte,.ts
 augroup END
]],
   false
)

vim.api.nvim_exec(
   [[
  augroup tsopen
   au BufNewFile,BufRead  app/javascript/*.ts  setl path+=app/javascript/,node_modules
   au BufNewFile,BufRead  app/javascript/*.ts  setl isfname+=@-@
   au BufNewFile,BufRead  app/javascript/*.ts  setl suffixesadd+=.vue,.json,.scss,.svelte
 augroup END
]],
   false
)
vim.api.nvim_exec(
   [[
  augroup vueopen
   au BufNewFile,BufRead app/javascript/*.vue setl path+=app/javascript/,node_modules
   au BufNewFile,BufRead app/javascript/*.vue setl isfname+=@-@
   au BufNewFile,BufRead app/javascript/*.vue setl suffixesadd+=.js,.json,.scss,.ts,.vue
 augroup END
]],
   false
)
vim.api.nvim_exec(
   [[
  augroup svelteopen
   au BufNewFile,BufRead app/javascript/*.svelte setl path+=app/javascript/,node_modules
   au BufNewFile,BufRead app/javascript/*.svelte setl isfname+=@-@
   au BufNewFile,BufRead app/javascript/*.svelte setl suffixesadd+=.js,.json,.scss,.ts
 augroup END
]],
   false
)

vim.cmd [[
 au BufNewFile,BufRead app/javascript/*.scss |
       setl path+=app/javascript/,node_modules |
       setl suffixesadd+=.css,.scss,.sass |
       setl isfname+=@-@ |
       setl inex=substitute(v:fname,'^\\~','','')
]]

vim.cmd [[
 au BufNewFile,BufRead */*.lua setl path+=lua
]]

vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

vim.api.nvim_exec(
[[
  set wildignore+=*.exe,*.swp,.DS_Store,*~,*.o
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip
  set wildignore+=*/log/*
  set wildignore+=*/coverage/*
  set wildignore+=*/public/system/*  " Rails images
]], false)
vim.api.nvim_exec([[autocmd CmdwinEnter * nnoremap <buffer> <esc> :q<cr>]], true)
-- " Delete every useless whitespace
vim.api.nvim_exec([[autocmd BufWritePre * :%s/\s\+$//e]], true)
vim.api.nvim_exec([[
  iabbrev vbase <template lang='pug'><CR>div<CR></template><CR><CR><script lang='ts'><CR>import Vue from 'vue'<CR><CR>export default Vue.extend({<CR>props: {}<CR>})<CR></script><CR><style scoped><CR></style>
]], true)
vim.api.nvim_exec([[
  iabbrev v3base <template><CR><div></div><CR></template><CR><CR><script lang='ts' setup><CR>import { ref, computed } from 'vue'<CR><CR>const props = defineProps<{}>()<CR></script><CR><CR><style scoped><CR></style>
]], true)
vim.api.nvim_exec([[
  iabbrev stimc import { Controller } from "stimulus"<CR><CR>export default class extends Controller {<CR>static values = {}<CR>static targets = []<CR><CR>connect() {<CR>}<CR>}
]], true)


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

