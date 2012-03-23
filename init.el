(add-to-list 'load-path (expand-file-name "site-lisp/org-mode" user-emacs-directory))
(defvar org-init-directory (expand-file-name "org-init.d" user-emacs-directory))
(require 'org-install)
(org-babel-load-file (expand-file-name "init.org" org-init-directory))
