vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'de'
  end,
  -- group = 'yaml',
  pattern = '*de.yml',
})
vim.api.nvim_create_autocmd('Filetype', {
  callback = function()
    vim.opt_local.foldmethod = 'indent'
  end,
  -- group = 'yaml',
  pattern = 'yaml',
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  callback = function()
    vim.api.nvim_set_option_value('filetype', 'yaml.ansible', { scope = "local" })
  end,
  pattern = {'*/playbooks/*.yml', '*/plays/*.yml', '*/roles/*.yml', '*/inventory/*.yml'},
})


vim.api.nvim_create_autocmd({'BufNewFile','BufRead'}, {
  callback = function()
    vim.opt_local.path = vim.opt_local.path + 'app/javascript/'
    vim.opt_local.isfname = vim.opt_local.isfname + '@-@'
    vim.opt_local.suffixesadd = vim.opt_local.suffixesadd + '.vue,.json,.scss,.svelte,.ts'
  end,
  pattern = {'app/javascript/*.js', 'app/javascript/*.vue', 'app/javascript/*.svelte', 'app/javascript/*.ts'},
})

-- vim.cmd [[
--  au BufNewFile,BufRead app/javascript/*.scss |
--        setl path+=app/javascript/,node_modules |
--        setl suffixesadd+=.css,.scss,.sass |
--        setl isfname+=@-@ |
--        setl inex=substitute(v:fname,'^\\~','','')
-- ]]
vim.api.nvim_create_autocmd({'BufNewFile','BufRead'}, {
  pattern = {'app/javascript/*.scss', 'app/javascript/*.sass'},
  callback = function()
    vim.opt_local.path = vim.opt_local.path + 'app/javascript/'
    vim.opt_local.suffixesadd = vim.opt_local.suffixesadd + '.css,.scss,.sass'
    vim.opt_local.isfname = vim.opt_local.isfname + '@-@'
    vim.opt_local.inex = 'substitute(v:fname,\'^\\~\',\'\',\'\')'
  end,
})

vim.api.nvim_create_autocmd({'BufNewFile','BufRead'}, {
  pattern = {'*/*.lua'},
  callback = function()
    vim.opt_local.path = vim.opt_local.path + 'lua/'
  end,
})

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local wildignore = vim.api.nvim_get_option_value("wildignore", {})
wildignore = "*.exe,*.swp,.DS_Store,*~,*.o,*/tmp/*,*.so,*.swp,*.zip" .. ",*/log/*" ..
  ",*/coverage/*,*/public/system/*"
vim.api.nvim_set_option_value("wildignore", wildignore, {})

vim.api.nvim_exec([[autocmd CmdwinEnter * nnoremap <buffer> <esc> :q<cr>]], true)

-- " Delete every useless whitespace
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    vim.cmd [[%s/\s\+$//e]]
  end,
  pattern = {'*.rb', '*.js', '*.ts', '*.vue', '*.svelte', '*.scss', '*.sass', '*.yml', '*.yaml'},
})

vim.cmd.iabbr('vbase', [[<template lang='pug'>
div
</template>

<script lang='ts'>
import Vue from 'vue'

export default Vue.extend({
  props: {}
})
</script>

<style scoped>
</style>
]])

vim.cmd.iabbr('v3base', [[<template>
<div></div>
</template>

<script lang='ts' setup>
import { ref, computed } from 'vue'

const props = defineProps<{}>()
</script>

<style scoped>
</style>
]])

vim.cmd.iabbr('stimc', [[import { Controller } from "stimulus"

export default class extends Controller {
  static values = {}
  static targets = []

  connect() {
}
}]])


-- " disable syntax highlighting in big files
-- function DisableSyntaxTreesitter()
--     echo("Big file, disabling syntax, treesitter and folding")
--     if exists(':TSBufDisable')
--         exec 'TSBufDisable autotag'
--         exec 'TSBufDisable highlight'
--         " etc...
--     endif
--
--     set foldmethod=manual
--     syntax clear
--     syntax off    " hmmm, which one to use?
--     filetype off
--     set noundofile
--     set noswapfile
--     set noloadplugins
-- endfunction
--
-- augroup BigFileDisable
--     autocmd!
--     " autocmd BufWinEnter * if getfsize(expand("%")) > 512 * 1024 | exec DisableSyntaxTreesitter() | endif
--     autocmd BufReadPre,FileReadPre * if getfsize(expand("%")) > 512 * 1024 | exec DisableSyntaxTreesitter() | endif
--
-- augroup END

-- now in lua:
vim.api.nvim_create_autocmd({'BufReadPre','FileReadPre'}, {
  callback = function()
    if vim.fn.getfsize(vim.fn.expand('%')) > 512 * 1024 then
      print("Big file, disabling syntax, treesitter and folding")
      vim.cmd [[TSBufDisable autotag]]
      vim.cmd [[TSBufDisable highlight]]
      vim.opt.foldmethod = 'manual'
      vim.cmd [[syntax clear]]
      vim.cmd [[syntax off]]
      vim.cmd [[filetype off]]
      vim.opt_local.undofile = false
      vim.opt_local.swapfile = false
      vim.opt_local.loadplugins = false
    end
  end,
})
