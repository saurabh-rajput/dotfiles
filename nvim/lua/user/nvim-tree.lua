local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local icons = require "user.icons"

-- utils.notify.warn = notify_level(vim.log.levels.WARN)
-- utils.notify.error = notify_level(vim.log.levels.ERROR)
-- utils.notify.info = notify_level(vim.log.levels.INFO)
-- utils.notify.debug = notify_level(vim.log.levels.DEBUG)

nvim_tree.setup {
  hijack_directories = {
    enable = false,
  },
  sort_by = "case_sensitive",
  -- hijack_directories = {
  --   enable = false,
  -- },
  -- on_attach = my_on_attach,
  -- update_to_buf_dir = {
  --   enable = false,
  -- },
  -- disable_netrw = true,
  -- hijack_netrw = true,
  -- open_on_setup = false,
  -- ignore_ft_on_setup = {
  --   "startify",
  --   "dashboard",
  --   "alpha",
  -- },
  filters = {
    enable = true,
    git_ignored = true,
    dotfiles = false,
    custom = { '.git' },
    exclude = { '.github', '.gitignore' },
  },
  update_cwd = false,
  -- auto_close = true,
  -- open_on_tab = false,
  -- hijack_cursor = false,
  -- update_cwd = false,
  -- update_to_buf_dir = {
  --   enable = true,
  --   auto_open = true,
  -- },
  -- --   error
  -- --   info
  -- --   question
  -- --   warning
  -- --   lightbulb
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":t",
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false
      }
    }
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  -- renderer = {
  --   add_trailing = false,
  --   group_empty = false,
  --   highlight_git = false,
  --   highlight_opened_files = "none",
  --   root_folder_modifier = ":t",
  --   indent_markers = {
  --     enable = false,
  --     icons = {
  --       corner = "└ ",
  --       edge = "│ ",
  --       none = "  ",
  --     },
  --   },
  --   icons = {
  --     webdev_colors = true,
  --     git_placement = "before",
  --     padding = " ",
  --     symlink_arrow = " ➛ ",
  --     show = {
  --       file = true,
  --       folder = true,
  --       folder_arrow = true,
  --       git = true,
  --     },
  --     glyphs = {
  --       default = "",
  --       symlink = "",
  --       folder = {
  --         arrow_open = icons.ui.ArrowOpen,
  --         arrow_closed = icons.ui.ArrowClosed,
  --         default = "",
  --         open = "",
  --         empty = "",
  --         empty_open = "",
  --         symlink = "",
  --         symlink_open = "",
  --       },
  --       git = {
  --         unstaged = "",
  --         staged = "S",
  --         unmerged = "",
  --         renamed = "➜",
  --         untracked = "U",
  --         deleted = "",
  --         ignored = "◌",
  --       },
  --     },
  --   },
  -- },
  -- diagnostics = {
  --   enable = true,
  --   icons = {
  --     hint = icons.diagnostics.Hint,
  --     info = icons.diagnostics.Information,
  --     warning = icons.diagnostics.Warning,
  --     error = icons.diagnostics.Error,
  --   },
  -- },
  -- update_focused_file = {
  --   enable = true,
  --   update_cwd = false,
  --   ignore_list = {},
  -- },
  actions = {
    open_file = {
      window_picker = {
        enable = false
      }
    }
  },
  -- system_open = {
  --   cmd = nil,
  --   args = {},
  -- },
  -- filters = {
  --   dotfiles = false,
  --   custom = {},
  -- },
  -- git = {
  --   enable = true,
  --   ignore = true,
  --   timeout = 500,
  -- },
  view = {
    width = 30,
    -- height = 30,
    side = "left",
    -- auto_resize = true,
    -- mappings = {
    --   custom_only = false,
    --   list = {
    --     { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
    --     { key = "h", cb = tree_cb "close_node" },
    --     { key = "v", cb = tree_cb "vsplit" },
    --   },
    -- },
    number = false,
    relativenumber = false,
  },
}
