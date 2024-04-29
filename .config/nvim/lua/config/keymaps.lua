local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ','

-- Quick save
map('n', '<leader>s', ':w<CR>')

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
map('n', 'wq', '<C-w><C-q>')

-- Move current line
map('n', '<C-Up>', ':m -2<CR>')
map('i', '<C-Up>', '<Esc>:m -2<CR>a')
map('n', '<C-Down>', ':m +1<CR>')
map('i', '<C-Down>', '<Esc>:m +1<CR>a')

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

-- Compile & Run
_G.compileAndRun = function()
  local ft = vim.bo.filetype
  local cmds = {
    javascript = 'node %',
    typescript = 'tsx %',
    go = 'go run .',
    java = 'javac %; java -cp %:p:h %:t:r',
    python = 'python %:p:t',
  }

  if cmds[ft] then
    vim.cmd(":w")
    vim.cmd("!" .. cmds[ft])
  else
    vim.print("Run command not found for " .. ft)
  end
end

map('n', '<leader>c', ':lua compileAndRun()<CR>')
