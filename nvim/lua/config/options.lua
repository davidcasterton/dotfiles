-- Options — mirrors vimrc preferences, extended for Neovim

-- Indentation: 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Line numbers (absolute only)
vim.opt.number = true
vim.opt.relativenumber = false


-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Scroll context: keep 5 lines visible above/below cursor
vim.opt.scrolloff = 5

-- Mouse support in all modes (upgrade from vimrc's right-click-only)
vim.opt.mouse = "a"

-- Always show status line
vim.opt.laststatus = 2

-- Use Unix line endings
vim.opt.fileformats = "unix,mac,dos"

-- No backup or swap files
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Disable current line highlight
-- vim.opt.cursorline = false
