-- ================================================================================================
-- TITLE : language servers
-- ABOUT : registers every server configuration, then enables them in one call
-- ================================================================================================

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Servers registered with `vim.lsp.config`. Each module returns a function taking `capabilities`.
-- The keys here are the exact names passed to `vim.lsp.enable` below.
local servers = {
	"bashls",
	"clangd",
	"dockerls",
	"emmet_ls",
	"gopls",
	"jsonls",
	"lua_ls",
	"pyright",
	"rust_analyzer",
	"solidity_ls_nomicfoundation",
	"tailwindcss",
	"ts_ls",
	"yamlls",
}

for _, name in ipairs(servers) do
	require("servers." .. name)(capabilities)
end

-- efm-langserver drives the linters and formatters; its module file is hyphenated.
require("servers.efm-langserver")(capabilities)
table.insert(servers, "efm")

vim.lsp.enable(servers)
