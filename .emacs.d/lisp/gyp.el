;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GYP support.  Requires python.el (as opposed to python-mode.el).
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'python)
(when (string-match "python-mode.el" (symbol-file 'python-mode 'defun))
  (error (concat "python-mode must be loaded from python.el (bundled with "
                 "recent emacsen), not from the older and less maintained "
                 "python-mode.el")))
(defadvice python-calculate-indentation (after ami-outdent-closing-parens
                                               activate)
  "De-indent closing parens, braces, and brackets in python and derived modes."
  (if (string-match "^ *[])}][],)}]* *$"
                    (buffer-substring-no-properties (line-beginning-position)
                                                    (line-end-position)))
      (setq ad-return-value (- ad-return-value 2))))
(define-derived-mode gyp-mode python-mode "Gyp"
  "Major mode for editing .gyp files."
  (setq python-continuation-offset 2
        python-indent 2
        python-guess-indent nil))
(add-to-list 'auto-mode-alist '("\\.gyp\\'" . gyp-mode))
(add-to-list 'auto-mode-alist '("\\.gypi\\'" . gyp-mode))
