" See: https://github.com/neovim/neovim/wiki/Differences-from-vim

" GENERAL SETTINGS
syntax enable
syntax sync minlines=256        " Speed up vim's syntax highlighting
let mapleader="s"               " 
set tabstop=2                   " Number of spaces represented by an actual <Tab> char
set softtabstop=2               " Number of spaces that a <Tab> is converted into
set shiftwidth=2                " Number of spaces for autoindent
set scrolloff=0                 " Lines of vertical padding around cursor
set virtualedit=onemore         " Add one extra 'virtual' space at end of each line
"set laststatus=2                " Always put a status line in (results in gray bar).
"set cmdheight=2                 " Set command window height to 2. Avoids return to continue.
"set showcmd                     " Show partial commands in last line of screen
"set rnu                         " Relative line numbers.
"set nu                          " Show absolute line number on current line when rnu set
"set nostartofline               " 
"set timeout                     " Lower delay of escapting out of other modes (3 lines)
"set timeoutlen=5000             " 
"set ttimeoutlen=0               "
"set linebreak                   " Wraps at 'breakat' instead of middle
"set so=0                        " Lines of context at bottom / top of document
"set noshowmatch                 " Don't show matching brackets (%)
"set shiftround                  " Round indent to multiple of shiftwidth (applies to > and <)
"set sessionoptions-=options     " Don't save options in sessions
"set nocursorcolumn              " Never highlight screen column (speed up highlighting)
"set nocursorline                " Never highlight line (speed up highlighting)
set hlsearch                    " Highlight all search patterns
set expandtab                   " Insert spaces instead of tabs
set autoread                    " Read file when changed externally
set incsearch                   " Enable incremental search
set noswapfile                  " No more *.swp files
set nobackup                    " No backup files (large undo history)
set nowb                        " No backup when writing file to disk
set hidden                      " Allow switching from unsaved buffers
set wildmenu                    " Better command line completion
set wildmode=longest:full,full  " 
set ignorecase                  " Searching: case ignored
set smartcase                   " If capital is entered during search, case is used
set backspace=indent,eol,start  " Allow backspacing over autoindent, line breaks, and insert start
set autoindent                  " Maintain indent
set ruler                       " Display cursor position in status line
set confirm                     " Confirm dialog for save instead of fail
set visualbell                  " Visual bell instead of beep
set t_vb=                       " Disable visual bell (reset terminal code)

" Write to unnamed register (and '*', '+' registers). Easy interaction with system clipboard.
if has ('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

" Hack for getting system clipboard to work.
" Will only work on Linux. Not yet willing to install
" python / pip and install neovim bundle and xerox
" bundle to get this simple functionality to work.
" See https://github.com/neovim/neovim/issues/583
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction

vnoremap <silent> y y:call ClipboardYank()<cr>
vnoremap <silent> d d:call ClipboardYank()<cr>
nnoremap <silent> p :call ClipboardPaste()<cr>p
onoremap <silent> y y:call ClipboardYank()<cr>
onoremap <silent> d d:call ClipboardYank()<cr>

" Setup persistent undo/redo. Quite nice.
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile
set undolevels=1250

" When opening files, return to the last edit position.
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
