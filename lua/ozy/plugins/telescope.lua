return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      }
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap
    local builtin = require("telescope.builtin")

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set('n', "<leader>fr", function() builtin.oldfiles({ cwd = vim.fn.expand('%:p:h') }) end, { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>f/", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy string in cwd" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set('n', "<leader>fs", builtin.current_buffer_fuzzy_find, { desc = "Find string in current buffer"})
    keymap.set('n', "<C-p>", function() builtin.find_files({ hidden = true, no_ignore = true }) end, {})
    keymap.set('n', "<leader>fb", builtin.buffers, { desc = "Fuzzy find buffers" })

  end,
}
