# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Setup

This is a **bare git repository** stored at `~/.dotfiles.git` with `$HOME` as the working tree. Files are managed using the `config` alias:

```sh
config status
config add ~/.zshrc
config commit -m "Update zshrc"
config push
```

The `config` alias expands to `git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME`. The `cfg` alias is a shorthand for the same thing.

**Never use plain `git` commands to manage dotfiles** — always use `config`/`cfg`.

## Architecture

### Shell
- **`.profile`** — cross-shell env vars and PATH setup (sourced by both bash and zsh). This is where PATH entries, language tool homes (GOPATH, JAVA_HOME, GEM_HOME, CARGO), and env vars like `EDITOR=nvim` live.
- **`.zshrc`** — zsh-specific config. Sources `.profile`, loads Oh-My-Zsh with Powerlevel10k, enables vi mode, FZF, and loads `.aliases`.
- **`.bashrc`** / **`.bash_profile`** — minimal bash config.
- **`.aliases`** — shared aliases sourced by both shells. Kubernetes context aliases (`k`, `pk`, `tk`), helm aliases (`h`, `ph`, `th`), and the `config`/`cfg` dotfiles alias live here.

### Neovim (`.config/nvim/`)
Plugin manager is **lazy.nvim**. Entry point is `init.lua`, which calls `require('lazy').setup('plugins', ...)` — lazy auto-loads all files under `lua/plugins/`.

- `lua/plugins/init.lua` — general plugins (colorscheme gruvbox-material, fugitive, gitsigns, lualine, go.nvim, rust.vim, etc.)
- `lua/plugins/cmp.lua` — completion (nvim-cmp)
- `lua/plugins/lsp.lua` — LSP plugin setup
- `lua/config/lsp.lua` — LSP server configuration
- `lua/plugins/telescope.lua` — fuzzy finder
- `lua/plugins/treesitter.lua` — syntax highlighting
- `lua/plugins/neo-tree.lua` — file explorer
- `lua/plugins/oil.lua` — file manager buffer

Auto-format on save is enabled for Go (`goimports`) and Rust (`rustfmt`).

### Window Manager
DWM is the WM (launched via `startdwm` in `.local/bin/`). The X session is set up by `.xinitrc`, which starts: picom (compositor), sxhkd (hotkeys), dunst (notifications), statusbard (status bar daemon), cpuloadd, and xss-lock with betterlockscreen.

- **`.config/sxhkd/sxhkdrc`** — global hotkeys (brightness, volume, lock, wallpaper, app shortcuts)
- **`.config/polybar/`** — polybar config and launch script
- **`.config/picom/picom.conf`** — compositor config
- **`.Xresources`** — X resource settings
- `.xmonad/` — xmonad config (legacy, DWM is currently active)

### tmux (`.tmux.conf`)
- Prefix remapped to `C-a`
- tmux-sessionizer (`tms`) bound to `C-o` (open) and `C-j` (switch), `C-k` to kill session
- Plugin manager: TPM with tmux-gruvbox theme
- Copy mode uses vi keys, yanks to Wayland clipboard via `wl-copy`

### Git
- GPG signing is always on (`commit.gpgsign = true`, key `0B511D15D35B94A0`)
- Pull uses rebase
- `.gitconfig.formelio` is an alternate identity for work (include it conditionally in `.gitconfig` for work projects)
- YAML files use a SOPS diff driver (`*.yaml diff=sopsdiffer` in `.gitattributes`)

### Scripts (`.local/bin/`)
Custom scripts on PATH:
- `statusbard` — statusbar daemon; auto-restarted by nvim on file save
- `cpuloadd` — CPU load daemon feeding the statusbar
- `randwal` / `randwald` — random wallpaper setter/daemon
- `savewal` — save/delete current wallpaper
- `startdwm` — DWM launch wrapper
- `ghopen` — open current GitHub repo in browser
- `jdtls` — Java LSP launcher

### Kubernetes
Multiple contexts in use: `03926-ivido` (production), `transip-dev` (dev), `minikube` (local). Aliases `pk`/`pks`/`ph` target production; `tk`/`th` target transip-dev.

### Environment Variables of Note
- `TMS_CONFIG_FILE` — points to `.config/tms/config.toml` for tmux-sessionizer
- `JSEARCH_API_KEY` — RapidAPI key for JSearch (LinkedIn job search)
- Sensitive vars loaded from `~/.env` (not tracked)
