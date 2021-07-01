local M = {}

M.config = function()
  local ts_config = require("nvim-treesitter.configs")

  ts_config.setup {
    ensure_installed = {
      "javascript",
      "html",
      "css",
      "bash",
      "lua",
      "json",
      "python",
      "ruby",
      "go",
      "rust",
      "clojure",
      "commonlisp",
      "dockerfile",
      "erlang",
      "fennel",
      "graphql",
      "comment",
      "jsdoc",
      "tsx",
      "typescript",
      "yaml",
      "regex"
    },
    highlight = {
      enable = true,
    }
  }
end

return M
