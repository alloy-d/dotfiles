# vim: set foldmethod=marker:

use readline-binding
use direnv

use base16

# Helpful things that need initializing {{{

# Zoxide, a directory changer that learns. {{{2
# Set it up as `j` to replace autojump.
eval (zoxide init elvish --cmd j | slurp)
# 2}}}

# ASDF, a generic version manager. {{{2
use asdf _asdf
fn asdf [@args]{ _asdf:asdf $@args }
edit:completion:arg-completer[asdf] = $_asdf:arg-completer~
# 2}}}

# GPG {{{2
set E:GPG_TTY = (tty)
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null
# 2}}}

# }}}

# Environment & Path {{{

set-env DIFFPROG 'nvim -d'
set-env EDITOR 'nvim'
set-env TERMINAL 'alacritty'
set-env MANPAGER 'most'
set-env MANWIDTH 80

set paths = [$@paths ~/.local/bin]

# }}}

# Aliases {{{

# Aliases for git {{{2

edit:small-word-abbr['gp'] = 'git push'
edit:small-word-abbr['gpsu'] = 'git push --set-upstream'

fn gpc { git push origin (git current) }
fn gfpo { git fetch --prune origin }

# 2}}}

# Aliases for tmux {{{2

# Function style:
# fn tat [@args]{ tmux attach -t $@args }
# fn tnt [@args]{ tmux new -t $@args }
# fn tns [@args]{ tmux new -s $@args }
fn tls [@args]{ tmux ls $@args }

# Abbreviation style:
edit:small-word-abbr['tat'] = 'tmux attach -t'  # attach to session
edit:small-word-abbr['tns'] = 'tmux new -s'     # new session
edit:small-word-abbr['tnt'] = 'tmux new -t'     # new session in group
# edit:small-word-abbr['tls'] = 'tmux ls'         # list sessions
# 2}}}

#}}}
