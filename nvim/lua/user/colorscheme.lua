-- require('onedark').load()
-- vim.cmd [[
-- try
--   colorscheme nord
-- catch /^Vim\%((\a\+)\)\=:E185/
--   colorscheme default
--   set background=dark
-- endtry
-- ]]

local status_ok, onedark = pcall(require, "onedark")
if not status_ok then
  return
end


onedark.setup({
  style = 'warmer'
})
onedark.load()
