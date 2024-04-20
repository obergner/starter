-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "pyright" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-------------------------------------------------------------------------------------
-- Customizations
-------------------------------------------------------------------------------------

-- Experiment: does this show the inferred type?
-- Available starting with neovim 0.10.x
--vim.lsp.inlay_hint.enable(true)

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

-- TODO: Consider moving this code to somewhere better suited
-- See> https://haseebmajid.dev/posts/2023-07-31-how-to-use-neotest-dap-with-lazyvim-for-golang-development/
-- Neotest: running a test
vim.keymap.set("n", "<leader>tn", function()
  require("neotest").run.run()
end, { noremap = true, silent = true, desc = "Run nearest test (neotest)" })

-- Neotest: toggle summary window
vim.keymap.set("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, { noremap = true, silent = true, desc = "Toggle test summary (neotest)" })

-- Neotest: Show test output
vim.keymap.set("n", "<leader>to", function()
  require("neotest").output.open { enter = true, auto_close = true }
end, { noremap = true, silent = true, desc = "Show test output (neotest)" })

-- Neotest: Toggle output panel
vim.keymap.set("n", "<leader>tO", function()
  require("neotest").summary.toggle()
end, { noremap = true, silent = true, desc = "Toggle test output panel (neotest)" })
