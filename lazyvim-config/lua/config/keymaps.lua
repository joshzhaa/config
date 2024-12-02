-- Keyvim.keymap.sets are automatically loaded on the VeryLazy event
-- Default keyvim.keymap.sets that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keyvim.keymap.sets here

-- buffer keybinds
vim.keymap.set("n", "<Tab>", "<cmd> BufferLineCycleNext <CR>")
vim.keymap.set("n", "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>")
vim.keymap.set("n", "<C-q>", "<cmd> bd <CR>")

-- who needs their terminal to receive an <Esc> anyway?
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
