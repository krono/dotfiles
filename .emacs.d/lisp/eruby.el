(mmm-add-classes
 '((eruby
    :submode ruby-mode
;    :face mmm-decleration-submode-face
    :front "<%[=]?"
    :back "%>")))

;(mmm-add-mode-ext-class MODULE EXTENSION CLASS)
(mmm-add-mode-ext-class 'html-helper-mode "\\.rhtml$" 'eruby)

;(mmm-add-classes
; '((eruby
;    :submode ruby-mode
;    :front "<%"
;    :back "%>"
;    :insert ((?c eruby nil @ "<%" @ " " _ " " @ "%>" @)
;	     (?e eruby nil @ "<%=" @ " " _ " " @ "%>" @)))))
;(add-hook 'html-mode-hook 
;	  (lambda ()
;	    (setq mmm-classes '(eruby))
;	    (mmm-mode-on)))