local status_ok, _ = pcall(require, "luasnip")
if not status_ok then
  return
end


require("luasnip.loaders.from_snipmate").lazy_load()
-- Load lua snipmate snippets
