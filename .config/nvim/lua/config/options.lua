local opt = vim.opt

if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = true,
  }
end

-- UTILITY
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'

opt.ignorecase = true
opt.smartcase = true
opt.history = 1000
opt.updatetime = 200
opt.virtualedit = 'block'
opt.scrolloff = 4
opt.sidescrolloff = 4
-- opt.autochdir = true

-- FORMATTING
opt.shiftwidth = 2
opt.shiftround = true
opt.tabstop = 2
opt.expandtab = true
opt.wrap = true
opt.linebreak = true
opt.conceallevel = 0

-- UI
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.colorcolumn = '80'
opt.title = true
opt.splitright = true
opt.splitbelow = true
opt.cursorline = true
opt.pumwidth = 25
opt.pumheight = 20
opt.laststatus = 3
-- opt.pumblend=10
-- opt.winblend=10
