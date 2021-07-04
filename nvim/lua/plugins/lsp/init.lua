require("plugins.lsp.config")

local vim = vim
local cmd = vim.cmd
local wk = require("which-key")
local lspinstall = require("lspinstall")
local nvim_lsp = require('lspconfig')
local saga = require("lspsaga")
saga.init_lsp_saga()

local on_attach = function(client, bufnr)
  -- local opts = { noremap=true, silent=true }

  wk.register({
    name = "lsp",
    g = {
      name = "go to",
      d = {"<Cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition"},
      D = {"<Cmd>lua vim.lsp.buf.declaration()<CR>", "Peek definition"},
    }
  }, { buffer = bufnr })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspinstall.setup()
local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end

-- Lua
local luadev = require("lua-dev").setup({
  lspconfig = {
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = {
          enable = true,
          globals = {"vim", "use"}
        }
      }
    }
  }
})
nvim_lsp.lua.setup(luadev)

-- Go
function goimports(timeout_ms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/handler.lua) for how to do this properly.
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result or next(result) == nil then return end
  local actions = result[1].result
  if not actions then return end
  local action = actions[1]

  -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
  -- is a CodeAction, it can have either an edit, a command or both. Edits
  -- should be executed first.
  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

nvim_lsp.gopls.setup({
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
cmd('autocmd BufWritePre *.go lua goimports(1000)')

vim.api.nvim_command('nnoremap <silent>K :Lspsaga hover_doc<CR>')
