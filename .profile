#export LANG=de_DE.UTF-8

if [ -z "$HOME" ]; then
  if [ -d ~ ]; then
    HOME=~
  else
    HOME=/Users/tobias
  fi
fi

[ -f "$HOME/.env" ] && . $HOME/.env

[ -z "$BASH_VERSION" ] || source $HOME/.bashrc
if [ -n "$KSH_VERSION" ]; then
  ENV=$HOME/.kshrc; export ENV
elif [ -z "$BASH_VERSION$ZSH_VERSION" ]; then
  ENV=$HOME/.shrc; export ENV
fi
