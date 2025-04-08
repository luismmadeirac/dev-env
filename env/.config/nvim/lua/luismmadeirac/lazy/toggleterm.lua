-- nvim/lua/luismmadeirac/lazy/toggleterm.lua
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    -- Define keymaps with specific sizes
    -- Adjust the size values (e.g., 40, 15, 80) as needed

    -- Floating terminal: size is percentage of screen height (e.g., 40%)
    -- You can also add winwidth=X for percentage width (e.g., winwidth=50)
    { "<leader>tt", "<cmd>ToggleTerm direction=float size=40<cr>", mode = {"n", "t"}, desc = "ToggleTerm (Float 40%)" },

    -- Horizontal terminal: size is number of rows (e.g., 15)
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal size=40<cr>", mode = {"n", "t"}, desc = "ToggleTerm (Horizontal 15 lines)" },

    -- Vertical terminal: size is number of columns (e.g., 80)
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", mode = {"n", "t"}, desc = "ToggleTerm (Vertical 80 cols)" },

    -- Keymap specifically for terminal mode to easily escape back to normal mode
    { "<Esc><Esc>", [[<C-\><C-n>]], mode = "t", desc = "Exit Terminal Mode" },
  },
  opts = {
    -- === Configuration Options ===
    -- This default size is overridden by the keymaps above when used
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = 'float', -- Default direction if just :ToggleTerm is run
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = 'rounded',
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      }
    },
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)
  end
}