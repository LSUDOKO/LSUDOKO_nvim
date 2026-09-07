-- ================================================================================================
-- TITLE : todo-comments.nvim
-- ABOUT : highlights TODO, FIXME, HACK, NOTE and friends, and makes them searchable.
-- LINKS :
--   > github : https://github.com/folke/todo-comments.nvim
-- ================================================================================================

return {
	"folke/todo-comments.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = { signs = true },
	keys = {
		{ "<leader>ft", "<Cmd>TodoFzfLua<CR>", desc = "Find TODO comments" },
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next TODO comment",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Previous TODO comment",
		},
	},
}
