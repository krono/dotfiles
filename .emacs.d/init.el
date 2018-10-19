;; my emacs init.
;;
;; ____________________________________________________________________________
;; Aquamacs custom-file warning:
;; Warning: After loading this .emacs file, Aquamacs will also load
;; customizations from `custom-file' (customizations.el). Any settings there
;; will override those made here.
;; Consider moving your startup settings to the Preferences.el file, which
;; is loaded after `custom-file':
;; ~/Library/Preferences/Aquamacs Emacs/Preferences
;; _____________________________________________________________________________
(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory "~/.emacs.d/"
    "Directory beneath which additional per-user
    Emacs-specificfiles are placed. Various programs in Emacs
    store information in this directory. Note that this should
    end with a directory separator. See also
    `locate-user-emacs-file'"))


(let ((default-directory
        (concat user-emacs-directory
                (convert-standard-filename "lisp/"))))
  (setq load-path
        (append
         (let ((load-path (copy-sequence load-path))) ;; Shadow
           (append
            (copy-sequence (normal-top-level-add-to-load-path '(".")))
            (normal-top-level-add-subdirs-to-load-path)))
         load-path)))

;; Each file in init-other-packages named init-<somelibrary>.el is
;; loaded just after its corresponding library.
(setq init-files '())
(let ((init-directory
        (concat user-emacs-directory
                (convert-standard-filename "init/"))))
  (add-to-list 'load-path init-directory)
  (dolist (file (directory-files init-directory nil ".*\\.el\\'") t)
    (let ((file-sans-ext (file-name-sans-extension file)))
      (if (string-match (format "^init-\\(.+\\)\\.el\\'") file)
          (eval-after-load (match-string-no-properties 1 file)
            `(load ,file-sans-ext))
        (add-to-list 'init-files file-sans-ext)))))

(require 'python)

;(autoload 'python "python" "Python mode." t)


(unless (featurep 'aquamacs)
  (setq custom-file (concat
                     user-emacs-directory
                     (convert-standard-filename "customizations.el")))
  (load custom-file))


(require 'package nil 'noerror)

(when (functionp 'package-initialize)
  (package-initialize))

(when (and (functionp 'package-installed-p)
           (not (seq-every-p #'package-installed-p package-selected-packages)))
  (package-install-selected-packages))

; once again to collect customize of loaded packages)
(unless (featurep 'aquamacs) (load custom-file))

(mapc #'load init-files)

(eval '(setq inhibit-startup-echo-area-message t))

; Date'n'Time Modeline
(display-time)

(column-number-mode t)
(line-number-mode t)
(transient-mark-mode t)
;; Paren matchine
(show-paren-mode t)
(setq show-paren-style 'parenthesis)
(setq blink-matching-paren-distance 102400)

;; ignore visual basic
(setq auto-mode-alist (assq-delete-all-equal "\\.\\(frm\\|bas\\|cls\\)$" auto-mode-alist))

;;;;;;;;;;;;;
;; ;; ecb

;(require 'ecb-autoloads)
;(require 'ecb)

;(require 'textmate)
;(textmate-mode)

;(require 'color-theme)

;(require 'snippet)


(autoload 'yaml-mode "yaml-mode" "Yaml mode." t)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;(require 'gnuplot)


(setq sentence-end-double-space nil)
(setq yank-excluded-properties t) ; do not paste any properties
(setq confirm-nonexistent-file-or-buffer t)
(setq-default case-fold-search t)
(setq isearch-allow-scroll t)
(setq confirm-kill-emacs 'y-or-n-p)

;; opt for ido
;; (require 'ffap)
;; rebind C-x C-f and others to the ffap bindings
;; (see variable ffap-bindings)
;; (ffap-bindings)

(require 'helm)

;(load-library "hex-util")

(load "completion")
(initialize-completions)


(defun try-complete-abbrev (old)
  (if (expand-abbrev) t nil))

(require 'tramp)
; emacsserver
(server-start)

(add-hook
 'server-switch-hook
 (lambda ()
   (when (current-local-map)
     (use-local-map (copy-keymap (current-local-map))))
   (when server-buffer-clients
     (local-set-key (kbd "C-x k") 'server-edit))))

(autoload
  'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist
             '("\\.\\(md\\|text\\)\\'" . markdown-mode))

(setq aquamacs-skim-show-reading-bar nil)



(load-file
 (concat user-emacs-directory
         (convert-standard-filename "lisp/comment-dwim.el")))

(load-library "graphviz-dot-mode")

(load-library "smalltalk-mode")
(load-library "cmake-mode")

;; ;; missing:
;; (defun tags-complete-tag (string predicate what)
;;   (save-excursion
;;     ;; If we need to ask for the tag table, allow that.
;;     (if (eq what t)
;;      (all-completions string (tags-completion-table) predicate)
;;       (try-completion string (tags-completion-table) predicate))))


;;noweb
(autoload 'noweb-mode "noweb-mode" "Editing noweb files." t)

(add-to-list 'auto-mode-alist '("\\.nw\\'" . noweb-mode))
(add-hook 'noweb-select-mode-hook
          '(lambda () (hack-local-variables-prop-line)))

;;; auto-refill
(autoload 'refill-mode "refill" "Autorefill-mode")
;;;;;;;;;;;;;;;;;

(require 'htmlize)

(autoload 'pypytrace-mode "pypytrace-mode" "Pypytrace mode" t)
(add-to-list 'auto-mode-alist '("\\.pypy\\(trace\\|log\\)\\'" . pypytrace-mode))

(require 'ls-lisp)

(require 'transpose-frame)

(defun editing-visual-helpers ()
  "Some visual cues that are valuable in either prog-modes and text-modes"
  ;(nlinum-mode)
  (fci-mode)
  (rainbow-delimiters-mode))


(add-hook 'python-mode-hook 'editing-visual-helpers)
(add-hook 'prog-mode-hook 'editing-visual-helpers)
(add-hook 'smalltalk-mode-hook 'editing-visual-helpers)
;; done via customize
;; (add-hook 'text-mode-hook 'editing-visual-helpers)

(when (featurep 'partial-completion-mode)
    (partial-completion-mode))

;; Make all "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)

;eof
