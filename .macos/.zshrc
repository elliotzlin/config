# This sets up my environment on macOS
# To install, I create symlinks:
# ln -sf ~/git/config/.profile ~/.profile
# ln -sf ~/git/config/.zprofile ~/.zprofile
# ln -sf ~/git/config/.macos/.zshrc ~/.zshrc

# Bash-like navigation
# https://stackoverflow.com/questions/444951/zsh-stop-backward-kill-word-on-directory-delimiter
autoload -U select-word-style
select-word-style bash

# Homebrew installs under /opt/homebrew on Apple Silicon
# https://docs.brew.sh/Installation
# https://stackoverflow.com/a/65259353
if [[ `uname -m` == 'arm64' ]]; then
    export HOMEBREW_PREFIX="/opt/homebrew";
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    export HOMEBREW_SHELLENV_PREFIX="/opt/homebrew";
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
fi

# History configs
# https://zsh.sourceforge.io/Doc/Release/Options.html#History
# N.B. See also /etc/zshrc_Apple_Terminal for additional behavior on history behavior
# TODO Implement something like save/restore session in zshrc_Apple_Terminal for something like file
# rotation when history file grows too large.
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
HISTSIZE=999999999
SAVEHIST=999999999

# Colorful prompt string
autoload -U colors && colors
PS1_PRE="%B%F{red}%m%f%b:%B%F{blue}%~%f%b" # host in red, dir in blue
PS1_POST="> "
PS1="${PS1_PRE}${PS1_POST}"

# Homebrew shell completion
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit

  # N.B. brew's shell completion instructions fail to source git-prompt.sh for zsh users. :(
  GIT_PROMPT="$(brew --prefix)/etc/bash_completion.d/git-prompt.sh"
  [[ -r $GIT_PROMPT ]] && source $GIT_PROMPT
fi


if [[ -f ~/.zsh_aliases ]]; then
    . ~/.zsh_aliases
fi

# Link version-controlled dotfiles if they exist
# N.B. array parsing. See https://zsh.sourceforge.io/FAQ/zshfaq03.html
CONFIG_DOTFILES=(.emacs .gitconfig .profile .ssh/config .config/flake8 .zprofile .zsh_aliases)
CONFIG_DOTFILES_ROOT="${HOME}/git/config"
(
    for dotfile in $CONFIG_DOTFILES; do
	if [[ -f $CONFIG_DOTFILES_ROOT/$dotfile ]]; then
	    mkdir -p ~/$(dirname $dotfile)
	    ln -sf $CONFIG_DOTFILES_ROOT/$dotfile ~/$dotfile
	fi
    done
) &!

MACOS_DOTFILES=(.zshrc .ssh/config)
MACOS_DOTFILES_ROOT="${HOME}/git/config/.macos"
(
    for dotfile in $MACOS_DOTFILES; do
	if [[ -f $MACOS_DOTFILES_ROOT/$dotfile ]]; then
	    mkdir -p ~/$(dirname $dotfile)
	    ln -sf $MACOS_DOTFILES_ROOT/$dotfile ~/$dotfile
	fi
    done
) &!

# macOS uses BSD flavor of ls, which doesn't support dircolors or --color=auto
alias ls='ls -G'

# Git prompt configs
precmd() { __git_ps1 "$PS1_PRE" "$PS1_POST" }
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS="yes"
GIT_PS1_SHOWDIRTYSTATE="yes"
GIT_PS1_SHOWSTASHSTATE="yes"
GIT_PS1_SHOWUNTRACKEDFILES="yes"

# http://osxdaily.com/2010/06/22/remove-the-last-login-message-from-the-terminal/
# N.B. if you open a new shell with the same working directory that's not the home directory, you
# will see the 'last login' message.
touch ~/.hushlogin

# This is the penultimate line
# Anything below this final line was probably added by a script
