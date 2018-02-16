; ruby.
(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
;; fuer den Ruby-Interpreter:
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
;; Taken from the comment section in inf-ruby.el
(autoload 'rd-mode "rd-mode" "major mode for ruby document formatter RD" t)
(add-to-list 'auto-mode-alist '("\\.rd\(.en\|.ja\)?$" . rd-mode))

;(autoload 'ri "ri-ruby" nil t)
(setq ri-ruby-script "/Users/tobias/.emacs.d/ri-emacs.rb")
(autoload 'ri "/Users/tobias/.emacs.d/ri-ruby.el" nil t)


;; dafuer sorgen, dass der emacs Ruby-Dateien mit dem ruby-mode anzeigt:
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                     interpreter-mode-alist))


;;; review! (require 'ruby-electric)
;(require 'rails)


(add-hook 'ruby-mode-hook
      '(lambda ()
         (inf-ruby-keys)
))
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key 'f1 'ri)
            (local-set-key "\M-\C-i" 'ri-ruby-complete-symbol)
            (local-set-key 'f5 'ri-ruby-show-args)
            ))

;(setq rails-use-mongrel t)

;; Erlang
(setq erlang-root-dir "/usr/local/share")
(setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
(require 'erlang-start nil t)

;; Some Erlang customizations
(add-hook 'erlang-mode-hook '(lambda ()
       ;; when starting an Erlang shell in Emacs, default in the node name
        (setq inferior-erlang-machine-options '("-sname" "emacs"))
        ;; customize keys
        (local-set-key [return] 'newline-and-indent)))

(add-hook 'erlang-new-file-hook 'tempo-template-erlang-normal-header)


; remote-display
;; kein running-xwindows
;(load "remotedisplay")

(defun set-vim-foldmarker (fmr)
  "Set Vim-type foldmarkers for the current buffer"
  (interactive "sSet local Vim foldmarker: ")
  (if (equal fmr "")
      (message "Abort")
    (setq fmr (regexp-quote fmr))
    (set (make-local-variable 'outline-regexp)
         (concat ".*" fmr "\\([0-9]+\\)"))
    (set (make-local-variable 'outline-level)
         `(lambda ()
            (save-excursion
              (re-search-forward
               ,(concat fmr "\\([0-9]+\\)") nil t)
              (string-to-number (match-string 1)))))))

;(require 'ide-skel)