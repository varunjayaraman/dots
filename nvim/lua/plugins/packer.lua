local register = require("which-key").register

register({
  p = {
    name = "packer",
    c = {"<cmd>:PackerCompile<cr>", "compile"},
    s = {"<cmd>:PackerSync<cr>", "sync"},
    p = {"<cmd>:PackerStatus<cr>", "status"},
  },
}, {prefix = "<Space>"})
