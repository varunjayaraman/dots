local config = {}

function config.nvim_treesitter()
  local configs = require'nvim-treesitter.configs'
  configs.setup {
    ensure_installed = "maintained",
    highlight = {
      enable = true
    }
  }
end

return config
