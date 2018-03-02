#
# for pdksh-shells
_colors=$1
set -A COLORS $(for i in $(jot $_colors 0 $_colors);\
           do printf "$(tput setaf $i 0 0) ";\
           done)
set -A BGCOLORS $(for  $(jot $_colors 0 $_colors);\
             do printf "$(tput setab $i 0 0) ";\
             done))
export COLORS
export BGCOLORS
