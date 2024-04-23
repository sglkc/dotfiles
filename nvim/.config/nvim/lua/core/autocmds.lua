-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

-- Color scheme matchup

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
  end
})

-- Remove whitespace on save
autocmd('BufWritePre', {
  pattern = '*',
  command = ":%s/\\s\\+$//e"
})

-- Don't auto commenting new lines
--autocmd('BufEnter', {
--  pattern = '*',
--  command = 'set fo-=c fo-=r fo-=o'
--})

-- Auto lcd for relative buffer names
autocmd('VimEnter', {
  pattern = '*',
  command = 'silent! lcd %:p:h'
})

-- Settings for filetypes:
-- Set indentation to 2 spaces
--augroup('setIndent', { clear = true })
--autocmd('Filetype', {
--  group = 'setIndent',
--  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
--    'yaml', 'lua'
--  },
--  command = 'setlocal shiftwidth=2 tabstop=2'
--})

-- autocmd('FileType', {
--   pattern = { '*.nasm' },
--   command = 'setlocal autoindent noexpandtab shiftwidth=4 tabstop=4'
-- })

augroup('nasm', { clear = true })
autocmd('BufEnter', { group = 'nasm', pattern = { '*.nasm' },
  command = 'setlocal! ft=nasm noexpandtab shiftwidth=8 tabstop=8'
})
autocmd('BufEnter', { group = 'nasm', pattern = { '*.nasm' },
  command = 'lua require("cmp").setup.buffer { enabled = false }'
})
autocmd('BufEnter', { group = 'nasm', pattern = { '*.nasm' },
  command = 'command! Compile !./compile %'
})

autocmd('FileType', {
  pattern = { 'qml' },
  command = 'setlocal! ft=qml'
})

-- Auto buffer colorizer
--autocmd('FileType', {
--  pattern = { 'html', 'css', 'javascript', 'typescript', 'javascriptreact',
--    'lua', 'vim'
--  },
--  command = 'ColorizerAttachToBuffer'
--})

-- Auto javascriptreact syntax
-- autocmd('FileType', {
--   pattern = { 'javascriptreact' },
--   command = 'setlocal syntax=javascriptreact'
-- })

-- Astro syntax
--autocmd('BufEnter', {
--  pattern = { '*.astro' },
--  command = 'setlocal filetype=astro'
--})

-- Terminal settings:
-- Open a Terminal on the right tab
autocmd('CmdlineEnter', {
  command = 'command! Term :botright vsplit term://$SHELL'
})

-- Enter insert mode when switching to terminal
autocmd('TermOpen', {
  command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})

autocmd('TermOpen', {
  command = 'nnoremap <buffer> <C-c> i<C-c>'
})

autocmd('TermOpen', {
  command = 'startinsert'
})

-- Close terminal buffer on process exit
autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert'
})

-- COMPILING COMMANDS!

-- Compile pascal
autocmd('FileType', {
  pattern = { 'pascal' },
  command = "command! Compile !fpc %:p:t | grep -v '^Free Pascal\\|^Copyright\\|^Compiling\\|^Target OS'; echo '' ; if \\! grep -q -i read %:p:t ; then ./%:t:r ; rm ./%:t:r.o ; fi"
})

-- Compile C++ buat Grafika
augroup('CPPCompiles', { clear = true })
autocmd('FileType', {
  group = 'CPPCompiles',
  pattern = { 'cpp' },
  command = 'command! Compile !g++ %:p:t -o %:r -lglfw -lGL -lglut -lm -lX11 -lXi -lpthread -lXrandr -ldl; ./%:r'
})
autocmd('FileType', {
  group = 'CPPCompiles',
  pattern = { 'cpp' },
  command = 'command! CS silent Compile'
})

-- Jalanin pytohn
autocmd('FileType', {
  pattern = { 'python' },
  command = 'command! Compile !python %:p:t'
})

-- Compile java
autocmd('FileType', {
  pattern = { 'java' },
  command = 'command! Compile !javac %; java -cp %:p:h %:t:r'
})

-- Run javascript
autocmd('FileType', {
  pattern = { 'javascript' },
  command = 'command! Compile !node %'
})

-- Run go
autocmd('FileType', {
  pattern = { 'go' },
  command = 'command! Compile !go run .'
})

-- Run typescript
autocmd('FileType', {
  pattern = { 'typescript' },
  command = 'command! Compile !tsx %'
})
