(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex -synctex=1 -etex")
 '(LaTeX-mode-hook
   (quote
    (LaTeX-math-mode flyspell-babel-setup flyspell-mode-on auto-fill-mode smart-dnd-latex turn-on-bib-cite turn-on-reftex LaTeX-preview-setup
                     (lambda nil
                       (TeX-fold-mode t)))))
 '(TeX-clean-confirm nil)
 '(TeX-command "etex")
 '(TeX-mode-hook (quote (aquamacs-latex-viewer-support)))
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-start-server t)
 '(after-save-hook
   (quote
    (executable-make-buffer-file-executable-if-script-p)))
 '(auto-fill-function (quote do-auto-fill) t)
 '(auto-word-wrap-default-function nil)
 '(before-save-hook (quote (time-stamp)))
 '(c-tab-always-indent (quote other))
 '(compilation-scroll-output t)
 '(current-language-environment "UTF-8")
 '(desktop-save-mode t)
 '(display-battery-mode t)
 '(display-time-day-and-date t)
 '(display-time-mode t)
 '(ecb-activation-selects-ecb-frame-if-already-active t)
 '(ecb-add-path-for-not-matching-files (quote (nil)))
 '(ecb-auto-update-methods-after-save t)
 '(ecb-compilation-buffer-names
   (quote
    (("*Calculator*")
     ("*vc*")
     ("*vc-diff*")
     ("*Apropos*")
     ("*Occur*")
     ("*shell*")
     ("\\*[cC]ompilation.*\\*" . t)
     ("\\*i?grep.*\\*" . t)
     ("*JDEE Compile Server*")
     ("*Help*")
     ("*Completions*")
     ("*Backtrace*")
     ("*Compile-log*")
     ("*bsh*")
     ("*Messages*")
     ("\\*.*output\\*" . t)
     ("\\*TeX.*\\*" . t))))
 '(ecb-compile-window-height 6)
 '(ecb-compile-window-temporally-enlarge (quote after-selection))
 '(ecb-compile-window-width (quote edit-window))
 '(ecb-enlarged-compilation-window-max-height (quote half))
 '(ecb-excluded-directories-regexps
   (quote
    ("^\\(CVS\\|\\.[^xX]*\\)$" "/Library/Application Support/Aquamacs Emacs/Temporary Files/")))
 '(ecb-layout-name "leftright4")
 '(ecb-layout-window-sizes
   (quote
    (("leftright4"
      (ecb-methods-buffer-name 0.19801980198019803 . 0.9795918367346939)
      (ecb-directories-buffer-name 0.2079207920792079 . 0.5918367346938775)
      (ecb-history-buffer-name 0.2079207920792079 . 0.3877551020408163)))))
 '(ecb-options-version "2.40")
 '(ecb-select-edit-window-on-redraw t)
 '(ecb-show-sources-in-directories-buffer (quote always))
 '(ecb-source-path
   (quote
    (("~/dev" "Dev")
     ("~/Documents/Uni/8/" "Uni")
     ("~/Documents/Marcel" "Weltweise")
     ("~/dev/seasidetutorial" "seaside"))))
 '(ecb-tip-of-the-day nil)
 '(ecb-vc-enable-support t)
 '(focus-follows-mouse t)
 '(generic-extras-enable-list
   (quote
    (alias-generic-mode apache-conf-generic-mode apache-log-generic-mode etc-fstab-generic-mode etc-modules-conf-generic-mode etc-passwd-generic-mode etc-services-generic-mode etc-sudoers-generic-mode fvwm-generic-mode hosts-generic-mode inetd-conf-generic-mode ini-generic-mode java-manifest-generic-mode java-properties-generic-mode javascript-generic-mode mailagent-rules-generic-mode mailrc-generic-mode named-boot-generic-mode named-database-generic-mode prototype-generic-mode resolve-conf-generic-mode samba-generic-mode show-tabs-generic-mode vrml-generic-mode x-resource-generic-mode xmodmap-generic-mode)))
 '(global-nlinum-mode t)
 '(hippie-expand-try-functions-list
   (quote
    (try-complete-abbrev try-complete-file-name-partially try-complete-file-name try-expand-all-abbrevs try-expand-list try-expand-line try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill try-complete-lisp-symbol-partially try-complete-lisp-symbol)))
 '(indent-tabs-mode nil)
 '(indicate-buffer-boundaries t)
 '(linum-delay t)
 '(org-export-latex-classes
   (quote
    (("article" "\\documentclass[11pt]{article}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{amssymb}
\\usepackage{hyperref}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
     ("report" "\\documentclass[11pt]{report}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{amssymb}
\\usepackage{hyperref}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("book" "\\documentclass[11pt]{book}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{amssymb}
\\usepackage{hyperref}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("speach" "\\documentclass[12pt,DIV=15]{scrartcl}
\\setlength\\textwidth{318.68709pt}
\\setlength\\marginparwidth{140.81625pt}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{hyperref}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))))
 '(package-archive-priorities
   (quote
    (("gnu" . 150)
     ("melpa-stable" . 100)
     ("marmalade" . 50)
     ("tromey" . 50)
     ("org" . 100)
     ("melpa" . 0))))
 '(package-archives
   (quote
    (("melpa-stable" . "https://stable.melpa.org/packages/")
     ("marmalade" . "http://marmalade-repo.org/packages/")
     ("melpa" . "https://melpa.org/packages/")
     ("org" . "http://orgmode.org/elpa/")
     ("tromey" . "http://tromey.com/elpa/")
     ("gnu" . "https://elpa.gnu.org/packages/"))))
 '(package-selected-packages
   (quote
    (geiser puppet-mode smartparens latex-extra magit csv-mode neotree all-the-icons go-mode extempore-mode unicode-whitespace highlight-symbol tuareg switch-window sphinx-frontend sml-mode smex shell-switcher rainbow-delimiters quack prolog pcmpl-git pcmpl-args org-plus-contrib nlinum lua-mode helm-package helm-git-grep helm-flymake helm-flycheck haskell-mode gnuplot fill-column-indicator expand-region eshell-manual ediprolog ecb dired-efap dired-details diminish column-marker auctex-lua)))
 '(puppet-fontify-variables-in-comments t)
 '(puppet-include-indent 4)
 '(puppet-indent-level 4)
 '(puppet-lint-command
   "puppet-lint --with-context --log-format \"%{path}:%{line}: %{kind}: %{message} (%{check})\"")
 '(reftex-default-bibliography (quote ("/Users/tobias/Documents/Uni/Bib/ITSE.bib")))
 '(reftex-enable-partial-scans t)
 '(reftex-extra-bindings t)
 '(reftex-use-external-file-finders t)
 '(safe-local-variable-values
   (quote
    ((yaml-indent-offset . 4)
     (TeX-engine . xetex)
     (TeX-master . t)
     (TeX-style-local . "common")
     (TeX-style-local . common))))
 '(scroll-preserve-screen-position 1)
 '(semantic-default-submodes
   (quote
    (global-semantic-highlight-func-mode global-semantic-decoration-mode global-semantic-stickyfunc-mode global-semantic-idle-completions-mode global-semantic-idle-scheduler-mode global-semanticdb-minor-mode global-semantic-idle-summary-mode global-semantic-mru-bookmark-mode)))
 '(semantic-mode t)
 '(show-scratch-buffer-on-startup nil)
 '(size-indication-mode t)
 '(special-display-frame-alist
   (quote
    ((user-position)
     (width . 75)
     (height . 30)
     (left - 0)
     (top . 30)
     (unsplittable)
     (active-alpha . 0.9)
     (inactive-alpha . 0.6))))
 '(tab-always-indent (quote complete))
 '(text-mode-hook
   (quote
    (turn-on-flyspell auto-detect-wrap smart-spacing-mode text-mode-hook-identify)))
 '(tramp-syntax (quote url))
 '(vc-command-messages t)
 '(visual-line-mode nil t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
