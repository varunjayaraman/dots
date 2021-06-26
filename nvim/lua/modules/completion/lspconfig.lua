local vim = vim
local lspconfig = require 'lspconfig'
local lsp = vim.lsp
local servers = {'sumneko_lua'}


local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach
  }
end
