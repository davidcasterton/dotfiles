# dotfiles

Personal system configuration for macOS and Ubuntu. Covers shell (bash + zsh), Neovim (primary editor), vim (SSH fallback), git workflow aliases, and environment variables. All files are symlinked from this repo into `~`, so changes here take effect immediately without re-running the installer.

---

## What gets configured

### Shell

**Zsh (primary)** — `zshrc`
- Loads [Oh My Zsh](https://ohmyzsh.sh) with the [Dracula](https://draculatheme.com/zsh) theme
- Sources `~/.exports`, `~/.aliases`, and `~/.localrc` (machine-specific overrides)
- Sets up NVM and Yarn PATH entries

**Bash (fallback)** — `bashrc`, `bash_prompt`, `bash_profile`
- `bashrc`: history management (10k entries, cross-session sync), bash completion, NVM, Yarn PATH
- `bash_prompt`: git-aware prompt via [bash-git-prompt](https://github.com/magicmonty/bash-git-prompt); shows branch, dirty state, last command exit status, and current path
- `bash_profile`: macOS login shell setup — Homebrew PATH, color support
- Inside VS Code / Cursor terminals the fancy prompt is skipped in favor of a plain `user@host:dir$`

### Neovim — `nvim/`

Primary editor. Uses [LazyVim](https://lazyvim.org) — a batteries-included distribution that provides IDE features out of the box. Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim) and install automatically on first launch; nothing is committed to this repo.

**What LazyVim provides on first launch:**
- LSP autocomplete and inline diagnostics (via Mason + nvim-lspconfig)
- Fuzzy file/text search (Telescope)
- File tree (neo-tree)
- Inline git diff signs (gitsigns)
- Treesitter syntax highlighting
- Which-key popup for discovering keybindings

**Customizations on top of LazyVim defaults:**
- Dracula colorscheme (`Mofiqul/dracula.nvim`) — matches vim and zsh theme
- 4-space indentation, 120-column guide
- `<M-Right>` / `<M-Left>` word navigation (normal and insert mode)
- Auto-strip trailing whitespace on save
- Real tabs in Makefiles

**Adding language support:** Edit `nvim/lazyvim.json` and add extras from the [LazyVim extras list](https://lazyvim.org/extras), e.g.:
```json
{
  "extras": [
    "lazyvim.plugins.extras.lang.python",
    "lazyvim.plugins.extras.lang.go"
  ]
}
```

**Adding or overriding plugins:** Drop a `.lua` file in `nvim/lua/plugins/`. Each file returns a table of lazy.nvim plugin specs.

See [nvim.md](nvim.md) for a full usage guide, common commands, and learning resources.

### Vim — `vimrc` (SSH fallback)

Used when Neovim is unavailable (e.g. remote SSH to a server). Plugin manager: [Pathogen](https://github.com/tpope/vim-pathogen)

| Plugin | Purpose |
|--------|---------|
| vim-airline + themes | Status line and tabline |
| dracula-theme | Color scheme (also available: darcula, lucario, solarized) |
| rainbow_parentheses | Bracket pair colorization |
| vim-virtualenv | Python virtualenv detection in status line |
| vim-flavored-markdown | GitHub-flavored Markdown syntax |
| vim-pbtxt | Protocol buffer text format syntax |

Key settings:
- 4-space indentation, spaces not tabs (Makefiles excepted)
- 120-character color column
- Case-insensitive search with highlighting
- Auto-strip trailing whitespace on save
- `<M-Right>` / `<M-Left>` — word forward/backward (normal and insert mode)
- `<leader>f` — echo full path of current file
- `<leader>src` / `<leader>erc` — source or edit vimrc

### Aliases — `aliases`

**Navigation / system**
| Alias | Effect |
|-------|--------|
| `ll` | `ls -lha` |
| `cls` / `cll` | clear + pwd + ls |
| `lsd` | list directories only |
| `grep` | grep with color |

**tmux**
| Alias | Effect |
|-------|--------|
| `tm [name]` | attach to session or create it (default name: `1`) |
| `tml` | list sessions |

**Git**
| Alias / Function | Effect |
|-----------------|--------|
| `gs` | `git status` |
| `gd` / `gds` | diff / diff staged |
| `gp` / `gpu` | pull / push |
| `gpn` | push and set upstream to current branch |
| `gcm` / `gca` | commit with message / amend |
| `glog` | `git log --oneline` |
| `ghash` | print HEAD SHA |
| `gbdc` | list branches matching your username |
| `mmb` / `rmb` / `rmbi` | merge / rebase / interactive rebase from master |
| `gwhere <branch> <sha>` | check if a commit is in a branch |
| `grel <sha>` | show which release branches contain a commit |
| `shain <sha> <branch>` | yes/no — is this commit an ancestor of this branch? |
| `gps` | full sync: unlock, prune, pull, update submodules |
| `gsubpull` | update all submodules to latest remote |
| `gsubrevert` | hard reset all submodules to HEAD |
| `gsubprune` | fetch --prune across all submodules |
| `gsubupdate` | `git submodule update --init --recursive` |
| `grevert` | hard reset + clean working directory |
| `gunlock` | ⚠️ remove `.git/index.lock` and `.git/gc.log` — only use if no git operation is running |
| `gclean` | ⚠️ delete local branches whose remotes are gone, then `git gc` |

**Media (ffmpeg)**
| Function | Effect |
|----------|--------|
| `gif <input> <output>` | convert video to optimized GIF at 1080px wide |
| `speed2x <file>` | re-encode video at 2× speed |
| `speed15x <file>` | re-encode video at 1.5× speed |

**Misc**
| Alias / Function | Effect |
|-----------------|--------|
| `greps <pattern> [dir] [context]` | recursive grep with surrounding context |
| `alert` | desktop notification when a long command finishes (`sleep 10; alert`) |

### Environment — `exports`

| Variable | Value |
|----------|-------|
| `HISTCONTROL` | `ignoreboth` — no duplicates, no space-prefixed commands |
| `PIP_REQUIRE_VIRTUALENV` | `true` — pip will refuse to install outside a virtualenv |
| `VISUAL` / `EDITOR` | `vim` |

---

## Installation

### 1. Clone with submodules

```bash
git clone --recurse-submodules https://github.com/yourusername/dotfiles.git
cd dotfiles
```

### 2. Run the installer

```bash
bash install
```

The installer will:
1. Symlink all dotfiles into `~`
2. **Linux only** — offer to `apt install zsh` if zsh is not present
3. Offer to set zsh as your default shell (`chsh`)
4. Offer to install Oh My Zsh (using `--keep-zshrc` so your symlinked `~/.zshrc` is preserved)
5. Symlink the Dracula zsh theme into `~/.oh-my-zsh/custom/themes/`
6. **Linux only** — offer to `snap install nvim --classic` if Neovim is not present
7. Symlink `nvim/` → `~/.config/nvim`

Existing files are never overwritten — the installer skips any destination that already exists.

### 3. Restart your shell

```bash
exec zsh
```

---

## Platform notes

### macOS (Ghostty + zsh)

- Zsh is the default shell on modern macOS — no changes needed
- `bash_profile` is only loaded if bash is invoked as a login shell; it sets Homebrew PATH and color support
- Ghostty requires no special shell integration; it works with the standard zsh setup

### Ubuntu (bash or zsh)

- Ubuntu ships with bash as the default shell
- Run `bash install` and choose yes at the zsh prompts to switch
- After `chsh`, log out and back in (or start a new terminal) for the change to take effect
- Zsh and Oh My Zsh provide the same experience as macOS

---

## Machine-specific configuration — `~/.localrc`

`~/.localrc` is sourced at the end of both `bashrc` and `zshrc`. It is never committed to this repo — it's the right place for anything specific to one machine.

Common uses:

```bash
# Machine identifier shown in prompt — useful when SSH'd into multiple machines
# zsh:  prepended to prompt as [myhost]
# bash: shown in place of user@host
export MACHINE_ID="myhost"
export GIT_PROMPT_MACHINE_ID="[myhost]"  # bash only

# Work-specific PATH or credentials
export PATH="$HOME/work/bin:$PATH"
export GITHUB_TOKEN="..."

# Machine-specific aliases
alias proj="cd ~/work/myproject"
```

---

## Submodules

| Submodule | Purpose |
|-----------|---------|
| `bash-git-prompt` | Git-aware bash prompt |
| `dracula/zsh` | Dracula theme for Oh My Zsh |
| `dracula/jetbrains` | Dracula theme for JetBrains IDEs |
| `vim/bundle/vim-airline` | Vim status line |
| `vim/bundle/vim-airline-themes` | Themes for vim-airline |
| `vim/bundle/dracula-theme` | Dracula color scheme for vim |
| `vim/bundle/darcula` | Darcula color scheme for vim |
| `vim/bundle/lucario` | Lucario color scheme for vim |
| `vim/bundle/vim-colors-solarized` | Solarized color scheme for vim |
| `vim/bundle/rainbow_parentheses.vim` | Bracket colorization |
| `vim/bundle/vim-virtualenv` | Python virtualenv in vim status line |
| `vim/bundle/vim-flavored-markdown` | GitHub Markdown syntax |
| `vim/bundle/vim-pbtxt` | Protocol buffer text syntax |

To update all submodules to their latest commits:

```bash
git submodule update --remote --recursive
```

---

## Updating dotfiles

Since all files are symlinked, editing any file in this repo takes effect immediately in new shells. For changes to `exports` or `aliases` to apply in an existing shell, re-source them:

```bash
source ~/.aliases
source ~/.exports
```
