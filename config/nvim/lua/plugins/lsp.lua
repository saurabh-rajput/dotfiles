return {
  {
    "neovim/nvim-lspconfig",
    -- opts = function(_, opts)
    --   opts.inlay_hints.enabled = true
    --
    --   opts.servers = vim.tbl_deep_extend("force", opts.servers, {
    --     clangd = {
    --       mason = false,
    --     },
    --   })
    -- end,

    setup = {
      ruff = {
        on_new_config = function(config, root_dir)
          local env = vim.trim(vim.fn.system('cd "' .. root_dir .. '"; poetry env info -p 2>/dev/null'))
          if string.len(env) > 0 then
            config.settings.python.pythonPath = env .. "/bin/python"
          end
        end,
      },
    },

    opts = {
      inlay_hints = { enabled = false },
      servers = {
        clangd = {
          mason = false,
        },
      },
    },
  },
}
