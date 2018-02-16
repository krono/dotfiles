;;; latex-doc-var
;;
;; X-RCS: $Id: latex-doc-var.el,v 1.2 2002/01/03 07:38:39 thlai Exp $
;;

;; These variables are internal to the package.

(defvar latex-doc-file
  (expand-file-name
   ".latex-doc"
   (or (file-name-directory (locate-library "latex-doc"))))
  "File stores documentation of LaTeX commands and environments.

Entry starts with \".C\", \".E\" and \".P\" corresponds to LaTeX
command, environment and package respectively.")


;; To support completion and to avoid re-defining LaTeX command,
;; environment and package, we use obarrays.  Each symbol in an
;; obarray, has the following attributes:
;;	* Name: the name of LaTeX command/environment/package (STRING).
;;	* Value: the actual LaTeX command/environment/package in
;;	  generic form (e.g. \chapter[sort]{text}) (STRING).
;;	* Property: "'latex-doc-points", which is a list of either 3
;;	  or 4 elements: (name value doc end) or (name value end).
;;	  These elements are the points of the corresponding command
;;	  or environment in `latex-doc-file'.  They will be used to
;;	  retrieve document of that command/environment/package.
;;
;; Obarray to store info of LaTeX commands:
(defconst latex-doc-cmd-obarray (make-vector 97 0))
;;
;; Obarray to store info of LaTeX environment:
(defconst latex-doc-env-obarray (make-vector 37 0))
;;
(defconst latex-doc-pkg-obarray (make-vector 37 0))

;; A temporary buffer to store documentation of LaTeX commands,
;; environments and packages.
(defvar latex-doc-working-buffer " *LaTeX-doc-data*")

;; File stores list of list of points for faster retrieving document
;; of LaTeX command/environment.  The list of points is obtained from
;; the property `latex-doc-points' of each symbol in the corresponding
;; obarray.
(defvar latex-doc-index-file
  (expand-file-name
  ".latex-doc-index.el"
  (or (file-name-directory (locate-library "latex-doc"))
      "./")))

;; List of list of points for LaTeX commands
(defvar latex-doc-cmd-list nil)

;; List of list of points for LaTeX environments
(defvar latex-doc-env-list nil)

;; List of list of points for LaTeX packages
(defvar latex-doc-pkg-list nil)

(defun latex-doc-set-buffer ()
  ;; Make the `latex-doc-working-buffer' current for editing
  ;; operations.
  (let ((buf (get-buffer-create latex-doc-working-buffer)))
    (set-buffer buf)
    (if (equal (point-max) (point-min))
	(progn
	  (insert-file-contents latex-doc-file)))
    (goto-char (point-max))))

(provide 'latex-doc-var)

;; latex-doc-var.el ends here
