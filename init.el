;;; 文字コーディング設定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; package.el初期設定
(when (require 'package nil t)
  ;; location to get package informations
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/")))

;; caskかpackageのどちらかで初期化
(if (file-exists-p "~/.cask/cask.el")
    (progn
      (require 'cask "~/.cask/cask.el")
      (cask-initialize)
      (require 'pallet nil t))
  (package-initialize))

;; use-packageを利用する（存在しない場合は無視する）
(if (require 'use-package nil t)
    (setq use-package-verbose t)
  (message "Use-package is unavailable!")
  (defmacro use-package (&rest args)))

;;; org-babel を使って初期化ファイルをロード
(defvar org-init-directory (locate-user-emacs-file "org-init.d"))
(require 'org)
;(setq org-src-preserve-indentation t)   ; エクスポートでインデントを保持する
(org-babel-load-file (expand-file-name "init.org" org-init-directory))
