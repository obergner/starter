local map = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()
local function opts(desc)
  return { buffer = bufnr, desc = "LSP " .. desc }
end

-- Adapted from: https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/configs/lspconfig.lua
map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
map("n", "K", vim.lsp.buf.hover, opts "hover information")
map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

map("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts "List workspace folders")

map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")

map("n", "<leader>ra", function()
  require "nvchad.lsp.renamer"()
end, opts "NvRenamer")

map("n", "gr", vim.lsp.buf.references, opts "Show references")

---------------------------------------------------------------------------------------------
-- Use rust-analyzer features not supported in generic LSP
---------------------------------------------------------------------------------------------
-- supports rust-analyzer's grouping
-- or vim.lsp.buf.codeAction() if you don't want grouping.
map({ "n", "v" }, "<leader>ca", vim.cmd.RustLsp "codeAction", opts "Code action")

-- TODO: These bindings using RustLsp do not yet work
-- Use debug configurations created by rust-analyzer
map("n", "<leader>dd", vim.cmd.RustLsp "debug", opts "Debug (rust-analyzer)")

-- Let rust-analyzer search for a runnable at the current cursor position
map("n", "<leader>rr", vim.cmd.RustLsp "run", opts "Run (rust-analyzer)")

-- Let rust-analyzer list all testables in the current scope
map("n", "<leader>tt", vim.cmd.RustLsp "run", opts "List tests (rust-analyzer)")
