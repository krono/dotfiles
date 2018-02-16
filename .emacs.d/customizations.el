(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex -synctex=1 -etex")
 '(LaTeX-mode-hook (quote (LaTeX-math-mode flyspell-babel-setup flyspell-mode-on auto-fill-mode smart-dnd-latex turn-on-bib-cite turn-on-reftex LaTeX-preview-setup (lambda nil (TeX-fold-mode t)))))
 '(TeX-clean-confirm nil)
 '(TeX-command "etex")
 '(TeX-mode-hook (quote (aquamacs-latex-viewer-support)))
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-start-server t)
 '(after-save-hook (quote (executable-make-buffer-file-executable-if-script-p)))
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
 '(ecb-compilation-buffer-names (quote (("*Calculator*") ("*vc*") ("*vc-diff*") ("*Apropos*") ("*Occur*") ("*shell*") ("\\*[cC]ompilation.*\\*" . t) ("\\*i?grep.*\\*" . t) ("*JDEE Compile Server*") ("*Help*") ("*Completions*") ("*Backtrace*") ("*Compile-log*") ("*bsh*") ("*Messages*") ("\\*.*output\\*" . t) ("\\*TeX.*\\*" . t))))
 '(ecb-compile-window-height 6)
 '(ecb-compile-window-temporally-enlarge (quote after-selection))
 '(ecb-compile-window-width (quote edit-window))
 '(ecb-enlarged-compilation-window-max-height (quote half))
 '(ecb-excluded-directories-regexps (quote ("^\\(CVS\\|\\.[^xX]*\\)$" "/Library/Application Support/Aquamacs Emacs/Temporary Files/")))
 '(ecb-layout-name "leftright4")
 '(ecb-layout-window-sizes (quote (("leftright4" (ecb-methods-buffer-name 0.19801980198019803 . 0.9795918367346939) (ecb-directories-buffer-name 0.2079207920792079 . 0.5918367346938775) (ecb-history-buffer-name 0.2079207920792079 . 0.3877551020408163)))))
 '(ecb-options-version "2.40")
 '(ecb-select-edit-window-on-redraw t)
 '(ecb-show-sources-in-directories-buffer (quote always))
 '(ecb-source-path (quote (("~/dev" "Dev") ("~/Documents/Uni/8/" "Uni") ("~/Documents/Marcel" "Weltweise") ("~/dev/seasidetutorial" "seaside"))))
 '(ecb-tip-of-the-day nil)
 '(ecb-vc-enable-support t)
 '(focus-follows-mouse t)
 '(hippie-expand-try-functions-list (quote (try-complete-abbrev try-complete-file-name-partially try-complete-file-name try-expand-all-abbrevs try-expand-list try-expand-line try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill try-complete-lisp-symbol-partially try-complete-lisp-symbol)))
 '(indicate-buffer-boundaries t)
 '(linum-delay t)
 '(org-export-latex-classes (quote (("article" "\\documentclass[11pt]{article}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{amssymb}
\\usepackage{hyperref}" ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}") ("\\paragraph{%s}" . "\\paragraph*{%s}") ("\\subparagraph{%s}" . "\\subparagraph*{%s}")) ("report" "\\documentclass[11pt]{report}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{amssymb}
\\usepackage{hyperref}" ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}")) ("book" "\\documentclass[11pt]{book}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{amssymb}
\\usepackage{hyperref}" ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}")) ("speach" "\\documentclass[12pt,DIV=15]{scrartcl}
\\setlength\\textwidth{318.68709pt}
\\setlength\\marginparwidth{140.81625pt}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{hyperref}" ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}") ("\\paragraph{%s}" . "\\paragraph*{%s}") ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))))
 '(reftex-default-bibliography (quote ("/Users/tobias/Documents/Uni/Bib/ITSE.bib")))
 '(reftex-enable-partial-scans t)
 '(reftex-extra-bindings t)
 '(reftex-use-external-file-finders t)
 '(safe-local-variable-values (quote ((TeX-engine . xetex) (TeX-master . t) (TeX-style-local . "common") (TeX-style-local . common))))
 '(scroll-preserve-screen-position 1)
 '(semantic-default-submodes (quote (global-semantic-highlight-func-mode global-semantic-decoration-mode global-semantic-stickyfunc-mode global-semantic-idle-completions-mode global-semantic-idle-scheduler-mode global-semanticdb-minor-mode global-semantic-idle-summary-mode global-semantic-mru-bookmark-mode)))
 '(semantic-mode t)
 '(show-scratch-buffer-on-startup nil)
 '(size-indication-mode t)
 '(special-display-frame-alist (quote ((user-position) (width . 75) (height . 30) (left - 0) (top . 30) (unsplittable) (active-alpha . 0.9) (inactive-alpha . 0.6))))
 '(text-mode-hook (quote (turn-on-flyspell auto-detect-wrap smart-spacing-mode text-mode-hook-identify)))
 '(tramp-syntax (quote url))
 '(vc-command-messages t)
 '(visual-line-mode nil t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
