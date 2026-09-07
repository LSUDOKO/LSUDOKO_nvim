-- ================================================================================================
-- TITLE : nvim-lspconfig
-- ABOUT : ships default configurations for the built-in Neovim LSP client. The per-server
--         settings this config layers on top live in `lua/servers/`.
-- LINKS :
--   > github                   : https://github.com/neovim/nvim-lspconfig
--   > efmls-configs-nvim (dep) : https://github.com/creativenull/efmls-configs-nvim
--   > cmp-nvim-lsp (dep)       : https://github.com/hrsh7th/cmp-nvim-lsp
-- ================================================================================================

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"mason-org/mason.nvim", -- LSP/DAP/linter installer & manager
		"creativenull/efmls-configs-nvim", -- preconfigured efm-langserver setups
		"hrsh7th/cmp-nvim-lsp", -- LSP completion capabilities
	},
	config = function()
		require("utils.diagnostics").setup()
		require("servers")
	end,
}
