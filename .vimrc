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
set vb " Visual Bell
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

" Key re-mappings {{{
" Remap the leader key and remove default spacebar functionality
nnoremap <space> <NOP>
vnoremap <space> <NOP>

let mapleader = " " " Set the map leader

" Change the <ESC> key mapping and remove the old one
inoremap jk <ESC>
cnoremap jk <ESC>
vnoremap <v> <ESC>
inoremap <ESC> <NOP>
vnoremap <ESC> <NOP>

" Remap the control sequences to their C- counter parts
inoremap  <C-l>
inoremap  <C-b>
inoremap  <C-z>

" A short vimscript to fix the option key to meta in OS X.
" This is magic. It works because it says so in
" http://vim.wikia.com/wiki/Fix_meta-keys_that_break_out_of_Insert_mode
let c='a'
while c <= 'z'
  exec "set <M-".tolower(c).">=\e".c
  exec "imap \e".c." <M-".tolower(c).">"
  let c = nr2char(1+char2nr(c))
endw
" }}}

" Tab and Window Mappings {{{
" Moving between tabs
nnoremap gh gT
nnoremap gl gt
nnoremap gH :tabmove -1<CR>
nnoremap gL :tabmove +1<CR>

" Moving between windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Moving windows
nnoremap <M-j> <C-w>J
nnoremap <M-k> <C-w>K
nnoremap <M-l> <C-w>L
nnoremap <M-h> <C-w>H

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

" Shorcut to close the current window or tab (mimics Chrome shortcut)
nnoremap <M-w> <C-w>c
" }}}

" Leader-key shortcuts {{{

" Writing the file and quiting
" Awful Nemonics = write-leave, quit-nosave, quit-edit
nnoremap <leader>w :w<CR>
nnoremap <leader>wl :wq<CR>
nnoremap <leader>qn :q!<CR>

" Command to write-quit current file and open a different file in the same buffer
command! -nargs=1 -complete=file WriteEditFile w|bd|e <args>
nnoremap <leader>we :WriteEditFile 

" Edit or source my vimrc
nnoremap <leader>ev :vsplit ~/.vimrc<CR>
nnoremap <leader>es :source ~/.vimrc<CR>

" Shorcuts for toggling settings that I only sometimes like
nnoremap <leader>tn :set relativenumber!<CR>
nnoremap <leader>tp :set paste!<CR>
nnoremap <leader>th :set hlsearch!<CR>

" Git commands 
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>ga :Git add %<CR>
nnoremap <leader>gc :Gcommit<CR>
" }}}

" Custom Operations (Control Key Mappings) {{{
" Insert Mode Operations {{{
" toggle capitalization of {count} words (Doesn't work on single Characters)
inoremap <C-l> <ESC>hEvBuEa
inoremap <C-u> <ESC>hEvBUEa

" clear current line and continue in insert mode where the first character was
inoremap <C-o> <ESC>$v^c
" }}}

" Normal Mode Operations {{{
" Clear the current line and enter insert mode where the first character was
nnoremap <C-o> $v^c

" Clear everything on the current line
nnoremap <C-n> $v0x
" }}}

" Visual Mode Operations {{{
" Wrap a visual selection in quotes
vnoremap q xi '<C-R>"'<ESC>
vnoremap Q xi "<C-R>""<ESC>
" }}}
" }}}

" Smaller Customizations (Meta Key Mappings) {{{
" Start editing on the beginning or end of the file
nnoremap <M-b> ggO
nnoremap <M-e> Go

" Turn off highlighting (after search)
nnoremap <M-n> :noh<CR>

" Move a line up or down by count lines
nnoremap <M-u> @='ddkP'<CR> 
nnoremap <M-d> @='ddjP'<CR>

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

" Map the block moving function in visual mode
command! -nargs=* -range MoveBlock <line1>,<line2>call MoveGroup(<f-args>)
vnoremap <C-d> :MoveBlock down 
vnoremap <C-u> :MoveBlock up 

" Function to switch between colorschemes
function! ToggleColorscheme()
    " I switch between my default colorscheme and monokai for now
    if g:colors_name == "default"
        colorscheme monokai
    elseif g:colors_name == "monokai"
        colorscheme default
    endif
endfunction

" Map color scheme toggling
nnoremap <M-c> :call ToggleColorscheme()<CR>
" }}}

" Filetype Dependent Autocommands {{{

" Function to forgoe the space placed after an abbreviation
" Add <C-R>=Eatchar('\s')<CR> at the end of any iabbr to suppress the white
" space. Courtesy of discussion on:
" http://stackoverflow.com/questions/11858927
function! Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunc

" Vimrc setup {{{
function! InitVimrcSettings()
    set fdm=marker " Set up folds to work correctly
    set tw=0 
    set formatoptions-=t " Don't auto-wrap text (except comments)

    " Set up commenting options in normal and visual mode
    nnoremap <C-c> 0i" <ESC>
    nnoremap <C-x> 02x
    vnoremap <C-c> : s/^/" /gi<CR>
    vnoremap <C-x> : s/^" //gi<CR>
endfunction
" }}}

" Python Customizations {{{
function! PreprocessPythonFile()
    0r ~/.vim/templates/template.py  " Read in the python file template
    %s/DATE/\=strftime("%B, %Y")/g    " Replace the DATE placeholder with month,year
endfunction

function! CustomizePython()
    " Set the commenting shortcuts
    nnoremap <C-c> 0i#  <ESC>
    nnoremap <C-x> 02x
    vnoremap <C-c> : s/^/# /gi<CR>
    vnoremap <C-x> : s/^# //gi<CR>
    
    " Set script abbreviation and definition searching
    iabbrev @#! #!/usr/bin/env python<C-R>=Eatchar('\s')<CR>
    map <leader>d  ?def <C-R><C-W><CR>

    " Python code autocompletion
    iabbr <silent> i/ if :<Left><C-R>=Eatchar('\s')<CR>
    iabbr <silent> ie/ if :<CR>else :<Up><End><Left><C-R>=Eatchar('\s')<CR>
    iabbr <silent> iee/ if :<CR>elif :<CR>else :<Up><Up><End><Left><C-R>=Eatchar('\s')<CR>
    iabbr <silent> d/ def():<CR>""" """<Up><End><Left><Left><Left>
    iabbr <silent> p/ print ""<Left><C-R>=Eatchar('\s')<CR>
    iabbr <silent> c/ class():<CR>""" """<CR>def __init__(self):<CR>""" """<Up><Up><Up><End><Left><Left><Left>
    iabbr <silent> f/ for in :<Left><Left><Left><Left><Left>
    iabbr <silent> w/ with as :<Left><Left><Left><Left><Left>
endfunction

function! PostProcessPython()
    " Auto-set marks based on comments
    :execute "normal! gg/import\<CR>"
    mark i
    :execute "normal! gg/def\<CR>"
    mark f
    :execute "normal! gg/class\<CR>"
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

" Javascript Customizations {{{
function! CustomizeJavascript()
    " Use indentation of 2 for JS
    set shiftwidth=2
    set softtabstop=2
endfunction
" }}}

" C Customizations {{{
function! PreprocessCFile()
    0r ~/.vim/templates/template.c  " Read in the C File template
    %s/DATE/\=strftime("%B, %Y")/g    " Replace the DATE placeholder with month,year
    
    " Replace the Filename in the comment
    let b:filename=expand('%:t:r')
    execute '%s/FNAME/' . b:filename . '/g'
    
    " Use indentation of 2 for C
    set shiftwidth=2
    set softtabstop=2
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
    nnoremap <C-c> 0i//  <ESC>
    nnoremap <C-x> 04x
    vnoremap <C-c> : s/^/\/\/  /gi<CR>
    vnoremap <C-x> : s/^\/\/  //gi<CR>

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
    :execute "normal! gg/#include\<CR>"
    mark i
    :execute "normal! gg/declarations\<CR>"
    mark f
    :execute "normal! gg/main(\<CR>"
    mark m
endfunction

function! PostProcessHeader()
    " Auto-set marks based on comments
    :execute "normal! gg/#include\<CR>"
    mark i
    :execute "normal! gg/declarations\<CR>"
    mark f
    :execute "normal! gg/Macro\<CR>"
    mark m
endfunction
" }}}

" I have a hard link between my actual .vimrc and a copy of it in a git repo.
" Run my .vimrc setup in either case.
autocmd BufRead ~/.vimrc,~/brz/vimrc/.vimrc :call InitVimrcSettings()

" Autocommands to call pre/post-processing and customization functions
au BufNewFile *.py call PreprocessPythonFile()
au BufNewFile *.sh call PreprocessBashScript()
au BufNewFile *.c call PreprocessCFile()
au BufNewFile *.h call PreprocessHeaderFile()

au BufNewFile,BufRead *.py call CustomizePython()
au BufNewFile,BufRead *.sh call CustomizeBash()
au BufNewFile,BufRead *.c,*.h call CustomizeC()
au BufNewFile,BufRead *.js call CustomizeJavascript()

au BufReadPost,BufNewFile *.py silent! call PostProcessPython()
au BufReadPost,BufNewFile *.c silent! call PostProcessC()
au BufReadPost,BufNewFile *.h silent! call PostProcessHeader()

" Recognize *.md extension as markdown (Thanks Tim Pope!)
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Remove trailing whitespace (but only from code when I know it's ok)
" This happens via pymode, so don't run this command for python mode
au BufWritePre *.sh,*.c,*.h %s/\s\+$//e
" }}}

" abbreviations and textual shortcuts {{{
" Common abbreviations
iabbrev @@ carter.bastian1@gmail.com
iabbrev @n Carter J. Bastian
iabbrev <expr> @d strftime("%b %d, %Y")

" Autocorrect
iabbrev pirnt print
iabbrev prnit print
iabbrev prnt print
iabbrev teh the
iabbrev adn and
" }}}
