local vim = vim

local function load_mappings()
  vim.api.nvim_exec([[
  inoremap jk <Esc>
  ]], true)
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
    undofile = true;
    undodir = vim.fn.stdpath('config') .. '/undodir';
    completeopt = 'menuone,noinsert,noselect';
    tabstop = 2;
    softtabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    smartcase = true;
    relativenumber = false;
    clipboard = 'unnamedplus'
  }

  for k, v in pairs(global_local) do
    vim.o[k] = v
  end

  local set_local = {
    autoindent = true;
    smartindent = true;
    number = true;
    wrap = true;
  }
  bind_option(set_local)
end


load_options()
load_mappings()
