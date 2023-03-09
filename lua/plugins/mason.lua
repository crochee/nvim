local M = {
  'williamboman/mason.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nanotee/sqls.nvim',
    'b0o/schemastore.nvim',
    ------ lsp
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    -------- dap
    'jayp0521/mason-nvim-dap.nvim',
    'mfussenegger/nvim-dap',
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
    'leoluz/nvim-dap-go',
    'theHamsta/nvim-dap-virtual-text',
    "rcarriga/nvim-dap-ui",

  }
}

function M.config()
  local status, mason = pcall(require, "mason")
  if not status then
    vim.notify("Plugin `mason.nvim` not found")
    return
  end

  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    },
    -- ~/.local/share/nvim/mason
    install_root_dir = vim.fn.stdpath("data") .. "/mason",
  })

  -------------------- LSP Install List
  -- https://github.com/williamboman/nvim-lsp-installer#available-lsps
  -- { key: lsp_name, value: lsp_config }
  local mason_lspconfig
  status, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not status then
    vim.notify("Plugin `mason-lspconfig` not found")
    return
  end

  local lspconfig
  status, lspconfig = pcall(require, "lspconfig")
  if not status then
    vim.notify("Plugin `lspconfig` not found")
    return
  end


  local servers = {
    gopls = require("lsp.gopls"),
    rust_analyzer = require("lsp.rust"),
    lua_ls = require("lsp.lua"),
  }

  local ensure_installed = { type = "list" }
  for name, _ in pairs(servers) do
    table.insert(ensure_installed, name)
  end

  mason_lspconfig.setup({
    ensure_installed = ensure_installed,
    automatic_installation = true,
  })

  -- 加载配置
  for name, config in pairs(servers) do
    lspconfig[name].setup(config)
  end
  -----------------dap Install List ---------------------
  local mason_dap
  status, mason_dap = pcall(require, "mason-nvim-dap")
  if not status then
    vim.notify("Plugin `mason-nvim-dap` not found")
    return
  end

  -- import dap's config
  require("daps.config")
  local list = {
    {
      name = "delve",
      alone = true,
    },
  }

  local handlers = {}
  local alones = {}
  local sources = {}

  for _, ele in pairs(list) do
    table.insert(sources, ele.name)
    if ele.alone then
      table.insert(alones, "daps.configs." .. ele.name)
    else
      handlers[ele.name] = require("daps.configs." .. ele.name)
    end
  end

  -- list the debug dependence that must be installed
  mason_dap.setup({
    ensure_installed = sources,
    automatic_installation = true,
  })

  -- config dap
  mason_dap.setup_handlers(handlers)

  for _, ele in pairs(alones) do
    require(ele)
  end
end

return M
