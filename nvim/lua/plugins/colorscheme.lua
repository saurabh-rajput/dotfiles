return {
  {
    -- load new colorscheme
    "navarasu/onedark.nvim",
    opts = {
      -- add your options that should be passed to the setup() function here
      style = "warmer",
    },
    config = function()
      vim.cmd [[colorscheme onedark]]
    end
  },
}
