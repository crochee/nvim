local status, mason_settings = pcall(require, "mason.settings")
if not status then
  vim.notify("not found mason.settings")
  return
end

local M = {}

M.mason_module_dir = mason_settings.current.install_root_dir

return M
