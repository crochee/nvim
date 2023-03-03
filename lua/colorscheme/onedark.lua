local M = {
  -- neovim〉= 0.5的黑暗和光明主题基于Atom One Dark & Atom One Light主题，用lua编写，并使用TreeSitter语法高亮显示
  'navarasu/onedark.nvim',
}

function M.config()
  require('onedark').setup {
    -- style = "dark"
    style = 'darker'
    -- style = 'cool'
    -- style = 'deep'
    -- style = 'warm'
    -- style = 'warmer'
  }
  require('onedark').load()
end

return M
