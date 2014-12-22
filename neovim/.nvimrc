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
set timeout                     " Lower delay of escapting out of other modes (3 lines)
set timeoutlen=5000             "
set ttimeoutlen=0               "
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

set so=0                        " Lines of context at the bottom / top of document.
set list
set listchars=tab:▸\ ,trail:+,extends:❯,precedes:❮

if has('nvim')
  " See: https://github.com/neovim/neovim/issues/1179
  " Try: pip instal git+https://github.com/neovim/python-client.git
  runtime! python_setup.vim
endif

" See :help nvim_clipboard. Works great on arch.
if has('nvim')
  set clipboard=unnamed
endif

" Setup persistent undo/redo. Quite nice.
silent !mkdir ~/.nvim/backups > /dev/null 2>&1
set undodir=~/.nvim/backups
set undofile
set undolevels=1250

" When opening files, return to the last edit position.
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

call plug#begin('~/.nvim/plugged')
Plug 'Shougo/vimproc.vim', { 'do' : './install.sh' }
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'Lokaltog/vim-easymotion'
Plug 'iauns/vim-subbed'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'kana/vim-submode'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/vim-easy-align'
Plug 'tomtom/tcomment_vim'
Plug 'wellle/targets.vim'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/seoul256.vim'
Plug 'derekwyatt/vim-fswitch'
"Plug 'airblade/vim-gitgutter'
Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'
" TODO: Figure out all text objection
Plug 'michaeljsmith/vim-indent-object'
"Plug 'tmhedberg/indent-motion'
Plug 'Raimondi/delimitMate'
" I don't use ultisnips all that often and it was causing a (large) slowdown
" on vim startup. May want to lazily load this.
"Plug 'SirVer/ultisnips'
call plug#end()

"--------------
" Color scheme
"--------------
let g:seoul256_background = 234
set background=dark
colorscheme seoul256
set background=dark

"------------------------------------------
" Key bindings Not Associated With Plugins
"------------------------------------------

nnoremap <silent> <C-n> :FSHere<CR>
noremap <silent> <leader>ov :exe 'e '.$HOME.'/.nvimrc'<CR>
nnoremap <silent> <Leader>fp :let @+=expand("%:p")<cr>:echo "Copied current file
      \ path '".expand("%:p")."' to clipboard"<cr>
nnoremap <silent> <Leader>0 :set paste!<cr>

" Search within visual block.
xnoremap / <esc>/\%V

" select last inserted text
nnoremap gV `[v`]

" Open a quickfix window for the last search
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" replay macro for each line of a visual selection
xnoremap @q :normal @q<CR>
xnoremap @@ :normal @@<CR>
" repeat last command for each line of a visual selection
xnoremap . :normal .<CR>

" Split line command (like join line)
nnoremap S i<CR><ESC><right>

" Hardly ever use m for mark. ! feels more appropriate.
" Remap ! as mark (will replace m eventually -- when a worthy command is found)
nnoremap m !
nnoremap ! m

" m will be remapped later on by easymotion
nnoremap m <nop>
nnoremap M <nop>

" disable Ex mode key and map it to something awesome.
nnoremap Q @@
xnoremap Q @@

noremap <leader>m :Make<CR>

" Remap apostrophe to backtick
nnoremap ' `
nnoremap ` '

" Splitting without ctrl. May not need this. Migrating away
" from tmux and to WM's.
noremap <leader>; :vsplit<CR>
noremap <leader>a :split<CR>

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
nnoremap Y y$

" Disable search highlighting
noremap <silent> <leader>h :noh<CR>

" Navigate between windows. See old vimrc for tmux integrated command.
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" TODO: Think about using c-q for expand snippet, or make expand snippet
" only work in insert mode.
nnoremap <C-e> :wa<CR>

" ---------------- Key remapping ------------------

" U: Redos since 'u' undos
nnoremap U <c-r>

" H: Go to beginning of line. Repeated invocation goes to previous line
noremap <expr> H getpos('.')[2] == 1 ? 'k' : '^'
nnoremap ^ H

" L: Go to end of line. Repeated invocation goes to next line
noremap <expr> L <SID>end_of_line()
function! s:end_of_line()
  let l = len(getline('.'))
  if (l == 0 || l == getpos('.')[2]-1)
    return 'jg_'
  else
    return 'g_'
endfunction

" ---------------- Quick fix / location list toggle ------------------

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>

" ---------------- Previous / Next ------------------

" Location list.
nnoremap <leader>nL :lprevious<CR>
nnoremap <leader>NL :lprevious<CR>
nnoremap <leader>nl :lnext<CR>

" quick fix
nnoremap <leader>, :cn<CR>
nnoremap <leader>' :cp<CR>
nnoremap <leader>. :cc<CR>

" ---------------- Spell checking ------------------
"
noremap <leader>ss :setlocal spell!<CR>
noremap <leader>sn ]s
noremap <leader>sp [s
noremap <leader>sa zg
noremap <leader>sh z=

"---------
" PLUGINS
"---------

" ---------------- Delimit Mate ------------------
" Look into auto-pairs
"silent! imap <CR> <C-g>u<Plug>delimitMateCR

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_balance_matchpairs = 1

" Disable delimit mate in unite buffers.
au FileType unite let b:delimitMate_autoclose = 0

" ---------------- Slime ------------------
let g:slime_target = "tmux"
let g:slime_no_mappings = 1
xmap <leader>i <Plug>SlimeRegionSend
nmap <leader>i <Plug>SlimeMotionSend
nmap <leader>ii <Plug>SlimeLineSend

" Debugging with GDB and Vim using Slime communication.
" Eventually I could build a plugin that keeps track of breakpoints? May not
" be too useful. But possibly.
nmap <leader>ib :exe ':SlimeSend1 b '.expand("%:p:t").":".line('.')<CR>

" I will need to update the b:slime_config variable on a per buffer basis to
" carry around the slime config. I can create global vim variables to do this
" and <leader>ib can check the existence of this variable. If it is set,
" then we should automatically set the buffer local configuration variables
" then call slime. It is a hack to work around slime, but it should work
" temporarily.

" ---------------- Vim Wiki ------------------

" Vim wiki toggle list item.
nmap <silent> <leader>t <Plug>VimwikiToggleListItem
nnoremap <silent> <leader>wo :VimwikiGoto 
nnoremap <silent> <leader>we :VimwikiSearch 
nmap <silent> <leader>wx <Plug>VimwikiToggleListItem

" ---------------- Vim-easy-align keys ------------------
"
vnoremap <silent> <Enter> :EasyAlign<Enter>

" ---------------- gitgutter ------------------

" " Always show the sign column.
" let g:gitgutter_sign_column_always = 0
" let g:gitgutter_map_keys = 0
"
" " Patch next / patch previous
" " nmap <leader>pn <Plug>GitGutterNextHunk
" " nmap <leader>pN <Plug>GitGutterPrevHunk
" nmap ]c <Plug>GitGutterNextHunk
" nmap [c <Plug>GitGutterPrevHunk
"
" " Patch add
" nmap <leader>po <Plug>GitGutterToggle
" nmap <leader>pa <Plug>GitGutterStageHunk
" nmap <leader>pu <Plug>GitGutterRevertHunk
"
" " Preview the patch
" nmap <leader>pv <Plug>GitGutterPreviewHunk
"
" " Disable git gutter initially.
" "execute '<Plug>GitGutterDisable'

" " ---------------- submode ------------------
"
" call submode#enter_with( 'GitPatch', 'n', '', '<leader>pn', ':GitGutterNextHunk<CR>zzzv'  )
" call submode#enter_with( 'GitPatch', 'n', '', '<leader>pN', ':GitGutterPrevHunk<CR>zzzv'  )
" call submode#map( 'GitPatch', 'n', '', 'n', ':GitGutterNextHunk<CR>zzzv'  )
" call submode#map( 'GitPatch', 'n', '', 'N', ':GitGutterPrevHunk<CR>zzzv'  )
"
" call submode#enter_with( 'WinResizeH', 'n', '', '<C-W><', '<C-W><'  )
" call submode#enter_with( 'WinResizeH', 'n', '', '<C-W>>', '<C-W>>'  )
" call submode#map( 'WinResizeH', 'n', '', '>', '<C-W>>'  )
" call submode#map( 'WinResizeH', 'n', '', '=', '<C-W>='  )
" call submode#map( 'WinResizeH', 'n', '', '<', '<C-W><'  )
"
" call submode#enter_with( 'WinResizeV', 'n', '', '<C-W>+', '<C-W>+'  )
" call submode#enter_with( 'WinResizeV', 'n', '', '<C-W>-', '<C-W>-'  )
" call submode#map( 'WinResizeV', 'n', '', '+', '<C-W>+'  )
" call submode#map( 'WinResizeV', 'n', '', '=', '<C-W>='  )
" call submode#map( 'WinResizeV', 'n', '', '-', '<C-W>-'  )

" ---------------- EasyMotion ------------------

map m <Plug>(easymotion-s2)
"let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj;'
let g:EasyMotion_keys = 'aoeidtn,.pyfgcrl;qjkxbmuhs'
let g:EasyMotion_smartcase = 1

map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)

" ---------------- vim-wiki ------------------

let g:vimwiki_list = [
      \{'path':              '~/me/wiki/central',
      \ 'template_path':     '~/me/wiki/templates',
      \ 'template_default':  'default',
      \ 'template_ext':      '.html'}]
let g:vimwiki_url_maxsave = 0

" ---------------- Unite ------------------

let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --hidden -g ""'

" No maximum number of files for max_cache. May want to toggle this on a per
" project basis.
let g:unite_source_file_rec_max_cache_files = 0
call unite#custom#source('file_mru,file_rec,file_rec/async,grepocate', 'max_candidates', 0)

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_selecta'])

" Map '-' to the prefix for Unite.
nnoremap [unite] <Nop>
nmap <leader>u [unite]

nnoremap <silent> <C-p> :<C-u>Unite -no-split -wipe -sync -buffer-name=files file_rec/async file/new<CR>

" Quickly search from buffer directory.
nnoremap <silent> [unite]d  :<C-u>UniteWithBufferDir
      \ -buffer-name=files -prompt=%\  -no-split -wipe buffer file file/new<CR>

nnoremap <silent> [unite]u :<C-u>UniteWithBufferDir -no-split -buffer-name=files file_rec<CR>
nnoremap <silent> [unite]f :<C-u>Unite -no-split -wipe -buffer-name=files -start-insert file file/new<CR>
nnoremap <silent> [unite]b :<C-u>Unite -no-split -wipe -buffer-name=buffers buffer bookmark<CR>
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<CR>
nnoremap <silent> [unite]o :<C-u>Unite -no-split -wipe -buffer-name=outline -vertical outline<CR>
nnoremap <silent> [unite]t :<C-u>Unite -buffer-name=tags -vertical tag<CR>
nnoremap <silent> [unite]p :<C-u>Unite -buffer-name=sessions session<CR>
nnoremap <silent> [unite]a :<C-u>Unite -buffer-name=sources source<CR>
nnoremap <silent> [unite]s :<C-u>Unite -buffer-name=snippets ultisnips<CR>
nnoremap <silent> [unite]g :<C-u>Unite -buffer-name=grep grep:.<CR>
nnoremap <silent> [unite]h :<C-u>Unite -buffer-name=help help<CR>
nnoremap <silent> [unite]l :<C-u>UniteWithCursorWord -buffer-name=search_file line<CR>
nnoremap <silent> [unite]m :<C-u>Unite -buffer-name=mru file_mru<CR>
nnoremap <silent> [unite]n :<C-u>Unite -buffer-name=find find:.<CR>
nnoremap <silent> [unite]c :<C-u>Unite -buffer-name=commands command<CR>
nnoremap <silent> [unite]j :<C-u>Unite -buffer-name=jumps jump<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  imap <buffer> <C-n> <Plug>(unite_select_next_page)
  imap <buffer> <C-p> <Plug>(unite_select_previous_page)

  nmap <buffer> <C-c> <Plug>(unite_exit)
  imap <buffer> <C-c> <Plug>(unite_exit)
  imap <buffer> <c-a> <Plug>(unite_choose_action)
  imap <buffer> <C-w> <Plug>(unite_delete_backward_word)
  imap <buffer> <C-u> <Plug>(unite_delete_backward_path)
  " Quick match is awesome! I use this all of the time.
  imap <buffer> ' <Plug>(unite_quick_match_default_action)
  nmap <buffer> ' <Plug>(unite_quick_match_default_action)
  nmap <buffer> <C-r> <Plug>(unite_redraw)
  imap <buffer> <C-r> <Plug>(unite_redraw)

  " Renaming files from the unite buffer... based on the buffer names we have
  " been assigning to unite.
  let unite = unite#get_current_unite()
  if unite.buffer_name =~# '^search'
    nnoremap <silent><buffer><expr> r unite#do_action('replace')
  else
    nnoremap <silent><buffer><expr> r unite#do_action('rename')
  endif

  " Press 'cd' in normal mode will change vim's current directory to that of
  " the selected file.
  nnoremap <silent><buffer><expr> cd unite#do_action('lcd')

  " Using Ctrl-\ to trigger outline, so close it using the same keystroke
  if unite.buffer_name =~# '^outline'
    imap <buffer> <C-\> <Plug>(unite_exit)
  endif

	nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
	        \ empty(unite#mappings#get_current_filters()) ? ['sorter_reverse'] : [])
endfunction

let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_file_mru_limit = 200
let g:unite_cursor_line_highlight = 'TabLineSel'
let g:unite_source_file_mru_filename_format = ''
let g:unite_source_file_mru_time_format = ''

" if executable('ack-grep')
"   let g:unite_source_grep_command = 'ack-grep'
"   " Match whole word only. This might/might not be a good idea
"   let g:unite_source_grep_default_opts = '--no-heading --no-color -a -w'
"   let g:unite_source_grep_recursive_opt = ''
" elseif executable('ack')
"   let g:unite_source_grep_command = 'ack'
"   let g:unite_source_grep_default_opts = '--no-heading --no-color'
"   let g:unite_source_grep_recursive_opt = ''
" endif
"

" ---------------- Color column ------------------

set colorcolumn=81
hi! link SignColumn LineNr

" Source the :Man command from sources included in vim distro
runtime ftplugin/man.vim
runtime macros/matchit.vim

" Never continue a comment when using 'o' or 'O' in normal mode.
" Comments will only be continued when in insert mode.
autocmd FileType * setlocal formatoptions-=o

" set fillchars+=vert:\│
" hi clear VertSplit
