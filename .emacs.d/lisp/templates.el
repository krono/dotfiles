;; -*- emacs-lisp -*- 
;; 
;; Provide templates for the most common XSLT constructions. 
;; Insert a proper header in the current buffer. 
;; 
;; Copyright (C) 2000 Ovidiu Predescu 
;; 
;; Author: Ovidiu Predescu <ovidiu@cup.hp.com> 
;; Created: February, October 2000 
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
;; (require 'templates) 
;; 
 
 
(require 'tempo)
;(require 'psgml)

;; The following templates add a comment to the beginning of the
;; current buffer describing the author's name and the current date

;; Java, C, C++, Objective-C
(tempo-define-template "c-like-header"
  '("/*\n"
    "    " (buffer-name) "\n\n"
    "    Author: " user-full-name " <" user-mail-address ">\n"
    "    Date: " (format-time-string "%B %e, %Y" (current-time)) "\n\n"
    " */\n\n"
    (if (string= mode-name "JDE")
	(let ((package (jpack-generate-package-statement)))
	    (unless (string= package "")
	          (concat package "\n\n"))))))

;; Makefiles, shell scripts
(tempo-define-template "sh-like-header"
  '("#\n"
    "#  Author: " user-full-name " <" user-mail-address ">\n"
    "#  Date: " (format-time-string "%B %e, %Y" (current-time)) "\n"
    "#\n\n"))

;; Emacs lisp
(tempo-define-template "lisp-like-header"
  '(";;\n"
    ";;  Author: " user-full-name " <" user-mail-address ">\n"
    ";;  Date: " (format-time-string "%B %e, %Y" (current-time)) "\n"
    ";;\n\n"))

;; XML
(tempo-define-template "xml-like-header"
 '("<?xml version=\"1.0\"?>\n"
   "\n"
   "<!-- Author: " user-full-name " \"" user-mail-address "\" -->\n"
   "<!-- Date: " (format-time-string "%B %e, %Y" (current-time)) " -->\n"
   "\n"))

(defun insert-header ()
  (interactive)
  (goto-char (point-min))
  (cond ((eq major-mode 'sh-mode) (tempo-template-sh-like-header))
	((eq major-mode 'autoconf-mode) (tempo-template-sh-like-header))
	((eq major-mode 'makefile-mode) (tempo-template-sh-like-header))
	((eq major-mode 'c-mode) (tempo-template-c-like-header))
	((eq major-mode 'c++-mode) (tempo-template-c-like-header))
	((eq major-mode 'objc-mode) (tempo-template-c-like-header))
	((eq major-mode 'java-mode) (tempo-template-c-like-header))
	((eq major-mode 'jde-mode) (tempo-template-c-like-header))
	((eq major-mode 'xml-mode) (tempo-template-xml-like-header))
	((eq major-mode 'emacs-lisp-mode) (tempo-template-lisp-like-header))))

;;;###autoload
(global-set-key [f8] 'insert-header)

;;
;; XSL keyboard aliases
;;
(defun get-value-from-minibuffer (display format-string)
  (let ((input (read-from-minibuffer display)))
    (if (string= input "")
	""
      (format format-string input))))

(tempo-define-template "xsl-template"
 '('&'o'> "<xsl:template"
   (get-value-from-minibuffer "match: " " match=\"%s\"")
   (get-value-from-minibuffer "name: " " name=\"%s\"")
   (get-value-from-minibuffer "mode: " " mode=\"%s\"")
   ">" 'n'>'n
   "</xsl:template>" '>
   (end-of-line 0)))

(tempo-define-template "xsl-if"
 '('&'o'> "<xsl:if"
   (get-value-from-minibuffer "test: " " test=\"%s\"")
   ">" 'n'>'n
   "</xsl:if>" '>
   (end-of-line 0)))

(tempo-define-template "xsl-for-each"
 '('&'o'> "<xsl:for-each"
   (get-value-from-minibuffer "select: " " select=\"%s\"")
   ">" 'n'>'n
   "</xsl:for-each>" '>
   (end-of-line 0)))

(tempo-define-template "xsp-logic"
 '('&'o'> "<xsp:logic>" '>'n'>'n
   "</xsp:logic>" '>'n
   (end-of-line -1)))

(tempo-define-template "xsp-expr"
 '('&'o'> "<xsp:expr>" '>'n'>'n
   "</xsp:expr>" '>'n
   (end-of-line -1)))

(tempo-define-template "xsl-value-of"
 '('> "<xsl:value-of"
   (get-value-from-minibuffer "select: " " select=\"%s\"")
   "/>" '>))

(tempo-define-template "xsl-variable"
 '('> "<xsl:variable"
   (get-value-from-minibuffer "name: " " name=\"%s\"")
   (get-value-from-minibuffer "select: " " select=\"%s\"")
   "/>" '>))

(tempo-define-template "xsl-copy"
 '('&'o'> "<xsl:copy>" '>'n'>'n
   "</xsl:copy>" '>'n
   (end-of-line -1)))

(tempo-define-template "xsl-copy-of"
 '('> "<xsl:copy-of"
   (get-value-from-minibuffer "select: " " select=\"%s\"")
   "/>" '>))

(tempo-define-template "xsl-apply-templates"
 '('> "<xsl:apply-templates"
   (get-value-from-minibuffer "select: " " select=\"%s\"")
   (get-value-from-minibuffer "mode: " " mode=\"%s\"")
   "/>" '>))

;; (define-key xml-mode-map "\C-ct" 'tempo-template-xsl-template)
;; (define-key xml-mode-map "\C-ci" 'tempo-template-xsl-if)
;; (define-key xml-mode-map "\C-cf" 'tempo-template-xsl-for-each)
;; (define-key xml-mode-map "\C-cvo" 'tempo-template-xsl-value-of)
;; (define-key xml-mode-map "\C-cvv" 'tempo-template-xsl-variable)
;; (define-key xml-mode-map "\C-ca" 'tempo-template-xsl-apply-templates)
;; (define-key xml-mode-map "\C-cl" 'tempo-template-xsp-logic)
;; (define-key xml-mode-map "\C-ce" 'tempo-template-xsp-expr)
;; (define-key xml-mode-map "\C-ccc" 'tempo-template-xsl-copy)
;; (define-key xml-mode-map "\C-cco" 'tempo-template-xsl-copy-of)

(provide 'templates)
