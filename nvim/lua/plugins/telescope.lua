local wk = require("which-key")

print "hello!"
wk.register({
  f = {
    name = "Telescope",
    f = {"<cmd>lua require('telescope.builtin').find_files()<cr>", "Find Files"}
  }
}, { prefix = "<leader>"})

