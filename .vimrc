" put in vim mode
set nocompatible

set backspace=indent,eol,start
set ruler        " show the cursor position all the time
set showcmd      " display incomplete commands
set incsearch    " do incremental searching
set mouse=a      " force mouse input to on
set number       " turn on line numbers
syntax on        " turn on syntax hilighting

" turn on tab complete for commands, with longest complete possible
set wildmenu
set wildmode=list:longest,full

" Vundle config
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'AnsiEsc.vim'
Plugin 'foldlist'
Plugin 'winmanager'
Plugin 'linediff.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'

call vundle#end()
filetype plugin indent on

" shortcut to display tabs
"nnoremap <C-l> :set list!<CR>

" faster navigation
noremap <C-j> 10j
noremap <C-k> 10k
"noremap <A-left> 5h
"noremap <A-right> 5l
"noremap <A-down> 5j
"noremap <A-up> 5k

" next and previous button hotkeys
nnoremap <C-A-left> :bp<CR>
nnoremap <C-A-right> :bn<CR>

" toggle pastemode
set pastetoggle=<F2>

" map a hotkey for wrap/nowrap
nnoremap <F8> :set wrap!<CR>

" map a hotkey for the tabmode cycler
nnoremap <F9> :call TabModeHelper()<CR>

" map a hotkey for "do last macro"
nnoremap <F10> @@

" TabModeHelper: select a tabmode, or create it if first run
" Cycle through the available tab modes, and call TabModeAbsolute to set the
" mode. Print the mode if not first time
fu! TabModeHelper()
    if !exists("g:curtabmode")
        let g:curtabmode = 0
    elseif g:curtabmode < 2
        let g:curtabmode += 1
        echo "Tab Mode is" g:curtabmode
    else
        let g:curtabmode = 0
        echo "Tab Mode is" g:curtabmode
    endif
    call TabModeAbsolute(g:curtabmode)
endfu

" TabModeAbsolute: set the tab mode based on the argument
fu! TabModeAbsolute(mode)
    if a:mode == 0
        set tabstop=4
        set shiftwidth=4
        set softtabstop=4
        set expandtab
    elseif a:mode == 1
        set tabstop=2
        set shiftwidth=2
        set softtabstop=2
        set expandtab
    elseif a:mode == 2
        set tabstop=4
        set shiftwidth=4
        set softtabstop=4
        set noexpandtab
    endif
endfu

" call TabModeHelper to put in first tab mode
call TabModeHelper()

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

" Settings for window manager plugin
map <C-F12> :call DS_WMToggle<CR>
imap <C-F12> <ESC>:call DS_WMToggle<CR>i
let g:winManagerWindowLayout = 'BufExplorer'
let g:winManagerWidth = 30
let g:bufExplorerSortBy = 'name'

function! DS_WMToggle()
    let currentWindowNumber = winnr() + 1
    execute "WMToggle"
    call DS_GotoWindow(0)
    setlocal winfixwidth
    call DS_GotoWindow(currentWindowNumber)
endfunction

function! DS_GotoWindow(reqdWinNum)
  let startWinNum = winnr()
  if startWinNum == a:reqdWinNum
    return 1
  end
  if winbufnr(a:reqdWinNum) == -1
    return 0
  else
    exe a:reqdWinNum.' wincmd w'
    return 1
  end
endfunction

" Automatically delete trailing whitespace.
autocmd BufWritePre * :%s/\s\+$//e

" Foldlist
let g:Flist_width=40

map <F11> :vertical rightb wincmd f<CR>

if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

" vimscript the hard way
let mapleader=" "
let localleader="\\"
nnoremap <leader>ev :topleft vertical split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
inoremap jk <esc>
"vnoremap jk <esc>

noremap OD <nop>
noremap OC <nop>
noremap OA <nop>
noremap OB <nop>
inoremap <esc> <nop>

let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_python_pylint_post_args = '--rcfile=/home/dsirgey/.pylintrc'
"let g:syntastic_python_pylint_args = '--rcfile=/home/dsirgey/.pylintrc'

"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview
set colorcolumn=73
