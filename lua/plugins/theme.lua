-- ================================================================================================
-- TITLE : nightfox.nvim (duskfox)
-- ABOUT : the colourscheme, loaded before everything else so no window ever paints unstyled.
-- LINKS :
--   > github : https://github.com/EdenEast/nightfox.nvim
--   > github : https://github.com/xiyaowong/nvim-transparent
-- ================================================================================================

return {
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000, -- must load before any other plugin draws
		config = function()
			local palette = require("nightfox.palette").load("duskfox")

			require("nightfox").setup({
				options = {
					transparent = true,
					terminal_colors = true,
					dim_inactive = false,
					styles = {
						comments = "italic",
						keywords = "bold",
						functions = "italic,bold",
					},
				},
				groups = {
					duskfox = {
						-- Visual selection needs a real background to stay legible on a
						-- transparent scheme.
						Visual = { bg = palette.bg1 },
						CursorLine = { bg = palette.bg1 },
						-- Keep floats and the sign column flush with the terminal ground.
						NormalFloat = { bg = "NONE" },
						FloatBorder = { fg = palette.blue.base, bg = "NONE" },
						SignColumn = { bg = "NONE" },
						NvimTreeNormal = { bg = "NONE" },
						NvimTreeWinSeparator = { fg = palette.bg1, bg = "NONE" },
					},
				},
			})

			vim.cmd.colorscheme("duskfox")
		end,
	},

	{
		"xiyaowong/nvim-transparent",
		lazy = false,
		priority = 999,
		opts = {
			extra_groups = {
				"NormalFloat",
				"NvimTreeNormal",
				"NvimTreeNormalNC",
				"TelescopeNormal",
			},
		},
	},
}
