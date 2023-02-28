-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
local util = require "lspconfig/util"
local opts = {
  cmd = { "pylsp" },
  filetypes = { "python" },
  root_dir = util.root_pattern(".git"),
  single_file_support = true,
  on_attach = require('lsp.utils').on_attach
}

return opts
