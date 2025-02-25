local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- This is temporary, modify mapleader in keymaps.lua!
vim.g.mapleader = ","
vim.g.localmapleader = ","

require("lazy").setup("plugins", {
  concurrency = 4,
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  checker = {
    enabled = true,
    concurrency = 4,
    frequency = 604800
  },
  ui = {
    border = 'single'
  },
  performance = {
    rtp = {
      disabled_plugins = {
        -- "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        -- "tarPlugin",
        "tohtml",
        "tutor",
        -- "zipPlugin",
      },
    },
  },
})
