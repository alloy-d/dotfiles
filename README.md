# Usage

This puts the git working directory in `$HOME`.

Everything _not_ under `.config` is ignored by default, so it's
worthwhile to check for other files occasionally.

At the moment, I still keep [my `vim` configs][vim-config] in a separate
repo.

[vim-config]: https://github.com/alloy-d/vim-config

## Setup

```sh
$ git clone --no-checkout git@github.com:alloy-d/dotfiles.git ~/.dotfiles.d
$ pushd ~/.dotfiles.d
$ git config core.worktree "$HOME"
$ git config core.sparseCheckout true
$ cat | git sparse-checkout set --stdin
/*
!/README.md
^D
$ git checkout master
$ echo "gitdir: ~/.dotfiles.d/.git" > ~/.git
```

## Listing untracked and ignored files

List files and folders in the current directory (probably most useful in
`$HOME`) that are not tracked.

```sh
$ git ls-files --others --directory --exclude-from ~/.config/git/ignore
```
