;;; latex-doc --- Show summary of LaTeX command/environment/package

;; Copyright (C) 2002 Triet Hoai Lai
;; Author:     Triet Hoai Lai <thlai@mail.usyd.edu.au>
;; Keywords:   help, LaTeX
;; Version:    0.1
;; X-RCS: $Id: latex-doc.el,v 1.4 2002/01/05 01:27:34 thlai Exp $

;; This file is *NOT* part of Emacs.

;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the Free
;; Software Foundation; either version 2, or (at your option) any later
;; version.

;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;; FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
;; more details.

;; You should have received a copy of the GNU General Public License along with
;; GNU Emacs; see the file COPYING.  If not, write to the Free Software
;; Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

;;; Commentary:

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Introduction
;; ------------
;;
;; This package provides 3 commands `latex-doc-command', `latex-doc-environment'
;; and `latex-doc-package' which display a brief document of LaTeX command,
;; environment, and package respectively.
;;
;;
;; Install
;; -------
;;
;; - Put the files in some directory, e.g. ~/elisp/latex-doc
;;
;; - Change the first line of Makefile to program name of your Emacs, e.g.:
;;	EMACS = emacs
;;
;; - Run make.  It will byte compile *.el and produce 2 additional files in
;;   current directory:
;;	* .latex-doc: file stores LaTeX document.
;;	* .latex-index.el: index file.
;;
;; - Put the following lines into your .emacs
;;      (add-to-list 'load-path "~/elisp/latex-doc")
;;	(require 'latex-doc)
;;	(latex-doc-initialize)
;;
;;
;; Usage
;; -----
;;
;; - `latex-doc-command':     display document of LaTeX command.
;;	M-x latex-doc-command
;;
;; - `latex-doc-environment': ......................... environment.
;;	M-x latex-doc-environment
;;
;; - `latex-doc-package': ............................. package.
;;	M-x latex-doc-package
;;
;; You might want to bind these commands to some available keys in LaTeX mode.
;;
;;
;; Files
;; -----
;;
;; * To run `latex-doc-*' commands, you only need these files: latex-doc.el,
;;   latex-doc-var.el, .latex-doc, .latex-doc-index.el.
;;
;; * latex-doc-build.el and latex-doc-data.el are used to add new document for
;;   LaTeX commands, environments, packages.
;;	- 3 functions available in latex-doc-build.el for this purpose:
;;	  `latex-doc-defcmd', `latex-doc-defenv', and `latex-doc-defpkg'.
;;
;;	- Currently, there isn't any interactive function to add document.  But
;;	  it is simple enough, just look at the examples in latex-doc-data.el
;;
;;	- Remember to run make again after adding new document.
;;
;;
;; How it works
;; ------------
;;
;; At compilation time, `latex-doc-def*' append document to `latex-doc-file',
;; record the points of that definition and save to the corresponding hash table
;; (obarray).  At the last stage of compilation, information in the hash tables,
;; is written into `latex-doc-index-file'.
;;
;; The package is initialized by loading `latex-doc-index-file', that sets up
;; the hash tables so that the lookup functions can find the points
;; corresponding to the given definition.
;; 
;;
;; Acknowledgements
;; ----------------
;;
;; Most document is taken from latexhelp.html in Ktexmaker2 (a KDE LaTeX editor)
;; (http://xm1.net.free.fr/linux/index.html), written by Pascal Brachet
;; <pascal.brachet@free.fr>.
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; code:

(require 'cl)
(require 'latex-doc-var)

(defun latex-doc-initialize ()
  "Call it before using any interactive `latex-doc' commands.

That means you have to put following line in your dot emacs:
	(require 'latex-doc)
	(latex-doc-initialize)"
  ;; Initialize all neccessary information such as building obarrays
  ;; for LaTeX commands,  environments and packages.

  (interactive)
  ;; Load index file so that the 3 lists of list of points
  ;; (`latex-doc-cmd-list', `latex-doc-env-list' and `latex-doc-pkg-list') are
  ;; initialized. (Yes, it's a bad trick!)
  (load (file-name-sans-extension latex-doc-index-file))

  (latex-doc-list-to-obarray latex-doc-cmd-list
			     latex-doc-cmd-obarray)

  (latex-doc-list-to-obarray latex-doc-env-list
			     latex-doc-env-obarray)

  (latex-doc-list-to-obarray latex-doc-pkg-list
			     latex-doc-pkg-obarray))

(defun latex-doc-list-to-obarray (lst oba)
  (dolist (entry lst)
    (let ((symbol (intern (nth 0 entry) oba))) ; name of cmd/env/pkg
      (set symbol (nth 1 entry))	; value
      (put symbol 'latex-doc-points (nth 2 entry))))) ; list of points


(defun latex-doc-command ()
  "Show document of LaTeX command with completion."
  (interactive)
  (latex-doc-show-help 'latex-command))

(defun latex-doc-environment ()
  "Show document of LaTeX environment with completion."
  (interactive)
  (latex-doc-show-help 'latex-environment))

(defun latex-doc-package ()
  "Show document of LaTeX package with completion."
  (interactive)
  (latex-doc-show-help 'latex-package))

(defun latex-doc-show-help (type)
  ;; Popup a buffer in some window and print document for LaTeX
  ;; command, environment or package depending on TYPE.
  (let (oba str prompt name)
    (cond ((eq type 'latex-command)
	   (setq oba latex-doc-cmd-obarray
		 prompt "Command: "))
	  ((eq type 'latex-environment)
	   (setq oba latex-doc-env-obarray
		 prompt "Environment: "))
	  ((eq type 'latex-package)
	   (setq oba latex-doc-pkg-obarray
		 prompt "Package: "))
	  (t
	   (error "invalid type %s" (symbol-name type))))
    (setq str (completing-read prompt oba))
    (unless (= 0 (length str))
      (if (string-match "^\\\\[a-zA-Z]" str)
	  (setq name (substring str 1 (length str)))
	(setq name str))

      (let ((sym (intern-soft name oba)))
	(with-output-to-temp-buffer "*LaTeX-doc*"
	  (let ((truncate-lines t))
	    (if sym
		(progn
		  ;; print the value and deliminator (probably support
		  ;; editing doc will be added later on and the
		  ;; separators will help to distinguish value and doc.
		  (princ (format "%s\n%s\n\n"
				 (symbol-value sym)
				 (make-string (- (window-width) 1) ?=)))

		  ;; print doc
		  (princ (latex-doc-extract-doc sym))

		  (print-help-return-message))
	    (error "no document for \"%s\"" str))))))))

(defun latex-doc-extract-doc (entry)
  ;; Return document in `latex-help-doc-file' for the given
  ;; command/environment.
  (let* ((pos-list (get entry 'latex-doc-points))
	 (len (length pos-list)))
    (save-excursion
      (latex-doc-set-buffer)
      
      ;; get the name of command/environment/package.
      (let ((str (buffer-substring
		  (nth 0 pos-list)
		  (- (nth 1 pos-list) 1)))) ; don't count "\n"
	(or (string-match "^\.[CEP]" str)
	    (error "name of command/environment/package expected"))
	(or (string= (symbol-name entry) (substring str 2 (length str)))
	    (error "name of command/environment/package not matched"))

	;; get the document
	(cond ((= len 4)		; (name val doc end)
	       (buffer-substring (nth 2 pos-list) (nth 3 pos-list)))
	      ((= len 3)		; (name val end)
	       "*Not documented*")
	      (t
	       (error "wrong type argument")))))))


(provide 'latex-doc)

;;; latex-doc.el ends here
