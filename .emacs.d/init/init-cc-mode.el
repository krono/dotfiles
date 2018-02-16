;; For openbsd and the like
(c-add-style "openbsd"
              '("bsd"
                (c-backspace-function . delete-backward-char)
                (c-syntactic-indentation-in-macros . nil)
                (c-tab-always-indent . nil)
                (c-hanging-braces-alist
                 (block-close . c-snug-do-while))
                (c-offsets-alist
                 (arglist-cont-nonempty . *)
                 (statement-cont . *))
                (indent-tabs-mode . t)))
