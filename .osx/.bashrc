# This sets up my environment on OSX
# To install, I create symlinks:
# ln -sf ~/git/config/.bash_profile ~/.bash_profile
# ln -sf ~/git/config/.osx/.bashrc ~/.bashrc

PS1="\[\033[01;31m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]> " # host in red, dir in blue
shopt -s checkwinsize

# http://unix.stackexchange.com/a/18443/27433
shopt -s histappend
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"
# OSX doesn't seem to like size = -1
HISTCONTROL=ignoreboth
HISTSIZE=9999999
HISTFILESIZE=9999999
HISTTIMEFORMAT="%Y/%m/%d %T "

# https://github.com/kaihendry/dotfiles
test -d ~/.bash_history || mkdir ~/.bash_history
HISTFILE=~/.bash_history/$(date +%Y-%m)

# Search through all my bash history
h() {
    grep -a "$@" ~/.bash_history/*
}

# Homebrew shell completion
# https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Create links from git repos
function mkdir_link {
    if [ -e "$1" ]; then
        mkdir -p $2
        ln -sf $1 $2
    fi
}
(
    for d in ~/git/ezl-*; do
	mkdir_link $d ~/
    done
    unset d
    unset mkdir_link
) & disown

# Link version controlled dotfiles if they exist
CONFIG_DOTFILES=".bash_profile .profile .bash_aliases .emacs .vimrc .vim/colors/deus.vim .gitconfig .ssh/config .config/flake8 .ansible.cfg .pystartup"
CONFIG_DOTFILES_ROOT="$HOME/git/config"
(
    for dotfile in $CONFIG_DOTFILES; do
	if [ -f $CONFIG_DOTFILES_ROOT/$dotfile ]; then
      mkdir -p ~/`dirname $dotfile`
	    ln -sf $CONFIG_DOTFILES_ROOT/$dotfile ~/$dotfile
	fi
    done
) & disown

OSX_DOTFILES=".bashrc .ssh/config"
OSX_DOTFILES_ROOT="${HOME}/git/config/.osx"
(
    for dotfile in $OSX_DOTFILES; do
	if [ -f $OSX_DOTFILES_ROOT/$dotfile ]; then
	    mkdir -p ~/`dirname $dotfile`
      ln -sf $OSX_DOTFILES_ROOT/$dotfile ~/$dotfile
	fi
    done
) & disown

# Vundle
if [ ! -d ~/.vim/bundle ] && [ -n $(which git) ] && [ -n $(which vim) ] && [ -f ~/.vimrc ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    # https://github.com/VundleVim/Vundle.vim/issues/511#issuecomment-134251209
    echo | echo | vim +PluginInstall +qall &>/dev/null
fi

# Custom OSX-specific aliases
alias ls='ls -G'                # OSX doesn't support dircolors or --color=auto

# Docker auto-completion
(curl -sfL https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker > `brew --prefix`/etc/bash_completion.d/docker || echo curl failed for bash completion) & disown

# Git prompt configs
PROMPT_COMMAND="$PROMPT_COMMAND"' __git_ps1 "\[\033[01;31m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]" "> ";' # FQDN
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS="yes"
GIT_PS1_SHOWDIRTYSTATE="yes"
GIT_PS1_SHOWSTASHSTATE="yes"
GIT_PS1_SHOWUNTRACKEDFILES="yes"

# http://osxdaily.com/2010/06/22/remove-the-last-login-message-from-the-terminal/
touch ~/.hushlogin

# SSH Agent / OSX Keychain
ssh-add -AK 2> /dev/null

# Brew asks for this.
export PATH="/usr/local/sbin:$PATH"

# This is the penultimate line
# Anything below this final line was probably added by a script
