local nvim_lsp = require('lspconfig')
local saga = require("lspsaga")
saga.init_lsp_saga()


local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end  -- Mappings.
  local opts = { noremap=true, silent=true }  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --...
end

nvim_lsp.tsserver.setup {on_attach = on_attach}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

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

vim.api.nvim_command('nnoremap <silent>K :Lspsaga hover_doc<CR>')
