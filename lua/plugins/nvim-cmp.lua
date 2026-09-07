-- ================================================================================================
-- TITLE : nvim-cmp
-- ABOUT : the completion engine, its sources and the snippet integration.
-- LINKS :
--   > github                            : https://github.com/hrsh7th/nvim-cmp
--   > lspkind (dep)                     : https://github.com/onsails/lspkind.nvim
--   > cmp_luasnip (dep)                 : https://github.com/saadparwaiz1/cmp_luasnip
--   > luasnip (dep)                     : https://github.com/L3MON4D3/LuaSnip
--   > friendly-snippets (dep)           : https://github.com/rafamadriz/friendly-snippets
--   > cmp-nvim-lsp (dep)                : https://github.com/hrsh7th/cmp-nvim-lsp
--   > cmp-buffer (dep)                  : https://github.com/hrsh7th/cmp-buffer
--   > cmp-path (dep)                    : https://github.com/hrsh7th/cmp-path
--   > cmp-nvim-lsp-signature-help (dep) : https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
-- ================================================================================================

return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"onsails/lspkind.nvim", -- VS Code-like pictograms in the completion menu
		"saadparwaiz1/cmp_luasnip", -- LuaSnip as a completion source
		{
			"L3MON4D3/LuaSnip", -- snippet engine
			version = "v2.*",
			build = "make install_jsregexp",
			dependencies = { "rafamadriz/friendly-snippets" },
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		"hrsh7th/cmp-nvim-lsp", -- LSP completions
		"hrsh7th/cmp-buffer", -- words from the current buffer
		"hrsh7th/cmp-path", -- filesystem paths
		"hrsh7th/cmp-nvim-lsp-signature-help", -- function signatures while typing arguments
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			formatting = {
				expandable_indicator = true,
				fields = { "kind", "abbr", "menu" },
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "…",
					menu = {
						codeium = "[AI]",
						luasnip = "[Snip]",
						buffer = "[Buf]",
						path = "[Path]",
						nvim_lsp = "[LSP]",
						nvim_lsp_signature_help = "[Sig]",
					},
				}),
			},

			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),

				-- Tab cycles the menu, then jumps through snippet placeholders,
				-- and otherwise falls through to a literal Tab.
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			-- Ordered by group: an earlier group wins outright when it has matches.
			sources = cmp.config.sources({
				{ name = "nvim_lsp", priority = 1000 },
				{ name = "nvim_lsp_signature_help", priority = 900 },
				{ name = "luasnip", priority = 800 },
				{ name = "codeium", priority = 700 },
			}, {
				{ name = "buffer", priority = 500, keyword_length = 3 },
				{ name = "path", priority = 400 },
			}),

			experimental = { ghost_text = { hl_group = "Comment" } },
		})

		-- `/` and `?` search completion draws from the current buffer
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = { { name = "buffer" } },
		})
	end,
}
