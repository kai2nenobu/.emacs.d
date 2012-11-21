;;; 文字コーディング設定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;;; org-babel を使って初期化ファイルをロード
(add-to-list 'load-path (expand-file-name "site-lisp/org-mode" user-emacs-directory))
(defvar org-init-directory (expand-file-name "org-init.d" user-emacs-directory))
(require 'org)
;(setq org-src-preserve-indentation t)   ; エクスポートでインデントを保持する
(org-babel-load-file (expand-file-name "init.org" org-init-directory))
