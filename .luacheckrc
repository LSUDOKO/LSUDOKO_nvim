-- Static analysis configuration for the Neovim Lua config.
-- Run with: luacheck lua/

std = "luajit"

globals = {
  "vim",
}

read_globals = {
  "vim",
}

-- Neovim config files are read top-to-bottom; long descriptive lines are intentional.
max_line_length = 120

ignore = {
  "212", -- unused argument (common in autocmd/LSP callbacks)
  "213", -- unused loop variable
  "631", -- line is too long
}

exclude_files = {
  "lazy-lock.json",
}
