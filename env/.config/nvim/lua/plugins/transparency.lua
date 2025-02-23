return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine-moon",
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      disable_background = true,
      disable_float_background = true,
      styles = {
        transparency = true,
      },
    },
  },
}
