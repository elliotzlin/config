# ~/.profile has the stuff NOT specifically related to bash, such as environment variables (PATH and friends)
# (http://superuser.com/questions/789448/choosing-between-bashrc-profile-bash-profile-etc)

# set PATH so it includes user's private bin if it exists, and find /usr/local/bin ahead of /usr/bin
PATH="/usr/local/bin:$PATH"
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Unicode niceness
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Best editor ever
export VISUAL=vim
export EDITOR="$VISUAL"

# Pretty colors
if [ "$TERM" == "xterm" ] ; then
  export TERM=xterm-256color
fi

# Golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
