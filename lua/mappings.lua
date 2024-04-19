require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-------------------------------------------------------------------------------------
-- Customizations
-------------------------------------------------------------------------------------

-- DAP (Debugger)

map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Toggle breakpoint at line" })
map("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Start or continue debugging" })

-- LSP
-- NOTE: K is mapped to vim.lsp.buf.hover already in the standard NVChad lsp configuration.
-- See: https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/configs/lspconfig.lua
-- However, without mapping K here again neovim always calls `man` when pressing that key. Strange.
--map("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "LSP hover information" })
