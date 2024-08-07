return {
  {
    -- load new colorscheme
    "navarasu/onedark.nvim",
    opts = {
      -- add your options that should be passed to the setup() function here
      style = "warmer",
    },
  },
  {
    -- change the default color scheme to new loaded scheme
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
