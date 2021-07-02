-------------
-- Aliases --
-------------

local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local map = vim.api.nvim_set_keymap
local o = vim.opt


-- Leader

g.mapleader = ' '

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

local packer = require("packer")
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
    use{"neovim/nvim-lspconfig"}
    use{"glepnir/lspsaga.nvim"}
end)

require("options")
require("plugins.lsp")
