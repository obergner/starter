return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -------------------------------------------------------------------------------------
  -- Customizations
  -------------------------------------------------------------------------------------

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
    },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "clangd",
        "clang-format",
        "codelldb",
        "rust-analyzer",
        "pyright",
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "c",
        "query",
        "bash",
        "cmake",
        "cpp",
        "dockerfile",
        "make",
        "rust",
        "toml",
      },
    },
  },

  --------------------------------------------------------------------------------------
  -- DON'T CONFIGURE rust-analyzer MANUALLY!
  -- We use rustaceanvim instead, a filetype plugin that configures rust-analyzer
  -- automatically
  --------------------------------------------------------------------------------------

  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      require "configs.rustaceanvim"
    end,
  },

  {
    "saecki/crates.nvim",
    tag = "stable",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end,
  },

  -------------------------------------------------------------------------------------
  -- Debug support using DAP
  -------------------------------------------------------------------------------------

  {
    "mfussenegger/nvim-dap",
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -------------------------------------------------------------------------------------
  -- auto-cd to root of git project
  -- 'airblade/vim-rooter'
  -------------------------------------------------------------------------------------

  -- TODO: FixIt - This does not seem to work righ now :-(
  {
    "notjedi/nvim-rooter.lua",
    config = function()
      require("nvim-rooter").setup()
    end,
  },
  -- Extend NVChad's default options for nvim-tree to support nvim-rooter
  -- See: https://github.com/notjedi/nvim-rooter.lua?tab=readme-ov-file#usage
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      local opts = require "nvchad.configs.nvimtree"
      opts.update_cwd = true
      opts.update_focused_file = {
        enable = true,
        update_cwd = true,
      }
      return opts
    end,
  },

  -------------------------------------------------------------------------------------
  -- inline function signatures
  -------------------------------------------------------------------------------------

  -- TODO: FixIt - This does not seem to work righ now :-(
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.lsp_signature"
    end,
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },

  -------------------------------------------------------------------------------------
  -- Use neotest for executing tests:
  -- https://github.com/nvim-neotest/neotest
  --
  -- ATTENTION: Do NOT install neotest-rust adapter since we use rustaceanvim's neotest
  --            integration (https://github.com/mrcjkb/rustaceanvim?tab=readme-ov-file)
  -------------------------------------------------------------------------------------

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require "configs.neotest"
    end,
  },
}
