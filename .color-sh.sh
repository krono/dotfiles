#
# for sane shells
_color=$1
COLORS=( $(for ((i=0; i<_colors; i++));\
           do printf "$(tput setaf $i 0 0) ";\
           done))
BGCOLORS=( $(for ((i=0; i<_colors; i++));\
             do printf "$(tput setab $i 0 0) ";\
             done))
export COLORS
export BGCOLORS
