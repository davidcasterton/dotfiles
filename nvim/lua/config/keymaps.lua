-- Keymaps

-- Word navigation with Alt+Arrow — matches existing vimrc muscle memory
vim.keymap.set("n", "<M-Right>", "w", { desc = "Next word" })
vim.keymap.set("n", "<M-Left>", "b", { desc = "Previous word" })
vim.keymap.set("i", "<M-Right>", "<C-o>w", { desc = "Next word" })
vim.keymap.set("i", "<M-Left>", "<C-o>b", { desc = "Previous word" })

-- Echo full path of current file (matches <leader>f from vimrc)
vim.keymap.set("n", "<leader>f", function()
  print(vim.fn.expand("%:p"))
end, { desc = "Echo file path" })
