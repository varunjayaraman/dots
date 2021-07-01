local packer = require("packer")

return packer.startup(function()
  use "wbthomason/packer.nvim"

  use {
    "glepnir/galaxyline.nvim",
    config = function()
      require('plugins.statusline')
    end
  }

  use { 'glepnir/zephyr-nvim', config = [[vim.cmd('colorscheme zephyr')]]}

  use "kyazdani42/nvim-web-devicons"

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufRead",
    config = function()
      require('plugins.treesitter').config()
    end
  }

  use {
    "hrsh7th/nvim-compe",
    config = require("plugins.compe").config
  }

  use "kabouzeid/nvim-lspinstall"

  use "folke/lua-dev.nvim"

  use {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    config = require("plugins.lsp").config,
  }

  use {
     "windwp/nvim-autopairs",
     config = require("plugins.autopairs").config
  }
end)
