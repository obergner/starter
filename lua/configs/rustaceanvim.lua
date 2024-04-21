vim.g.rustaceanvim = {
  -- LSP configuration
  server = {
    on_attach = function(_, bufnr)
      --------------------------------------------------------------------------------------------
      -- Keymappings
      ---------------------------------------------------------------------------------------------

      local map = vim.keymap.set
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

      -- Toggle inlay hints (inferred types)
      -- Works only on neovim version (+0.10.x) that natively support inlay hints
      map("n", "<leader>ti", function()
        if vim.lsp.inlay_hint then
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(bufnr), { bufnr = bufnr })
        end
      end, opts "LSP Toggle inlay hints")

      ---------------------------------------------------------------------------------------------
      -- Use rust-analyzer features not supported in generic LSP
      ---------------------------------------------------------------------------------------------
      -- supports rust-analyzer's grouping
      -- or vim.lsp.buf.codeAction() if you don't want grouping.
      map({ "n", "v" }, "<leader>ca", vim.cmd.RustLsp "codeAction", opts "Code action")

      -- Use debug configurations created by rust-analyzer
      map("n", "<leader>dd", function()
        vim.cmd.RustLsp "debug"
      end, opts "Debug (rust-analyzer)")

      -- Let rust-analyzer search for a runnable at the current cursor position
      map("n", "<leader>rr", function()
        vim.cmd.RustLsp "run"
      end, opts "Run (rust-analyzer)")

      -- Let rust-analyzer list all testables in the current scope
      map("n", "<leader>tt", function()
        vim.cmd.RustLsp "testables"
      end, opts "List tests (rust-analyzer)")

      -- Let rust-analyzer expand the macro under the cursor
      map("n", "<leader>me", function()
        vim.cmd.RustLsp "expandMacro"
      end, opts "Expand macro (rust-analyzer)")

      -- Grouped code actions
      map("n", "<leader>ca", function()
        vim.cmd.RustLsp "codeAction"
      end, opts "Code actions (rust-analyzer)")
    end,
  },
}
