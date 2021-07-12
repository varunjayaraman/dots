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
  use {"wbthomason/packer.nvim", config = function() require("plugins.packer") end}

  -- theme
  use {"embark-theme/vim", config = function() vim.cmd [[colorscheme embark]] end}
  use {
    "hoob3rt/lualine.nvim",
    requires = {"kyazdani42/nvim-web-devicons", opt = true},
    config = function() require("plugins.lualine") end,
  }

  -- ui
  use {
    "folke/zen-mode.nvim",
    config = function()
      require("plugins.zen_mode")
    end
  }

  -- files
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function ()
      require("plugins.telescope")
    end
  }
  use {
    "vim-test/vim-test",
    config = function() require("plugins.vim_test") end,
  }

  -- terminal
  use {"kassio/neoterm"}

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

  -- lsp/completion
  use {"hrsh7th/nvim-compe", config = require("plugins.compe").config}
  use "folke/lua-dev.nvim"
  use{"neovim/nvim-lspconfig", config = function() require("plugins.lsp") end}
  use 'kabouzeid/nvim-lspinstall'
  use"glepnir/lspsaga.nvim"
  use {"hrsh7th/vim-vsnip", config = function() require("plugins.vsnip") end}

  -- clojure
  use {"Olical/conjure", tag = 'v4.21.0'}
  use {"guns/vim-sexp"}
  use {"tpope/vim-sexp-mappings-for-regular-people"}

  -- git
  use { 
    'TimUntersberger/neogit', 
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require("plugins.neogit")
    end
  }
end)
