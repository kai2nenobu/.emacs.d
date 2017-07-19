;;; uiflow-mode.el --- Major mode for UI Flows

;;; Commentary:
;;

;;; Code:

(require 'rx)

(defvar uiflow-screen-regexp "^\\[[^]]+\\]")
(defvar uiflow-separator-regexp "^\\(?:--+\\)")
(defvar uiflow-transition-regexp "^\\(==*\\({[^}]*}\\)?=>\\)[ \t]*\\(.*\\)")

(defvar uiflow-font-lock-keywords
  `(
    ;; screen name
    (,uiflow-screen-regexp . font-lock-type-face)
    ;; separator
    (,uiflow-separator-regexp . font-lock-keyword-face)
    ;; transition
    (,uiflow-transition-regexp
     (1 font-lock-keyword-face)  ; right arrow
     (2 font-lock-string-face t t)  ; transition name
     (3 font-lock-builtin-face nil t)  ; destination
     )
    ))

(defun uiflow-jump-to-screen-definition ()
  "Jump to a screen definition."
  (interactive)
  (let ((line (buffer-substring (point-at-bol) (point-at-eol))))
    (if (string-match uiflow-transition-regexp line)
        (let ((screen-name (string-trim (match-string 3 line)))
              (current-pt (point)))
          (goto-char (point-min))
          (if (re-search-forward (concat "^\\[\\(" screen-name "\\)\\]") nil t)
              (progn
                (push-mark current-pt 'nomsg)  ; Save current position as a mark
                (goto-char (match-beginning 1)))
            (goto-char current-pt)
            (message "Not found a screen named \"%s\"" screen-name)))
      (message "The cursor is not on transition"))))

(defun uiflow-search-token (&optional count)
  "Search a token."
  (save-excursion
    (let ((count (or count 1))  ; defaults to 1
          (regexp (concat "\\(?:" uiflow-screen-regexp
                          "\\|" uiflow-separator-regexp
                          "\\|" uiflow-transition-regexp "\\)")))
      (when (> count 0)
        (goto-char (1+ (point))))  ; avoid to hit a current token
      (re-search-forward regexp nil t count))))

(defun uiflow-next-token (count)
  "Move cursor to a next token."
  (interactive "p")
  (if (uiflow-search-token count)
      (goto-char (match-beginning 0))
    (message "Not found a next token")))

(defun uiflow-previous-token (count)
  "Move cursor to a previous token."
  (interactive "p")
  (if (uiflow-search-token (- count))
      (goto-char (match-beginning 0))
    (message "Not found a previous token")))


;;;###autoload
(define-derived-mode uiflow-mode prog-mode "UIFLOW"
  "Major mode for UI Flow script

\\{uiflow-mode-map}"
   (setq-local font-lock-defaults '(uiflow-font-lock-keywords t t))
   (setq-local comment-start nil)
   (setq-local comment-end nil))

(define-key uiflow-mode-map (kbd "C-c C-j") 'uiflow-jump-to-screen-definition)
(define-key uiflow-mode-map (kbd "C-c C-n") 'uiflow-next-token)
(define-key uiflow-mode-map (kbd "C-c C-p") 'uiflow-previous-token)

(provide 'uiflow-mode)
;;; uiflow-mode.el ends here
