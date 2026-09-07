-- ================================================================================================
-- TITLE : solidity_ls_nomicfoundation (Solidity Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/NomicFoundation/hardhat-vscode
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	-- NOTE: the config name must match the name passed to `vim.lsp.enable` in servers/init.lua.
	vim.lsp.config("solidity_ls_nomicfoundation", {
		capabilities = capabilities,
		cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
		filetypes = { "solidity" },
		root_markers = { "hardhat.config.js", "hardhat.config.ts", "foundry.toml", ".git" },
	})
end
