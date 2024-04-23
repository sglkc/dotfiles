-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                       -- Enable mouse support
opt.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
--opt.swapfile = false                  -- Don't use swapfile
opt.completeopt = 'menuone,longest,preview'  -- Autocomplete options

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true             -- Show line number
opt.relativenumber = true     -- Relative line number
opt.showmatch = true          -- Highlight matching parenthesis
opt.foldmethod = 'marker'     -- Enable folding (default 'foldmarker')
opt.colorcolumn = '80'        -- Line lenght marker at 80 columns
opt.splitright = true         -- Vertical split to the right
opt.splitbelow = true         -- Horizontal split to the bottom
opt.ignorecase = true         -- Ignore case letters when search
opt.smartcase = true          -- Ignore lowercase for the whole pattern
opt.linebreak = true          -- Wrap on word boundary
opt.termguicolors = true      -- Enable 24-bit RGB colors
opt.laststatus = 2            -- Set global statusline
opt.pumheight = 20            -- Completion max height
opt.pumblend = 15             -- Completion opacity blend
opt.title = true              -- Set terminal title

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true        -- Use spaces instead of tabs
opt.shiftwidth = 2          -- Shift 2 spaces when tab
opt.tabstop = 4             -- 1 tab == 4 spaces
opt.smartindent = true      -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true           -- Enable background buffers
opt.history = 100           -- Remember N lines in history
opt.lazyredraw = true       -- Faster scrolling
opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 700        -- ms to wait for trigger an event

-- MINE
opt.autochdir = true        -- auto directory move
opt.guicursor = opt.guicursor + 'a:-blinkwait175-blinkoff150-blinkon175' -- cursor blink
opt.cursorline = true       -- highlight current line

vim.filetype.add({
  pattern = {
    ['.*%.blade%.php'] = 'blade',
  },
  extension = {
    mdx = 'mdx',
  },
})

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append "sI"

-- -- Disable builtin plugins
local disabled_built_ins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   -- "gzip",
   "logipat",
   --"netrw",
   --"netrwPlugin",
   --"netrwSettings",
   --"netrwFileHandlers",
   "matchit",
   -- "tar",
   -- "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   -- "zip",
   -- "zipPlugin",
   "tutor",
   "rplugin",
   "synmenu",
   "optwin",
   "compiler",
   "bugreport",
   "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
   g["loaded_" .. plugin] = 1
end

vim.lsp.set_log_level("off")
