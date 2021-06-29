local editor = {}
local conf = require('modules.editor.config')

editor['Raimondi/delimitMate'] = {
  event = 'InsertEnter',
  config = conf.delimimate,
}

editor['rhysd/accelerated-jk'] = {
  opt = true
}

editor['norcalli/nvim-colorizer.lua'] = {
  ft = { 'html','css','sass','vim','typescript','typescriptreact'},
  config = conf.nvim_colorizer
}

editor['rhysd/vim-operator-surround'] = {
  event = 'BufRead',
  requires = 'kana/vim-operator-user'
}


editor["folke/which-key.nvim"] = {}
return editor
