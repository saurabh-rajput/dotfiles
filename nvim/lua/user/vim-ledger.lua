vim.cmd [[
  augroup ledgergroup
      autocmd!
      autocmd Filetype journal,ledger setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
  augroup END
]]

local status_ok, ledger = pcall(require, "ledger")
if not status_ok then
  print("vim ledger not found")
  return
end


local opts = {
  ledger_maxwidth = 80,
  ledger_align_at = 60,
  ledger_fillstring = '    -',
}

  -- expandtab = true,                        -- convert tabs to spaces
  -- shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  -- tabstop = 2,                             -- insert 2 spaces for a tab

--ledger.setup(setup)
--ledger.register(mappings, opts)
ledger.register(opts)
