# Neovim Guide

Reference for using Neovim with the LazyVim configuration in this repo.

---

## Overview

[Neovim](https://neovim.io) is a modal text editor — meaning the keyboard behaves differently depending on which **mode** you're in. This is the core concept that makes it fast once internalized: your hands never leave the home row.

This config uses [LazyVim](https://lazyvim.org), a distribution that pre-configures Neovim with IDE-quality features (LSP, fuzzy search, file tree, git integration) while remaining fully customizable.

---

## Modes

| Mode | How to enter | What it does |
|------|-------------|--------------|
| **Normal** | `Esc` from anywhere | Navigate, run commands. This is the default — always return here first. |
| **Insert** | `i` (before cursor), `a` (after), `o` (new line below), `O` (new line above) | Type text |
| **Visual** | `v` (char), `V` (line), `Ctrl+v` (block) | Select text |
| **Command** | `:` | Run editor commands (save, quit, search/replace, etc.) |

**The most important habit:** always return to Normal mode with `Esc` when you're done typing. Think of Normal mode as home base.

---

## First Launch

On first launch, lazy.nvim will install all plugins automatically. This takes ~30 seconds. Subsequent launches are fast (~94ms).

Run the built-in tutorial to learn the basics interactively:

```
:Tutor
```

---

## Essential Commands

### Files & Navigation

| Key | Action |
|-----|--------|
| `<Space>ff` | Fuzzy find file by name |
| `<Space>fr` | Recent files |
| `<Space>fg` | Fuzzy search text across project (grep) |
| `<Space>e` | Toggle file tree (neo-tree) |
| `<Space>,` | Switch between open buffers |
| `<Space>bd` | Close current buffer |
| `Ctrl+p` | Alternative fuzzy file find |

### Movement (Normal mode)

| Key | Action |
|-----|--------|
| `h j k l` | Left / down / up / right |
| `w` / `b` | Next / previous word |
| `Option+Right` / `Option+Left` | Next / previous word (Ghostty sends `<M-f>`/`<M-b>`) |
| `0` / `$` | Start / end of line |
| `gg` / `G` | Top / bottom of file |
| `Ctrl+d` / `Ctrl+u` | Scroll half page down / up |
| `{` / `}` | Jump between blank lines (paragraphs) |
| `%` | Jump to matching bracket |
| `*` | Search for word under cursor |
| `n` / `N` | Next / previous search match |

### Editing (Normal mode)

| Key | Action |
|-----|--------|
| `dd` | Delete (cut) current line |
| `yy` | Yank (copy) current line |
| `p` / `P` | Paste after / before cursor |
| `u` / `Ctrl+r` | Undo / redo |
| `x` | Delete character under cursor |
| `r<char>` | Replace character under cursor |
| `J` | Join current line with line below |
| `.` | Repeat last change — extremely useful |
| `>` / `<` | Indent / dedent (works on visual selection too) |

### Text Objects — the killer feature

Combine an **operator** (`c`hange, `d`elete, `y`ank) with a **motion** or **text object**:

| Key | Action |
|-----|--------|
| `ciw` | Change inner word |
| `ci"` | Change inside quotes |
| `ci(` | Change inside parentheses |
| `ci{` | Change inside braces |
| `ca"` | Change around quotes (includes the quotes) |
| `di"` | Delete inside quotes |
| `yi(` | Yank inside parentheses |
| `vip` | Select inner paragraph |
| `das` | Delete around sentence |

The pattern is: `operator` + `i`nner or `a`round + delimiter. Works with `"`, `'`, `` ` ``, `(`, `[`, `{`, `<`, `t` (HTML tag).

### LSP (Code Intelligence)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `K` | Hover documentation |
| `<Space>ca` | Code action (quick fix, refactor) |
| `<Space>cr` | Rename symbol |
| `<Space>cf` | Format file |
| `[d` / `]d` | Previous / next diagnostic |
| `<Space>cd` | Show diagnostic detail |

### Git

| Key | Action |
|-----|--------|
| `<Space>gg` | Open Lazygit (full git TUI) |
| `<Space>gb` | Git blame current line |
| `<Space>gd` | Git diff |
| `]h` / `[h` | Next / previous git hunk |
| `<Space>ghs` | Stage hunk |
| `<Space>ghr` | Reset hunk |

### Windows & Splits

| Key | Action |
|-----|--------|
| `<Space>-` | Split horizontally |
| `<Space>\|` | Split vertically |
| `Ctrl+h/j/k/l` | Move between splits |
| `<Space>wd` | Close split |

### Saving & Quitting

| Key | Action |
|-----|--------|
| `:w` | Save |
| `:q` | Quit |
| `:wq` or `ZZ` | Save and quit |
| `:q!` or `ZQ` | Quit without saving |
| `:wa` | Save all buffers |

### Search & Replace

```
:%s/old/new/g          replace all occurrences in file
:%s/old/new/gc         replace with confirmation
:10,20s/old/new/g      replace in lines 10-20
```

In normal mode, `/` searches forward and `?` searches backward. `n`/`N` cycle through matches.

---

## Discovering Keybindings

Press `<Space>` in normal mode and wait — [which-key](https://github.com/folke/which-key.nvim) shows a popup of every available keybinding under that prefix. This is the best way to explore what's available without memorizing everything upfront.

Common prefixes:
- `<Space>f` — find (files, text, buffers)
- `<Space>g` — git
- `<Space>c` — code (LSP actions)
- `<Space>b` — buffers
- `<Space>w` — windows
- `g` — go to (definition, references, etc.)
- `[` / `]` — previous / next (diagnostic, hunk, buffer)

---

## Customizing This Config

### Adding language support

Edit `nvim/lazyvim.json` and add entries from the [LazyVim extras list](https://lazyvim.org/extras):

```json
{
  "extras": [
    "lazyvim.plugins.extras.lang.python",
    "lazyvim.plugins.extras.lang.go",
    "lazyvim.plugins.extras.lang.typescript"
  ]
}
```

Relaunch nvim — Mason will install the required language servers automatically.

### Adding or overriding plugins

Drop a `.lua` file in `nvim/lua/plugins/`. Each file returns a table of [lazy.nvim plugin specs](https://lazy.folke.io/spec):

```lua
-- nvim/lua/plugins/example.lua
return {
  -- Add a new plugin
  { "plugin/name", opts = {} },

  -- Override an existing LazyVim plugin's options
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        layout_strategy = "vertical",
      },
    },
  },
}
```

### Changing options or keymaps

Edit `nvim/lua/config/options.lua` or `nvim/lua/config/keymaps.lua` directly. Changes take effect on next launch.

---

## Learning Path

1. **`:Tutor`** — do this first, takes ~30 minutes, covers all the basics interactively
2. **Use `<Space>` and wait** — let which-key show you what's available as you need it
3. **Master text objects** — `ci"`, `ca(`, `vip` etc. are what make vim editing feel different from any other editor
4. **Learn one new motion per day** — don't try to memorize everything at once; add to your repertoire gradually
5. **Stop using arrow keys** — force yourself to use `hjkl` and word motions; it becomes natural within a week

---

## Resources

| Resource | What it covers |
|----------|---------------|
| [LazyVim docs](https://lazyvim.org) | Full keybinding reference for this config |
| [Neovim docs](https://neovim.io/doc/user/) | Complete editor reference |
| [lazy.nvim docs](https://lazy.folke.io) | Plugin manager — adding/configuring plugins |
| [Mason registry](https://mason-registry.dev) | Available language servers, linters, formatters |
| [LazyVim extras](https://lazyvim.org/extras) | Language packs to add to `lazyvim.json` |
| `:Tutor` (in nvim) | Interactive built-in tutorial |
| [Vim Motions for Beginners](https://youtu.be/X6AR2RMB5tE) | Practical motion drills (YouTube) |
| [ThePrimeagen's Neovim series](https://www.youtube.com/@ThePrimeagen) | Opinionated, fast-paced, widely recommended |
| [TJ DeVries (teej_dv)](https://www.youtube.com/@teej_dv) | Core Neovim contributor — deep dives on Lua config |
