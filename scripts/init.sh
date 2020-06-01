#!/bin/bash
set -euxo pipefail

REPO="git@github.com:alloy-d/dotfiles.git"
DEST="${HOME}/.dotfiles.d"

mac_checkout() {
  cat <<EOF
!/*
/.editorconfig
/.pryrc
/.tmux.conf

/.config/fish
/.config/git
/.config/kitty
/.config/nvim
/.config/qutebrowser
/.config/ranger

/.gnupg
EOF
}

linux_checkout() {
  cat <<EOF
/*
EOF
}

git clone --no-checkout "${REPO}" "${DEST}"

pushd "${DEST}"
git config core.worktree "${HOME}"
git config core.sparseCheckout true

if [ "$(uname)" = "Darwin" ]; then
  mac_checkout | git sparse-checkout set --stdin
else
  linux_checkout | git sparse-checkout set --stdin
fi

git sparse-checkout add '!/README.md'
git sparse-checkout add '!/scripts'

git checkout master
echo "gitdir: ${HOME}/.dotfiles.d/.git" > ~/.git
