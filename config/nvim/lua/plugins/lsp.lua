return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.inlay_hints.enabled = true

      opts.servers = vim.tbl_deep_extend("force", opts.servers, {
        clangd = {
          mason = false,
        },
      })
    end,

    -- opts = {
    --   inlay_hints = { enabled = false },
    --   servers = {
    --     clangd = {
    --       mason = false,
    --     },
    --   },
    -- },
  },
}
