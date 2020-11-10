""""""""""""""""""""""""""""""""""""""""""""""""
" install pathogen
""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()
syntax on
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""
" Status line stuff - vim-airline
""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2                    " always show the status line

let g:airline#extensions#tabline#enabled=1

"""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""
" Show line numbers
set number
" Turn on formatted paste
"set paste
" Turn on the Wild menu
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
" Always show current position
set ruler
" Case insensitive search
set ignorecase
" When searching try to be smart about cases
" set smartcase
" Highlight search results
set hlsearch
" Find words as typing out search
set incsearch
" Enable extended % matching
runtime macros/matchit.vim
" Start scrolling before cursor hits top/bottom
set scrolloff=5
" Number of lines to jump when scrolling off screen
" -# = percentage
set scrolljump=-10

" Set the paste toggle
map <F10> :set paste<cr>
map <F11> :set nopaste<cr>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

set colorcolumn=120
set colorcolumn=+1        " highlight column after 'textwidth'

""""""""""""""""""""""""""""
" => Tags
""""""""""""""""""""""""""""
" setup tags
set tags=./tags;/

""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" set 256 terminal support
set t_Co=256

" Set the colorscheme (different for gui)
color dracula

" Use Unix as the standard file type
set ffs=unix,mac,dos

" Set the mouse to always show
set mouse=r
set nomh

""""""""""""""""""""""""""""
" syntastic
""""""""""""""""""""""""""""
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc.
set nobackup
set nowb
set noswapfile

" Auto change directory
"set acd

" Echo the full path of file being edited
nnoremap <leader>f :echo expand('%:p')<cr>

" Source and Edit vimrc
nnoremap <leader>src :source ~/.vimrc<cr>
nnoremap <leader>erc :vsp ~/.vimrc<cr>

""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Do not expand tab for Makefiles
autocmd FileType make set noexpandtab

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Auto indent and wrap lines
set ai
set wrap

""""""""""""""""""""""""""""
" Misc
""""""""""""""""""""""""""""
" search highlighting
hi Search   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white gui=underline

" Auto remove trailing whitespace on write
autocmd BufWritePre * :%s/\s\+$//e

" rainbow parens
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" keyboard shortcuts
map <D-Right> $
map <D-Left> 0
map <M-Right> w
map <M-Left> b
