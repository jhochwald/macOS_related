# .bashrc

# User specific aliases and functions
alias ls='ls -G'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias cp='cp -i'
alias l.='ls -Gd .*'
alias ll='ls -Gltr'
alias la='ls -Gla'
alias mv='mv -i'
alias rm='rm -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export CLICOLOR=1
export LSCOLORS=ExCxhxdxbxegedabaghbag
export COPYFILE_DISABLE=true

declare -x PS1='\[\033[1;33m\]\u\[\033[1;37m\]@\[\033[1;32m\]\h\[\033[1;37m\]:\[\033[1;31m\]\w \[\033[1;36m\]\$ \[\033[0m\]'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

#alias sudo='/usr/local/bin/sudo'
#alias visudo='/usr/local/bin/visudo'

#[ -n "$PS1" ] && source ~/.bash_profile;

alias gitinfo='git log --all --decorate --oneline --graph'
