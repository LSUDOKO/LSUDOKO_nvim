-- ================================================================================================
-- TITLE : lazy.nvim bootstrap & plugin setup
-- ABOUT :
--   Bootstraps the 'lazy.nvim' plugin manager by cloning it if not present, prepends it to the
--   runtime path, then loads the core configuration (globals, options, keymaps, autocmds) before
--   initialising lazy.nvim with the plugin specs under 'lua/plugins'.
-- LINKS :
--   > lazy.nvim github  : https://github.com/folke/lazy.nvim
--   > lazy.nvim website : https://lazy.folke.io/installation
-- ================================================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field (fs_stat)
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Leader keys must be set before any plugin defines a mapping.
require("config.globals")
require("config.options")
require("config.keymaps")
require("config.autocmds")

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	install = {
		colorscheme = { "duskfox", "habamax" },
	},
	checker = {
		enabled = true,
		notify = false, -- check for updates silently; don't interrupt
	},
	change_detection = {
		notify = false,
	},
	ui = {
		border = "rounded",
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrw",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
