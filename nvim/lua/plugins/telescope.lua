local telescope = require("telescope")
local actions = require('telescope.actions')
local wk = require("which-key")

telescope.setup({
  file_sorter = require'telescope.sorters'.get_fzy_sorter,
  defaults = {
    prompt_prefix = "🔍",
    selection_caret = "> ",
    mappings = {
      i = {
        ["<C-c>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["<C-c>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true
    }
  }
})
wk.register({
  f = {
    name = "telescope",
    f = {"<cmd>lua require('telescope.builtin').find_files()<cr>", "find files"},
    b = {"<cmd>lua require('telescope.builtin').buffers()<cr>", "buffers"},
    g = {"<cmd>lua require('telescope.builtin').live_grep()<cr>", "live grep"},
  },
  g = {
    name = "git",
    c = {"<cmd>lua require('telescope.builtin').git_commits()<cr>", "commits"},
  }
}, { prefix = "<leader>"})

