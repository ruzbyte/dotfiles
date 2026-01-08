-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Shift / + = Select Word and view

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.g.mapleader = " "

-- Zeilen verschieben mit Alt + Pfeiltasten (Normal Mode)
vim.keymap.set("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
vim.keymap.set("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move line down" })

-- Blöcke verschieben mit Alt + Pfeiltasten (Visual Mode)
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

vim.keymap.set("n", "<C-Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without replacing the default register" })

vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank to system clipboard (line)" })

vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete without replacing the default register" })
vim.keymap.set("v", "<leader>d", '"_d', { desc = "Delete without replacing the default register" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")
