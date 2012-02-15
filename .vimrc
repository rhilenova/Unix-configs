" put in vim mode
set nocompatible
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set ruler        " show the cursor position all the time
set showcmd      " display incomplete commands
set incsearch    " do incremental searching
set mouse=a      " force mouse input to on
syntax on        " turn on syntax hilighting
" turn on tab complete for commands, with longest complete possible
set wildmenu
set wildmode=list:longest,full

" cindent options, probably need some work
set cindent
set cinoptions=">4:4=4g0h4"
set cink-=0#

" shortcut to display tabs
map <C-l> :set list!<CR>

" faster navigation
map <C-down> 10j
map <C-up> 10k
map <A-left> 5h
map <A-right> 5l
map <A-down> 5j
map <A-up> 5k

" next and previous button hotkeys
map <C-A-left> :bp<CR>
map <C-A-right> :bn<CR>

" toggle pastemode
set pastetoggle=<F2>

" add or remove comments from a line
map <C-m> I/*<ESC>A*/<ESC>
map <C-A-m> I<DEL><DEL><ESC>A<BS><BS><ESC>

" map a hotkey for wrap/nowrap
map <F8> :set wrap!<CR>

" map a hotkey for the tabmode cycler
map <F9> :call TabModeHelper()<CR>

" map a hotkey for "do last macro"
map <F10> @@

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

