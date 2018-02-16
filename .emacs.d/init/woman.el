;;
;; init woman.el
(autoload 'woman "woman"
  "Decode and browse a UN*X man page." t)
(autoload 'woman-find-file "woman"
  "Find, decode and browse a specific UN*X man-page file." t)
(autoload 'woman-dired-find-file "woman"
  "In dired, run the WoMan man-page browser on this file." t)
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "W" 'woman-dired-find-file)))
