-- ================================================================================================
-- TITLE : diagnostics
-- ABOUT : presentation of LSP diagnostics — signs, virtual text and float styling
-- ================================================================================================

local M = {}

local signs = {
	[vim.diagnostic.severity.ERROR] = " ",
	[vim.diagnostic.severity.WARN] = " ",
	[vim.diagnostic.severity.INFO] = " ",
	[vim.diagnostic.severity.HINT] = " ",
}

M.setup = function()
	vim.diagnostic.config({
		signs = { text = signs },
		virtual_text = {
			spacing = 4,
			prefix = "●",
			source = "if_many",
		},
		float = {
			border = "rounded",
			source = "if_many",
			header = "",
			prefix = "",
		},
		underline = true,
		update_in_insert = false,
		severity_sort = true,
	})
end

return M
