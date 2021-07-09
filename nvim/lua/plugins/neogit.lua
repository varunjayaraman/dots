local register = require("which-key").register
local neogit = require("neogit")
neogit.setup{}

register({
  name = "neogit",
  g = {
    g = {"<cmd>:Neogit<cr>", "status"},
    l = {"<cmd>:Neogit log<cr>", "logs"},
    p = {"<cmd>:Neogit push<cr>", "push"}
  }
}, {prefix = "<Space>"})



