;;; flycheck-textlint.el --- Flycheck: textlint extensions  -*- lexical-binding: t; -*-


;;; Commentary:
;; 

;;; Code:

(require 'flycheck)

(flycheck-define-checker textlint
      "A linter by textlint."
      :command ("textlint" "--config" (eval (expand-file-name ".textlintrc" "~")) "--format" "json" source-inplace)
      :error-parser flycheck-parse-eslint
      :modes (text-mode markdown-mode gfm-mode))

(add-to-list 'flycheck-checkers 'textlint)

(provide 'flycheck-textlint)
;;; flycheck-textlint.el ends here
