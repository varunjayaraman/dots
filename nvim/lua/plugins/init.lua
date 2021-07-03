local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  print "Packer is not loaded, exiting..."
end

packer.startup(function()
  use {"wbthomason/packer.nvim"}
  use { "kyazdani42/nvim-web-devicons" }
  use{
    "glepnir/galaxyline.nvim",
    requires = {{'glepnir/zephyr-nvim'}},
    config = function() 
      require("plugins.statusline") 
    end,
  }

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

  use "folke/lua-dev.nvim"

  use{
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp")
    end,
  }

  use 'kabouzeid/nvim-lspinstall'
  use{"glepnir/lspsaga.nvim"}
  use {"windwp/nvim-autopairs", config = function() require'plugins.autopairs' end }
  use {"folke/which-key.nvim"}
end)
