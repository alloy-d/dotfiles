# Usage

This puts the git working directory in `$HOME`.

Everything _not_ under `.config` is ignored by default, so it's
worthwhile to check for other files occasionally.

At the moment, I still keep [my `vim` configs][vim-config] in a separate
repo.

[vim-config]: https://github.com/alloy-d/vim-config

## Setup

Somewhat clumsily, this repo includes a script to clone this repo:

```sh
$ DIR=$(mktemp -d)
$ git clone git@github.com:alloy-d/dotfiles.git $DIR
$ $DIR/scripts/init.sh
```

## Listing untracked and ignored files

List files and folders in the current directory (probably most useful in
`$HOME`) that are not tracked.

```sh
$ git ls-files --others --directory --exclude-from ~/.config/git/ignore
```
