# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH

pidof gpg-agent || gpg-agent --daemon --write-env-file "${HOME}/.gpg-agent-info"

