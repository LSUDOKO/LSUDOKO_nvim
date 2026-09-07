-- ================================================================================================
-- TITLE : trouble.nvim
-- ABOUT : a structured, navigable list for diagnostics, references and the quickfix list.
-- LINKS :
--   > github : https://github.com/folke/trouble.nvim
-- ================================================================================================

return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	opts = {
		focus = true,
		win = { border = "rounded" },
	},
	keys = {
		{ "<leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (workspace)" },
		{
			"<leader>xX",
			"<Cmd>Trouble diagnostics toggle filter.buf=0<CR>",
			desc = "Diagnostics (buffer)",
		},
		{
			"<leader>xs",
			"<Cmd>Trouble symbols toggle focus=false<CR>",
			desc = "Symbol outline",
		},
		{ "<leader>xl", "<Cmd>Trouble loclist toggle<CR>", desc = "Location list" },
		{ "<leader>xq", "<Cmd>Trouble qflist toggle<CR>", desc = "Quickfix list" },
	},
}
