local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- Utilities
  -- Telescope similar to command-t
  use "nvim-lua/plenary.nvim"
  use {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x"
  }
  -- Syntax/Treesitter
  use "nvim-treesitter/nvim-treesitter"


  -- LSP
  use "williamboman/mason.nvim"         -- Installation of lsp servers and daps
  use "williamboman/mason-lspconfig.nvim"
  use "neovim/nvim-lspconfig"           -- enable LSP
  use "jose-elias-alvarez/null-ls.nvim" -- Formatting and Linting
  use "simrat39/symbols-outline.nvim"
  use "ray-x/lsp_signature.nvim"        -- lsp signature while typing
  -- Refactorying
  use "ThePrimeagen/refactoring.nvim"
  --
  -- Autocompletion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- Snippets
  use({ "L3MON4D3/LuaSnip", tag = "v1.0.0" })
  use "honza/vim-snippets"
  use "saadparwaiz1/cmp_luasnip" -- snippet completions

  -- Indent
  -- use "lukas-reineke/indent-blankline.nvim"

  -- File Explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
  }

  -- Tests
  use "vim-test/vim-test"

  -- Comment
  use "numToStr/Comment.nvim"

  -- Terminal
  use "akinsho/toggleterm.nvim"

  -- Editing Support
  use "windwp/nvim-autopairs"

  -- Motion
  use {
    "phaazon/hop.nvim",
    branch = 'v2'
  }

  -- Keybinding
  use "folke/which-key.nvim"

  -- Colorschemes
  use "navarasu/onedark.nvim"

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
