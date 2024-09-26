return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      clangd = {
        mason = false,
      },
      mesonlsp = {
        mason = false,
      },
    },
  },
}
