return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { "<leader>g", "<cmd>LazyGit<cr>", desc = "LazyGit" }
  },
  config = function ()
    vim.g.lazygit_floating_window_scaling_factor = 0.9
    vim.api.nvim_set_hl(0, 'LazyGitBorder', { link='TelescopeBorder' })
  end
}
