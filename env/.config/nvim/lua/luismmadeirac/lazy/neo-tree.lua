-- nvim/lua/luismmadeirac/lazy/neo-tree.lua
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    -- Add other dependencies if needed (like colorscheme integration example from before)
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", function()
        -- Add position = "left" (or "right", "float" if you prefer)
        require("neo-tree.command").execute({
          toggle = true,
          source = "filesystem",
          position = "left" -- Specify the position
        })
      end, desc = "Explorer NeoTree (Filesystem)"
    },
    { "<leader>E", function()
        -- Also specify position for reveal if desired, ensures consistency
        require("neo-tree.command").execute({
          reveal = true,
          source = "filesystem",
          position = "left" -- Specify the position
        })
      end, desc = "Explorer NeoTree (Reveal File)"
    },
    -- Add other keymaps as needed
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    default_component_configs = {
      -- Your component configs (icons, indent, etc.) here
      indent = { indent_size = 2, padding = 1 },
      icon = { folder_closed = "", folder_open = "", folder_empty = "", default = "" },
      modified = { symbol = "●" },
      name = { trailing_slash = false, use_git_status_colors = true },
      git_status = { symbols = { added = "✚", modified = "●", deleted = "✖", renamed = "➜", untracked = "★", ignored = "☂", unstaged = "△", staged = "✓", conflict = "≠"}},
    },
    window = {
      position = "left", -- Make sure this matches the position in the keymap command
      width = 30,
      mapping_options = { noremap = true, nowait = true },
      mappings = {
        ["<Esc>"] = "close_window",
        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
        -- Add other mappings
      }
    },
    filesystem = {
      filtered_items = { visible = false, hide_dotfiles = false, hide_gitignored = false, hide_hidden = false, never_show = { ".DS_Store", "thumbs.db" }},
      follow_current_file = { enabled = true },
      group_empty_dirs = false,
      hijack_netrw_behavior = "open_default",
    },
    -- Add other source configs (buffers, git_status) if needed
  }
}