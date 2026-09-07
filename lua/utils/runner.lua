-- ================================================================================================
-- TITLE : code runner
-- ABOUT : compiles and runs the current file in a terminal split, so stdin still works.
--         Compiled languages build into a temp directory rather than beside the source.
-- ================================================================================================

local M = {}

--- Shell-quote a path so spaces and punctuation survive the trip.
--- @param s string
--- @return string
local function q(s)
	return vim.fn.shellescape(s)
end

--- Build command for the current buffer, per filetype.
--- `file` is the absolute path, `bin` a temp output path for compiled artefacts.
--- @type table<string, fun(file: string, bin: string): string>
local commands = {
	c = function(file, bin)
		return ("gcc -Wall -O2 %s -o %s && %s"):format(q(file), q(bin), q(bin))
	end,
	cpp = function(file, bin)
		return ("g++ -std=c++17 -Wall -O2 %s -o %s && %s"):format(q(file), q(bin), q(bin))
	end,
	rust = function(file, bin)
		return ("rustc -o %s %s && %s"):format(q(bin), q(file), q(bin))
	end,
	go = function(file)
		return ("go run %s"):format(q(file))
	end,
	java = function(file)
		local dir = vim.fn.fnamemodify(file, ":h")
		local class = vim.fn.fnamemodify(file, ":t:r")
		return ("javac -d %s %s && java -cp %s %s"):format(q(dir), q(file), q(dir), class)
	end,
	python = function(file)
		return ("python3 -u %s"):format(q(file))
	end,
	javascript = function(file)
		return ("node %s"):format(q(file))
	end,
	typescript = function(file)
		return ("npx tsx %s"):format(q(file))
	end,
	sh = function(file)
		return ("bash %s"):format(q(file))
	end,
	lua = function(file)
		return ("lua %s"):format(q(file))
	end,
}

--- Compile and run the current file in a terminal split.
--- @return nil
function M.run()
	local ft = vim.bo.filetype
	local builder = commands[ft]

	if not builder then
		vim.notify(
			("No run command configured for filetype %q"):format(ft ~= "" and ft or "none"),
			vim.log.levels.WARN
		)
		return
	end

	local file = vim.fn.expand("%:p")
	if file == "" then
		vim.notify("Buffer has no file on disk — save it first", vim.log.levels.WARN)
		return
	end

	-- Write the buffer so the compiler sees the current text, not the last save.
	if vim.bo.modified then
		vim.cmd("silent write")
	end

	-- Compiled output goes to a temp dir, so binaries never litter the project.
	local outdir = vim.fn.stdpath("cache") .. "/coderunner"
	vim.fn.mkdir(outdir, "p")
	local bin = outdir .. "/" .. vim.fn.fnamemodify(file, ":t:r")

	local cmd = builder(file, bin)

	-- A real terminal split, not a scratch buffer, so programs that read stdin still work.
	vim.cmd("botright " .. math.max(12, math.floor(vim.o.lines * 0.3)) .. "split")
	vim.cmd("terminal " .. cmd)

	local buf = vim.api.nvim_get_current_buf()
	vim.bo[buf].buflisted = false
	vim.keymap.set("n", "q", "<Cmd>bdelete!<CR>", { buffer = buf, silent = true })
	vim.cmd("startinsert")
end

return M
