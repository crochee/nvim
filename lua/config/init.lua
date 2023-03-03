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

require("config.options")
require("config.keymaps")
require("config.autocmds")
local opts = require("config.lazynvim")

require("lazy").setup({
  -- Lazy can manage itself
  { 'folke/lazy.nvim',         url = "https://github.com/folke/lazy.nvim.git" },
  -- Dependency required by other plugins
  'nvim-lua/plenary.nvim',
  'kyazdani42/nvim-web-devicons',

  -- Edit
  'rafamadriz/friendly-snippets',
  'machakann/vim-sandwich',

  -- lsp
  { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  { 'neovim/nvim-lspconfig' },
  { 'nanotee/sqls.nvim' },

  -- import/override with your plugins
  { import = "plugins" },
}, opts)

-- 每次保存 plugins.lua 自动安装插件
pcall(vim.cmd, [[
augroup lazy_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | Lazy sync
augroup end
]])
