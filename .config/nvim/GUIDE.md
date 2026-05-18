# Neovim Configuration Guide

Leader key: `Space`

---

## Plugin Manager — lazy.nvim

| Command | Description |
|---------|-------------|
| `:Lazy` | Open plugin manager UI |
| `:Lazy update` | Update all plugins |
| `:Lazy sync` | Install + update + clean |
| `:Lazy clean` | Remove unused plugins |

---

## LSP

### Navigation

| Key | Description |
|-----|-------------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | References (fzf-lua picker) |
| `gI` | Implementations (fzf-lua picker) |
| `K` | Hover documentation |

### Actions

| Key | Description |
|-----|-------------|
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action (normal + visual) |
| `<leader>f` | Format buffer |
| `<leader>h` | Toggle inlay hints |

### Diagnostics

| Key | Description |
|-----|-------------|
| `<leader>e` | Float diagnostic under cursor |
| `[e` | Previous diagnostic |
| `]e` | Next diagnostic |
| `<leader>q` | Send diagnostics to quickfix list |

### Management

| Key / Command | Description |
|---------------|-------------|
| `<leader>li` | LSP health check |
| `<leader>lr` | Restart LSP |
| `<leader>ll` | Open LSP log |
| `:Mason` | Open Mason UI (install/update servers) |
| `<C-s>` (insert) | Toggle function signature hint |

### Installed servers

`gopls`, `rust_analyzer`, `ts_ls`, `pyright`, `lua_ls`, `jsonls`, `bashls`, `lemminx`, `marksman`

Java (`jdtls`) is managed separately — install it via `:MasonInstall jdtls`.

---

## Completion — blink.cmp

| Key | Description |
|-----|-------------|
| `<C-Space>` | Trigger / toggle documentation |
| `<C-n>` / `<C-p>` | Next / previous item |
| `<Tab>` / `<S-Tab>` | Next / previous item (also advances snippets) |
| `<CR>` | Confirm selection |
| `<C-e>` | Dismiss menu |
| `<C-d>` / `<C-u>` | Scroll documentation down / up |

---

## Fuzzy Finder — fzf-lua

| Key | Description |
|-----|-------------|
| `<C-p>` | Git-tracked files |
| `<leader>tf` | All files (respects .gitignore, shows hidden) |
| `<leader>ts` | Live grep across project |
| `<leader>tw` | Grep word under cursor |
| `<leader>tb` | Open buffers |
| `<leader>th` | Help tags |

Inside any picker: `<C-j>`/`<C-k>` or arrow keys to navigate, `<CR>` to open, `<C-x>` horizontal split, `<C-v>` vertical split, `<Esc>` to close.

---

## File Explorer — neo-tree

| Key | Description |
|-----|-------------|
| `<C-n>` | Toggle tree |
| `<CR>` / `o` | Open file |
| `s` | Open in horizontal split (with window picker) |
| `v` | Open in vertical split (with window picker) |
| `a` | Add file/directory |
| `d` | Delete |
| `r` | Rename |
| `y` | Copy file |
| `x` | Cut file |
| `p` | Paste |
| `R` | Refresh |
| `H` | Toggle hidden files |
| `<bs>` | Close node |
| `q` | Close tree |

---

## File Manager — oil.nvim

Press `-` from any buffer to open the parent directory as an editable buffer.

| Key | Description |
|-----|-------------|
| `-` | Open parent directory |
| `<CR>` | Open file / enter directory |
| `-` | Go up one directory |
| `_` | Open current working directory |
| `<C-s>` | Save changes (rename, delete, create) |
| `<C-h>` | Toggle hidden files |
| `<C-p>` | Preview file |
| `q` | Quit oil |

Edit file names directly in the buffer and save with `<C-s>` to rename/move/delete in bulk.

---

## Window Navigation

| Key | Description |
|-----|-------------|
| `<C-h>` | Focus left window |
| `<C-j>` | Focus below window |
| `<C-k>` | Focus above window |
| `<C-l>` | Focus right window |

---

## Git — gitsigns + fugitive

### Gitsigns (hunk operations)

| Key | Description |
|-----|-------------|
| `]c` | Next hunk |
| `[c` | Previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame current line |

### Fugitive

| Command | Description |
|---------|-------------|
| `:Git` | Interactive git status |
| `:Git log` | Commit history |
| `:Git diff` | Diff view |
| `:Git blame` | Blame view |
| `:GBrowse` | Open in browser |

In the `:Git` status window: `s` stage, `u` unstage, `cc` commit, `dd` diff, `=` toggle inline diff, `?` for all bindings.

---

## Diagnostics Panel — trouble.nvim

| Key | Description |
|-----|-------------|
| `<leader>xx` | Toggle diagnostics panel |
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Document diagnostics |
| `<leader>xl` | Location list |
| `<leader>xq` | Quickfix list |

---

## AI Assistant — avante.nvim (Claude)

Requires `ANTHROPIC_API_KEY` in the environment (loaded from `~/.env`).

| Key | Description |
|-----|-------------|
| `<leader>aa` | Open / focus Avante sidebar |
| `<leader>at` | Toggle sidebar |
| `<leader>ar` | Refresh / re-run last request |
| `<leader>ae` | Edit selected code inline (visual mode) |

In the sidebar, type your request and press `<CR>` to submit. Avante will show a diff for code changes which you can accept or reject.

---

## Treesitter Text Objects

### Select (visual mode)

| Key | Description |
|-----|-------------|
| `aa` / `ia` | Around / inside parameter |
| `af` / `if` | Around / inside function |
| `ac` / `ic` | Around / inside class |

### Move

| Key | Description |
|-----|-------------|
| `]m` / `[m` | Next / previous function start |
| `]M` / `[M` | Next / previous function end |
| `]]` / `[[` | Next / previous class start |

### Swap

| Key | Description |
|-----|-------------|
| `<leader>a` | Swap parameter with next |
| `<leader>A` | Swap parameter with previous |

---

## Editing Utilities

### Commenting — Comment.nvim

| Key | Description |
|-----|-------------|
| `gcc` | Toggle line comment |
| `gc` + motion | Toggle comment over motion (e.g. `gcap` for paragraph) |
| `gc` (visual) | Toggle comment on selection |

### Surround — nvim-surround

| Key | Description |
|-----|-------------|
| `ys` + motion + char | Add surround (e.g. `ysiw"` surrounds word with `"`) |
| `cs` + old + new | Change surround (e.g. `cs"'` changes `"` to `'`) |
| `ds` + char | Delete surround (e.g. `ds(` removes parentheses) |
| `S` (visual) | Surround selection |

### Autopairs

Brackets, quotes, and parentheses are auto-closed. Press `<CR>` inside a pair to expand it.

---

## Clipboard

| Key | Description |
|-----|-------------|
| `<leader>y` | Yank to system clipboard |
| `<leader>Y` | Yank to end of line to clipboard |
| `<leader>y` (visual) | Yank selection to clipboard |
| `<leader>p` / `<leader>P` | Paste from clipboard (after / before) |
| `<leader>d` / `<leader>D` | Delete to clipboard |
| `Y` | Yank to end of line (default register) |

---

## Quickfix Navigation

| Key | Description |
|-----|-------------|
| `gn` | Next quickfix entry (centered) |
| `gp` | Previous quickfix entry (centered) |

---

## Search

| Key | Description |
|-----|-------------|
| `n` / `N` | Next / previous match (auto-centered) |
| `<leader><space>` | Clear search highlight |

---

## Per-Project Config — nvim-config-local

Place a `.nvim.lua` or `.nvimrc` file in a project root (or any parent directory) to load project-specific settings automatically when you open files in that directory. Example `.nvim.lua`:

```lua
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
```

You will be prompted to confirm trust on first load.

---

## Go

Auto `goimports` runs on save via `go.nvim`. Use LSP keymaps for everything else.

| Command | Description |
|---------|-------------|
| `:GoInstallDeps` | Install Go tools |
| `:GoTest` | Run tests |
| `:GoCoverage` | Show test coverage |

## Rust

`rustfmt` runs on save automatically. `rust-analyzer` provides all LSP features including proc macro support.

## Java

`jdtls` starts automatically when you open a `.java` file (requires `:MasonInstall jdtls`). Lombok is supported. Each project gets an isolated workspace under `~/.cache/jdtls/workspace/`.
