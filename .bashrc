# This sets up my environment on a Linux dev container

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Bash history
shopt -s checkwinsize
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=-1
HISTFILESIZE=-1
HISTTIMEFORMAT="%Y/%m/%d %T "

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Show Git status in prompt; and provide auto-completion
PROMPT_COMMAND='history -a; __git_ps1 "\[\033[01;32m\]\H\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]" "> ";' # FQDN
if [[ $(uname -r) == *linuxkit ]]; then
    # Don't do git prompt with Docker Desktop (for Mac) because it's super slow.
    # See: https://docs.docker.com/docker-for-mac/osxfs/
    PROMPT_COMMAND='history -a'
    PS1="\[\033[01;32m\]\H\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]> "
fi
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS="yes"
GIT_PS1_SHOWDIRTYSTATE="yes"
GIT_PS1_SHOWSTASHSTATE="yes"
GIT_PS1_SHOWUNTRACKEDFILES="yes"

# Link version controlled dotfiles if they exist
CONFIG_DOTFILES=".bash_profile .profile .bashrc .bash_aliases .vimrc .vim/colors/deus.vim .gitconfig .ssh/config .tmux.conf .config/flake8 .pystartup"
CONFIG_DOTFILES_ROOT="$HOME/git/config"
(
    for dotfile in $CONFIG_DOTFILES; do
	if [ -f $CONFIG_DOTFILES_ROOT/$dotfile ]; then
            mkdir -p ~/`dirname $dotfile`
            ln -sf $CONFIG_DOTFILES_ROOT/$dotfile ~/$dotfile
	fi
    done
) & disown

# Other
function start {
    # Start a specified container
    started=""
    for container in "$@"; do
        if [ "$(docker inspect -f '{{ .State.Running }}' $container)" != true ]; then
            echo "*** Starting Docker container for $container ***"
            docker start $container
            started="1"
        fi
    done
    if [ -n "$started" ]; then
        echo Wait 5 seconds for services to start... && sleep 5
    fi
}
