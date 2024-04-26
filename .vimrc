" Autoexec
set updatetime=1000
set tabstop=2
set shiftwidth=2
set cursorline
set colorcolumn=1
set number relativenumber
set guicursor+=a:-blinkwait175-blinkoff150-blinkon175
set clipboard=unnamedplus
set autochdir
set mouse=a
set ignorecase
set smartcase
set colorcolumn=80
highlight ColorColumn ctermbg=0
set synmaxcol=400
syntax sync minlines=100

" Custom Commands
map <C-b><C-n> :bn!<CR>
map <C-b><C-p> :bp!<CR>
map <C-b><C-d> :bd!<CR>
map bn :bn!<CR>
map bp :bp!<CR>
map bd :bd!<CR>
map ww <C-w><C-w>
map wa <C-w><S-w>
map wq <C-w><C-q>
tnoremap <Esc> <C-\><C-n>
nnoremap <C-Down> :m .+1<CR>
nnoremap <C-Up> :m .-2<CR>

" Colors
if (has('termguicolors'))
 set termguicolors
endif
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"colorscheme night-owl
syntax enable
hi MatchParen guibg=black ctermbg=black guifg=white ctermfg=white gui=underline cterm=underline
hi ColorColumn guibg=#011740 ctermbg=235
hi LineNr guifg=#6f6f6f ctermfg=238
hi Normal guibg=NONE
