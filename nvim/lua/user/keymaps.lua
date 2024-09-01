M = {}

local opts = { noremap = true, silent = false }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<cr>>", opts)
keymap("n", "<C-Down>", ":resize +2<cr>>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<cr>>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<cr>>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<cr>>", opts)
keymap("n", "<S-h>", ":bprevious<cr>>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<cr>>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<cr>>==gi", opts)

-- Insert --
-- Press jj fast to enter
keymap("i", "jj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<cr>>==", opts)
keymap("v", "<A-k>", ":m .-2<cr>>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<cr>>gv-gv", opts)
keymap("x", "K", ":move '<-2<cr>>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<cr>>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<cr>>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Basic
keymap("n", "<leader><space>", ":nohlsearch<cr>", opts)
-- keymap("n", "<leader>p", ":cp<cr>", opts)
-- keymap("n", "<leader>n", ":cn<cr>", opts)
keymap("n", ";", ":", opts)
keymap("n", "B", "^", opts)
keymap("n", "E", "$", opts)
keymap("", "^", "<Nop>", opts)
keymap("", "$", "<Nop>", opts)
keymap("", "$", "<Nop>", opts)
keymap("n", "Q", "<cmd>bdelete!<cr>>", opts)

M.show_documentation = function()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand "<cword>")
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand "<cword>")
  elseif vim.fn.expand "%:t" == "Cargo.toml" then
    require("crates").show_popup()
  else
    vim.lsp.buf.hover()
  end
end
vim.api.nvim_set_keymap("n", "K", ":lua require('user.keymaps').show_documentation()<cr>>", opts)


-- Formating and code
-- local bufkeymap = vim.api.nvim_buf_set_keymap
-- Use [g and ]g to navigate diagnostic
-- keymap("n", "[g", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<cr>>', opts)
-- keymap("n", "[g", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<cr>>', opts)
-- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]
-- Code navigation
-- working -- keymap("n", "gd", '<cmd>lua vim.lsp.buf.definition()<cr>>', opts)
-- working -- keymap("n", "gy", '<cmd>lua vim.lsp.buf.type_definition()<cr>>', opts)
-- working -- keymap("n", "gi", '<cmd>lua vim.lsp.buf.implementation()<cr>>', opts)
-- working -- keymap("n", "gr", '<cmd>lua vim.lsp.buf.references()<cr>>', opts)
-- working -- -- Signature help
-- working -- keymap("n", "K", '<cmd>lua vim.lsp.buf.hover()<cr>>', opts)
-- working -- keymap("n", "<C-k>", '<cmd>lua vim.lsp.buf.signature_help()<cr>>', opts)
-- diagnostic list
-- working -- keymap("n", "<space>a", '<cmd>lua vim.diagnostic.setloclist()<cr>>', opts)

-- Nvimtree
keymap("n", "<C-n>", ":NvimTreeToggle<cr>", opts)

-- Comment
-- keymap("n", "<leader>c<space>", "<cmd>lua require('Comment.api').toggle.linewise.current(null)<cr>>", opts)
-- keymap("x", "<m-/>", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<cr>>', opts)

-- Hop keyboard
keymap("n", "<leader><leader>w", ":HopWordAC<cr>", opts)
keymap("n", "<leader><leader>f", ":HopChar1AC<cr>", opts)
keymap("n", "<leader><leader>b", ":HopWordBC<cr>", opts)

-- Telescope
keymap("n", "<leader>d", ":Telescope diagnostics<cr>", opts)
keymap("n", "<leader>g", ":Telescope live_grep<cr>", opts)
keymap("n", "<leader>b", ":Telescope buffers<cr>", opts)
keymap("n", "<leader>/", ":Telescope lsp_dynamic_workspace_symbols<cr>", opts)
-- keymap("n", "<leader>c", ":Telescope current_buffer_tags<cr>", opts)
keymap("n", "<leader>c", ":Telescope lsp_document_symbols<cr>", opts)
keymap("n", "<leader>l", ":Telescope current_buffer_fuzzy_find<cr>", opts)
keymap("n", "<leader>s", ":Telescope git_files<cr>", opts)
keymap("n", "<leader>t", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>\\", ":Telescope commands<cr>", opts)
keymap("n", "<leader>a", ":Telescope grep_string<cr>", opts)
keymap("n", "<C-/>", ":Telescope<cr>", opts)
-- keymap("n", "<leader><space>", ":Telescope<cr>", opts)

return M
