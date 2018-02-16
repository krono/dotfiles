(require 'helm)
(require 'helm-config)
(require 'helm-eshell)
(require 'helm-files)
(require 'helm-grep)
(require 'helm-command)
(require 'helm-buffers)


(define-key helm-map (kbd "<tab>")
  'helm-execute-persistent-action) ; rebhnd tab to do persistent action
(define-key helm-map (kbd "C-i")
  'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")
  'helm-select-action) ; list actions using C-z

(define-key helm-grep-mode-map (kbd "<return>")
  'helm-grep-mode-jump-other-window)
(define-key helm-grep-mode-map (kbd "n")
  'helm-grep-mode-jump-other-window-forward)
(define-key helm-grep-mode-map (kbd "p")
  'helm-grep-mode-jump-other-window-backward)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
(global-set-key (kbd "C-c h x") 'helm-register)

(global-set-key (kbd "M-s o") 'helm-occur)

(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map (kbd "M-l")  'helm-eshell-history)))
;; Save current position to mark ring when jumping to a different place
(add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

(helm-mode 1)
