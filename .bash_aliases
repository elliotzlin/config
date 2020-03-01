# Some defaults
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'

# Personal preferences
alias sb='source ~/.bash_profile'
alias ap='ansible-playbook'
alias e='emacs'

# Git
function gclean {
    git branch --merged | grep -v "\*" | grep -v " master$" | xargs -n 1 git branch -d
    git fetch -p && for branch in `git branch -vv | grep ': gone]' | awk '{print $1}'`; do git branch -D $branch; done
}

# Docker
function dclean {
    # Remove my exited containers, all dead containers, and all dangling images and volumes
    test -n "`docker ps -q -f status=exited -f Name=.*$USER.*`" && docker rm `docker ps -q -f status=exited -f Name=.*$USER.*`
    test -n "`docker ps -q -f status=dead`" && docker rm -f `docker ps -q -f status=dead`
    test -n "`docker images -q -f dangling=true`" && docker rmi -f `docker images -q -f dangling=true`
    test -n "`docker volume ls -q -f dangling=true`" && docker volume rm `docker volume ls -q -f dangling=true`
}
function dcleana {
    # Remove all exited containers, all dead containers, and all dangling images and volumes
    test -n "`docker ps -q -f status=exited`" && docker rm `docker ps -q -f status=exited`
    test -n "`docker ps -q -f status=dead`" && docker rm -f `docker ps -q -f status=dead`
    test -n "`docker images -q -f dangling=true`" && docker rmi -f `docker images -q -f dangling=true`
    test -n "`docker volume ls -q -f dangling=true`" && docker volume rm `docker volume ls -q -f dangling=true`
}

# Remove backup files
alias clean='rm *~; rm *#; rm *.pyc'
function cleanr {
    (find . -name "*~" -or -name "\#*\#" -or -name "*.pyc") | while read f; do
        echo Removing $f
        rm -f $f
    done
}
