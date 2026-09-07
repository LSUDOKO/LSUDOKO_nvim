-- ================================================================================================
-- TITLE : windsurf.nvim (formerly codeium.nvim)
-- ABOUT : AI completions, surfaced through nvim-cmp rather than as inline ghost text.
-- LINKS :
--   > github : https://github.com/Exafunction/windsurf.nvim
-- ================================================================================================

return {
	"Exafunction/windsurf.nvim",
	event = "InsertEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	opts = {
		enable_chat = false,
	},
	config = function(_, opts)
		require("codeium").setup(opts)
	end,
}
