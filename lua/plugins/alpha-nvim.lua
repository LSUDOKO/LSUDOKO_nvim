-- ================================================================================================
-- TITLE : alpha-nvim
-- ABOUT : the start screen shown when Neovim opens without a file.
-- LINKS :
--   > github : https://github.com/goolord/alpha-nvim
-- ================================================================================================

return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			"                                                     ",
			"  ██╗     ███████╗██╗   ██╗██████╗  ██████╗ ██╗  ██╗ ",
			"  ██║     ██╔════╝██║   ██║██╔══██╗██╔═══██╗██║ ██╔╝ ",
			"  ██║     ███████╗██║   ██║██║  ██║██║   ██║█████╔╝  ",
			"  ██║     ╚════██║██║   ██║██║  ██║██║   ██║██╔═██╗  ",
			"  ███████╗███████║╚██████╔╝██████╔╝╚██████╔╝██║  ██╗ ",
			"  ╚══════╝╚══════╝ ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ",
			"                                                     ",
		}

		dashboard.section.buttons.val = {
			dashboard.button("f", "  Find file", "<Cmd>FzfLua files<CR>"),
			dashboard.button("n", "  New file", "<Cmd>ene | startinsert<CR>"),
			dashboard.button("r", "  Recent files", "<Cmd>FzfLua oldfiles<CR>"),
			dashboard.button("g", "  Find text", "<Cmd>FzfLua live_grep<CR>"),
			dashboard.button("c", "  Config", "<Cmd>edit $MYVIMRC<CR>"),
			dashboard.button("l", "󰒲  Lazy", "<Cmd>Lazy<CR>"),
			dashboard.button("m", "  Mason", "<Cmd>Mason<CR>"),
			dashboard.button("q", "  Quit", "<Cmd>qa<CR>"),
		}

		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl = "AlphaButtons"
			button.opts.hl_shortcut = "AlphaShortcut"
		end
		dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"
		dashboard.opts.layout[1].val = 8

		alpha.setup(dashboard.opts)

		-- Show the plugin count once lazy.nvim has finished starting up
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			once = true,
			callback = function()
				local stats = require("lazy").stats()
				local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
				dashboard.section.footer.val =
					("⚡ %d/%d plugins loaded in %sms"):format(stats.loaded, stats.count, ms)
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
