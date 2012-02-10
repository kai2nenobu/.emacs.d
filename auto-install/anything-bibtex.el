;;; anything-bibtex.el --- An Anything source for BibTeX

;; Copyright (C) 2011  Kyosuke Kawai

;; Author: Kyosuke Kawai <askjkawai@gmail.com>
;; Keywords: anything tex
;; Version: 0.1

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

;; This is an anything source for bibtex.
;; It uses RefTex.
;; This version works only for bibliography command, instead of thebibliography command.

;;; Code:

(require 'reftex-cite)
(require 'anything)

(defconst anything-bibtex-format-bib-delimiter ";"
  "The delimiter charactor used in bibliography format instead of newline.")

(defvar anything-bibtex-format-bib-entry-flag nil
  "The flag whether an adviece `reftex-format-delete-newline' for
`reftex-format-bib-entry' performed or not.")

(defadvice reftex-format-bib-entry
  (after reftex-format-delete-newline activate)
  "Replace newline in bibliography format
with `anything-reftex-format-bib-delimiter'
to collect each citation in one line."
  (when anything-bibtex-format-bib-entry-flag
    (setq ad-return-value
          (concat (replace-regexp-in-string
                   "\n"
                   anything-bibtex-format-bib-delimiter
                   ad-return-value)
                  "\n")))
  ad-return-value)

(defun anything-bibtex-collect-entries-by-regexp ()
  (let ((anything-bibtex-format-bib-entry-flag t))
    (reftex-extract-bib-entries (reftex-get-bibfile-list))))
(defun anything-bibtex-format-bib (entries)
  (if entries
      (reftex-insert-bib-matches entries)
    (error "Sorry, no matches found")))
(defun anything-bibtex-init ()
  (with-current-buffer
      anything-current-buffer
    (let ((matched-bib (anything-bibtex-collect-entries-by-regexp)))
      (with-current-buffer
          (anything-candidate-buffer 'global)
        (anything-bibtex-format-bib matched-bib))
      )))
(defun anything-bibtex-reconstruct-entry-alist (entry)
  (string-match "\\(.+\\); +\\(.+\\); +\\(.+\\);;" entry)
  (let ((key (match-string 1 entry))
        (title (match-string 3 entry))
        (other (match-string 2 entry)))
    (insert (reftex-format-citation
             `(("&key" . ,key)
               )
              nil))))
(defvar anything-c-source-bibtex
  '((name . "BibTeX")
    (candidates-in-buffer)
    (init . anything-bibtex-init)
    (action . anything-bibtex-reconstruct-entry-alist)))

(provide 'anything-bibtex)
;;; anything-bibtex.el ends here
