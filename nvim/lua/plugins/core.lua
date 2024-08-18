if true then return {} end
return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				clangd = {
					mason = false,
				},
			},
		},
	},
}
