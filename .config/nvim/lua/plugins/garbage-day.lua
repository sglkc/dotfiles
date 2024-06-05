return {
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
      grace_period = 10 * 60, -- wait secs after losing focus to stop LSP
      wakeup_delay = 3 * 1000, -- ms
      notifications = true,
      timeout = 3000 -- start retry timeout in ms
    }
  }
}
