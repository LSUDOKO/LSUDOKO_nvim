-- ================================================================================================
-- TITLE : mason.nvim
-- ABOUT : installs and manages the language servers, linters and formatters this config expects.
-- LINKS :
--   > github : https://github.com/mason-org/mason.nvim
--   > github : https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
-- ================================================================================================

return {
	{
		"mason-org/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		event = "VeryLazy",
		opts = {
			ensure_installed = {
				-- Language servers
				"bash-language-server",
				"clangd",
				"css-lsp",
				"dockerfile-language-server",
				"emmet-ls",
				"gopls",
				"json-lsp",
				"lua-language-server",
				"pyright",
				"rust-analyzer",
				"tailwindcss-language-server",
				"typescript-language-server",
				"yaml-language-server",

				-- Linters & formatters, driven through efm-langserver
				"black",
				"clang-format",
				"cpplint",
				"efm",
				"eslint_d",
				"fixjson",
				"flake8",
				"gofumpt",
				"hadolint",
				"prettierd",
				"revive",
				"shellcheck",
				"shfmt",
				"stylua",
			},
			run_on_start = false, -- install on demand via :MasonToolsInstall, not on every launch
		},
	},
}
