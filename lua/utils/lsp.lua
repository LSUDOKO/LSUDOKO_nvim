-- ================================================================================================
-- TITLE : LSP utilities
-- ABOUT : buffer-local keymaps and behaviour applied when a language server attaches
-- ================================================================================================

local M = {}

--- Buffer-local LSP keymaps, set on the `LspAttach` event.
--- @param event table the autocmd event table (carries `buf` and `data.client_id`)
--- @return nil
M.on_attach = function(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if not client then
		return
	end

	local bufnr = event.buf

	--- @param mode string|string[]
	--- @param lhs string
	--- @param rhs string|function
	--- @param desc string
	local function map(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, {
			noremap = true,
			silent = true,
			buffer = bufnr,
			desc = "LSP: " .. desc,
		})
	end

	-- Navigation (fzf-lua pickers where a list is useful, native LSP otherwise)
	map("n", "gd", "<Cmd>FzfLua lsp_definitions<CR>", "Goto definition")
	map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
	map("n", "gr", "<Cmd>FzfLua lsp_references<CR>", "References")
	map("n", "gi", "<Cmd>FzfLua lsp_implementations<CR>", "Goto implementation")
	map("n", "gy", "<Cmd>FzfLua lsp_typedefs<CR>", "Goto type definition")
	map("n", "<leader>gS", "<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>", "Goto definition (split)")

	-- Documentation
	map("n", "K", function()
		vim.lsp.buf.hover({ border = "rounded" })
	end, "Hover documentation")
	map({ "n", "i" }, "<C-s>", function()
		vim.lsp.buf.signature_help({ border = "rounded" })
	end, "Signature help")

	-- Refactoring
	map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")

	-- Diagnostics
	map("n", "<leader>D", function()
		vim.diagnostic.open_float({ border = "rounded" })
	end, "Line diagnostics")
	map("n", "[d", function()
		vim.diagnostic.jump({ count = -1, float = true })
	end, "Previous diagnostic")
	map("n", "]d", function()
		vim.diagnostic.jump({ count = 1, float = true })
	end, "Next diagnostic")

	-- Symbols
	map("n", "<leader>fs", "<Cmd>FzfLua lsp_document_symbols<CR>", "Document symbols")
	map("n", "<leader>fS", "<Cmd>FzfLua lsp_live_workspace_symbols<CR>", "Workspace symbols")

	-- Manual format (format-on-save is handled by efm in autocmds.lua)
	map({ "n", "v" }, "<leader>lf", function()
		vim.lsp.buf.format({ async = true })
	end, "Format buffer")

	-- Organise imports, then re-format so the new order is tidy
	if client:supports_method("textDocument/codeAction", bufnr) then
		map("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
			})
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50)
		end, "Organise imports")
	end

	-- Inlay hints, when the server can produce them
	if client:supports_method("textDocument/inlayHint", bufnr) then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		map("n", "<leader>uh", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
		end, "Toggle inlay hints")
	end

	-- Highlight other references to the symbol under the cursor
	if client:supports_method("textDocument/documentHighlight", bufnr) then
		local group = vim.api.nvim_create_augroup("LspDocumentHighlight" .. bufnr, { clear = true })
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = group,
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			group = group,
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

return M
