;; -*- emacs-lisp -*-
;;
;; remotedisplay.el - change the background color to indicate a
;; remote display
;;
;; Copyright (C) 2000 Ovidiu Predescu
;;
;; Author: Ovidiu Predescu <ovidiu@cup.hp.com>
;; Created: May 2000
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;
;; Setup: put this file in your Lisp path and add the following line in
;; your .emacs:
;;
;; (load "remotedisplay")
;;

; Change the color of the display if we are running on a remote
; display
(if running-xwindows
    (let* ((machine-display (getenv "DISPLAY"))
           (cannonical-display ; If machine-display is specified like
                               ; :0, cannonical-name will be
                               ; hostname:0.0
            (if (string-match "^:.*" machine-display)
                (concat (system-name) ":0.0")
              machine-display))
            (machine (substring cannonical-display
                                0
                                (string-match ":.*"
                                              cannonical-display))))
      (if (not (string-match machine (system-name)))
          (progn
            (set-face-background 'default "bisque")
            (custom-set-faces
             '(font-lock-reference-face ((t (:foreground "blue4"))))
             '(font-lock-keyword-face
               ((t (:foreground "red" :background ""))))
             '(font-lock-comment-face ((t (:foreground "blue4"))))
             '(font-lock-function-name-face ((t (:foreground "blue"))))
             '(dired-face-symlink
               ((((class color)) (:foreground "blue3")))))))))
