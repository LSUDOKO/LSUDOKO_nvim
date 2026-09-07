-- ================================================================================================
-- TITLE : mini.nvim
-- ABOUT : a library of small, independent modules. Each is enabled and configured on its own.
-- LINKS :
--   > github : https://github.com/echasnovski/mini.nvim
-- ================================================================================================

return {
	-- Extended and improved `a`/`i` text objects
	{ "echasnovski/mini.ai", version = "*", event = "VeryLazy", opts = {} },

	-- `gc` comment operator, treesitter-aware
	{ "echasnovski/mini.comment", version = "*", event = "VeryLazy", opts = {} },

	-- Move lines and selections with Alt+hjkl
	{ "echasnovski/mini.move", version = "*", event = "VeryLazy", opts = {} },

	-- Add, delete and replace surroundings (`sa`, `sd`, `sr`)
	{ "echasnovski/mini.surround", version = "*", event = "VeryLazy", opts = {} },

	-- Underline other occurrences of the word under the cursor
	{
		"echasnovski/mini.cursorword",
		version = "*",
		event = "VeryLazy",
		opts = { delay = 300 },
	},

	-- Auto-close brackets and quotes
	{ "echasnovski/mini.pairs", version = "*", event = "InsertEnter", opts = {} },

	-- Highlight and trim trailing whitespace
	{ "echasnovski/mini.trailspace", version = "*", event = "VeryLazy", opts = {} },

	-- Delete a buffer without destroying the window layout
	{ "echasnovski/mini.bufremove", version = "*", lazy = true },

	-- Animated indent scope guide
	{
		"echasnovski/mini.indentscope",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			return {
				symbol = "│",
				options = { try_as_border = true },
				draw = {
					delay = 50,
					animation = require("mini.indentscope").gen_animation.none(),
				},
			}
		end,
		init = function()
			-- The guide is noise in these buffers
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"lazy",
					"mason",
					"notify",
					"NvimTree",
					"Trouble",
					"markdown",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	-- Notifications, routed through vim.notify
	{
		"echasnovski/mini.notify",
		version = "*",
		event = "VeryLazy",
		opts = {
			lsp_progress = { enable = true },
			window = { config = { border = "rounded" } },
		},
		config = function(_, opts)
			require("mini.notify").setup(opts)
			vim.notify = require("mini.notify").make_notify()
		end,
	},
}
