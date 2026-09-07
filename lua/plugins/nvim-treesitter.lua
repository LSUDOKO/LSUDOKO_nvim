-- ================================================================================================
-- TITLE : nvim-treesitter
-- ABOUT : treesitter configuration — syntax highlighting, indentation, folds and text objects.
-- NOTE  : pinned to the `master` branch. Upstream has archived `master` in favour of `main`, which
--         is a breaking rewrite with a different setup API. `master` remains stable and is the
--         right place to sit until the `main` rewrite settles; migrating means rewriting this file.
-- LINKS :
--   > github : https://github.com/nvim-treesitter/nvim-treesitter
-- ================================================================================================

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		lazy = false,
		main = "nvim-treesitter.configs",
		opts = {
			-- Parsers that must always be present
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"css",
				"diff",
				"dockerfile",
				"git_config",
				"gitcommit",
				"gitignore",
				"go",
				"gomod",
				"html",
				"javascript",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"rust",
				"solidity",
				"svelte",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"vue",
				"yaml",
			},
			auto_install = true, -- install parsers on demand for new filetypes
			sync_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = "<TAB>",
					node_decremental = "<S-TAB>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
					goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
				},
			},
		},
	},

	-- Function / class / parameter text objects and motions
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "master",
		lazy = false,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},

	-- Keep the enclosing function or class visible at the top of the window
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			max_lines = 3,
			multiline_threshold = 1,
		},
	},
}
