#!/usr/bin/make -f

SAVE:=. .. .git .gitmodules .config .DS_Store
DOTFILES=$(filter-out $(SAVE), $(wildcard .*))
DESTINATION=$(addprefix $(HOME)/,$(DOTFILES))

CONFIGFILES=$(filter-out $(SAVE), $(wildcard .config/*))
CONFIGDESTIONATION=$(addprefix $(HOME)/,$(CONFIGFILES))

ifeq ($(OS),)
    OS := $(shell uname -s)
endif

.PHONY: default link-files link-dotfiles link-dot-emacs $(OS)

default: link-files $(OS)

link-files: link-dotfiles link-dot-emacs link-configfiles

link-dotfiles: $(DESTINATION)

link-dot-emacs: link-dotfiles
link-dot-emacs: $(HOME)/.emacs

link-configfiles: $(HOME)/.config
link-configfiles: $(CONFIGDESTIONATION)

$(HOME)/.config:
	mkdir -p "$@"
$(HOME)/.config/% : %
	ln -s "$(PWD)/$<" "$@"

$(HOME)/.emacs: 
	ln -s "$(PWD)/.emacs.d/init.el" "$(HOME)/.emacs"


$(HOME)/.% : .%
	ln -s "$(PWD)/$<" "$@"

Darwin:
