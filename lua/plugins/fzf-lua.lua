-- ================================================================================================
-- TITLE : fzf-lua
-- ABOUT : the fuzzy finder — files, grep, buffers, diagnostics and LSP pickers.
-- LINKS :
--   > github : https://github.com/ibhagwan/fzf-lua
-- ================================================================================================

return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		"telescope", -- a familiar, roomy profile
		winopts = {
			height = 0.85,
			width = 0.85,
			row = 0.35,
			border = "rounded",
			preview = {
				default = "bat",
				border = "rounded",
				scrollbar = "float",
				layout = "flex",
			},
		},
		files = {
			cwd_prompt = false,
			-- Honour .gitignore, but still show dotfiles
			fd_opts = [[--color=never --type f --hidden --follow --exclude .git]],
		},
		grep = {
			rg_opts = [[--column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git/']],
		},
	},
	keys = {
		-- Files & buffers
		{ "<leader>ff", "<Cmd>FzfLua files<CR>", desc = "Find files" },
		{ "<leader>fr", "<Cmd>FzfLua oldfiles<CR>", desc = "Recent files" },
		{ "<leader>fb", "<Cmd>FzfLua buffers<CR>", desc = "Buffers" },
		{ "<leader><leader>", "<Cmd>FzfLua files<CR>", desc = "Find files" },

		-- Search
		{ "<leader>fg", "<Cmd>FzfLua live_grep<CR>", desc = "Live grep" },
		{ "<leader>fw", "<Cmd>FzfLua grep_cword<CR>", desc = "Grep word under cursor" },
		{ "<leader>fw", "<Cmd>FzfLua grep_visual<CR>", mode = "v", desc = "Grep selection" },
		{ "<leader>/", "<Cmd>FzfLua lgrep_curbuf<CR>", desc = "Search in current buffer" },

		-- Diagnostics
		{ "<leader>fx", "<Cmd>FzfLua diagnostics_document<CR>", desc = "Document diagnostics" },
		{ "<leader>fX", "<Cmd>FzfLua diagnostics_workspace<CR>", desc = "Workspace diagnostics" },

		-- Git
		{ "<leader>gc", "<Cmd>FzfLua git_commits<CR>", desc = "Git commits" },
		{ "<leader>gb", "<Cmd>FzfLua git_branches<CR>", desc = "Git branches" },
		{ "<leader>gs", "<Cmd>FzfLua git_status<CR>", desc = "Git status" },

		-- Vim internals
		{ "<leader>fh", "<Cmd>FzfLua help_tags<CR>", desc = "Help tags" },
		{ "<leader>fk", "<Cmd>FzfLua keymaps<CR>", desc = "Keymaps" },
		{ "<leader>fc", "<Cmd>FzfLua commands<CR>", desc = "Commands" },
		{ "<leader>f:", "<Cmd>FzfLua command_history<CR>", desc = "Command history" },
		{ "<leader>fR", "<Cmd>FzfLua resume<CR>", desc = "Resume last picker" },
	},
}
