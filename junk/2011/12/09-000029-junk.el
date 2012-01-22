(defun anything-dired-file ()
  "Anything command in dired buffer."
  (interactive)
  (anything-other-buffer
   '(anything-c-source-files-in-current-dir+)
   "*anything dired:"))
  
(define-key dired-mode-map (kbd "/") 'anything-dired-file)