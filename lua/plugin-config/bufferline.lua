local M = {
  'akinsho/bufferline.nvim'
}

function M.config()
  vim.opt.termguicolors = true
  require("bufferline").setup {
    options = {
      -- 使用 nvim 内置lsp
      diagnostics = "nvim_lsp",
      -- 左侧让出 nvim-tree 的位置
      offsets = { {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left"
      } },
      -- show_buffer_icons = false,
      -- show_buffer_close_icons = false,
    }
  }
end

return M
