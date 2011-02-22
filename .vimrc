"Don't be backwards compatible with vi
set nocompatible

" Jump to matching parenthesis/bracket for two seconds
set showmatch
set matchtime=2

" Use backups (to prevent, y'know, wiping out C code with archives...)
"set backup

set si

" Enable syntax highlighting, indenting, etc.
syntax enable

filetype indent plugin on

" Read modelines
set modeline

" Configure folding
"set foldenable
"set foldmethod=syntax

" Number lines
set number

" Show in-progress commands in the status line
set showcmd

" Use lazy redrawing (don't redraw during macros etc.)
set lz

" Use four-space tabs, and expand them
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Highlight extended_variables as such
let perl_extended_vars=1

" Line breaks and wrapping
set lbr
set textwidth=72
set wrap

" Allow viewing of man pages using the :Man command
"runtime! ftplugin/man.vim

" Prettiness
"set cul
set nonumber
"colorscheme darkdot
"colorscheme delek
"colorscheme molokai_trans
colorscheme default
set bg=light
"set bg=dark

set printfont=Inconsolata "just in case it eventually uses the font name
set printoptions=paper:letter

" Search settings
set hlsearch
set incsearch
set ignorecase
"set smartcase

" Load Mercurial support for vcscommand
runtime plugin/vcshg.vim

"" TODO: there must be a better way to do this, no?
" Reduce the shiftwidth for HTML.
au BufEnter *.{html,html.*,haml,sass} setlocal shiftwidth=2
au BufEnter *.{html,html.*,haml,sass} setlocal tabstop=2
au BufEnter *.{html,html.*,haml,sass} setlocal softtabstop=2

" Reduce the shiftwidth for LISP/Scheme
au BufEnter *.{lisp,ss,scm} setlocal shiftwidth=2
au BufEnter *.{lisp,ss,scm} setlocal tabstop=2
au BufEnter *.{lisp,ss,scm} setlocal softtabstop=2

" Reduce the shiftwidth for Ruby
au BufEnter *.rb setlocal shiftwidth=2
au BufEnter *.rb setlocal tabstop=2
au BufEnter *.rb setlocal softtabstop=2

" Reduce the shiftwidth for Java
au BufEnter *.java setlocal shiftwidth=2
au BufEnter *.java setlocal tabstop=2
au BufEnter *.java setlocal softtabstop=2

" Load Haskell stuff
"au BufEnter *.hs compiler ghc
"let g:haddock_browser="/usr/bin/firefox"

" Load LaTeX stuff
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

au BufEnter *.cls set ft=tex

set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

runtime mycolemak.vim
