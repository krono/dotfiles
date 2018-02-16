;;; latex-doc-build
;;
;; X-RCS: $Id: latex-doc-build.el,v 1.3 2002/01/05 01:22:15 thlai Exp $
;;

;; code:

(require 'cl)
(require 'latex-doc-var)

;; Functions used to record LaTeX command or environment (CaE').  They
;; creates a symbol in the corresponding obarray with all details.  In
;; general, we will define several commands and environments only at
;; build time.  Thus, it would be better if `latex-doc-working-buffer'
;; won't be saved each time invoking these functions to avoid
;; excessive disk access.
(defun latex-doc-defcmd (name val &optional doc dont-save-p)
  "Define NAME as a LaTeX command.

VAL is the actual LaTeX command in a generic form (i.e. with all its
options, arguments).  DOC is the full description of the command.

If DONT-SAVE-P is non-nil, the information of LaTeX command is only
stored in `latex-doc-working-buffer' but not saved to `latex-doc-file'."
  (check-type name string)
  (check-type val string)
  (check-type doc (or null string))

  (let ((symbol (intern-soft name latex-doc-cmd-obarray)))
    (if symbol
	(error "command %s is already defined" name)
      (setq symbol (intern name latex-doc-cmd-obarray)))

    (set symbol val)

    (put symbol 'latex-doc-points
	 (latex-doc-store symbol 'latex-command doc dont-save-p))
    ))
;;
;;
(defun latex-doc-defenv (name val &optional doc dont-save-p)
  "Define NAME as a LaTeX environment.

VAL is the actual LaTeX environment in a generic form (i.e. with all
its options, arguments).  DOC is the full description of the environment.

If DONT-SAVE-P is non-nil, the information of LaTeX environment is only
stored in `latex-doc-working-buffer' but not saved to `latex-doc-file'."
  (check-type name string)
  (check-type val string)
  (check-type doc (or null string))

  (let ((symbol (intern-soft name latex-doc-env-obarray)))
    (if symbol
	(error "environment %s is already defined" name)
      (setq symbol (intern name latex-doc-env-obarray)))

    (set symbol val)

    (put symbol 'latex-doc-points
	 (latex-doc-store symbol 'latex-environment doc dont-save-p))
    ))
;;
;;
(defun latex-doc-defpkg (name val &optional doc dont-save-p)
  "Define NAME as a LaTeX package.

VAL is the actual LaTeX package in a generic form (i.e. with all its
options, arguments) and maybe commands it's provided.  DOC is the full
description of the package.

If DONT-SAVE-P is non-nil, the information of LaTeX package is only
stored in `latex-doc-working-buffer' but not saved to `latex-doc-file'."
  (check-type name string)
  (check-type val string)
  (check-type doc (or null string))

  (let ((symbol (intern-soft name latex-doc-pkg-obarray)))
    (if symbol
	(error "package %s is already defined" name)
      (setq symbol (intern name latex-doc-pkg-obarray)))

    (set symbol val)

    (put symbol 'latex-doc-points
	 (latex-doc-store symbol 'latex-package doc dont-save-p))
    ))
;;
;;
(defun latex-doc-store (entry type &optional doc dont-save-p)
  ;; Append DOC to `latex-doc-working-buffer' and return the list of
  ;; points (name value doc end).  If there is no DOC the list is
  ;; (name value end) instead.  If DONT-SAVE-P is non-nil, don't save
  ;; `latex-doc-working-buffer' to `latex-doc-file'.
  (let (point-list oba var)
    (save-excursion
      (latex-doc-set-buffer)

      ;; name of command/environment/package
      (goto-char (point-max))
      (push (point) point-list)
      (cond ((eq type 'latex-command)
	     (insert "\.C" (symbol-name entry) "\n")
	     (setq oba latex-doc-cmd-obarray
		   var (symbol-name 'latex-doc-cmd-list)))
	    ((eq type 'latex-environment)
	     (insert "\.E" (symbol-name entry) "\n")
	     (setq oba latex-doc-env-obarray
		   var (symbol-name 'latex-doc-env-list)))
	    ((eq type 'latex-package)
	     (insert "\.P" (symbol-name entry) "\n")
	     (setq oba latex-doc-pkg-obarray
		   var (symbol-name 'latex-doc-pkg-list)))
	    (t
	     (error "wrong type argument")))

      ;; value (i.e. syntax of command/environment
      (push (point) point-list)
      (insert (symbol-value entry) "\n")

      ;; doc (i.e. description)
      (if doc
	  (progn
	    (push (point) point-list)
	    (insert doc "\n")))

      ;; end point
      (push (point) point-list)

      (insert "\n")

      (unless dont-save-p
	(let ((buffer-file-name (file-truename latex-doc-file)))
	  (save-buffer 0)))

      (nreverse point-list))))



;; The purpose of following functions is to write the information in
;; the obarrays into index file `latex-doc-index-file' for faster
;; retrieving the document.

;; Temporary list of list of points.
(defvar latex-doc-index-list nil)

(defun latex-doc-write-index ()
  (latex-doc-write-index-1 latex-doc-cmd-obarray
			   (symbol-name 'latex-doc-cmd-list))
  (latex-doc-write-index-1 latex-doc-env-obarray
			   (symbol-name 'latex-doc-env-list))
  (latex-doc-write-index-1 latex-doc-pkg-obarray
			   (symbol-name 'latex-doc-pkg-list)))

(defun latex-doc-write-index-1 (oba var)
  ;; Convert obarray OBA to a list of list of points and write the
  ;; list into the index file `latex-doc-index-file' in the following
  ;; format:
  ;;	(setq VAR list-of-list-of-points)
  ;; so that it can be evaluated after loading the index file.
  (mapatoms 'latex-doc-push-symbol-to-index-list oba)
  (if latex-doc-index-list
      (progn
	(with-temp-buffer
	  (insert "(setq " var " ")
	  (insert ?' (prin1-to-string latex-doc-index-list))
	  (insert ")\n")
	  (let ((backup-inhibited t))
	    (append-to-file (point-min) (point-max) latex-doc-index-file)))))

  ;; Initialize for next call
  (setq latex-doc-index-list nil))

(defun latex-doc-push-symbol-to-index-list (symbol)
  (let ((lop (list (symbol-name symbol)
		   (symbol-value symbol)
		   (get symbol 'latex-doc-points))))
    (push lop latex-doc-index-list)))

(provide 'latex-doc-build)

;; latex-doc-build.el ends here
