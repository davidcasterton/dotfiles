-- Leader key must be set before lazy.nvim loads
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Bootstrap lazy.nvim and LazyVim
require("config.lazy")
