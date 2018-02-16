#!/bin/sh

# (
#   x=`tput op` y=`printf %$((${COLUMNS}-6))s`;
#   for i in {0..256}; do
#     o=00$i;
#     echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i` ${y// /=}$x;
#   done;
# )

# for ((i=0; i<`tput colors`; i++)); do
#   if [ 4 -ne $(( ($i ) % 6 )) ]; then :; else
#     o=00$i
#     printf "\n${o:${#o}-3:3} ";
#   fi;
#   printf "`tput setaf $i`■`tput sgr0``tput setab $i` `tput sgr0`";
# done

case "$COLORTERM" in 
  xfce4-terminal) export TERM=xterm-256color;;
esac

CACHE_FILE="${HOME}/.color.sh.${SHELL_NAME}-${TERM}"

if [ -f "${CACHE_FILE}" ]; then
  . "${CACHE_FILE}"
else
  
  if (tput setaf 1 2>/dev/null >/dev/null) && [ "$NO_ARRAYS" != "1" ]; then
    EXTENDED=1
    _colors=$(tput colors)
    COLORS=( $(for ((i=0; i<_colors; i++));\
                       do printf "$(tput setaf $i) ";\
                    done))
    BGCOLORS=( $(for ((i=0; i<_colors; i++));\
                       do printf "$(tput setab $i) ";\
                    done))
    export COLORS
    export BGCOLORS
    _bold="$(tput bold)"
    if [ $_colors -ge 256 ]; then
      export   COLOR_NUMBER_BLACK=0
      export   COLOR_NUMBER_MAGENTA=165
      export   COLOR_NUMBER_BLUE=33
      export   COLOR_NUMBER_CYAN=51
      export   COLOR_NUMBER_PURPLE=141
      export   COLOR_NUMBER_ORANGE=172
      export   COLOR_NUMBER_GREEN=28
      export   COLOR_NUMBER_YELLOW=226
      export   COLOR_NUMBER_WHITE=255
      export   COLOR_NUMBER_RED=196
    else
      export   COLOR_NUMBER_BLACK=0
      export   COLOR_NUMBER_RED=1
      export   COLOR_NUMBER_GREEN=2
      export   COLOR_NUMBER_YELLOW=3
      export   COLOR_NUMBER_BLUE=4
      export   COLOR_NUMBER_MAGENTA=5
      export   COLOR_NUMBER_CYAN=6
      export   COLOR_NUMBER_WHITE=7
      export   COLOR_NUMBER_ORANGE=3
      export   COLOR_NUMBER_PURPLE=5
    fi
    export   COLOR_BLACK="${COLORS[$COLOR_NUMBER_BLACK]}"
    export BGCOLOR_BLACK="${BGCOLORS[$COLOR_NUMBER_BLACK]}"
    export   COLOR_MAGENTA="${COLORS[$COLOR_NUMBER_MAGENTA]}"
    export BGCOLOR_MAGENTA="${BGCOLORS[$COLOR_NUMBER_MAGENTA]}"
    export   COLOR_BLUE="${COLORS[$COLOR_NUMBER_BLUE]}"
    export BGCOLOR_BLUE="${BGCOLORS[$COLOR_NUMBER_BLUE]}"
    export   COLOR_CYAN="${COLORS[$COLOR_NUMBER_CYAN]}"
    export BGCOLOR_CYAN="${BGCOLORS[$COLOR_NUMBER_CYAN]}"
    export   COLOR_PURPLE="${COLORS[$COLOR_NUMBER_PURPLE]}"
    export BGCOLOR_PURPLE="${BGCOLORS[$COLOR_NUMBER_PURPLE]}"
    export   COLOR_ORANGE="${COLORS[$COLOR_NUMBER_ORANGE]}"
    export BGCOLOR_ORANGE="${BGCOLORS[$COLOR_NUMBER_ORANGE]}"
    export   COLOR_GREEN="${COLORS[$COLOR_NUMBER_GREEN]}"
    export BGCOLOR_GREEN="${BGCOLORS[$COLOR_NUMBER_GREEN]}"
    export   COLOR_YELLOW="${COLORS[$COLOR_NUMBER_YELLOW]}"
    export BGCOLOR_YELLOW="${BGCOLORS[$COLOR_NUMBER_YELLOW]}"
    export   COLOR_WHITE="${COLORS[$COLOR_NUMBER_WHITE]}"
    export BGCOLOR_WHITE="${BGCOLORS[$COLOR_NUMBER_WHITE]}"
    export   COLOR_RED="${COLORS[$COLOR_NUMBER_RED]}"
    export BGCOLOR_RED="${BGCOLORS[$COLOR_NUMBER_RED]}"
    export COLOR_BLACK_BOLD="$_bold$COLOR_BLACK"
    export COLOR_RED_BOLD="$_bold$COLOR_RED"
    export COLOR_GREEN_BOLD="$_bold$COLOR_GREEN"
    export COLOR_YELLOW_BOLD="$_bold$COLOR_YELLOW"
    export COLOR_BLUE_BOLD="$_bold$COLOR_BLUE"
    export COLOR_MAGENTA_BOLD="$_bold$COLOR_MAGENTA"
    export COLOR_CYAN_BOLD="$_bold$COLOR_CYAN"
    export COLOR_WHITE_BOLD="$_bold$COLOR_WHITE"

    export LESS_TERMCAP_mb="$COLOR_GREEN_BOLD"
    export LESS_TERMCAP_md="$COLOR_BLUE_BOLD"
    export LESS_TERMCAP_me="$COLOR_NONE"
    export LESS_TERMCAP_so="$COLOR_YELLOW_BOLD$BGCOLOR_BLUE"
    export LESS_TERMCAP_se="$COLOR_NONE"
    export LESS_TERMCAP_us="$(tput smul)$COLOR_WHITE"
    export LESS_TERMCAP_ue="$(tput rmul)$COLOR_NONE"
    export LESS_TERMCAP_mr="$(tput rev)"
    export LESS_TERMCAP_mh="$(tput dim)"
    export LESS_TERMCAP_ZN="$(tput ssubm)"
    export LESS_TERMCAP_ZV="$(tput rsubm)"
    export LESS_TERMCAP_ZO="$(tput ssupm)"
    export LESS_TERMCAP_ZW="$(tput rsupm)"
  else
    EXTENDED=0
    export COLOR_BLACK="\[\033[30m\]"
    export COLOR_RED="\[\033[31m\]"
    export COLOR_GREEN="\[\033[320m\]"
    export COLOR_YELLOW="\[\033[33m\]"
    export COLOR_BLUE="\[\033[34m\]"
    export COLOR_MAGENTA="\[\033[35m\]"
    export COLOR_CYAN="\[\033[36m\]"
    export COLOR_WHITE="\[\033[37m\]"
    export COLOR_BLACK_BOLD="\[\033[30;1m\]"
    export COLOR_RED_BOLD="\[\033[31;1m\]"
    export COLOR_GREEN_BOLD="\[\033[32;1m\]"
    export COLOR_YELLOW_BOLD="\[\033[33;1m\]"
    export COLOR_BLUE_BOLD="\[\033[34;1m\]"
    export COLOR_MAGENTA_BOLD="\[\033[35;1m\]"
    export COLOR_CYAN_BOLD="\[\033[36;1m\]"
    export COLOR_WHITE_BOLD="\[\033[37;1m\]"
  fi
  export COLOR_DEFAULT="[39;49m"
  export COLOR_NONE="[m"


  if [ "${EXTENDED}" = "1" ]; then
    cat > "${CACHE_FILE}" <<END
export   COLOR_NUMBER_BLACK="${COLOR_NUMBER_BLACK}"
export   COLOR_NUMBER_MAGENTA="${COLOR_NUMBER_MAGENTA}"
export   COLOR_NUMBER_BLUE="${COLOR_NUMBER_BLUE}"
export   COLOR_NUMBER_CYAN="${COLOR_NUMBER_CYAN}"
export   COLOR_NUMBER_PURPLE="${COLOR_NUMBER_PURPLE}"
export   COLOR_NUMBER_ORANGE="${COLOR_NUMBER_ORANGE}"
export   COLOR_NUMBER_GREEN="${COLOR_NUMBER_GREEN}"
export   COLOR_NUMBER_YELLOW="${COLOR_NUMBER_YELLOW}"
export   COLOR_NUMBER_WHITE="${COLOR_NUMBER_WHITE}"
export   COLOR_NUMBER_RED="${COLOR_NUMBER_RED}"
export   COLOR_BLACK="${COLOR_BLACK}"
export BGCOLOR_BLACK="${BGCOLOR_BLACK}"
export   COLOR_MAGENTA="${COLOR_MAGENTA}"
export BGCOLOR_MAGENTA="${BGCOLOR_MAGENTA}"
export   COLOR_BLUE="${COLOR_BLUE}"
export BGCOLOR_BLUE="${BGCOLOR_BLUE}"
export   COLOR_CYAN="${COLOR_CYAN}"
export BGCOLOR_CYAN="${BGCOLOR_CYAN}"
export   COLOR_PURPLE="${COLOR_PURPLE}"
export BGCOLOR_PURPLE="${BGCOLOR_PURPLE}"
export   COLOR_ORANGE="${COLOR_ORANGE}"
export BGCOLOR_ORANGE="${BGCOLOR_ORANGE}"
export   COLOR_GREEN="${COLOR_GREEN}"
export BGCOLOR_GREEN="${BGCOLOR_GREEN}"
export   COLOR_YELLOW="${COLOR_YELLOW}"
export BGCOLOR_YELLOW="${BGCOLOR_YELLOW}"
export   COLOR_WHITE="${COLOR_WHITE}"
export BGCOLOR_WHITE="${BGCOLOR_WHITE}"
export   COLOR_RED="${COLOR_RED}"
export BGCOLOR_RED="${BGCOLOR_RED}"
export COLOR_BLACK_BOLD="${COLOR_BLACK_BOLD}"
export COLOR_RED_BOLD="${COLOR_RED_BOLD}"
export COLOR_GREEN_BOLD="${COLOR_GREEN_BOLD}"
export COLOR_YELLOW_BOLD="${COLOR_YELLOW_BOLD}"
export COLOR_BLUE_BOLD="${COLOR_BLUE_BOLD}"
export COLOR_MAGENTA_BOLD="${COLOR_MAGENTA_BOLD}"
export COLOR_CYAN_BOLD="${COLOR_CYAN_BOLD}"
export COLOR_WHITE_BOLD="${COLOR_WHITE_BOLD}"
export COLOR_DEFAULT="${COLOR_DEFAULT}"
export COLOR_NONE="${COLOR_NONE}"

export LESS_TERMCAP_mb="${LESS_TERMCAP_mb}"
export LESS_TERMCAP_md="${LESS_TERMCAP_md}"
export LESS_TERMCAP_me="${LESS_TERMCAP_me}"
export LESS_TERMCAP_so="${LESS_TERMCAP_so}"
export LESS_TERMCAP_se="${LESS_TERMCAP_se}"
export LESS_TERMCAP_us="${LESS_TERMCAP_us}"
export LESS_TERMCAP_ue="${LESS_TERMCAP_ue}"
export LESS_TERMCAP_mr="${LESS_TERMCAP_mr}"
export LESS_TERMCAP_mh="${LESS_TERMCAP_mh}"
export LESS_TERMCAP_ZN="${LESS_TERMCAP_ZN}"
export LESS_TERMCAP_ZV="${LESS_TERMCAP_ZV}"
export LESS_TERMCAP_ZO="${LESS_TERMCAP_ZO}"
export LESS_TERMCAP_ZW="${LESS_TERMCAP_ZW}"
END
  else
    cat > "${CACHE_FILE}" <<END
export COLOR_BLACK="${COLOR_BLACK}"
export COLOR_RED="${COLOR_RED}"
export COLOR_GREEN="${COLOR_GREEN}"
export COLOR_YELLOW="${COLOR_YELLOW}"
export COLOR_BLUE="${COLOR_BLUE}"
export COLOR_MAGENTA="${COLOR_MAGENTA}"
export COLOR_CYAN="${COLOR_CYAN}"
export COLOR_WHITE="${COLOR_WHITE}"
export COLOR_BLACK_BOLD="${COLOR_BLACK_BOLD}"
export COLOR_RED_BOLD="${COLOR_RED_BOLD}"
export COLOR_GREEN_BOLD="${COLOR_GREEN_BOLD}"
export COLOR_YELLOW_BOLD="${COLOR_YELLOW_BOLD}"
export COLOR_BLUE_BOLD="${COLOR_BLUE_BOLD}"
export COLOR_MAGENTA_BOLD="${COLOR_MAGENTA_BOLD}"
export COLOR_CYAN_BOLD="${COLOR_CYAN_BOLD}"
export COLOR_WHITE_BOLD="${COLOR_WHITE_BOLD}"
export COLOR_DEFAULT="${COLOR_DEFAULT}"
export COLOR_NONE="${COLOR_NONE}"  
END
  fi
fi

# # NVT="\033[7m"; NORM="\033[0m"; BOLD="\033[1m"; BLINK="\033[5m"
# # #UNDR="\033[2m\033[4m"; EOL="\033[0K"; EOD="\033[0J"
# # UNDR="\033[4m"; EOL="\033[0K"; EOD="\033[0J"
# # SOD="\033[1;1f"; CUR_UP="\033[1A"; CUR_DN="\033[1B"; CUR_LEFT="\033[1D"
# # CUR_RIGHT="\033[1C"
# # #-- ANSI code
# # SCR_HOME="\033[0;0H" #-- Home of the display
