#!/usr/bin/make -f
THISDIR !=find . -name .\* -a ! \( -name .git -o -name . -o -name .gitmodules -o -name .config \) -maxdepth 1
DOTFILES=${THISDIR:S/.\///g}
DESTINATION=${DOTFILES:S/^/$(HOME)\//g}

CONFIGFILES !=find .config ! \( -name .git -o -name . -o -name .gitmodules -o -name .config \) -maxdepth 1
CONFIGDESTIONATION=${CONFIGFILES:S/^/$(HOME)\//g}

.ifndef OS
    OS !=uname -s
.endif

include dotfiles.mk
