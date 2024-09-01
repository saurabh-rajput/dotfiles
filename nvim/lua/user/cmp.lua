local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

local function contains(t, value)
	for _, v in pairs(t) do
		if v == value then
			return true
		end
	end
	return false
end

local compare = require("cmp.config.compare")

local check_backspace = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local buffer_fts = {
  "markdown",
  "toml",
  "yaml",
  "json",

}
local icons = require("user.icons")

local kind_icons = icons.kind

vim.g.cmp_active = true

cmp.setup({
	enabled = function()
		local buftype = vim.api.nvim_buf_get_option(0, "buftype")
		if buftype == "prompt" then
			return false
		end
		return vim.g.cmp_active
	end,
	preselect = cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = cmp.mapping.preset.insert({
    -- ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    -- ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-c>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- -- Accept currently selected item. If none selected, `select` first item.
    -- -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = false },
    -- ["<Right>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.jumpable(1) then
        luasnip.jump(1)
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif check_backspace() then
        -- cmp.complete()
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
		-- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
		-- ["<C-f>"] = cmp.mapping.scroll_docs(4),
		-- ["<C-Space>"] = cmp.mapping.complete(),
		-- ["<C-e>"] = cmp.mapping.abort(),
		-- ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	window = {
		-- documentation = false,
		documentation = {
		  border = "rounded",
		  winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
		},
		completion = {
			border = "rounded",
			winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
		},
	},
	sources = {
		{
			name = "nvim_lsp",
			filter = function(entry, ctx)
				local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
				if kind == "Snippet" and ctx.prev_context.filetype == "java" then
					return true
				end

				if kind == "Text" then
					return true
				end
			end,
			group_index = 2,
      max_item_count = 3,
      -- keyword_length = 4,
		},
		{ name = "nvim_lua", group_index = 2 },
		{ name = "luasnip", group_index = 2 },
		{
			name = "buffer",
			group_index = 2,
			filter = function(entry, ctx)
				if not contains(buffer_fts, ctx.prev_context.filetype) then
					return true
				end
			end,
		},
		{ name = "path", group_index = 2 },
		-- { name = "copilot", group_index = 2 },
	},
	sorting = {
		priority_weight = 2,
		comparators = {
			-- require("copilot_cmp.comparators").prioritize,
			-- require("copilot_cmp.comparators").score,
			compare.offset,
			compare.exact,
			-- compare.scopes,
			compare.score,
			compare.recently_used,
			compare.locality,
			-- compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
			-- require("copilot_cmp.comparators").prioritize,
			-- require("copilot_cmp.comparators").score,
		},
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = kind_icons[vim_item.kind]
			-- NOTE: order matters
			vim_item.menu = ({
				nvim_lsp = "LSP",
				nvim_lua = "Lua",
				luasnip = "Snippet",
				buffer = "Buffer",
				path = "Path"
				-- emoji = "",
			})[entry.source.name]
			return vim_item
		end,
	},
})
