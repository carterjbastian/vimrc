" Carter J. Bastian's .vimrc file

" To get folds to work, use :set fdm=marker
" Toggle a fold with 'za', open all with 'zR', close all with 'zM'
" Alterantively, open a fold with 'zo' and close it with 'zc'

" Always check `:help index.txt` and `:map!` before mapping to makes sure that
" you aren't overriding anything you'd like to keep.

" Plugins {{{
" Load the following plugins: fugitive.vim, python-mode
call pathogen#infect()
call pathogen#helptags()

" Configure pymode so that it only does what I want
let g:pymode = 1 

" Turn off unwanted python features
let g:pymode_options = 0
let g:pymode_folding = 0
let g:pymode_doc = 0
let g:pymode_virtualenv = 0
let g:pymode_breakpoint = 0
let g:pymode_rope = 0
let g:pymode_syntax = 0
let g:pymode_lint = 0

" Turn on only the things I want
let g:pymode_trim_whitespaces = 1 " Trim whitespaces on save
let g:pymode_run = 1 " Binds running python code to <leader>r
let g:pymode_motion = 1
let g:pymode_indent = 1 " Python indentation
" }}}

" Basic Settings {{{
set nocompatible
set showcmd
set backspace=indent,eol,start
set timeoutlen=750 " Three Quarters the Default timeout length
:set vb " Visual Bell
set autoindent " Turn on autoindent
set smartindent " Turn on smart indentation
set number
set hlsearch
set sidescroll=5
set ignorecase
set smartcase

set colorcolumn=80
syntax on
filetype on
set shiftwidth=4
set softtabstop=4
set expandtab
filetype plugin indent on
let g:colors_name = "default"

" Use this snippet from the autoclose plugin to make arrow keys work correctly
if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
  inoremap <silent> <C-[>OC <RIGHT>
endif
" }}}

" Tab and Window Mappings {{{
nnoremap gh gT
nnoremap gl gt
nnoremap gH :tabmove -1<CR>
nnoremap gL :tabmove +1<CR>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

nnoremap <m-j> <C-w>J
nnoremap <m-k> <C-w>K
nnoremap <m-l> <C-w>L
nnoremap <m-h> <C-w>H

" Splitting windows
nnoremap <leader>sh :leftabove vnew<CR>
nnoremap <leader>sl :rightbelow vnew<CR>
nnoremap <leader>sk :leftabove new<CR>
nnoremap <leader>sj :rightbelow new<CR>

" Shortcuts for switching to a certain tab
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

" Shortcut to open a new tab
nnoremap <C-t> :tabe 
" }}}

" Key re-mappings {{{
" Remap the leader key and remove default spacebar functionality
nnoremap <space> <nop>
vnoremap <space> <nop>

let mapleader = " " " Set the map leader

" Change the <esc> key mapping and remove the old one
inoremap jk <esc>
cnoremap jk <esc>
vnoremap <v> <esc>

inoremap <esc> <nop>
vnoremap <esc> <nop>

" Remap the control sequences to their C- counter parts
inoremap  <c-l>
inoremap  <c-b>
inoremap  <c-z>

" Short vimscript to fix the option key to meta in OS X {{{
" This is magic. It works because it says so in
" http://vim.wikia.com/wiki/Fix_meta-keys_that_break_out_of_Insert_mode
let c='a'
while c <= 'z'
  exec "set <M-".tolower(c).">=\e".c
  exec "imap \e".c." <M-".tolower(c).">"
  let c = nr2char(1+char2nr(c))
endw
" }}}

" }}}

" Leader-key shortcuts {{{

" Writing the file and quiting
" Awful Nemonics = write-leave, quit-nosave, quit-edit
nnoremap <leader>w :w<cr>
nnoremap <leader>wl :wq<cr>
nnoremap <leader>qn :q!<cr>

" Command to write-quit current file and open a different file in the same buffer
command! -nargs=1 -complete=file WriteEditFile w|bd|e <args>
nnoremap <leader>we :WriteEditFile 


" Edit or source my vimrc
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>es :source ~/.vimrc<cr>

" Shorcuts for toggling settings
nnoremap <leader>tn :set relativenumber!<cr>
nnoremap <leader>tp :set paste!<cr>
nnoremap <leader>th :set hlsearch!<cr>

" Git commands 
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>ga :Git add %<cr>
nnoremap <leader>gc :Gcommit<cr>
" }}}

" Custom Operations (Control Key Mappings) {{{

" Insert Mode Operations {{{

" toggle capitalization of {count} words (Doesn't work on single Characters)
inoremap <c-l> <esc>hEvBuEa
inoremap <c-u> <esc>hEvBUEa

" clear current line and continue in insert mode where the first character was
inoremap <c-o> <esc>$v^c
" }}}

" Normal Mode Operations {{{
" Clear the current line and enter insert mode where the first character was
nnoremap <c-o> $v^c
" Clear everything on the current line
nnoremap <c-n> $v0x
" }}}

" Visual Mode Operations {{{
" Wrap a visual selection in quotes
vnoremap q xi '<c-R>"'<esc>
vnoremap Q xi "<c-R>""<esc>
" }}}
" }}}

" Smaller Customizations (Meta Key Mappings) {{{
" Start editing on the beginning or end of the file
nnoremap <m-b> ggO
nnoremap <m-e> Go
" Turn off highlighting (after search)
nnoremap <m-n> :noh<cr>

" Move a line or group of lines up or down by count
nnoremap <m-u> @='ddkP'<cr> 
nnoremap <m-d> @='ddjP'<cr>

" Define a function to do the moving to let this work in visual mode
function! MoveGroup(direction, lines) range
    exec 'silent '.a:firstline.','.a:lastline.'d'
    let c = 0
    
    let maxChange = str2nr(a:lines)
    echom maxChange
    while c < maxChange
        if a:direction == "up"
            normal k
        elseif a:direction == "down"
            normal j
        endif

        let c += 1
    endwhile
    normal P
endfunction

command! -nargs=* -range MoveBlock <line1>,<line2>call MoveGroup(<f-args>)

vnoremap <c-d> :MoveBlock down 
vnoremap <c-u> :MoveBlock up 

function! ToggleColorscheme()
    " I switch between my default colorscheme and monokai for now
    if g:colors_name == "default"
        colorscheme monokai
    elseif g:colors_name == "monokai"
        colorscheme default
    endif
endfunction

nnoremap <m-c> :call ToggleColorscheme()<CR>

" }}}

" Filetype Dependent Autocommands {{{

" Function to forgoe the space placed after an abbreviation
" Add <C-R>=Eatchar('\s')<CR> at the end of any iabbr to suppress the white
" space
function! Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunc

" Vimrc setup {{{
" TODO(carter): Fix comment toggling into function that works with any range
function! InitVimrcSettings()
    set fdm=marker " Set up folds to work correctly
    set tw=0 
    set formatoptions-=t " Don't auto-wrap text (except comments)
    " Set up commenting options in normal and visual mode
    nnoremap <c-c> 0i" <esc>
    nnoremap <c-x> 02x
    vnoremap <c-c> : s/^/" /gi<cr>
    vnoremap <c-x> : s/^" //gi<cr>
endfunction

autocmd BufRead ~/.vimrc :call InitVimrcSettings()
" }}}

" Python Customizations {{{
function! PreprocessPythonFile()
    0r ~/.vim/templates/template.py  " Read in the python file template
    %s/DATE/\=strftime("%B, %Y")/g    " Replace the DATE placeholder with month,year
endfunction

function! CustomizePython()
    " Set the commenting shortcuts
    nnoremap <c-c> 0i#  <esc>
    nnoremap <c-x> 02x
    vnoremap <c-c> : s/^/# /gi<cr>
    vnoremap <c-x> : s/^# //gi<cr>
    
    " Set script abbreviation and definition searching
    iabbrev @#! #!/usr/bin/env python<C-R>=Eatchar('\s')<CR>
    map <leader>d  ?def <c-R><c-W><CR>

    " Python code autocompletion
    iabbr <silent> i/ if :<Left><C-R>=Eatchar('\s')<CR>
    iabbr <silent> ie/ if :<CR>else :<Up><End><Left><C-R>=Eatchar('\s')<CR>
    iabbr <silent> iee/ if :<CR>elif :<CR>else :<Up><Up><End><Left><C-R>=Eatchar('\s')<CR>
    iabbr <silent> d/ def():<Cr>""" """<Up><End><Left><Left><Left>
    iabbr <silent> p/ print ""<Left><C-R>=Eatchar('\s')<CR>
    iabbr <silent> c/ class():<CR>""" """<CR>def __init__(self):<CR>""" """<Up><Up><Up><End><Left><Left><Left>
    iabbr <silent> f/ for in :<Left><Left><Left><Left><Left>
    iabbr <silent> w/ with as :<Left><Left><Left><Left><Left>

endfunction

function! PostProcessPython()
    " Auto-set marks based on comments
    :execute "normal! gg/import\<cr>"
    mark i
    :execute "normal! gg/def\<cr>"
    mark f
    :execute "normal! gg/class\<cr>"
    mark c
endfunction
" }}}

" Bash Customizations {{{
function! PreprocessBashScript()
    0r ~/.vim/templates/template.sh  " Read in the C File template
    %s/DATE/\=strftime("%B, %Y")/g    " Replace the DATE placeholder with month,year

    " Replace the Filename in the comment
    let b:filename=expand('%:t:r')
    execute '%s/FNAME/' . b:filename . '/g'
endfunction

function! CustomizeBash()
    iabbrev @#! #!/bin/bash<C-R>=Eatchar('\s')<CR>
endfunction
" }}}

" C Customizations {{{
function! PreprocessCFile()
    0r ~/.vim/templates/template.c  " Read in the C File template
    %s/DATE/\=strftime("%B, %Y")/g    " Replace the DATE placeholder with month,year
    
    " Replace the Filename in the comment
    let b:filename=expand('%:t:r')
    execute '%s/FNAME/' . b:filename . '/g'
endfunction

function! PreprocessHeaderFile()
    0r ~/.vim/templates/template.h  " Read in the Header File template
    %s/DATE/\=strftime("%B, %Y")/g    " Replace the DATE placeholder with month,year
    
    " Replace the Filename in the comment
    let b:filename=expand('%:t:r')
    execute '%s/FNAME/' . b:filename . '/g'

    " Build the Header Guard
    let b:hguard = toupper(b:filename) . '_H_'
    execute '%s/HEADER_GUARD/' . b:hguard . '/g'
endfunction

function! CustomizeC()
    " Set the commenting shortcuts
    nnoremap <c-c> 0i//  <esc>
    nnoremap <c-x> 04x
    vnoremap <c-c> : s/^/\/\/  /gi<cr>
    vnoremap <c-x> : s/^\/\/  //gi<cr>

    " Shortcut for adding a semicolon at the end of a line
    nnoremap <leader>; :execute "normal! mqA;<C-v><ESC>`q"<CR>

    " C code autocompletion
    iabbr <silent> i/ if () {<CR>}<Up><End><Left><Left><Left><C-R>=Eatchar('\s')<CR>
    iabbr <silent> ie/ if () {<CR>} else {<CR>}<Up><Up><End><Left><Left><Left><C-R>=Eatchar('\s')<CR>
    iabbr <silent> iee/ if () {<CR>} else if ( ) {<CR>} else {<CR>}<Up><Up><Up><End><Left><Left><Left><C-R>=Eatchar('\s')<CR>
    iabbr <silent> f/ for (;;;) {<CR>}<Up><End><Left><Left><Left><Left><Left><Left><C-R>=Eatchar('\s')<CR>
    iabbr <silent> w/ while () {<CR>}<Up><End><Left><Left><Left><C-R>=Eatchar('\s')<CR>
    iabbr <silent> d/ do {<CR>} while ()<Left><C-R>=Eatchar('\s')<CR>
    iabbr <silent> s/ switch () {<CR>case  :<CR>break;<CR>case  :<CR>break;<CR>default :<CR>}<Up><Up><Up><Up><Up><Up><End><Left><Left><Left><C-R>=Eatchar('\s')<CR>
    iabbr <silent> m/ int main(int argc, char **agrv) {<CR>/* Main Function */<CR>}<Up><End><C-R>=Eatchar('\s')<CR>
endfunction

function! PostProcessC()
    " Auto-set marks based on comments
    :execute "normal! gg/#include\<cr>"
    mark i
    :execute "normal! gg/declarations\<cr>"
    mark f
    :execute "normal! gg/main(\<cr>"
    mark m
endfunction

function! PostProcessHeader()
    " Auto-set marks based on comments
    :execute "normal! gg/#include\<cr>"
    mark i
    :execute "normal! gg/declarations\<cr>"
    mark f
    :execute "normal! gg/Macro\<cr>"
    mark m
endfunction
" }}}

" Autocommands to call pre-processing functions
au BufNewFile *.py call PreprocessPythonFile()
au BufNewFile *.sh call PreprocessBashScript()
au BufNewFile *.c call PreprocessCFile()
au BufNewFile *h call PreprocessHeaderFile()

au BufNewFile,BufRead *.py call CustomizePython()
au BufNewFile,BufRead *.sh call CustomizeBash()
au BufNewFile,BufRead *.c,*.h call CustomizeC()

au BufReadPost,BufNewFile *py silent! call PostProcessPython()
au BufReadPost,BufNewFile *c silent! call PostProcessC()
au BufReadPost,BufNewFile *h silent! call PostProcessHeader()

" Remove trailing whitespace (but only from code when I know it's ok)
" This happens via pymode, so don't run this command for python mode
au BufWritePre *.sh,*.c,*.h %s/\s\+$//e
" }}}

" abbreviations and textual shortcuts {{{
iabbrev @@ carter.bastian1@gmail.com
iabbrev @n Carter J. Bastian
iabbrev <expr> @d strftime("%b %d, %Y")

" Autocorrect {{{
iabbrev pirnt print
iabbrev prnit print
iabbrev prnt print
iabbrev teh the
iabbrev adn and
" }}}

" }}}
