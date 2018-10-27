# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH
unset USERNAME

source ~/.git-completion.bash

export HOMEBREW_GITHUB_API_TOKEN="<TOKEN_HERE>"

test -e ${HOME}/.iterm2_shell_integration.bash && source ${HOME}/.iterm2_shell_integration.bash
export PATH="/usr/local/sbin:$PATH"

echo $PATH | grep -q -s "/usr/local/bin"
if [ $? -eq 1 ]; then
	PATH=$PATH:/usr/local/bin
	export PATH
fi

/usr/bin/git config --global user.name "<NAME_HERE>"
/usr/bin/git config --global user.email "<MAIL_HERE>"
/usr/bin/git config --global github.user <GITHUB_USER>
/usr/bin/git config --global github.token <TOKEN_HERE>

/usr/bin/git config --global color.diff auto
/usr/bin/git config --global color.status auto
/usr/bin/git config --global color.branch auto

export PROMPT_COMMAND='printf "\033]0;${USER}: ${PWD/$HOME/~}\007"'

# improve bash history
shopt -s histappend
PROMPT_COMMAND=$PROMPT_COMMAND';history -a'

# Store 10000 commands in bash history
export HISTFILESIZE=10000
export HISTSIZE=10000
# Don't put duplicate lines in the history
export HISTCONTROL=ignoredups

export LANG=en_US.UTF-8

alias localip='ifconfig | awk '\''{if($1=="inet" && $5=="broadcast") {print $2}}'\'''
alias remoteip='dig myip.opendns.com @resolver1.opendns.com +short'

# In case you have i2cssh
alias AllCentos='/usr/local/bin/i2cssh -c AllCentos --iterm2 --tab-split'
alias lCentos='/usr/local/bin/i2cssh -c lCentos --iterm2 --tab-split'
alias rCentos='/usr/local/bin/i2cssh -c rCentos --iterm2 --tab-split'

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don?t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2>/dev/null
done

# Add tab completion for many Bash commands
if which brew &>/dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion"
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &>/dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall
