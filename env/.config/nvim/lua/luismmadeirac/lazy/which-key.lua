return {
    "folke/which-key.nvim",
    event = "VeryLazy", -- Load plugin efficiently
    opts = {
      -- Optional: configure options here
      -- For example:
      -- window = {
      --   border = "rounded", -- String = 'none' | 'single' | 'double' | 'rounded' | 'solid' | 'shadow'
      -- },
    },
    config = function(_, opts)
      -- Setup the plugin
      require("which-key").setup(opts)
  
      -- Optional: Register keybindings to show with which-key
      -- Example: Register bindings for the '<leader>f' prefix
      -- require("which-key").register({
      --   ["<leader>"] = {
      --     f = { name = "+file", _ = "which_key_ignore" }, -- Define a group named "+file"
      --     -- You can add specific mappings here if they aren't automatically picked up
      --     -- e.g., pf = {"Find File", "which_key_ignore"}, -- Manually add description if needed
      --   },
      --   -- Add other prefixes like 'g', '[', etc. if desired
      -- })
      -- Note: Many plugins like Telescope often register their own keys with which-key,
      -- and which-key automatically picks up standard vim.keymap.set mappings with descriptions.
    end,
}
