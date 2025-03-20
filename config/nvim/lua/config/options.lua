-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- do no animate
vim.g.snacks_animate = false

-- Do not hide markup
vim.opt.conceallevel = 0
-- Clipboard make it to system clipboard
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard

-- Enable word wrapping
vim.opt.wrap = true

-- Force python ruff
vim.g.lazyvim_python_ruff = "ruff"
