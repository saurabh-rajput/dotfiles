return {
  {
    "folke/snacks.nvim",
    opts = {
      scroll = { enabled = false },
      animate = { enabled = false },
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    opts = function(_, opts)
      table.insert(opts.prompt_func_return_type, {
        python = true,
      })
      table.insert(opts.prompt_func_param_type, {
        python = true,
      })
    end,
  },
}
