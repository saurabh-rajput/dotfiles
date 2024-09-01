M = {}

-- Add capabilities

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities()
M.capabilities.offsetEncoding = { "utf-16" }
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

M.setup = function()
  local icons = require "user.icons"
  local signs = {

    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end
  local config = {
    -- disable virtual text
    virtual_lines = false,
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "if_many", -- Or "always"
      header = "",
      prefix = "",
      -- width = 40,
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    -- width = 60,
    -- height = 30,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    -- width = 60,
    -- height = 30,
  })
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = false }
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>Telescope lsp_implementations<cr>>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<cr>>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<cr>>", opts)
  -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]]
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-f>", "<cmd>Format<cr>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-a>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<cr>>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<cr>>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<cr>>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<cr>>", opts)


  -- vim.api.nvim_buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  -- vim.api.nvim_buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  -- vim.api.nvim_buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>Telescope lsp_declarations<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>Telescope lsp_definitions<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>Telescope lsp_implementations<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>Telescope lsp_type_definitions<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>[', '<cmd>Telescope lsp_outgoing_calls<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>]', '<cmd>Telescope lsp_incoming_calls<cr>', opts)
  -- --
  -- -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  -- --
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  -- -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
  -- -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
  -- -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
  -- -- vim.api.nvim_buf_set_keymap('n', '<space>la',  "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]]
  vim.cmd [[ command! Fix execute 'lua vim.lsp.buf.code_action()' ]]
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
end

function M.enable_format_on_save()
  vim.cmd [[
    augroup format_on_save
      autocmd! 
      autocmd BufWritePre * lua vim.lsp.buf.format({ async = false }) 
    augroup end
  ]]
  vim.notify "Enabled format on save"
end

function M.disable_format_on_save()
  M.remove_augroup "format_on_save"
  vim.notify "Disabled format on save"
end

function M.toggle_format_on_save()
  if vim.fn.exists "#format_on_save#BufWritePre" == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

function M.remove_augroup(name)
  if vim.fn.exists("#" .. name) == 1 then
    vim.cmd("au! " .. name)
  end
end

vim.cmd [[ command! LspToggleAutoFormat execute 'lua require("user.lsp.handlers").toggle_format_on_save()' ]]

return M
