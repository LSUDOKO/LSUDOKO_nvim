<div align="center">

# LSUDOKO_nvim

A fast, modular Neovim configuration built on `lazy.nvim`.

<samp>

**~31 ms startup** &nbsp;·&nbsp; **42 plugins** &nbsp;·&nbsp; **13 language servers** &nbsp;·&nbsp; **Neovim 0.11+**

</samp>

</div>

<img width="1907" height="1027" alt="LSUDOKO_nvim" src="https://github.com/user-attachments/assets/5648804e-6383-4cc3-99b5-cb985ed92cf7" />

---

## Overview

This configuration is written in Lua and organised so that every concern lives in exactly one
place. Plugins are lazy-loaded on events, commands or keys, so the editor is usable in about
30 ms regardless of how much is installed.

It uses the modern `vim.lsp.config` / `vim.lsp.enable` API introduced in Neovim 0.11, rather
than the older `lspconfig` setup calls.

## Requirements

| Requirement | Why |
| :--- | :--- |
| Neovim **0.11+** | Uses `vim.lsp.config`, `vim.lsp.enable` and `vim.diagnostic.jump` |
| `git` | Bootstraps `lazy.nvim` and powers `gitsigns` |
| A **Nerd Font** | Statusline, file tree and diagnostic glyphs |
| `ripgrep` | Backs `:grep` and `fzf-lua` live grep |
| `fd` | File discovery for `fzf-lua` |
| `bat` *(optional)* | Syntax-highlighted previews in `fzf-lua` |
| A C compiler | Builds the treesitter parsers |

## Installation

> [!WARNING]
> This replaces any existing Neovim configuration. Back up `~/.config/nvim` first.

```bash
# Back up an existing config, if you have one
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# Install
git clone https://github.com/LSUDOKO/LSUDOKO_nvim.git ~/.config/nvim
nvim
```

On first launch `lazy.nvim` bootstraps itself and installs everything. Then install the
language servers and formatters:

```vim
:MasonToolsInstall
```

Check that everything is wired up correctly:

```vim
:checkhealth
```

## Layout

```
.
├── init.lua                  Entry point — hands off to config.lazy
├── lazy-lock.json            Pinned plugin revisions (commit this)
└── lua
    ├── config
    │   ├── autocmds.lua      Event-driven behaviour
    │   ├── globals.lua       Leader keys — must load first
    │   ├── keymaps.lua       Plugin-independent mappings
    │   ├── lazy.lua          Bootstrap and plugin manager setup
    │   └── options.lua       Native Neovim options
    ├── plugins               One file per plugin, returning a lazy.nvim spec
    ├── servers               One file per language server, plus efm
    └── utils
        ├── diagnostics.lua   Diagnostic signs, virtual text and float styling
        ├── lsp.lua           Buffer-local LSP keymaps, set on LspAttach
        └── runner.lua        Compile-and-run for the current file
```

Adding a plugin means dropping a new file into `lua/plugins/` — `lazy.nvim` imports the whole
directory, so nothing else needs to change.

Adding a language server means dropping a file into `lua/servers/` that returns a function
taking `capabilities`, then adding its name to the `servers` list in `lua/servers/init.lua`.
The filename must match the name passed to `vim.lsp.enable`.

## Keymaps

Leader is <kbd>Space</kbd>. Press <kbd>Space</kbd> and pause to let `which-key` show what is
available, or <kbd>Space</kbd><kbd>f</kbd><kbd>k</kbd> to search every mapping.

### Navigation

| Key | Action |
| :--- | :--- |
| <kbd>Ctrl</kbd>+<kbd>h/j/k/l</kbd> | Move between windows |
| <kbd>Shift</kbd>+<kbd>h</kbd> / <kbd>Shift</kbd>+<kbd>l</kbd> | Previous / next buffer |
| <kbd>Ctrl</kbd>+<kbd>d</kbd> / <kbd>Ctrl</kbd>+<kbd>u</kbd> | Half page down / up, centred |
| <kbd>n</kbd> / <kbd>N</kbd> | Next / previous search result, centred |
| <kbd>Alt</kbd>+<kbd>j</kbd> / <kbd>Alt</kbd>+<kbd>k</kbd> | Move the line or selection |

### Finding

| Key | Action |
| :--- | :--- |
| `<leader><leader>` | Find files |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fr` | Recent files |
| `<leader>fw` | Grep the word under the cursor |
| `<leader>/` | Search within the current buffer |
| `<leader>fk` | Search keymaps |
| `<leader>ft` | Find TODO comments |
| `<leader>fR` | Resume the last picker |

### LSP

Buffer-local; active once a language server attaches.

| Key | Action |
| :--- | :--- |
| `gd` / `gD` | Goto definition / declaration |
| `gr` | References |
| `gi` / `gy` | Goto implementation / type definition |
| <kbd>K</kbd> | Hover documentation |
| <kbd>Ctrl</kbd>+<kbd>s</kbd> | Signature help |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>lf` | Format buffer |
| `<leader>oi` | Organise imports |
| `<leader>uh` | Toggle inlay hints |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>D` | Line diagnostics in a float |

### Git

| Key | Action |
| :--- | :--- |
| `[h` / `]h` | Previous / next hunk |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff against the index |
| `<leader>ht` | Toggle inline blame |
| `<leader>gs` / `<leader>gc` | Git status / commits |

### Diagnostics & windows

| Key | Action |
| :--- | :--- |
| `<leader>xx` | Workspace diagnostics (Trouble) |
| `<leader>xX` | Buffer diagnostics |
| `<leader>xs` | Symbol outline |
| `<leader>e` / `<leader>m` | Toggle / focus the file explorer |
| `<leader>sv` / `<leader>sh` | Split vertically / horizontally |
| `<leader>bd` | Delete buffer, keep the window layout |

### Terminal & running code

| Key | Action |
| :--- | :--- |
| <kbd>Ctrl</kbd>+<kbd>\\</kbd> | Toggle the floating terminal (works from any mode) |
| `<leader>tf` / `<leader>th` / `<leader>tv` | Terminal — float / horizontal / vertical |
| `<leader>t1` … `<leader>t3` | Numbered terminals, kept side by side |
| `<leader>tt` | Plain terminal in a split |
| `<leader>tg` | Lazygit |
| `<leader>rr` | **Run the current file** |
| <kbd>Esc</kbd> or <kbd>Esc</kbd><kbd>Esc</kbd> | Leave terminal mode |
| <kbd>q</kbd> | Close a finished run window (normal mode) |

`<leader>rr` saves the buffer, compiles it if the language needs compiling, and runs it in a
terminal split — so programs that read **stdin still work**, and a failed compile stops before
running. Binaries are written to Neovim's cache directory, never beside your source.

| Filetype | Command |
| :--- | :--- |
| C | `gcc -Wall -O2` |
| C++ | `g++ -std=c++17 -Wall -O2` |
| Rust | `rustc` |
| Go | `go run` |
| Java | `javac` then `java` |
| Python | `python3 -u` |
| JavaScript | `node` |
| TypeScript | `npx tsx` |
| Bash | `bash` |
| Lua | `lua` |

Add or change a language by editing the `commands` table in `lua/utils/runner.lua`.

### Toggles

| Key | Action |
| :--- | :--- |
| `<leader>uw` | Line wrap |
| `<leader>us` | Spell check |
| `<leader>ud` | Diagnostics |

## Language support

Language servers are configured in `lua/servers/` and enabled through `vim.lsp.enable`.

| Language | Server | Linter | Formatter |
| :--- | :--- | :--- | :--- |
| Lua | `lua_ls` | luacheck | stylua |
| Python | `pyright` | flake8 | black |
| Go | `gopls` | revive | gofumpt |
| Rust | `rust_analyzer` | clippy | rustfmt |
| TypeScript / JavaScript | `ts_ls` | eslint_d | prettierd |
| C / C++ | `clangd` | cpplint | clang-format |
| Solidity | `solidity_ls_nomicfoundation` | solhint | prettierd |
| Bash | `bashls` | shellcheck | shfmt |
| JSON | `jsonls` | eslint_d | fixjson |
| YAML | `yamlls` | — | — |
| Dockerfile | `dockerls` | hadolint | — |
| HTML / CSS | `emmet_ls` | — | prettierd |
| Tailwind | `tailwindcss` | — | — |

Linting and formatting are routed through a single
[`efm-langserver`](https://github.com/mattn/efm-langserver) instance, so there is one
formatting path rather than a second plugin competing with the LSP client.

### Format on save

Formatting runs on `BufWritePre` through `efm`, **synchronously** — an asynchronous format can
resolve after the write has already completed, which silently discards the result.

To turn it off:

```vim
:FormatDisable    " globally
:FormatDisable!   " current buffer only
:FormatEnable     " back on
```

## Plugins

<details>
<summary><b>Editor</b></summary>

- [lazy.nvim](https://github.com/folke/lazy.nvim) — plugin manager
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) — file explorer
- [fzf-lua](https://github.com/ibhagwan/fzf-lua) — fuzzy finder
- [which-key.nvim](https://github.com/folke/which-key.nvim) — keybinding hints
- [trouble.nvim](https://github.com/folke/trouble.nvim) — diagnostics list
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) — highlight TODO/FIXME
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) — persistent toggleable terminals

</details>

<details>
<summary><b>LSP & completion</b></summary>

- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) — server defaults
- [mason.nvim](https://github.com/mason-org/mason.nvim) — tool installer
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) — completion engine
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip) — snippets
- [windsurf.nvim](https://github.com/Exafunction/windsurf.nvim) — AI completions

</details>

<details>
<summary><b>Syntax & UI</b></summary>

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) — parsing, folds, text objects
- [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim) — the `duskfox` colourscheme
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) — statusline
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) — buffer tabs
- [alpha-nvim](https://github.com/goolord/alpha-nvim) — start screen
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) — git decorations
- [mini.nvim](https://github.com/echasnovski/mini.nvim) — text objects, surround, comments, pairs

</details>

## Notes

**Treesitter is pinned to `master`.** Upstream has archived that branch in favour of `main`,
which is a breaking rewrite with a different setup API. `master` is stable and remains the
right place to sit until `main` settles; migrating means rewriting
`lua/plugins/nvim-treesitter.lua`.

**Mason's bin directory is prepended to Neovim's `PATH`** in `lua/config/options.lua`, so
servers resolve without depending on your shell profile.

**The theme is transparent by default.** To use a solid background, set
`transparent = false` in `lua/plugins/theme.lua` and remove `nvim-transparent`.

## Licence

[MIT](LICENSE)
