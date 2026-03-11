-- Keymaps

-- Word navigation: Ghostty sends <M-f>/<M-b> (readline convention) for Option+Arrow
vim.keymap.set("n", "<M-f>", "w", { desc = "Next word" })
vim.keymap.set("n", "<M-b>", "b", { desc = "Previous word" })
vim.keymap.set("i", "<M-f>", "<C-o>w", { desc = "Next word" })
vim.keymap.set("i", "<M-b>", "<C-o>b", { desc = "Previous word" })

-- Echo full path of current file (matches <leader>f from vimrc)
vim.keymap.set("n", "<leader>f", function()
  print(vim.fn.expand("%:p"))
end, { desc = "Echo file path" })
