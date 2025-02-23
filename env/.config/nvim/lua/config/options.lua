-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.winblend = 0
vim.opt.pumblend = 0
vim.opt.termguicolors = true

-- Disable some background colors
local function disable_background()
  vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeFloatNormal", { bg = "NONE", ctermbg = "NONE" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = disable_background,
})

-- Call it initially
disable_background()
