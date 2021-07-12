local register = require("which-key").register

register({
  t = {
    name = "test",
    f = {":TestFile", "file"}
  }
}, { prefix = "<Leader>"})
