-- ================================================================================================
-- TITLE : lualine.nvim
-- LINKS :
--   > github : https://github.com/nvim-lualine/lualine.nvim
-- ABOUT : a fast, configurable statusline written in Lua.
-- ================================================================================================

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = function()
		--- Names of the language servers attached to the current buffer.
		--- @return string
		local function lsp_clients()
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			if #clients == 0 then
				return ""
			end
			local names = vim.tbl_map(function(client)
				return client.name
			end, clients)
			table.sort(names)
			return " " .. table.concat(names, " ")
		end

		return {
			options = {
				theme = "duskfox",
				icons_enabled = true,
				globalstatus = true, -- one statusline for the whole editor, not per split
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "alpha", "NvimTree", "snacks_dashboard" },
				},
			},
			sections = {
				lualine_a = { { "mode", fmt = string.lower } },
				lualine_b = {
					{ "branch", icon = "" },
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
					},
				},
				lualine_c = {
					{ "filename", path = 1, symbols = { modified = " ●", readonly = " " } },
					{
						"diagnostics",
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
					},
				},
				lualine_x = {
					{ lsp_clients, color = { fg = "#a3a1a8" } },
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					"encoding",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			extensions = { "nvim-tree", "lazy", "quickfix", "man", "fzf" },
		}
	end,
}
