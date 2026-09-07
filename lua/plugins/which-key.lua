-- ================================================================================================
-- TITLE : which-key.nvim
-- ABOUT : shows the available keybindings as you type a prefix.
-- LINKS :
--   > github : https://github.com/folke/which-key.nvim
-- ================================================================================================

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		win = { border = "rounded" },
		-- Names for the leader-key groups, so the popup reads as a menu rather than a key dump.
		spec = {
			{ "<leader>b", group = "buffer" },
			{ "<leader>c", group = "code" },
			{ "<leader>d", group = "diagnostics" },
			{ "<leader>f", group = "find" },
			{ "<leader>g", group = "goto" },
			{ "<leader>h", group = "git hunk" },
			{ "<leader>l", group = "lsp" },
			{ "<leader>s", group = "split" },
			{ "<leader>u", group = "toggle" },
			{ "<leader>x", group = "quickfix" },
			{ "[", group = "previous" },
			{ "]", group = "next" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer local keymaps (which-key)",
		},
	},
}
