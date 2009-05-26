"Don't be backwards compatible with vi
set nocompatible

" Briefly jump to matching parenthesis/bracket
set showmatch

" Use backups (to prevent, y'know, wiping out C code with archives...)
"set backup

" Enable syntax highlighting, indenting, etc.
syntax enable

filetype on
filetype plugin on
filetype indent plugin on

" Read modelines
set modeline

" Configure folding
set foldenable
set foldmethod=syntax

" Number lines
set number

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
set textwidth=75
set wrap

" Allow viewing of man pages using the :Man command
"runtime! ftplugin/man.vim

" Prettiness
"set cul
"set bg=light
set bg=dark
"colorscheme darkdot
"colorscheme delek


" Search settings
set hlsearch
set incsearch
set ignorecase
"set smartcase

