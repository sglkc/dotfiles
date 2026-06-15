local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

local function feedkeys(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), 'n', false)
end

vim.g.mapleader = ','

-- Quick save
map('n', '<leader>w', ':lua vim.lsp.buf.format()<CR>:w<CR>')

-- Quick close
map('n', '<leader>q', ':qa!<CR>')

-- Escape from terminal mode
map('t', '<Esc>', '<C-\\><C-n>')

-- Quick buffer navigation (Check plugins/barbar)
map('n', 'bn', ':bn<CR>')
map('n', 'bp', ':bp<CR>')
map('n', 'bd', ':bd<CR>')

-- Quick window navigation
map('n', 'ww', '<C-w><C-w>')
map('n', 'wW', '<C-w><S-w>')
map('n', 'WW', '<C-w><S-w>')
map('n', 'wq', '<C-w><C-q>')
map('n', 'w<Left>', '<C-w><Left>')
map('n', 'w<Right>', '<C-w><Right>')

-- Smart Home/End in soft-wrapped lines
local function smart_home()
  local screen_col = vim.fn.wincol()
  if screen_col == 1 then return '0'
  else return 'g0' end
end

local function smart_end()
  local current_virt = vim.fn.virtcol('.')
  local win_width = vim.api.nvim_win_get_width(0) - vim.fn.wincol() + vim.fn.virtcol('.')

  -- If we're at the last visible character of the *current screen line*
  -- (i.e. next right move would wrap or go to next buffer line)
  if current_virt == win_width or vim.fn.virtcol('.') == vim.fn.virtcol('$') - 1 then return '$'
  else return 'g$' end
end

map({ 'n', 'x' }, '<Home>', smart_home, { expr = true, silent = true })
map({ 'n', 'x' }, '<End>',  smart_end,  { expr = true, silent = true })
map('i', '<Home>', function() feedkeys('<C-o>' .. smart_home()) end, { silent = true })
map('i', '<End>',  function() feedkeys('<C-o>' .. smart_end())  end, { silent = true })

-- Cursor navigation in soft-wrapped lines
map({ 'n', 'x' }, '<Up>', 'gk')
map({ 'n', 'x' }, '<Down>', 'gj')
map('i', '<Up>', '<C-o>gk')
map('i', '<Down>', '<C-o>gj')

-- Keep center when scrolling
map('n', 'k', 'kzz')
map('n', 'j', 'jzz')

-- Small scroll
map('n', '<C-k>', '<C-U>')
map('n', '<C-Up>', '<C-U>')
map('i', '<C-Up>', '<C-o><C-U>')
map('n', '<C-j>', '<C-D>')
map('n', '<C-Down>', '<C-D>')
map('i', '<C-Down>', '<C-o><C-D>')

-- Move current line
map('n', '<A-Up>', ':m -2<CR>')
map('i', '<A-Up>', '<Esc>:m -2<CR>a')
map('n', '<A-Down>', ':m +1<CR>')
map('i', '<A-Down>', '<Esc>:m +1<CR>a')

-- Delete words
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

-- Prevent deleting from also copying
-- map('n', 'd', '"_d')
-- map('v', 'd', '"_d')
-- map('n', 'dd', '"_dd')
-- map('n', '<leader>d', 'd')
-- map('v', '<leader>d', 'd')
-- map('n', '<leader>dd', 'dd')

-- Delete Shortcut
map('v', '<BS>', '"_d')

-- Compile & Run
_G.compileAndRun = function()
  local ft = vim.bo.filetype
  local cmds = {
    javascript = 'node %',
    typescript = 'tsx %',
    go = 'go run .',
    java = 'javac %; java %:t:r',
    python = 'python %',
    php = 'php %'
  }

  if cmds[ft] then
    vim.cmd(":w")
    vim.cmd("!" .. cmds[ft])
  else
    vim.print("Run command not found for " .. ft)
  end
end

map('n', '<leader>c', ':lua compileAndRun()<CR>')
