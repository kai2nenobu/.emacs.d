;;; bom-mode.el --- Visualize BOM mark

;;; Commentary:

;;; Code:

(defgroup bom-mode nil
  "Group for bom-mode."
  :group 'help
  :prefix "bom-mode-")

(defcustom bom-mode-utf-8-string "BOM" "BOM mark string for utf-8.")
(defcustom bom-mode-utf-16be-string "BE" "BOM mark string for utf-16be.")
(defcustom bom-mode-utf-16le-string "LE" "BOM mark string for utf-16le.")

(defface bom-mode-mark-face
  '((((class color) (background dark))
     (:foreground "dark blue" :background "red" :weight bold :box t))
    (((class color) (background light))
     (:foreground "gray30" :background "gold" :weight bold :box t)))
  "Face for BOM mark.")

(defvar-local bom-mode-overlay nil "hogehoge")

;;;###autoload
(define-minor-mode bom-mode "Visualize BOM in buffer."
  :init-value nil
  :global nil
  :lighter " BOM"
  (if bom-mode
      (bom-mode--visualize)
    (bom-mode--clear)))

(defun bom-mode--visualize ()
  (setq bom-mode-overlay (make-overlay 1 1))
  (let* ((base-cs (coding-system-base buffer-file-coding-system))
         (name (symbol-name base-cs)))
    (when (string-match "-with-signature" name)
      (overlay-put bom-mode-overlay
                   'before-string (bom-mode--bom-string buffer-file-coding-system)))))

(defun bom-mode--bom-string (coding-system)
  (let* ((base-cs (coding-system-base  coding-system))
         (name (symbol-name base-cs))
         (str (cond ((string-match "utf-8" name) bom-mode-utf-8-string)
                    ((string-match "utf-16be" name) bom-mode-utf-16be-string)
                    ((string-match "utf-16le" name) bom-mode-utf-16le-string)
                    (t ""))))
    (propertize str 'face 'bom-mode-mark-face)))

(defun bom-mode--clear ()
  (delete-overlay bom-mode-overlay)
  (setq bom-mode-overlay nil))


(provide 'bom-mode)
;;; bom-mode.el ends here
