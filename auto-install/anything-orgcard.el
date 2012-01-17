;;; anything-orgcard.el --- browse the orgcard by anything

;; Copyright (C) 2011  

;; Author:  <m.sakurai at kiwanami.net>
;; Keywords: anything, org

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

;; (require 'anything-orgcard)
;;
;; M-x aoc:anything-orgcard

;;; Code:

(defvar aoc:orgcard-url "http://orgmode.org/orgcard.txt" "URL to the orgcard.txt.")
(defvar aoc:orgcard-file "~/.emacs.d/orgcard.txt" "Path to the orgcard.txt.")

(defun aoc:try-file ()
  "[internal] Check the local file. If it does not exist, this
function retrieves from the URL."
  (let ((file (expand-file-name aoc:orgcard-file)))
  (unless (file-exists-p file)
    (let ((buf (url-retrieve-synchronously aoc:orgcard-url)))
      (when buf
        (with-current-buffer buf 
          (write-file file))
        (kill-buffer buf))))
  (unless (file-exists-p file)
    (error "Can not get the orgcard file!"))))

(defun aoc:readline ()
  "[internal] read a line."
  (buffer-substring-no-properties
   (line-beginning-position)
   (line-end-position)))

(defun aoc:create-sources ()
  "[internal] create an anything source for orgcard."
  (let (heads cur-title cur-subtitle cur-records)
    (with-temp-buffer
      (insert-file-contents (expand-file-name aoc:orgcard-file))
      (goto-char (point-min))
      (forward-line 4) ; skip title
      (while 
          (let ((line (aoc:readline)))
            (cond
             ((equal "" line) nil)     ; do nothing
             ((equal ?= (aref line 0)) ; header
              (when cur-title          ; flush records
                (push 
                 `((name . ,cur-title)
                   (candidates ,@cur-records)
                   (action 
                    . (("Echo" . aoc:echo-action))))
                 heads))
              (forward-line 1)
              (setq cur-title (aoc:readline))
              (setq cur-records nil cur-subtitle nil)
              (forward-line 1))
             ((equal ?- (aref line 0)) ; subtitle
              (forward-line 1)
              (setq cur-subtitle (concat (aoc:readline) "# " ))
              (forward-line 1))
             (t                        ; normal line
              (push (concat cur-subtitle line) cur-records)))
            (forward-line 1)
            (not (eobp)))))
    (when cur-title ; flush the last records
      (push 
       `((name . ,cur-title)
         (candidates ,cur-records)
         (action . (("Echo" . aoc:echo-action))))
       heads))
    (reverse heads)))

(defun aoc:echo-action (entry)
  "[internal] popup an entry of orgcard."
  (message entry)
  ;;(popup-tip entry)
  nil)

(defun aoc:anything-orgcard ()
  "Anything command for orgcard."
  (interactive)
  (aoc:try-file)
  (anything (aoc:create-sources)))

(provide 'anything-orgcard)
;;; anything-orgcard.el ends here
