(defun set-newline-and-indent ()
  (local-set-key (kbd "RET") 'newline-and-indent))

(defun kill-and-join-forward (&optional arg)
  "If at end of line, join with following; otherwise kill line.
Deletes whitespace at join."
  (interactive "P")
  (if (and (eolp) (not (bolp)))
      (delete-indentation t)
    (kill-line arg)))

(if (and (featurep 'aquamacs) (boundp 'osx-key-mode-map))
    (define-key osx-key-mode-map (kbd "C-k") 'kill-and-join-forward)
  (global-set-key "\C-k" 'kill-and-join-forward))



(dolist (command '(yank yank-pop))
   (eval `(defadvice ,command (after indent-region activate)
            (and
             ;; (not current-prefix-arg)
             ;; (member major-mode '(emacs-lisp-mode lisp-mode
             ;;                      clojure-mode    scheme-mode
             ;;                      haskell-mode    ruby-mode
             ;;                      rspec-mode      python-mode
             ;;                      c-mode          c++-mode
             ;;                      objc-mode       latex-mode
             ;;                      plain-tex-mode))
            current-prefix-arg
            (let ((mark-even-if-inactive transient-mark-mode))
              (indent-region (region-beginning) (region-end) nil))))))

(global-set-key (kbd "<kp-enter>") 'newline-and-indent)
; (global-set-key [?\C-x ?\M-t] 'toggle-truncate-lines)
; (global-set-key [?\C-x ?\M-r] 'toggle-rot13-mode)
(global-set-key (kbd "<C-tab>") 'complete)

(global-set-key (kbd "C-M-[") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-]") 'enlarge-window-horizontally)


(if (and (featurep 'aquamacs) (boundp 'osx-key-mode-map))
    (define-key osx-key-mode-map (kbd "A-C-M-d") 'neotree-toggle)
  (global-set-key (kbd "C-M-s-d") 'neotree-toggle))
(global-set-key (kbd "<f9>") 'neotree-toggle)



(defun -set-delete-key (map)
  (define-key map (kbd "<delete>") 'delete-forward-char)
  (define-key map (kbd "<kp-delete>") 'delete-forward-char))

(if (and (featurep 'aquamacs) (boundp 'osx-key-mode-map))
    (-set-delete-key osx-key-mode-map)
  (-set-delete-key (current-global-map)))

(defun suspend-on-tty-only ()
  (interactive)
  (unless window-system
    (suspend-frame)))

(when window-system
  (global-set-key (kbd "C-z") 'suspend-on-tty-only)
  (global-set-key (kbd "C-x C-z") 'suspend-on-tty-only))

;; EOF
