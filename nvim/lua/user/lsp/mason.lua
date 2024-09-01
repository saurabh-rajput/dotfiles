local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end


local status_ok_1, mc = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

-- REF: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/lua/mason-lspconfig/mappings/server.lua
local servers = {
  "lua_ls",
  "clangd",
  "cmake",
  "pylsp",
  -- "clang-format",
  -- "verible"
  -- "cmake-language-server",
  -- "stylua"
  -- "cmake-language-server",
}


local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)

mc.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }
  lspconfig[server].setup(opts)
  ::continue::
end
