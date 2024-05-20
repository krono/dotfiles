;; strange hack
(defun mouse-start-rectangle (start-event)
  (interactive "e")
  (deactivate-mark)
  (mouse-set-point start-event)
  (rectangle-mark-mode +1)
  (let ((drag-event))
    (track-mouse
      (while (progn
               (setq drag-event (read-event))
               (mouse-movement-p drag-event))
        (mouse-set-point drag-event)))))

(when (featurep 'aquamacs)
  (unless (fboundp 'frame-iconified-p)
    (fset 'frame-iconified-p 'frcmds-frame-iconified-p))
 ; (global-set-key (kbd "S-<down-mouse-1>") #'mouse-start-rectangle)
  (global-set-key (kbd "S-<down-mouse-2>") #'mouse-start-rectangle))
