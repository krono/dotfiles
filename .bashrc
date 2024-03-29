#!/bin/bash

[[ -f ~/.shrc ]] && source ~/.shrc

# mac hack
if command -v update_terminal_cwd 2>/dev/null >/dev/null; then
  :
else
  [[ -e /etc/bashrc ]] && . /etc/bashrc
fi

if command -v update_terminal_cwd 2>/dev/null >/dev/null; then 
  UTCWD=update_terminal_cwd
else 
  UTCWD=:
fi

[[ -e ~/.complete.sh ]] && source ~/.complete.sh

#source /Applications/Aquamacs.app/Contents/Resources/etc/emacs.bash

SHID="β"

export __additional_prompt=""

function __branch () {
  B="$(__git_ps1 "${GIT_PS1_FORMAT}")"
  if [[ -z "$B" ]]; then
    B=$(hg prompt "$HG_PROMPT_FORMAT" 2>/dev/null)
    # if [ -z "${B}" ]; then
    #   B=""
    # fi
  fi
  if [[ ! -x "${B}" ]]; then
   B="${B} "
  fi
  printf "%b" "${B}"
}

# function __svc () {
#   case "$(VCPROMPT_FORMAT="%n" vcprompt)" in
#     git) printf "±" ;;
#     hg)  printf "☿" ;;
#     svn) printf "§" ;;
#     *)   : ;;
#   esac
# }

_EXITCODE="%"



function __make_ps1 () {
  shopt -s promptvars
  echo -n '\[${COLOR_NONE}\]'
  echo -n '\[${COLOR_RED}\]'; echo -n '${__additional_prompt}'; echo -n '\[${COLOR_NONE}\]'
  echo -n '\[${COLOR_GREEN}\]\u\[${COLOR_BLACK}\]@\[${COLOR_HOST}\]\h '
  echo -n '\[${COLOR_WHITE_BOLD}\]\w\[${COLOR_NONE}\]'
  echo
  echo -n '\[${COLOR_BLUE}\][\t]'
  echo -n '\[${COLOR_CYAN}\]'; echo -n '$(__branch)'; echo -n '\[${COLOR_NONE}\]'
  echo -n '\[${COLOR_MAGENTA}\]'; echo -n '${SHID}'; echo -n '\[${COLOR_NONE}\]'
  echo -n ' ${_EXITCODE} '
}

export PS1=$(__make_ps1)

function __prompt_command() {
  # Show last commands exit-code by color
  if [[ $? = 0 ]]; then
    _EXITCODE="${COLOR_GREEN_BOLD}\$"
  else
    _EXITCODE="${COLOR_RED_BOLD}\$"
  fi
  _EXITCODE=$_EXITCODE${COLOR_NONE}

  $UTCWD
}


PROMPT_COMMAND=__prompt_command

shopt -s histappend

[[ $TERM = "dumb" ]] && PS1='$ ' && PROMPT_COMMAND=

[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

if [[ -f ~/.fzf.bash ]]; then
  source ~/.fzf.bash
  # take back ^T
  bind -m emacs-standard '"\C-t": transpose-chars'
  # bind -m emacs-standard -x '"\C-t": fzf-file-widget'
fi

# No xon/xoff
stty -ixon

# EOF