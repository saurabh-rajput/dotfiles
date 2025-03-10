return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>h", group = "hop", icon = { icon = "󰙵 ", color = "cyan" } },
      },
    },
  },
  -- hop
  {
    "smoka7/hop.nvim",
    version = "*",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>hw",
        "<cmd>HopWordAC<cr>",
        desc = "Hop any word after cursor",
      },
      {
        "<leader>hb",
        "<cmd>HopWordBC<cr>",
        desc = "Hop any word before cursor",
      },
      {
        "<leader>hf",
        "<cmd>HopChar1AC<cr>",
        desc = "Hop any word matching pattern after cursor",
      },
      {
        "<leader>hl",
        "<cmd>HopLine<cr>",
        desc = "Hop any line",
      },
      {
        "<leader>hn",
        "<cmd>HopNodes<cr>",
        desc = "Hop any node",
      },
    },

    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
  },
}
