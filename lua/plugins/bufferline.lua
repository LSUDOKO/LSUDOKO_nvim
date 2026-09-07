-- ================================================================================================
-- TITLE : bufferline.nvim
-- ABOUT : open buffers rendered as tabs across the top of the editor.
-- LINKS :
--   > github : https://github.com/akinsho/bufferline.nvim
-- ================================================================================================

return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(_, _, diagnostics)
				local icons = { error = " ", warning = " " }
				local parts = {}
				for level, count in pairs(diagnostics) do
					local icon = level:match("error") and icons.error or icons.warning
					table.insert(parts, icon .. count)
				end
				return table.concat(parts, " ")
			end,
			offsets = {
				{
					filetype = "NvimTree",
					text = "Explorer",
					highlight = "Directory",
					separator = true,
				},
			},
			show_buffer_close_icons = false,
			separator_style = "thin",
			always_show_bufferline = false,
		},
	},
	keys = {
		{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close other buffers" },
		{ "<leader>bP", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin buffer" },
		{ "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Go to buffer 1" },
		{ "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Go to buffer 2" },
		{ "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Go to buffer 3" },
		{ "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Go to buffer 4" },
	},
}
