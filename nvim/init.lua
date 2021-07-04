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

require("options")
require("plugins")
require("keymap") -- it's important that this gets required after plugins
