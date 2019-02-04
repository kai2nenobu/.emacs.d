;;; init.el --- Initialize Emacs
;;; Commentary:

;;; Code:

;; ~/.emacs.d/ 外の場所から読み込めるようにする
;; http://blog.shibayu36.org/entry/2015/05/01/172215
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;;; 文字コーディング設定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;;; custom設定を保存するファイルを別にする
(setq custom-file (locate-user-emacs-file "init-custom.el"))
(add-hook 'after-init-hook (lambda () (load custom-file)))

;; プロキシ設定を読み込む refs. https://qiita.com/ytoda129/items/9252678c65187296b9a3
(load (locate-user-emacs-file "proxy.el") t)

;; package.el初期設定
(require 'package nil t)
;; location to get package informations
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; use-package、quelpa-use-packageをインストールする
(unless (and (package-installed-p 'use-package)
             (package-installed-p 'quelpa-use-package))
  (package-refresh-contents)
  (package-install 'use-package)
  (package-install 'quelpa-use-package))

;; use-packageを利用する（存在しない場合は無視する）
(if (require 'use-package nil t)
    (progn
      (set-variable 'use-package-verbose t)
      (set-variable 'use-package-always-ensure t))
  (message "Use-package is unavailable!")
  (defmacro use-package (&rest args)))

;; Quelpaを利用してパッケージをインストールする
(when (require 'quelpa-use-package nil t)
  (custom-set-variables
   '(quelpa-upgrade-p nil nil nil "パッケージを自動アップデートしない")
   '(quelpa-checkout-melpa-p nil nil nil "MELPAリポジトリをクローンしない")
   '(quelpa-update-melpa-p nil nil nil "MELPAリポジトリをアップデートしない")
   '(quelpa-melpa-recipe-stores nil nil nil "MELPAレシピの配置場所")))

;;; org-babel を使って初期化ファイルをロード
;; マークアップの前後とみなす文字を変更する
(set-variable 'org-emphasis-regexp-components
              (list
               (concat " \t('\"{"           "[:nonascii:]") ; pre
               (concat "- \t.,:!?;'\")}\\[" "[:nonascii:]") ; post
               " \t\r\n" ; border
               "." ; body
               1   ; newline
               ))
(defvar org-init-directory (locate-user-emacs-file "org-init.d")
  "Directory to locate configuration files written in `org-mode'.")
(require 'org)
;(setq org-src-preserve-indentation t)   ; エクスポートでインデントを保持する
(org-babel-load-file (expand-file-name "init.org" org-init-directory))

(provide 'init)
;;; init.el ends here
