local options = {
  adapters = {
    -- We use rustaceanvim's custom neotest integration instead of
    -- neotest's standard neotest-rust adapter for running rust tests
    require "rustaceanvim.neotest",
  },
}

require("neotest").setup(options)
