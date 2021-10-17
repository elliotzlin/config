# ~/.zprofile should be super-simple and just load .profile and .zshrc (in that order)
# Adapted from question on bash startup files below:
# (http://superuser.com/questions/789448/choosing-between-bashrc-profile-bash-profile-etc)

. "$HOME/.profile"
. "$HOME/.zshrc"
