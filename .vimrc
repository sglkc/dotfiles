" Autoexec
set updatetime=300
set tabstop=2
set shiftwidth=2
set expandtab
set cursorline
set number relativenumber
set signcolumn=yes
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
set clipboard=unnamedplus
set mouse=a
set ignorecase
set smartcase
set shortmess+=c
set colorcolumn=80
set synmaxcol=400
syntax sync minlines=100

" Custom Commands
nnoremap <C-b><C-n> :bn!<CR>
nnoremap <C-b><C-p> :bp!<CR>
nnoremap <C-b><C-d> :bd!<CR>
nnoremap bn :bn!<CR>
nnoremap bp :bp!<CR>
nnoremap bd :bd!<CR>
nnoremap ww <C-w><C-w>
nnoremap wa <C-w><S-w>
nnoremap wq <C-w><C-q>
tnoremap <Esc> <C-\><C-n>
nnoremap <C-Down> :m .+1<CR>
nnoremap <C-Up> :m .-2<CR>

" Colors
if (has('termguicolors'))
 set termguicolors
endif
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme zaibatsu