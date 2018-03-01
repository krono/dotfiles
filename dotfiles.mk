#!/usr/bin/make
# sans -f for as to make sure make uses proper makefile
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

$(HOME)/.emacs: .emacs.d/init.el
	ln -s "$(PWD)/.emacs.d/init.el" "$(HOME)/.emacs"

Darwin:
