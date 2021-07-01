local M = {}
local vim = vim

M.config = function()
  local lspinstall = require'lspinstall'
  lspinstall.setup()
  local servers = lspinstall.installed_servers()
  local lspconf = require("lspconfig")

  --   for _, server in pairs(servers) do
  --   lspconf[server].setup{}
  -- end

  lspconf.lua.setup({
    on_new_config = function(config, root_dir)
      if root_dir == vim.fn.stdpath('config') then
        config.settings = require("lua-dev").setup({
          lspconfig = {
            settings = {
              Lua = {
                diagnostics = {
                  enable = true,
                  globals = {"vim", "use"},
                },
              },
            },
          },
        }).settings
      end
    end,
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
end

return M
