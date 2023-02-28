-- setting leader key to " "
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 本地变量
local map = vim.keymap.set

local opt = {
  noremap = true,
  silent = true
}

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

------------------------------------------------------------------
-- magic search
map("n", "/", "/\\v", {
  noremap = true,
  silent = false
})
map("v", "/", "/\\v", {
  noremap = true,
  silent = false
})
-- Clean search (highlight)
map("n", "<leader><space>", ":noh<CR>", opt)
-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 在visual mode 里粘贴不要复制
map("v", "p", '"_dP', opt)

------------------------------------------------------------------
-- windows 分屏快捷键
map("n", "<leader>h", ":split<CR>", opt)
map("n", "<leader>v", ":vsplit<CR>", opt)

-- 关闭当前
map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt) -- close others
-- ctrl + hjkl  窗口之间跳转
map("n", "<C-h>", "<C-w>h", opt)
map("n", "<C-j>", "<C-w>j", opt)
map("n", "<C-k>", "<C-w>k", opt)
map("n", "<C-l>", "<C-w>l", opt)

-- 左右比例控制
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
-- 上下比例
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
-- 相等比例
map("n", "s=", "<C-w>=", opt)

--------------------------------------------------------------------

-- 插件快捷键
local pluginKeys = {}

-- nvimTree
map('n', '<F3>', ':NvimTreeToggle<CR>', opt)
-- 列表快捷键
pluginKeys.nvimTreeList = { -- 打开文件或文件夹
  {
    key = { "<CR>", "o", "<2-LeftMouse>" },
    action = "edit"
  }, -- 分屏打开文件
  {
    key = "v",
    action = "vsplit"
  },
  {
    key = "h",
    action = "split"
  }, -- 显示隐藏文件
  {
    key = "i",
    action = "toggle_ignored"
  }, -- Ignore (node_modules)
  {
    key = ".",
    action = "toggle_dotfiles"
  }, -- Hide (dotfiles)
  -- 文件操作
  {
    key = "<F5>",
    action = "refresh"
  },
  {
    key = "a",
    action = "create"
  },
  {
    key = "d",
    action = "remove"
  },
  {
    key = "r",
    action = "rename"
  },
  {
    key = "x",
    action = "cut"
  },
  {
    key = "c",
    action = "copy"
  },
  {
    key = "p",
    action = "paste"
  },
  {
    key = "s",
    action = "system_open"
  }
}

-- bufferline
-- Buffer nav
map("n", "<leader>q", ":BufferLineCyclePrev<CR>", opt)
map("n", "<leader>w", ":BufferLineCycleNext<CR>", opt)
-- Close buffer
map("n", "<leader>c", ":bd<CR>", opt)

-- floating terminal
map('n', '<A-d>', '<CMD>lua require("FTerm").toggle()<CR>', opt)
map('t', '<A-d>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opt)

-- gitsigns
pluginKeys.mapgit = function(mapbuf)
  -- Navigation
  mapbuf('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
  mapbuf('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

  -- Actions
  mapbuf('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
  mapbuf('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
  mapbuf('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
  mapbuf('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
  mapbuf('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
  mapbuf('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
  mapbuf('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
  mapbuf('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
  mapbuf('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
  mapbuf('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
  mapbuf('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
  mapbuf('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
  mapbuf('n', '<leader>td', '<cmd>gitsigns toggle_deleted<cr>')

  -- Text object
  mapbuf('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  mapbuf('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end


-- 代码注释插件 Comment
-- see ./lua/plugin-config/comment.lua
-- ctrl + /
map("n", "<C-_>", "gcc", { noremap = false })
map("v", "<C-_>", "gc", { noremap = false })

-- hop for easy motion
map('n', 'f',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
  , {})
map('n', 'F',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
  , {})
map('n', 't',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
  , {})
map('n', 'T',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
  , {})
map('n', '<leader>d', ':HopChar1<CR>', opt)

-- Telescope
map("n", "<leader>e", ":Telescope find_files<CR>", opt)
map("n", "<leader>f", ":Telescope live_grep<CR>", opt)
map("n", "<leader>b", ":Telescope buffers<CR>", opt)
map("n", "<leader>s", ":Telescope lsp_document_symbols<CR>", opt)
-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",
    ["<C-n>"] = "move_selection_next",
    ["<C-p>"] = "move_selection_previous",
    -- 历史记录
    ["<Down>"] = "cycle_history_next",
    ["<Up>"] = "cycle_history_prev",
    -- 关闭窗口
    -- ["<esc>"] = actions.close,
    ["<C-c>"] = "close",
    -- 预览窗口上下滚动
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down"
  }
}

-- lsp
-- lsp 回调函数快捷键设置
pluginKeys.maplsp = function(mapbuf)
  -- rename
  mapbuf('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)
  -- code action
  mapbuf('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opt)
  -- go xx
  mapbuf('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
  mapbuf('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
  mapbuf('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
  mapbuf('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
  mapbuf('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opt)
  -- diagnostic
  mapbuf('n', 'go', '<cmd>lua vim.diagnostic.open_float()<CR>', opt)
  mapbuf('n', 'gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opt)
  mapbuf('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opt)
  -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- leader + =
  mapbuf('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opt)
  -- mapbuf('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opt)
  -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
  return {
    -- 上一个
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    -- 下一个
    ['<C-j>'] = cmp.mapping.select_next_item(),
    -- 出现补全
    ['<A-.>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    -- 取消
    ['<A-,>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- 确认
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace
    }),
    -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs( -4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  }
end

return pluginKeys
