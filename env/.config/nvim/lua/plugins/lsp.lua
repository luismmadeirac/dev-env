return {
  -- LSP and Programming Tools
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        tsserver = {},
      },
    },
  },

  -- Language Support
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.json" },
}
