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
if [ -z "$KSH_VERSION$BASH_VERSION$ZSH_VERSION" ]; then
  ENV=$HOME/.shrc; export ENV
fi
