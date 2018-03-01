#!/usr/bin/make -f
SAVE:=. .. .git .gitmodules .config .DS_Store
DOTFILES=$(filter-out $(SAVE), $(wildcard .*))
DESTINATION=$(addprefix $(HOME)/,$(DOTFILES))

CONFIGFILES=$(filter-out $(SAVE), $(wildcard .config/*))
CONFIGDESTIONATION=$(addprefix $(HOME)/,$(CONFIGFILES))

ifeq ($(OS),)
    OS := $(shell uname -s)
endif

include dotfiles.mk

$(HOME)/.% : .%
	ln -s "$(PWD)/$<" "$@"
