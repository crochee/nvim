local M = {
  -- 背景主题颜色 Everforest是一种基于绿色的配色方案;为了保护开发人员的眼睛，它被设计得温暖而柔软。
  'sainnhe/everforest',
}

function M.config()
  require('everforest').setup()
  vim.cmd [[
  let g:everforest_background = 'soft'
  let g:everforest_better_performace = 1
  colorscheme everforest
]]
end

return M
