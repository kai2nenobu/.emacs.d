;;; -*- Emacs-Lisp -*-
;;; my-major.el

(defun my-mode ()
  (interactive)
  ;; メジャーモードを設定
  (setq major-mode  'my-mode
        ;; メジャーモード名
        mode-name "ほげほげ")
  ;; ローカルキーマップを作る
  (setq my-local-map (make-keymap))
  ;; キーマップを設定
  (define-key my-local-map "h" 'backward-char)
  (define-key my-local-map "j" 'previous-line)
  (define-key my-local-map "k" 'next-line)
  (define-key my-local-map "l" 'forward-char)
  (define-key my-local-map "\C-ch" 'hello-world)
  ;; ローカルマップ使用宣言
  (use-local-map my-local-map)
)


;; インタラクティブ関数定義
(defun hello-world ()
  (interactive)
  (insert "Hello, world!\n")
)

