-- ================================================================================================
-- TITLE : auto-commands
-- ABOUT : run code automatically on defined events (save, yank, resize, ...)
-- ================================================================================================

local augroup = function(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Restore the last cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_cursor"),
	callback = function(event)
		local exclude = { "gitcommit", "gitrebase" }
		if vim.tbl_contains(exclude, vim.bo[event.buf].filetype) then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
		local lcount = vim.api.nvim_buf_line_count(event.buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Create missing parent directories when writing a new file
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("auto_mkdir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Format on save via efm-langserver.
-- Synchronous on purpose: an async format can resolve after the write has already
-- completed, which silently discards the formatting.
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("format_on_save"),
	callback = function(event)
		if vim.g.disable_autoformat or vim.b[event.buf].disable_autoformat then
			return
		end
		if vim.tbl_isempty(vim.lsp.get_clients({ bufnr = event.buf, name = "efm" })) then
			return
		end
		vim.lsp.buf.format({ name = "efm", bufnr = event.buf, timeout_ms = 2000 })
	end,
})

-- :Format toggling, for the times a file must be committed unformatted
vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, { desc = "Disable format on save (! for current buffer only)", bang = true })

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, { desc = "Re-enable format on save" })

-- Buffer-local LSP keymaps and features
vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup("lsp_attach"),
	callback = require("utils.lsp").on_attach,
})

-- Close throwaway windows with plain `q`
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"checkhealth",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"startuptime",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = event.buf, silent = true })
	end,
})

-- Equalise splits when the terminal window is resized
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup("resize_splits"),
	callback = function()
		local tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. tab)
	end,
})

-- Spell check and soft wrapping for prose
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("prose"),
	pattern = { "gitcommit", "markdown", "text" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
		vim.opt_local.linebreak = true
	end,
})
