-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
vim.g.mapleader = ','

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Reload configuration without restart nvim
map('n', '<leader>r', ':so %<CR>')

-- Fast saving with <leader> and s
map('n', '<leader>s', ':w<CR>')
--map('i', '<leader>s', '<C-c>:w<CR>')

-- Close all windows and exit from Neovim with <leader> and q
--map('n', '<leader>q', ':qa!<CR>')

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Terminal mappings
map('n', '<C-t>', ':Term<CR>', { noremap = true })  -- open
map('t', '<Esc>', '<C-\\><C-n>')                    -- exit

-- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>')            -- open/close
map('n', '<leader>n', ':NvimTreeToggle<CR>')        -- open/close
map('n', '<leader>f', ':NvimTreeRefresh<CR>')       -- refresh
-- map('n', '<leader>n', ':NvimTreeFindFile<CR>')      -- search file

-- MINE
map('n', 'bn', ':BufferNext<CR>')                   -- next bufer
map('n', 'bp', ':BufferPrevious<CR>')               -- prev bufer
map('n', 'bd', ':BufferClose<CR>')                  -- delete bufer
map('n', '<C-b><C-n>', ':BufferNext<CR>')           -- next bufer
map('n', '<C-b><C-p>', ':BufferPrevious<CR>')       -- prev bufer
map('n', '<C-b><C-d>', ':BufferClose<CR>')          -- delete bufer
map('n', '<A-Left>', ':BufferMovePrevious<CR>')     -- move buffer to left
map('i', '<A-Left>', '<Esc>:BufferMovePrevious<CR>')-- move buffer to left
map('n', '<A-Right>', ':BufferMoveNext<CR>')        -- move buffer to right
map('i', '<A-Right>', '<Esc>:BufferMoveNext<CR>')   -- move buffer to right
map('n', '<S-Left>', 'B')
map('i', '<S-Left>', '<Esc>Bi')
map('n', '<S-Right>', 'E')
map('i', '<S-Right>', '<Esc>Ea')
map('n', 'ww', '<C-w><C-w>')                        -- next window
map('n', 'wW', '<C-w><C-w>')                        -- next window
map('n', 'w<C-w>', '<C-w><C-w>')                    -- next window
map('n', 'wa', '<C-w><S-w>')                        -- prev window
map('n', 'wq', '<C-w><C-q>')                        -- delete window
map('n', '<C-Up>', ':m .-2<CR>')                    -- move line up
map('i', '<C-Up>', '<Esc>:m .-2<CR>a')              -- move line up insert mode
map('n', '<C-Down>', ':m .+1<CR>')                  -- move line down
map('i', '<C-Down>', '<Esc>:m .+1<CR>a')            -- move line down insert mode
map('n', '<A-BS>', '"_dF ')                         -- delete back word until space
map('i', '<A-BS>', '<Esc><Right>"_dF i')            -- delete back word until space insert mode
map('n', '<C-H>', '"_db')                           -- delete back word
map('i', '<C-H>', '<C-w>')                          -- delete back word insert mode
map('n', '<C-Del>', '"_dw')                         -- delete front word
map('i', '<C-Del>', '<Esc><Right>"_cw')             -- delete front word insert mode
map('n', '<A-Del>', '"_df ')                        -- delete front word until space
map('i', '<A-Del>', '<Esc><Right>"_df i')           -- delete front word until space insert mode
map('n', '<S-Del>', '"_df ')                        -- delete front word until space
map('i', '<S-Del>', '<Esc><Right>"_df i')           -- delete front word until space insert mode
map('n', '<leader>l', ':lcd %:p:h<CR>')             -- set current nganu project
map('n', '<C-c>', ':w<CR>:silent Compile<CR>')
map('i', '<C-c>', '<Esc>:w<CR>:silent Compile<CR>')
map('n', '<leader>c', ':w<CR>:Compile<CR>')
