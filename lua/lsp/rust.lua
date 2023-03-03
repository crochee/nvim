-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
local util = require('lspconfig/util')
local opts = {
  cmd = { "rust-analyzer" },
  filetyps = { "rust" },
  root_dir = util.root_pattern("Cargo.toml", "rust-project.json"),
  settings = {
        ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "self",
      },
      cargo = {
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      },
    }
  },
  on_attach = require('lsp.utils').on_attach
}

return opts
