local M = {}

M.config = function()
  local npairs = require("nvim-autopairs")
  npairs.setup({
    check_ts = true,
  })
  require("nvim-autopairs.completion.compe").setup({
    map_cr = true, -- map <CR> on insert mode
    map_complete = true, -- auto inserts `(` after function or method
  })
end

return M
