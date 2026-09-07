-- ================================================================================================
-- TITLE : rust_analyzer (Rust Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/rust-lang/rust-analyzer
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("rust_analyzer", {
		capabilities = capabilities,
		filetypes = { "rust" },
		root_markers = { "Cargo.toml", "rust-project.json", ".git" },
		settings = {
			["rust-analyzer"] = {
				cargo = { allFeatures = true },
				checkOnSave = true,
				check = { command = "clippy" },
				inlayHints = {
					bindingModeHints = { enable = false },
					closureReturnTypeHints = { enable = "always" },
					parameterHints = { enable = true },
					typeHints = { enable = true },
				},
			},
		},
	})
end
