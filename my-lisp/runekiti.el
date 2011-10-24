;;; -*- Emacs-Lisp -*-
;;; runekiti.el

(defun my-mode ()
  (interactive)
  ;; メジャーモードを設定
  (setq major-mode  'runekiti.el
        ;; メジャーモード名
        mode-name "るねきちモ〜ド")
  ;; ローカルキーマップを作る
  (setq runekiti-local-map (make-keymap))
  ;; キーマップを設定
  (define-key runekiti-local-map "h" 'backward-char)
  (define-key runekiti-local-map "j" 'previous-line)
  (define-key runekiti-local-map "k" 'next-line)
  (define-key runekiti-local-map "l" 'forward-char)
  (define-key runekiti-local-map "\C-ch" 'hello-world)
  ;; ローカルマップ使用宣言
  (use-local-map runekiti-local-map)
)

;; インタラクティブ関数定義
(defun hello-world ()
  (interactive)
  (insert "Hello, world!\n")
)


(defun normal-function (a b)
  (message (concat a b))
)

(defun interactive-function (a b)
  (interactive "sInput string a:\nsInput string b:")
  (message (concat a b))
)

(defun count-down (arg)
  (interactive "p")
  (while (>= arg 0)
    (message "Time left %ds\n" arg)
    (sleep-for 1)
    (setq arg (- arg 1))))

(count-down 5)
(point-max)
