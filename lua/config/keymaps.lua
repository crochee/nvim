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
--   visual_mode = "v", --v
--   visual_block_mode = "x", -- C_v
--   term_mode = "t",
--   command_mode = "c",

-- 上下左右(kjhl)
------------------------- visual模式下缩进代码-----------

map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

----------------------- 分屏快捷键 ---------------------
-- sv 水平分屏sh 垂直分屏sc 关闭当前分屏 (s = close)so
map("n", "sv", ":vsp<CR>", opt) --水平分屏
map("n", "sh", ":sp<CR>", opt) --垂直分屏
map("n", "sc", "<C-w>c", opt) --关闭当前分屏 (s = close)
map("n", "so", "<C-w>o", opt) --关闭其他分屏 (o = other)
-- alt + hjkl 在窗口之间跳转
map("n", "<C-h>", "<C-w>h", opt)
map("n", "<C-j>", "<C-w>j", opt)
map("n", "<C-k>", "<C-w>k", opt)
map("n", "<C-l>", "<C-w>l", opt)

--------------------------------------------------------------------

-- 插件快捷键
local pluginKeys = {}

-------------------------- nvimTree 目录树插件 ---------------------
map('n', '<leader>ll', ':NvimTreeToggle<CR>', opt)
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

----------------------------------- bufferline --------------
-- Buffer nav
map("n", "<leader>q", ":BufferLineCyclePrev<CR>", opt)
map("n", "<leader>w", ":BufferLineCycleNext<CR>", opt)
-- Close buffer
map("n", "<leader>c", ":bd<CR>", opt)

--------------------------------- hop for easy motion --------------
map('n', 'f',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
  , {})
map('n', 'F',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
  , {})
map('v', 'f',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
  , {})
map('v', 'F',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
  , {})
map('n', 't', "<cmd>HopWord<cr>", {})
map('n', 'T', "<cmd>HopWord<cr>", {})
map('n', '<leader>df', ':HopChar1<CR>', opt)

------------------------------- Telescope  文件搜索 -------------------------
map("n", "<leader>e", ":Telescope find_files<CR>", opt)
map("n", "<leader>f", ":Telescope live_grep<CR>", opt)
map("n", "<leader>b", ":Telescope buffers<CR>", opt)
map("n", "<leader>s", ":Telescope lsp_document_symbols<CR>", opt)
-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ["<C-Down>"] = "move_selection_next",
    ["<C-Up>"] = "move_selection_previous",
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

---------------------- lsp 编程语言设置相关（代码跳转提示等）-------------------
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
  mapbuf('n', '<leader>=', '<cmd>lua vim.lsp.buf.format{ async =true}<CR>', opt)
  -- mapbuf('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opt)
  -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end

-------------------- nvim-cmp 自动补全 --------------------------
pluginKeys.cmp = function(cmp)
  return {
    -- 上一个
    ['<leader>kk'] = cmp.mapping.select_prev_item(),
    -- 下一个
    ['<leader>jj'] = cmp.mapping.select_next_item(),
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

--------------------- floating terminal -----------------------------
-- toggleTerm & Lazygit
map('n', '<leader>gg', '<CMD>lua _LAZYGIT_TOGGLE()<CR>')

----------------------dap debug ------------------------------------
-- Begin
map("n", "<leader>dd", ":lua require('dap').continue()<CR>", opt)
-- Stop
map(
  "n",
  "<leader>de",
  ":lua require'dap'.close()<CR>"
  .. ":lua require'dap'.terminate()<CR>"
  .. ":lua require'dap.repl'.close()<CR>"
  .. ":lua require'dapui'.close()<CR>"
  .. ":lua require('dap').clear_breakpoints()<CR>"
  .. "<C-w>o<CR>",
  opt
)
-- Continue
map("n", "<leader>dc", ":lua require'dap'.continue()<CR>", opt)
-- Set BreakPoint
map("n", "<leader>dt", ":lua require('dap').toggle_breakpoint()<CR>", opt)
map("n", "<leader>dT", ":lua require('dap').clear_breakpoints()<CR>", opt)
--  stepOver, stepOut, stepInto
map("n", "<leader>dj", ":lua require'dap'.step_over()<CR>", opt)
map("n", "<leader>dk", ":lua require'dap'.step_out()<CR>", opt)
map("n", "<leader>dl", ":lua require'dap'.step_into()<CR>", opt)
-- Pop-ups
map("n", "<leader>dh", ":lua require'dapui'.eval()<CR>", opt)

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

return pluginKeys
