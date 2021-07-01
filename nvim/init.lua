local vim = vim

local disable_distribution_plugins = function()
  vim.g.loaded_gzip              = 1
  vim.g.loaded_tar               = 1
  vim.g.loaded_tarPlugin         = 1
  vim.g.loaded_zip               = 1
  vim.g.loaded_zipPlugin         = 1
  vim.g.loaded_getscript         = 1
  vim.g.loaded_getscriptPlugin   = 1
  vim.g.loaded_vimball           = 1
  vim.g.loaded_vimballPlugin     = 1
  vim.g.loaded_matchit           = 1
  vim.g.loaded_matchparen        = 1
  vim.g.loaded_2html_plugin      = 1
  vim.g.loaded_logiPat           = 1
  vim.g.loaded_rrhelper          = 1
  vim.g.loaded_netrw             = 1
  vim.g.loaded_netrwPlugin       = 1
  vim.g.loaded_netrwSettings     = 1
  vim.g.loaded_netrwFileHandlers = 1
end

local function bind_option(options)
	for k, v in pairs(options) do
		if v == true or v == false then
			vim.cmd('set ' .. k)
		else
			vim.cmd('set ' .. k .. '=' .. v)
		end
	end
end

local function load_options()
	local global_local = {
		syntax = 'on';
		termguicolors = true;
		mouse = "nv";
		swapfile = false;
		writebackup = false;
		magic = true;
		history = 2000;
		hidden = true;
		smartcase = true;
		undofile = true;
		undodir = vim.fn.stdpath('config') .. '/undodir';
		completeopt = 'menuone,noinsert,noselect';
		tabstop = 2;
		softtabstop = 2;
		shiftwidth = 2;
		expandtab = true;

	}

	for k, v in pairs(global_local) do
		vim.o[k] = v
	end

	local set_local = {
		autoindent = true;
		smartindent = true;
		number = true;
		wrap = true;
    relativenumber = true;
	}
	bind_option(set_local)
end

local function load_mappings()
  vim.api.nvim_exec([[
  inoremap jk <Esc>
  ]], true)
end

local function load_config()
  disable_distribution_plugins()
  load_options()
  load_mappings()
  require("plugins")
  require("keymap")
end

load_config()
