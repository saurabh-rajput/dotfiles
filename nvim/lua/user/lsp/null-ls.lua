local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end


-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/completion
-- local completion = null_ls.builtins.completion

null_ls.setup {
  debug = false,
  sources = {
    -- code_actions.shellcheck
    -- diagnostics.luacheck,
    diagnostics.clang_check,
    -- diagnostics.cmake_lint,
    -- completion.spell,
    -- diagnostics.todo_comments,
    -- diagnostics.write_good,
    -- Formatting
    formatting.clang_format,
    -- formatting.lua_format,
    formatting.cmake_format,
    -- formatting.verible_verilog_format
  }
}
