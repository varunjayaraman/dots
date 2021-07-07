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
  use "wbthomason/packer.nvim"

  -- theme
  use "kyazdani42/nvim-web-devicons"
  use{
    "glepnir/galaxyline.nvim",
    requires = {{'glepnir/zephyr-nvim'}},
    config = function()
      require("plugins.statusline")
    end,
  }

  -- files
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function ()
      require("plugins.telescope")
    end
  }

  -- editor
  use {"windwp/nvim-autopairs", config = function() require'plugins.autopairs' end}
  use "folke/which-key.nvim"
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    -- event = "BufRead", -- Uncommenting this out causes autopairs to warn that treesitter has to load. See https://github.com/windwp/nvim-autopairs/issues/72
    config = function()
      require('plugins.treesitter').config()
    end
  }

  -- autocompletion
  use {"hrsh7th/nvim-compe", config = require("plugins.compe").config}

  -- lang
  use "folke/lua-dev.nvim"
  use{"neovim/nvim-lspconfig", config = function() require("plugins.lsp") end}
  use 'kabouzeid/nvim-lspinstall'
  use"glepnir/lspsaga.nvim"

  use {"hrsh7th/vim-vsnip", config = function() require("plugins.vsnip") end}

end)
