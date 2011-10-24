;;; describe-bindings

(defvar my-one-key-list '("C-x 5" "C-x 4") "Keystroke list to show keybindings")
(defun my-one-key-defvar-alist ()
  (interactive)
  (


(defvar my-one-key-alist "")
(defun my-one-key ()
  (interactive)
  (describe-buffer-bindings (current-buffer) (kbd "C-x") nil)
  )

(defun my-regex ()
  (interactive)
  (while (re-search-forward "^\\(C-x\\( [^ ]+\\)+\\) +\\(.*\\)$" nil t)
    (let* ((bind-key (match-string-no-properties 1))
	   (last-key (substring (match-string-no-properties 2) 1))
	   (command (match-string-no-properties 3))
	   (bind-splits (split-string bind-key " ")))
      (when (= (length  bind-splits) 2)
	 (add-to-list 'my-one-key-alist (cons last-key command) t))
      my-one-key-alist)))

(defun my-one-key-print-alist (alist)
  (interactive)
  (let (alist-elm
        (cnt 0))
    (while (setq alist-elm (nth cnt alist))
      (insert (format "%-15s %-39s\n" (concat "[" (car alist-elm) "]") (cdr alist-elm)))
      (setq cnt (1+ cnt)))
    ))



