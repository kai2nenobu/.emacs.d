;;; qv-mode.el --- Major mode for QlikView Load Script

;;; Commentary:
;;

;;; Code:

(defvar qv-statements
  (rx space
      (group
       (or "add" "alias" "binary" "buffer" "bundle" "call" "comment field"
           "comment table" "concatenate" "connect" "crosstable" "direct query"
           "directory" "disconnect" "do" "loop" "drop field" "drop  table"
           "execute" "exit script" "first" "for" "next" "for  each"
           "next" "force" "generic" "hierarchy" "hierarchybelongsto" "if"
           "then" "elseif" "else" "end  if" "image_size" "info" "inner"
           "inputfield" "intervalmatch" "join" "keep" "left" "let" "load"
           "loosen table" "mapping" "map" "using" "noconcatenate" "nullasnull"
           "nullasvalue" "outer" "qualify" "rem" "rename field" "rename table"
           "replace" "right" "sample" "section" "select" "semantic" "set"
           "sleep" "sql" "sqlcolumns" "sqltables" "sqltypes" "star" "store"
           "sub" "end sub" "switch" "case" "default" "end switch" "tag field"
           "trace" "unless" "unmap" "unqualify" "untag field" "when"))
      space)
  "Statements.")

(defvar qv-font-lock-keywords
  `(
    ("'[^']*'" . font-lock-string-face)
    ("\"[^\"]*\"" . font-lock-string-face)
    ("\\$([^)]*)" . font-lock-builtin-face)
    ("^\\sw+:" . font-lock-type-face)
    ("[sl]et\\s-+\\([$_[:word:]]+\\)\\s-*=" 1 font-lock-variable-name-face)
    (,qv-statements 1 font-lock-keyword-face)
    ("\\[\\([^]]+\\)\\]" 1 font-lock-keyword-face)
    ))

;;;###autoload
(define-derived-mode qv-mode prog-mode "QV"
  "Major mode for QlikView Load Script

\\{qv-mode-map}"
   (setq-local font-lock-defaults '(qv-font-lock-keywords t t))
   (setq-local comment-start "//")
   (setq-local comment-end ""))

;;;###autoload
(add-to-list 'magic-mode-alist (cons "///\\$tab Main" 'qv-mode))

(provide 'qv-mode)
;;; qv-mode.el ends here
