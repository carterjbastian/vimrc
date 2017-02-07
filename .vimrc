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

" Use this snippet from the autoclose plugin to make arrow keys work correctly
if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
  inoremap <silent> <C-[>OC <RIGHT>
endif
" }}}

" Movement Mappings {{{
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

" Git commands 
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>ga :Git add %<cr>
nnoremap <leader>gc :Gcommit<cr>

" Splitting windows
nnoremap <leader>sh :leftabove vnew<CR>
nnoremap <leader>sl :rightbelow vnew<CR>
nnoremap <leader>sk :leftabove new<CR>
nnoremap <leader>sj :rightbelow new<CR>

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
" }}}

" Filetype Dependent Autocommands {{{

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

" Filetype-dependent Functions to pre-process or customize settings for a file {{{
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
    iabbrev @#! #!/usr/bin/env python
    map <c-Space>  /def <c-R><c-W>

    " Python code autocompletion
    :ia i/ if ( ): <Up><End><Left><Left><Left>
    :ia ie/ if ( ): <BS><BS> else:<Up><Up><Up><End><Left><Left><Left>
    :ia iee/ if ( ): <BS><BS> elif (  ): <BS> else:<Up><Up>    <Up><Up><Up><End><Left><Left><Left>
    :ia d/ def ( ): """  """<Up><End><Left><Left><Left>
    :ia p/ print ""<Left> 
endfunction

function! PreprocessBashScript()
    0r ~/.vim/templates/template.sh  " Read in the C File template
    %s/DATE/\=strftime("%B, %Y")/g    " Replace the DATE placeholder with month,year
endfunction

function! CustomizeBash()
    iabbrev @#! #!/bin/bash
endfunction

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

" }}}

" Abbreviations and textual shortcuts {{{
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


" Testing ground

