-- nvim/lua/luismmadeirac/lazy/oil.lua
return {
  'stevearc/oil.nvim',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    default_file_explorer = false,
    columns = {
      "icon",
    },
    view_options = {
      show_hidden = true,
      natural_sort = true,
      sort_dirs_first = true,
    },
    float = {
      max_width = 100,
      max_height = 40,
      border = "rounded",
      win_options = {
        winblend = 10,
      },
    },
    skip_confirm_for_simple_edits = true,
    -- === Add keymaps specific to the oil buffer here ===
    keymaps = {
      -- Close the oil buffer/window when pressing Esc in normal mode
      ["<Esc>"] = {"actions.close", mode = "n"},
      -- Add other oil-specific keymaps if desired, e.g.:
      -- ["<C-h>"] = {"actions.toggle_hidden", mode = "n"}, -- Toggle hidden files
      -- ["g?"] = "actions.show_help",
    },
    -- ==============================================
  },
  config = function(_, opts)
    require('oil').setup(opts)

    -- Keymap to open oil in a float (remains unchanged)
    vim.keymap.set("n", "-", function()
      require("oil").open_float()
    end, { desc = "Open parent directory with oil.nvim (float)" })
  end,
}