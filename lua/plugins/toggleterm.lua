-- ================================================================================================
-- TITLE : toggleterm.nvim
-- ABOUT : persistent, toggleable terminals — floating, split, or as a lazygit window.
-- LINKS :
--   > github : https://github.com/akinsho/toggleterm.nvim
-- ================================================================================================

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = { "ToggleTerm", "TermExec" },
	opts = {
		open_mapping = [[<C-\>]], -- Ctrl+\ toggles the last-used terminal from anywhere
		direction = "float",
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return math.floor(vim.o.columns * 0.4)
			end
		end,
		float_opts = {
			border = "rounded",
			winblend = 0,
		},
		shade_terminals = false, -- keep the transparent theme intact
		start_in_insert = true,
		persist_size = true,
		persist_mode = false, -- always come back in insert mode
	},
	keys = {
		{ [[<C-\>]], desc = "Toggle terminal" },
		{ "<leader>tf", "<Cmd>ToggleTerm direction=float<CR>", desc = "Terminal (float)" },
		{ "<leader>th", "<Cmd>ToggleTerm direction=horizontal<CR>", desc = "Terminal (horizontal)" },
		{ "<leader>tv", "<Cmd>ToggleTerm direction=vertical<CR>", desc = "Terminal (vertical)" },
		-- Numbered terminals, so several can be kept side by side
		{ "<leader>t1", "<Cmd>1ToggleTerm direction=float<CR>", desc = "Terminal 1" },
		{ "<leader>t2", "<Cmd>2ToggleTerm direction=float<CR>", desc = "Terminal 2" },
		{ "<leader>t3", "<Cmd>3ToggleTerm direction=float<CR>", desc = "Terminal 3" },
		{
			"<leader>tg",
			function()
				require("toggleterm.terminal").Terminal
					:new({ cmd = "lazygit", hidden = true, direction = "float" })
					:toggle()
			end,
			desc = "Lazygit",
		},
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		-- Window navigation and escape, but only inside real terminal buffers. Applying these
		-- globally would break TUI programs (lazygit, htop) that need the raw keys.
		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*toggleterm#*",
			callback = function(event)
				local o = { buffer = event.buf, silent = true }
				vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], o)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], o)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], o)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], o)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], o)
			end,
		})
	end,
}
