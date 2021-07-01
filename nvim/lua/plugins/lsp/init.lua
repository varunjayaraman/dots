local M = {}

local function on_attach(client, bufnr)
  local lspconf = require("lspconfig")
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

M.config = function()
  local lspinstall = require'lspinstall'
  lspinstall.setup()
  local servers = lspinstall.installed_servers()
  local lspconf = require("lspconfig")

  for _, server in pairs(servers) do
    lspconf[server].setup{}
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- LSP Enable diagnostics
  vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
    signs = true,
    update_in_insert = false
  })

  local luadev = require("lua-dev").setup({
    lspconfig = {
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            enable = true,
            globals = {"vim", "use", "packer_plugins"}
          }
        }
      }
    }
  })

  lspconf.lua.setup(luadev)
  lspconf.gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {"gopls", "serve"},
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        buildFlags = {"-tags=integration"}
      }
    }
  })
end

return M
