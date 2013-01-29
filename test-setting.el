(add-to-list 'load-path "~/.emacs.d/package/popwin-20121210.2054")
(add-to-list 'load-path "~/.emacs.d/my-lisp/guide-key")
(require 'guide-key)
(setq guide-key/guide-key-sequence '("<f1>" "\C-x" "C-c"))
(guide-key-mode 1)
(setq guide-key/recursive-key-sequence-flag t)


(define-key key-translation-map (kbd "C-h") (kbd "DEL"))
