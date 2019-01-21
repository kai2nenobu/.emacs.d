;;; flycheck-textlint.el --- Flycheck: textlint extensions  -*- lexical-binding: t; -*-


;;; Commentary:
;; 

;;; Code:

(require 'flycheck)

(flycheck-define-checker textlint
      "A linter by textlint."
      :command ("textlint" "--config" (eval (expand-file-name ".textlintrc" "~")) "--format" "unix" source-inplace)
      :error-patterns
      ((warning line-start (file-name) ":" line ":" column ": "
                (id (one-or-more (not (any " "))))
                (message (one-or-more not-newline)
                         (zero-or-more "\n" (any " ") (one-or-more not-newline)))
                line-end))
      :modes (text-mode markdown-mode gfm-mode))

(add-to-list 'flycheck-checkers 'textlint)

(provide 'flycheck-textlint)
;;; flycheck-textlint.el ends here
