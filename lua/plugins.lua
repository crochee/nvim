-- 插件安装目录
-- ~/.local/share/nvim/lazy/lazy.nvim
-- 自动安装 Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = require("config")

require("lazy").setup({
  -- Lazy can manage itself
  'folke/lazy.nvim',

  -- Dependency required by other plugins
  'nvim-lua/plenary.nvim',
  'kyazdani42/nvim-web-devicons',

  -------------------- Colorscheme ---------------------
  -- neovim〉= 0.5的黑暗和光明主题基于Atom One Dark & Atom One Light主题，用lua编写，并使用TreeSitter语法高亮显示
  'navarasu/onedark.nvim',
  -- 背景主题颜色 Everforest是一种基于绿色的配色方案;为了保护开发人员的眼睛，它被设计得温暖而柔软。
  'sainnhe/everforest',
  'ellisonleao/gruvbox.nvim',

  ------------------- UI ------------------------------
  -- 目录树 
  require('plugin-config.nvim-tree'),
  require('plugin-config.bufferline'),
  require('plugin-config.lualine'),
  "numToStr/FTerm.nvim",
  'kevinhwang91/nvim-bqf',

  ------------ Edit -------------------
  require('plugin-config.nvim-autopairs'),
  require('plugin-config.comment'),
  -- 在编辑时去除尾随空格
  require('plugin-config.spaceless'),
  'hrsh7th/vim-vsnip',
  'rafamadriz/friendly-snippets',
  'machakann/vim-sandwich',
  require('plugin-config.hop'),

  -- Git
  require('plugin-config.gitsigns'),

  -- Fuzzy Search
  require('plugin-config.telescope'),

  -- treesitter
  require('plugin-config.nvim-treesitter'),

  -- LSP
  { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  { 'neovim/nvim-lspconfig' },
  { 'nanotee/sqls.nvim' },

  -- Autocomplete
  require('plugin-config.nvim-cmp'),
  'hrsh7th/cmp-vsnip',

  -- floating terminal
  require('plugin-config.toggleterm'),

}, opts)

-- 每次保存 plugins.lua 自动安装插件
pcall(vim.cmd, [[
augroup lazy_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | Lazy sync
augroup end
]])
