local M = {}

M.config = function()
  local lspinstall = require'lspinstall'
  lspinstall.setup()
  local servers = lspinstall.installed_servers()
  local lspconf = require("lspconfig")

  for _, server in pairs(servers) do
    lspconf[server].setup{}
  end

  local luadev = require("lua-dev").setup({
    lspconfig = {
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

  lspconf.lua.setup(luadev)
end

return M
