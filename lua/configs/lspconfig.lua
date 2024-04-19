-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-------------------------------------------------------------------------------------
-- Customizations
-------------------------------------------------------------------------------------

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

-- Enable fixes suggested by an LSP server, e.g. clangd
-- See: https://stackoverflow.com/questions/67988374/neovim-lsp-auto-fix-fix-current
local function quickfix()
  vim.lsp.buf.code_action {
    filter = function(a)
      return a.isPreferred
    end,
    apply = true,
  }
end

vim.keymap.set("n", "<leader>fq", quickfix, { noremap = true, silent = true, desc = "LSP quick fix" })
