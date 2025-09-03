return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local actions_layout = require("telescope.actions.layout")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<esc>"] = actions.close,
            ["<C-f>"] = actions_layout.toggle_preview,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "ivy",
          previewer = false
        },
        git_files = {
          theme = "ivy",
          previewer = false
        },
        live_grep = {
          theme = "ivy",
        },
        grep_string = {
          theme = "ivy",
        },
        current_buffer_fuzzy_find = {
          theme = "ivy",
          previewer = false
        },
        oldfiles = {
          theme = "ivy",
          previewer = false
        },
      }
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap
    local builtin = require("telescope.builtin")

    keymap.set("n", "<leader>pf", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set('n', "<leader>fr", function() builtin.oldfiles({ cwd = vim.fn.expand('%:p:h') }) end, { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy string in cwd" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set('n', "<leader>ss", builtin.current_buffer_fuzzy_find, { desc = "Find string in current buffer"})
    keymap.set('n', "<C-p>", function() builtin.find_files({ hidden = true, no_ignore = true }) end, {})
    keymap.set('n', "<leader>fb", builtin.buffers, { desc = "Fuzzy find buffers" })
    keymap.set('n', "<leader>,", builtin.buffers, { desc = "Fuzzy find buffers" })
    keymap.set('n', "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find todos" })
  end,
}
