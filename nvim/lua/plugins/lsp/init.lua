local M = {}
local format = require("plugins.lsp.format")
local api = vim.api


local function on_attach(client, bufnr)
  if client.resolved_capabilities.document_formatting then
    format.lsp_before_save()
  end
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end


M.config = function()
  local lspinstall =  require'lspinstall'
  lspinstall.setup()
  local servers = lspinstall.installed_servers()
  local lspconf = require("lspconfig")

  for _, server in pairs(servers) do
    lspconf[server].setup{}
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- LSP Enable diagnostics
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
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
