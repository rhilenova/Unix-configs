if !exists("loaded_setup")
    " put in vim mode
    set nocompatible
    let g:loaded_setup=1
endif

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
Plugin 'bufexplorer.zip'
Plugin 'winmanager'
Plugin 'linediff.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'surround.vim'
Plugin 'python.vim'
Plugin 'systemverilog.vim'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin indent on

set background=dark
colorscheme solarized

" vimscript the hard way
let mapleader=" "
let localleader="\\"

" shortcut to display tabs
nnoremap <leader>l :set list!<CR>

" faster navigation
noremap <C-j> 10j
noremap <C-k> 10k

" center line when searching
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" next and previous button hotkeys
nnoremap <leader>b :bp<CR>
nnoremap <leader>n :bn<CR>

" toggle pastemode
set pastetoggle=<F2>

" map a hotkey for wrap/nowrap
nnoremap <leader>w :set wrap!<CR>

" map a hotkey for the tabmode cycler
nnoremap <F9> :call TabModeHelper()<CR>

" map a hotkey for "do last macro"
nnoremap <C-B> @@

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
nnoremap <Leader>m :call DS_WMToggle()<CR>
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

map <leader>o :vertical rightb wincmd F<CR>

if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

" vimscript the hard way
nnoremap <leader>ev :topleft vertical split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
inoremap jk <esc>

" Syntastic
let g:syntastic_always_populate_loc_list = 1

" Put a diff into all other buffers.
function! GetDiffBuffers()
    return map(filter(range(1, winnr('$')), 'getwinvar(v:val, "&diff")'), 'winbufnr(v:val)')
endfunction

function! DiffPutAll()
    for bufspec in GetDiffBuffers()
        execute 'diffput' bufspec
    endfor
endfunction

command! -range=-1 -nargs=* DPA call DiffPutAll()
