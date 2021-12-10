# vim: set foldmethod=marker:

use readline-binding
use direnv
use platform
use str

use base16

# Helpful things that need initializing {{{

# Zoxide, a directory changer that learns. {{{2
# Set it up as `j` to replace autojump.
eval (zoxide init elvish --cmd j | slurp)
# 2}}}

# ASDF, a generic version manager. {{{2

# On Apple silicon Macs, we need to point ASDF at its unusual
# installation location.  Haven't yet checked an Intel Mac.
if (and (==s $platform:os "darwin") (==s $platform:arch "arm64")) {
  set-env ASDF_DIR /opt/homebrew/opt/asdf/libexec
}

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

set-env DIFFPROG  'nvim -d'
set-env EDITOR    'nvim'
set-env LANG      'en_US.UTF-8'
set-env LC_ALL    'en_US.UTF-8'
set-env MANPAGER  'most'
set-env MANWIDTH  80
set-env TERMINAL  'alacritty'

set paths = [$@paths ~/.local/bin]

# }}}

# Aliases {{{

# These are a mix of small word abbreviations and functions.
# Generally, I like the small word abbreviations better because they
# expand immediately to the real command.  The exception is commands
# that don't take arguments, since abbreviations require you to type
# a trigger character after them, and hitting enter doesn't trigger the
# abbreviation.

# Aliases for git {{{2

edit:small-word-abbr['gp'] = 'git push'
edit:small-word-abbr['gpsu'] = 'git push --set-upstream'

fn gpc { git push origin (git current) }
fn gplc { git pull origin (git current) }
fn gfpo { git fetch --prune origin }

# 2}}}

# Aliases for tmux {{{2

edit:small-word-abbr['tat'] = 'tmux attach -t'  # attach to session
edit:small-word-abbr['tns'] = 'tmux new -s'     # new session
edit:small-word-abbr['tnt'] = 'tmux new -t'     # new session in group
fn tls [@args]{ tmux ls $@args }                # list sessions

# 2}}}

#}}}

# {{{ Prompts

edit:prompt = { tilde-abbr $pwd; styled '> ' green }
edit:rprompt = (constantly (styled (whoami)@(hostname) dim))

# }}}

# Half-baked experiments {{{

# Sets the title of a terminal window.
fn set-title [@title]{
  formatted-title = (str:join ' ' $title)
  print "\e]0;"$formatted-title"\007"
}

fn in-tmux {
  and (has-env TMUX) ^
      (or (==s $E:TERM "screen-256color") ^
          (==s $E:TERM "screen"))
}

# Sets the title of a tmux window.
fn set-name [@name]{
  if (in-tmux) {
    formatted-name = (str:join ' ' $name)
    print "\033k"$formatted-name"\033\\"
  }
}

set edit:after-command = [ $@edit:after-command [_]{ set-name "elvish" } ]
set edit:after-readline = [ $@edit:after-readline [line]{ set-name (edit:wordify $line | take 1) } ]

# }}}
