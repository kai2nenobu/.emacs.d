;;; shell-session-mode.el --- Major mode for shell session

;;; Commentary:
;;

;;; Code:

(defvar shell-session-font-lock-keywords
  '(
    ;; prompt
    ("^\\([a-zA-Z0-9:@~]*[#$%>] \\)\\(.*\\)$"
     (1 font-lock-constant-face)
     (2 font-lock-doc-face)
     )
    ;; output
    (".*" . shell-session-output-face)
    )
  ".")

(defface shell-session-output-face
  '((((class color) (background dark))
     (:foreground "gray80"))
    (((class color) (background light))
     (:foreground "gray45")))
  "")
(defvar shell-session-output-face 'shell-session-output-face ".")

;;;###autoload
(define-derived-mode shell-session-mode text-mode "Shell-Session"
  "Major mode for shell session

\\{shell-session-mode-map}"
  (setq-local font-lock-defaults '(shell-session-font-lock-keywords t t))
  (setq-local comment-start "#")
  (setq-local comment-end nil))


(provide 'shell-session-mode)
;;; shell-session-mode.el ends here
