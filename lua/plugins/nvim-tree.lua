-- ================================================================================================
-- TITLE : nvim-tree.lua
-- ABOUT : the file explorer sidebar.
-- LINKS :
--   > github : https://github.com/nvim-tree/nvim-tree.lua
-- ================================================================================================

return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		hijack_cursor = true,
		sync_root_with_cwd = true,
		view = {
			width = 34,
			preserve_window_proportions = true,
		},
		renderer = {
			root_folder_label = false,
			highlight_git = true,
			indent_markers = { enable = true },
			icons = {
				glyphs = {
					default = "",
					git = {
						unstaged = "",
						staged = "",
						unmerged = "",
						renamed = "",
						untracked = "",
						deleted = "",
						ignored = "",
					},
				},
			},
		},
		filters = {
			dotfiles = false, -- show hidden files
			custom = { "^\\.git$", "^node_modules$", "^\\.cache$" },
		},
		git = { enable = true, ignore = false },
		diagnostics = {
			enable = true,
			show_on_dirs = true,
			icons = { hint = "", info = "", warning = "", error = "" },
		},
		actions = {
			open_file = {
				quit_on_open = false,
				window_picker = { enable = true },
			},
		},
		update_focused_file = {
			enable = true,
			update_root = false,
		},
	},
}
