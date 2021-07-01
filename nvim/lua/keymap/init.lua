local vim = vim

local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_args = bind.map_args
require('keymap.config')

local keymap = {
  ["i|<TAB>"]      = map_cmd('v:lua.tab_complete()'):with_expr():with_silent(),
  ["i|<S-TAB>"]    = map_cmd('v:lua.s_tab_complete()'):with_silent():with_expr(),

  -- ["n|K"]              = map_cmd("<Cmd>lua vim.lsp.buf.declaration()<CR>"):with_noremap():with_silent(),
  -- Plugin: accelerated-jk
  ["n|j"]              = map_cmd('v:lua.enhance_jk_move("j")'):with_silent():with_expr(),
  ["n|k"]              = map_cmd('v:lua.enhance_jk_move("k")'):with_silent():with_expr(),
}

bind.nvim_load_mapping(keymap)
