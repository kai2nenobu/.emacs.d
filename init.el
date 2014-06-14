;;; 文字コーディング設定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; package.el初期設定
(when (require 'package nil t)
  ;; location to get package informations
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/")))

;; caskかpackageのどちらかで初期化
(if (executable-find "cask")
    (progn
      (require 'cask "~/.cask/cask.el")
      (cask-initialize))
  (package-initialize))

;;; org-babel を使って初期化ファイルをロード
(defvar org-init-directory (expand-file-name "org-init.d" user-emacs-directory))
(require 'org)
;(setq org-src-preserve-indentation t)   ; エクスポートでインデントを保持する
(org-babel-load-file (expand-file-name "init.org" org-init-directory))
