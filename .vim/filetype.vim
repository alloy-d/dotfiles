runtime! ftdetect/*.vim

augroup filetypedetect
au BufRead,BufNewFile *.go setfiletype go
au BufRead,BufNewFile *.tumblr.html{,.m4} setfiletype tumblr
au BufRead,BufNewFile *.{markdown,mkd,md} setfiletype mkd
au BufRead *-sup.{compose,reply}-mode setfiletype mail
augroup END

