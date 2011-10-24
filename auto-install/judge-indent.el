;;; judge-indent.el --- judge indent and tab widths

;;; Copyright (C) 2011 yascentur

;; Author:   yascentur <screenname at gmail dot com>
;; Keywords: indent tab
;; Version:  1.0.0

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; The judge-indent.el judges indent and tab widths
;; into following 8 (strictly 7) patterns.
;;
;;   \  indent
;;    \  2 4 8
;; tab \------
;;   4 | o c -
;;   8 | o o c <- It can not distinguish between (8, 8) and (4, 4)
;; nil | o o o

;;; Usage:

;; Add following 3 lines into your emacs config file
;;   (require 'judge-indent)
;;   (global-judge-indent-mode t)
;;   (setq judge-indent-major-modes '(c-mode python-mode sh-mode))

;;; Customization:

;; Set default indent width (2, 4 or 8)
;;   (setq judge-indent-default-indent-width 4)
;; The default value is `c-basic-offset' or 4
;;
;; Set default tab width (4 or 8)
;;   (setq judge-indent-default-tab-width 8)
;; The default value is `tab-width' or 8
;;
;; Set flag of preferring tab or not when indent is not so deep
;;   (setq judge-indent-prefer-tabs-mode nil)
;; The default value is `indent-tabs-mode' or nil
;;
;; Set relative tolerance [%] for judging indent and tab widths
;;   (setq judge-indent-relative-tolerance 5)
;; The default value is 5 %
;;
;; Set search limit for large size files
;;   (setq judge-indent-search-limit 30000)
;; The default value is 30000 chars (equal to ca. 1000 lines)

;;; Functions:

;; * judge-indent-mode
;; * judge-indent-buffer
;; * judge-indent-set-indent-width{2, 4, 8}
;; * judge-indent-disable-tab
;; * judge-indent-set-tab-width{4, 8}
;; * judge-indent-set-indent-width{2, 4, 8}-disable-tab
;; * judge-indent-set-indent-width{2, 4, 8}-tab-width{2, 8}

;;; Code:

(eval-when-compile (require 'cl))

(defgroup judge-indent nil
  "Judge indent"
  :group  'convenience
  :prefix "judge-indent-")

(defcustom judge-indent-major-modes '()
  "Major modes of applying judge-indent-mode"
  :type  '(list symbol)
  :group 'judge-indent)

(defcustom judge-indent-default-indent-width
  (if (default-boundp 'c-basic-offset)
      (default-value 'c-basic-offset) 4)
  "Default indent width (2, 4 or 8)"
  :type  'number
  :group 'judge-indent)

(defcustom judge-indent-default-tab-width
  (if (default-boundp 'tab-width)
      (default-value 'tab-width) 8)
  "Default tab width (4 or 8)"
  :type  'number
  :group 'judge-indent)

(defcustom judge-indent-prefer-tabs-mode
  (if (default-boundp 'indent-tabs-mode)
      (default-value 'indent-tabs-mode) nil)
  "Prefer tab or not when indent is not so deep"
  :type  'boolean
  :group 'judge-indent)

(defcustom judge-indent-relative-tolerance 5
  "Relative tolerance [%] for judging indent and tab widths"
  :type  'number
  :group 'judge-indent)

(defcustom judge-indent-search-limit 30000
  "Search limit for large size files (30000 chars equal to ca. 1000 lines)"
  :type  'number
  :group 'judge-indent)

;; set indent width
(defun judge-indent-set-indent-width (indent)
  "Set indent width"
  (interactive)
  (setq c-basic-offset           indent)
  (setq indent-level             indent)
  (setq standard-indent          indent)
  (setq c-indent-level           indent)
  (setq python-indent            indent)
  (setq perl-indent-level        indent)
  (setq cperl-indent-level       indent)
  (setq ruby-indent-level        indent)
  (setq html-basic-offset        indent)
  (setq sgml-basic-offset        indent)
  (setq html-helper-basic-offset indent)
  (setq nxml-child-indent        indent)
  (setq css-indent-level         indent)
  (setq cssm-indent-level        indent)
  (setq javascript-indent-level  indent)
  (setq js-indent-level          indent)
  (setq sh-basic-offset          indent))

(defun judge-indent-set-indent-width2 ()
  "Set indent width to 2"
  (interactive)
  (message "Set indent width to 2...")
  (judge-indent-set-indent-width 2))

(defun judge-indent-set-indent-width4 ()
  "Set indent width to 4"
  (interactive)
  (message "Set indent width to 4...")
  (judge-indent-set-indent-width 4))

(defun judge-indent-set-indent-width8 ()
  "Set indent width to 8"
  (interactive)
  (message "Set indent width to 8...")
  (judge-indent-set-indent-width 8))

;; set tab width
(defun judge-indent-set-tab-width (tab)
  "Set tab width"
  (interactive)
  (if (= tab 0)
      (setq indent-tabs-mode nil)
    (progn
      (setq indent-tabs-mode t)
      (setq tab-width tab)
      (setq tab-stop-list
            '((* tab  1) (* tab  2) (* tab  3) (* tab  4) (* tab  5)
              (* tab  6) (* tab  7) (* tab  8) (* tab  9) (* tab 10)
              (* tab 11) (* tab 12) (* tab 13) (* tab 14) (* tab 15))))))

(defun judge-indent-disable-tab ()
  "Disable tab"
  (interactive)
  (message "Disable tab...")
  (judge-indent-set-tab-width 0))

(defun judge-indent-set-tab-width4 ()
  "Set tab width to 4"
  (interactive)
  (message "Set tab width to 4...")
  (judge-indent-set-tab-width 4))

(defun judge-indent-set-tab-width8 ()
  "Set tab width to 8"
  (interactive)
  (message "Set tab width to 8...")
  (judge-indent-set-tab-width 8))

;; set indent and tab widths
(defun judge-indent-set-indent-tab-widths (indent tab)
  "Set indent and tab widths"
  (interactive)
  (message
   (concat "Set indent width to " (number-to-string indent) " and "
           (if (= tab 0) "disable tab"
             (concat "tab width to " (number-to-string tab)))
           "..."))
  (setcar (cdr (assq 'judge-indent-mode minor-mode-alist))
          (concat " JI:" (number-to-string indent)
                  "[" (if (= tab 0) "-" (number-to-string tab)) "]"))
  (judge-indent-set-indent-width indent)
  (judge-indent-set-tab-width    tab))

(defun judge-indent-set-indent-width2-disable-tab ()
  "Set indent width to 2 and disable tab"
  (interactive)
  (judge-indent-set-indent-tab-widths 2 0))

(defun judge-indent-set-indent-width4-disable-tab ()
  "Set indent width to 4 and disable tab"
  (interactive)
  (judge-indent-set-indent-tab-widths 4 0))

(defun judge-indent-set-indent-width8-disable-tab ()
  "Set indent width to 8 and disable tab"
  (interactive)
  (judge-indent-set-indent-tab-widths 8 0))

(defun judge-indent-set-indent-width2-tab-width4 ()
  "Set indent width to 2 and tab width to 4"
  (interactive)
  (judge-indent-set-indent-tab-widths 2 4))

(defun judge-indent-set-indent-width4-tab-width4 ()
  "Set indent width to 4 and tab width to 4"
  (interactive)
  (judge-indent-set-indent-tab-widths 4 4))

(defun judge-indent-set-indent-width2-tab-width8 ()
  "Set indent width to 2 and tab width to 8"
  (interactive)
  (judge-indent-set-indent-tab-widths 2 8))

(defun judge-indent-set-indent-width4-tab-width8 ()
  "Set indent width to 4 and tab width to 8"
  (interactive)
  (judge-indent-set-indent-tab-widths 4 8))

(defun judge-indent-set-indent-width8-tab-width8 ()
  "Set indent width to 8 and tab width to 8"
  (interactive)
  (judge-indent-set-indent-tab-widths 8 8))

;; judge indent and tab widths
(defun judge-indent-buffer ()
  "Judge indent and tab widths of buffer"
  (interactive)
  (let ((space2-count 0)
        (space4-count 0)
        (space8-count 0)
        (tab-count    0)
        (tolerance    0))
    (save-excursion
      ;; count spaces and tabs
      (goto-char (point-min))
      (while (search-forward "\n  " judge-indent-search-limit t)
        (incf space2-count))
      (goto-char (point-min))
      (while (search-forward "\r  " judge-indent-search-limit t)
        (incf space2-count))
      (goto-char (point-min))
      (while (search-forward "\n    " judge-indent-search-limit t)
        (incf space4-count))
      (goto-char (point-min))
      (while (search-forward "\r    " judge-indent-search-limit t)
        (incf space4-count))
      (goto-char (point-min))
      (while (search-forward "\n        " judge-indent-search-limit t)
        (incf space8-count))
      (goto-char (point-min))
      (while (search-forward "\r        " judge-indent-search-limit t)
        (incf space8-count))
      (goto-char (point-min))
      (while (search-forward "\n\t" judge-indent-search-limit t)
        (incf tab-count))
      (goto-char (point-min))
      (while (search-forward "\r\t" judge-indent-search-limit t)
        (incf tab-count))
      ;; set absolute tolerance
      (setq tolerance
            (/ (* (+ space2-count tab-count)
                  judge-indent-relative-tolerance) 100))
      ;; judge indent and tab widths
      (if (and (= space2-count 0) (= tab-count 0))
          (judge-indent-set-indent-tab-widths
           judge-indent-default-indent-width
           (if judge-indent-prefer-tabs-mode
               judge-indent-default-tab-width 0))
        (if (<= tab-count tolerance)
            (if (and (<= (- space4-count space8-count) tolerance)
                     (<= (- space2-count space4-count) tolerance))
                ;; indent width = 8
                (judge-indent-set-indent-tab-widths 8 0)
              (if (<= (- space2-count space4-count) tolerance)
                  ;; indent width = 4
                  (judge-indent-set-indent-tab-widths
                   4
                   (if (and (= space8-count 0) judge-indent-prefer-tabs-mode)
                       8 0))
                ;; indent width = 2
                (judge-indent-set-indent-tab-widths
                 2
                 (if (and (= space4-count 0) judge-indent-prefer-tabs-mode)
                     judge-indent-default-tab-width
                   (if (and (= space8-count 0) judge-indent-prefer-tabs-mode)
                       8 0)))))
          (if (<= space2-count tolerance)
              ;; indent width = tab width
              (judge-indent-set-indent-tab-widths
               judge-indent-default-tab-width
               judge-indent-default-tab-width)
            (if (<= space4-count tolerance)
                ;; indent width = 2 & tab width = 4
                (judge-indent-set-indent-tab-widths 2 4)
              (if (<= (- space2-count space4-count) tolerance)
                  ;; indent width = 4 & tab width = 8
                  (judge-indent-set-indent-tab-widths 4 8)
                ;; indent width = 2 & tab width = 8
                (judge-indent-set-indent-tab-widths 2 8)))))))))

(define-minor-mode judge-indent-mode
  "Judge indent mode"
  :lighter " JI"
  :group   'judge-indent
  (if judge-indent-mode
    (progn
      (setq local-enable-local-variables nil)
      (judge-indent-buffer))
    (setq local-enable-local-variables t)))

(define-global-minor-mode global-judge-indent-mode
  judge-indent-mode judge-indent-check-major-mode
  :group 'judge-indent)

(defun judge-indent-check-major-mode ()
  "Check major mode"
  (if (memq major-mode judge-indent-major-modes)
      (judge-indent-mode t)))

(provide 'judge-indent)

;;; judge-indent.el ends here
