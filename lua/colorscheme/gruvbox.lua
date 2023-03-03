local M = {
  'ellisonleao/gruvbox.nvim'
}

function M.config()
  require('gruvbox').setup()
  vim.o.background = "dark" -- or "light" for light mode
  vim.cmd([[colorscheme gruvbox]])
end

return M
