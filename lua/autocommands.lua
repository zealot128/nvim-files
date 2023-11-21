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
wildignore = wildignore .. ",*.exe,*.swp,.DS_Store,*~,*.o"
wildignore = wildignore .. ",*/tmp/*,*.so,*.swp,*.zip"
wildignore = wildignore .. ",*/log/*"
wildignore = wildignore .. ",*/coverage/*"
wildignore = wildignore .. ",*/public/system/*" -- Rails images
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

