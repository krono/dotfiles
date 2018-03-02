#!/bin/ksh

if [ -z "$OSTYPE" ]; then
  export OSTYPE=`uname -s | tr A-Z a-z`
fi


if echo $KSH_VERSION | grep -qi 'PD KSH'; then
  export PDKSH=1
  SHID="π"
else
  SHID="κ"
fi

[ -f ~/.shrc ] && . ~/.shrc

settitle () {
        printf "\e]0;%s\a" "$1"
        if [ ! -z "$2" ]
        then
            printf "\e]7;%s\a" "$2"
        fi
}


update_terminal_cwd() {
  if [ "$OSTYPE" = "darwin" ]; then
    SEARCH=' '
    REPLACE='%20'
    PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
    settitle "$PWD" "$PWD_URL"
  fi
}


__branch() {
  print -n ""
}
__make_ps1() {
  __EC=$?
  # add
  print -n "$COLOR_RED$__additional_prompt$COLOR_NONE"
  # log/host
  print -n "$COLOR_GREEN$(logname)$COLOR_BLACK@$COLOR_HOST$(hostname -s)"
  print -n " "
  # pwd
  print -n "$COLOR_WHITE_BOLD"
  if [[ "${PWD#$HOME}" != "$PWD" ]]; then
    print -n "~${PWD#$HOME}"
  else
    print -n "$PWD"
  fi
  print -n "$COLOR_NONE"
  # \n
  print -n "$COLOR_NONE\n$COLOR_NONE"
  # cmd#/time
  print -n "$COLOR_BLUE[!|"
  print -n "$(date +'%H:%m:%S')"
  print -n "]$COLOR_NONE"
  print -n " "
  # branch
  print -n "$COLOR_CYAN$(__branch)$COLOR_NONE"
  # shid
  print -n "$COLOR_MAGENTA$SHID$COLOR_NONE"
  print -n " "
  # eop
  if [[ $__EC -ne 0 ]]; then
    print -n "$COLOR_RED"
  else
    print -n "$COLOR_GREEN"
  fi
  print -n "% $COLOR_NONE";
  update_terminal_cwd
  (exit $__EC)
}
PS1='$(__make_ps1)'
