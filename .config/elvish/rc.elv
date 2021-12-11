# vim: set foldmethod=marker:

use readline-binding
use direnv
use platform
use str

use base16

# Environment & Path {{{

set-env DIFFPROG  'nvim -d'
set-env EDITOR    'nvim'
set-env LANG      'en_US.UTF-8'
set-env LC_ALL    'en_US.UTF-8'
set-env MANPAGER  'most'
set-env MANWIDTH  80
set-env TERMINAL  'alacritty'

set paths = [$@paths ~/.local/bin ~/.go/bin]

# }}}

# Helpful things that need initializing {{{

# Zoxide, a directory changer that learns. {{{2
# Set it up as `j` to replace autojump.

# FIXME: zoxide suggests this eval thing, but Elvish 0.17 complains
# about it because of deprecations.  Using the hard-coded upgraded
# version in `upgraded/zoxide` for now, instead.

# eval (zoxide init elvis --cmd j | upgrade-scripts-for-0.17 -lambda | slurp)
use upgraded/zoxide _zoxide

# 2}}}

# ASDF, a generic version manager. {{{2

# On Apple silicon Macs, we need to point ASDF at its unusual
# installation location.  Haven't yet checked an Intel Mac.
if (and (==s $platform:os "darwin") (==s $platform:arch "arm64")) {
  set-env ASDF_DIR /opt/homebrew/opt/asdf/libexec
}

# FIXME: This is the module from asdf 0.9.0, run through Elvish's 0.17
# migration script.  This isn't what asdf would have you do, and
# I assume it will eventually subtly break with a newer asdf version.
use upgraded/asdf _asdf
fn asdf {|@args| _asdf:asdf $@args }
set edit:completion:arg-completer[asdf] = $_asdf:arg-completer~
# 2}}}

# GPG {{{2
set E:GPG_TTY = (tty)
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null
# 2}}}

# }}}

# Aliases {{{

# These are a mix of small word abbreviations and functions.
# Generally, I like the small word abbreviations better because they
# expand immediately to the real command.  The exception is commands
# that don't take arguments, since abbreviations require you to type
# a trigger character after them, and hitting enter doesn't trigger the
# abbreviation.

# Aliases for git {{{2

set edit:small-word-abbr['gp'] = 'git push'
set edit:small-word-abbr['gpsu'] = 'git push --set-upstream'

fn gpc { git push origin (git current) }
fn gplc { git pull origin (git current) }
fn gfpo { git fetch --prune origin }

# 2}}}

# Aliases for tmux {{{2

set edit:small-word-abbr['tat'] = 'tmux attach -t'  # attach to session
set edit:small-word-abbr['tns'] = 'tmux new -s'     # new session
set edit:small-word-abbr['tnt'] = 'tmux new -t'     # new session in group
fn tls {|@args| tmux ls $@args }                    # list sessions

# 2}}}

#}}}

# {{{ Prompts

set edit:prompt = { tilde-abbr $pwd; styled '> ' green }
set edit:rprompt = (constantly (styled (whoami)@(hostname) dim))

# }}}

# Half-baked experiments {{{

# Sets the title of a terminal window.
fn set-title {|@title|
  var formatted-title = (str:join ' ' $title)
  print "\e]0;"$formatted-title"\007"
}

fn in-tmux {
  and (has-env TMUX) ^
      (or (==s $E:TERM "screen-256color") ^
          (==s $E:TERM "screen"))
}

# Sets the title of a tmux window.
fn set-name {|@name|
  if (in-tmux) {
    var formatted-name = (str:join ' ' $name)
    print "\033k"$formatted-name"\033\\"
  }
}

set edit:after-command = [ $@edit:after-command {|_| set-name "elvish" } ]
set edit:after-readline = [ $@edit:after-readline {|line| set-name (edit:wordify $line | take 1) } ]

# }}}
