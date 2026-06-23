-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Delete without copying to clipboard
local keymap = vim.keymap

keymap.set("n", "dc", '"_dd', { noremap = true })
keymap.set("v", "dc", '"_d', { noremap = true })
keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
