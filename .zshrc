#!/usr/bin/env zsh

PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>$HOME/tmp/startlog.$$
    setopt xtrace prompt_subst
fi

[[ -e ~/.shrc ]] && emulate sh -c 'source ~/.shrc'


bindkey -e
bindkey "^?" backward-delete-char
bindkey "^[[3~" delete-char

if [[ ! -z "${MC_SID}"  || ! -z "${MC_CONTROL_PID}" ]]; then
        bindkey "^J" accept-line
else
        bindkey "^J" self-insert
fi
fpath=(/usr/local/share/zsh/site-functions $fpath) 

# NO XON XOFF
unsetopt FLOW_CONTROL

setopt prompt_subst
autoload -Uz vcs_info

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_TO_HOME

setopt CORRECT
setopt INTERACTIVE_COMMENTS
setopt PRINT_EXIT_VALUE

setopt EXTENDED_GLOB
setopt NO_CASE_GLOB
# disable -p '^'


export WORDCHARS='*?_[]~=&;!#$%^(){}'


function +vi-vcs2symbol() {
  [[ ${hook_com[vcs_orig]} == svn ]] && hook_com[vcs]="§"
  [[ ${hook_com[vcs_orig]} == git ]] && hook_com[vcs]="±"
  [[ ${hook_com[vcs_orig]} == hg ]] && hook_com[vcs]="☿"
}

zstyle ':vcs_info:*+set-message:*' hooks vcs2symbol
zstyle ':vcs_info:*' enable git hg svn bzr
zstyle ':vcs_info:*' actionformats \
    '%s %b%F{3}|%F{1}%a% '
zstyle ':vcs_info:*' formats \
    '%s %b '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

settitle() {
  printf "\e]0;%s\a" "$1"
  if [ ! -z "$2" ]; then
      printf "\e]7;%s\a" "$2";
  fi
}
update_terminal_cwd() {
  case "$OSTYPE" in
      darwin*)
	  local SEARCH=' '
	  local REPLACE='%20'
	  local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
	  settitle "$PWD:t/" "$PWD_URL"
	  ;;
      *)
	  settitle "$PWD"
	  ;;
  esac
}

chpwd_functions=(update_terminal_cwd)

function _set_exitcode() {
  if [ $? = 0 ]; then
    export _EXITCOLOR="${COLOR_NUMBER_GREEN}"
  else
    export _EXITCOLOR="${COLOR_NUMBER_RED}"
  fi
}
precmd () { _set_exitcode; vcs_info }

SHID="ζ"
#SHID=" "

function __make_prompt() {
  echo -n '%F{${COLOR_NUMBER_RED}}${__additional_prompt}%b%k%f';
  echo -n '%F{${COLOR_NUMBER_GREEN}}%n%f%F{${COLOR_NUMBER_BLACK}}@%F{${COLOR_NUMBER_HOST}}%B%m%b%k%f ' # host
  echo -n '%F{${COLOR_NUMBER_WHITE}}%B%6(~=%-2~…/%2~=%~)%b%f'
  echo -n '\n%{\r%}'
  echo -n '%F{${COLOR_NUMBER_BLUE}}[%*]%b%k%f ' # time
  echo -n '%F{${COLOR_NUMBER_MAGENTA}}'; echo -n '${SHID} '; echo -n '%b%k%f' # shid
  echo -n '%F{${COLOR_NUMBER_CYAN}}'; echo -n '${vcs_info_msg_0_}'; echo -n '%b%k%f' # vcs
  echo -n '%F{${_EXITCOLOR}}%B%#%b%k%f '
}


export PS1="$(__make_prompt)"

setopt HIST_FCNTL_LOCK
#setopt -o sharehistory
setopt INC_APPEND_HISTORY
# setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
HISTSIZE=90000
SAVEHIST=90000
HISTFILE=~/.zsh_history

(whence -w run-help | grep -q alias) && unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles

update_terminal_cwd

# Bash-like command editing 
autoload -U edit-command-line;
zle -N edit-command-line;
bindkey '^X^e' edit-command-line;


[[ $TERM = "dumb" ]] && unsetopt zle && PS1='$ '

[[ -e ~/.iterm2_shell_integration.zsh ]] && source ~/.iterm2_shell_integration.zsh 

[[ -e ~/.zcompletion ]] && source ~/.zcompletion

# turn off ZLE bracketed paste in dumb term
# otherwise turn on ZLE bracketed-paste-magic
if [[ $TERM == dumb ]]; then
    unset zle_bracketed_paste
else
    autoload -Uz bracketed-paste-magic
    zle -N bracketed-paste bracketed-paste-magic
fi

autoload -U url-quote-magic
zstyle ':urlglobber' url-other-schema ftp git gopher http https magnet
zstyle ':url-quote-magic:*' url-metas '*?[]^(|)~#='  # dropped { }
zle -N self-insert url-quote-magic

# Entirety of my startup file... then
if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi

# EOF
