-- nvim/lua/luismmadeirac/lazy/lazygit.lua
return {
    "kdheepak/lazygit.nvim",
    -- Optional dependencies for more features
    dependencies = {
      "nvim-lua/plenary.nvim", -- Useful for some internal operations
      "nvim-telescope/telescope.nvim", -- Optional, for integration with telescope.nvim
      -- "nvim-tree/nvim-web-devicons", -- Optional, for icons
    },
    -- Load the plugin when the LazyGit command is executed or via keymap
    cmd = "LazyGit",
    keys = {
      -- Example keymap: <leader>gg to toggle LazyGit popup
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      -- You can add more keymaps here if needed
    },
    config = function()
      -- Optional configuration can go here if needed,
      -- but often the defaults are fine.
      -- Example: vim.g.lazygit_floating_window_scaling_factor = 0.9
    end,
  }