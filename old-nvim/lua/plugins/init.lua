local packer = require("packer")

return packer.startup(function()
  use {"wbthomason/packer.nvim"}
  use "glepnir/galaxyline.nvim"
  use {'glepnir/zephyr-nvim', config = [[vim.cmd('colorscheme zephyr')]]}
  use "kyazdani42/nvim-web-devicons"
  use "norcalli/nvim-colorizer.lua"
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufRead",
    config = function()
      require('plugins.treesitter').config()
    end
  }

  
  -- load compe in insert mode only
  use {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    config = function()
      require("compe").config()
    end
  }

  use "kabouzeid/nvim-lspinstall"

  use {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    config = function()
      require("dots_lsp_config").config()
    end
  }
end)
