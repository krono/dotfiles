
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This program is free software; you can redistribute it and/or              ;;
;; modify it under the terms of the GNU General Public License                ;;
;; version 2 as published by the Free Software Foundation.                    ;;
;;                                                                            ;;
;; This program is distributed in the hope that it will be useful, but        ;;
;; WITHOUT ANY WARRANTY; without even the implied warranty of                 ;;
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU          ;;
;; General Public License for more details.                                   ;;
;;                                                                            ;;
;; Written and (C) by François Fleuret                                        ;;
;; Contact <francois.fleuret@epfl.ch> for comments & bug reports              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; $Id: alarm-vc.el,v 1.2 2006-09-10 18:26:06 fleuret Exp $

;; These functions display an alarm in the mode-line if the file in
;; the current buffer is not under CVS or subversion while the
;; directory is.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'vc-cvs nil t)

(when (require 'vc-svn nil t)

  ;; Weird that such a function exists in vc-cvs.el and not in vc-svn.el
  (defun vc-svn-responsible-p (file)
    "Return true if it seems that SVN is responsible for FILE."
    (file-exists-p (expand-file-name ".svn/entries"
                                     (file-name-directory file)))))

(defface alarm-vc-face
  '((((background light)) (:foreground "red" :bold t))
    (((background dark)) (:foreground "red" :bold t)))
  "The face for the modeline message.")

(setq minor-mode-alist (cons '(alarm-vc-alert alarm-vc-alert)
                             minor-mode-alist))

(make-variable-buffer-local 'alarm-vc-alert)

(defun alarm-vc-check ()
  "Adds an alarm in the modeline if the file in the current buffer is
not under CVS or subversion while the version control system seems to
be responsible for it."

  (if buffer-file-name
      (let ((message
             (concat

              ;; CVS
              (if (and (fboundp 'vc-cvs-registered)
                       (vc-cvs-responsible-p buffer-file-name)
                       (not (vc-cvs-registered buffer-file-name)))
                  " cvs")

              ;; Subversion
              (if (and (fboundp 'vc-svn-registered)
                       (vc-svn-responsible-p buffer-file-name)
                       (not (vc-svn-registered buffer-file-name)))
                  " svn")

              )))

        (setq alarm-vc-alert
              (if (string= message "") ""
                (concat " " (propertize (concat "Not under" message) 'face 'alarm-vc-face))))

        ))

  ;; Returns nil so that the file is not considered as saved when
  ;; the function is called by write-file-functions

  nil)

;; Refreshes the alarm when opening or saving a file

(add-hook 'find-file-hooks 'alarm-vc-check)
(add-hook 'write-file-hooks 'alarm-vc-check)

;; Since there is no hook called when one register a file through
;; version control, we need an advice.

(defadvice vc-register (after alarm-vc-check nil activate)
  (alarm-vc-check))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
