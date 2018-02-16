"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is from OS X's default vimrc, which brew's does not ship
" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark     " Assume a dark background
" The next two lines ensure that the ~/.vim/bundle/ system works
runtime! autoload/pathogen.vim
silent! call pathogen#helptags()
silent! call pathogen#runtime_append_all_bundles()

if !has('win32') && !has('win64')
  set term=$TERM       " Make arrow and other keys work
endif

filetype plugin indent on   " Automatically detect file types.
syntax on                   " syntax highlighting
set mouse=a                 " automatically enable mouse usage
scriptencoding utf-8

set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set virtualedit=onemore         " allow for cursor beyond last character
set history=9000                " Store a ton of history (default is 20)
"set spell                       " spell checking on

set backup                      " backups are nice ...
set backupdir=$HOME/.vim/_backup//  " but not when they clog .
set directory=$HOME/.vim/_swap//     " Same for swap files
set viewdir=$HOME/.vim/_views//  " same for view files

set tabpagemax=15               " only show 15 tabs
set showmode                    " display the current mode

color default

if has('cmdline_info')
  set ruler                   " show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) "
  set showcmd
endif

if has('statusline')
  set laststatus=2
         " Broken down into easily includeable segments
         set statusline=%<%f\   " Filename
         set statusline+=%w%h%m%r " Options
         set statusline+=%{fugitive#statusline()} "  Git Hotness
         set statusline+=\ [%{&ff}/%Y]            " filetype
         set statusline+=\ [%{getcwd()}]          " current dir
         "set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char
         set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

set backspace=indent,eol,start  " backspace for dummys
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " show matching brackets/parenthesis
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set winminheight=0              " windows can be 0 line high 
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present
set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=3                 " minimum lines to keep above and below cursor
set foldenable                  " auto fold code
set gdefault                    " the /g flag on :s substitutions by default
set list
set listchars=tab:»\ ,trail:.,extends:#,nbsp:. " Highlight problematic whitespace


set nowrap                      " wrap long lines
set autoindent                  " indent at the same level of the previous line
set shiftwidth=4                " use indents of 4 spaces
set expandtab                   " tabs are spaces, not tabs
set tabstop=4                   " an indentation every four columns
set softtabstop=4               " let backspace delete indent

" Stupid shift key fixes
cmap W w
cmap WQ wq
cmap wQ wq
cmap Q q
cmap Tabe tabe

"clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>


" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

if (has("termguicolors"))
  set termguicolors
else
  set t_Co=256
endif

syntax on
set fileformats=unix,mac,dos

if filereadable(expand("~/dev/pypy/pypy/rpython/jit/tool/pypytrace.vim"))
   autocmd BufRead,BufNewFile *.pypylog    set filetype=pypytrace
   autocmd BufRead,BufNewFile *.pypylog    set nolist
   autocmd BufRead,BufNewFile *.pypylog    set listchars=""
   autocmd BufRead,BufNewFile *.pypytrace set filetype=pypytrace
   autocmd BufRead,BufNewFile *.pypytrace set nolist
   autocmd BufRead,BufNewFile *.pypytrace set listchars=""
   autocmd Syntax pypytrace source ~/dev/pypy/pypy/rpython/jit/tool/pypytrace.vim
endif

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
