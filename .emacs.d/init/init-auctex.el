;
;  redefine that with this from Aquamacs
;

(autoload 'TeX-ispell-skip-setcar "tex" "Add SKIP to car of `ispell-tex-skip-alists'. ..." t)

(defun TeX-run-discard-or-function-AQ (name command file)
  "Start COMMAND as process or execute it as a Lisp function.
If run as a process, the output is discarded.  COMMAND is
expected to be a string.  NAME and FILE are ignored.
COMMAND may be a string containing a lisp expression
to be evaluated."
  (let ((expr (car (read-from-string command))))
    (if (or (functionp expr)
        (and (listp expr) (functionp (car expr))))
      (TeX-run-function name command file)
    (TeX-run-discard name command file))))

(eval-after-load "tex-buf"
  '(progn
     (fset 'TeX-run-discard-or-function 'TeX-run-discard-or-function-AQ)))

(require 'font-latex) ;better fontification


; chktex can be stupid
(setenv "CHKTEXRC" (getenv "HOME"))
