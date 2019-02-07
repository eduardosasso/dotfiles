set nocompatible        " disable compatibility mode with vi
set number              " show line numbers
set wrap                " wrap lines
set encoding=utf-8      " set encoding to UTF-8 (default was "latin1")
set mouse=a             " enable mouse support (might not work well on Mac OS X)
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw screen only when we need to
set showmatch           " highlight matching parentheses / brackets [{()}]
set laststatus=2        " always show statusline (even with only single window)
set ruler               " show line and column number of the cursor on right side of statusline
set visualbell          " blink cursor on error, instead of beeping

set expandtab           " convert <TAB> key-presses to spaces

set softtabstop=2
set tabstop=2
set shiftwidth=2
set showcmd "show command in bottom bar
" set cursorline "highlight current line
" filetype indent on "load filetype-specific indent files
syntax enable
filetype plugin indent on
" set guioptions=
" set guifont=Hack:h14

set autoindent          " copy indent from current line when starting a new line
set smartindent         " even better autoindent (e.g. add indent after '{')
" set autochdir           " change to dir in current file useful for creating new files under same folder
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" Use case insensitive search, except when using capital letters<Paste>
set ignorecase
set smartcase
" turn off search highlighting with <CR> (carriage-return)
nnoremap <CR> :nohlsearch<CR><CR>

let mapleader = ','
set rtp+=/usr/local/opt/fzf
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Plug 'ctrlpvim/ctrlp.vim'
" A
" de /Users/eduardosasso/Dropbox/prompts/example.js
"
Plug 'kaicataldo/material.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'w0rp/ale'
Plug 'terryma/vim-multiple-cursors'
Plug 'mhartington/oceanic-next'
Plug 'hzchirs/vim-material'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tpope/vim-rails'
" Plug 'ryanoasis/vim-devicons'
" Plug 'tpope/vim-sensible'
" Plug 'rakr/vim-one'
"Plug 'hzchirs/vim-material'
"  You will load your plugin here
"  Make sure you use single quotes
" Initialize plugin system
call plug#end()

set background=dark

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set guitablabel=%t

" let g:material_theme_style = 'dark'
" let g:airline_theme = 'material'
" colorscheme material
if (has("autocmd") && !has("gui_running"))
  augroup colors
    autocmd!
    let s:background = { "gui": "#212121", "cterm": "235", "cterm16": "0" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "bg": s:background }) "No `fg` setting
  augroup END
endif
colorscheme onedark
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 0
" let g:airline_theme='one'

let g:airline_powerline_fonts = 1

" Map movement through errors without wrapping.
nmap <silent> <C-k> <Plug>(ale_previous)
nmap <silent> <C-j> <Plug>(ale_next)
 
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

let g:airline_skip_empty_sections = 1
let g:ale_set_highlights = 0
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '.'
" let g:ale_lint_on_text_changed = 'never'
" You can disable this option too
" " if you don't want linters to run on opening a file
" let g:ale_lint_on_enter = 0
" let g:airline_solarized_bg='dark'
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
"   \   <bang>0 ? fzf#vim#with_preview('up:60%')
"   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \   <bang>0)

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

"send to clipboard when yank cut
set clipboard+=unnamedplus
nnoremap <c-p> :FZF <cr>
nnoremap <c-s> :Rg <cr>
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
" "command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
