;; one-key menu for my-mode-specific

(defvar one-key-menu-my-mode-specific-alist nil
  "The `one-key' menu alist for my-mode-specific.")

(setq one-key-menu-my-mode-specific-alist
      '(
	(("D" . "Sdic Describe Word At Point (D)") . sdic-describe-word-at-point)
	(("a" . "Align Regexp (a)") . align-regexp)
	(("c" . "Compile (c)") . compile)
	(("d" . "Sdic Describe Word (d)") . sdic-describe-word)
	(("e" . "Jaunte (e)") . jaunte)
	(("o" . "Occur By Moccur (o)") . occur-by-moccur)
	(("r" . "Recentf Open Files (r)") . recentf-open-files)
	(("s" . "Shell (s)") . shell)
	))

(defun one-key-menu-my-mode-specific ()
  "The `one-key' menu for my-mode-specific"
  (interactive)
  (one-key-menu "my-mode-specific" one-key-menu-my-mode-specific-alist))

;; Use the `one-key-get-menu' command to show menu/keybindings for this buffer.

;; Uncomment and edit following line to set this menu as default for mode.
;;(add-to-list 'one-key-mode-alist '(mode-specific . one-key-menu-my-mode-specific))
;; Uncomment and edit following line to add this menu to toplevel menu.
;;(add-to-list 'one-key-toplevel-alist '(("type key here" . "my-mode-specific") . one-key-menu-my-mode-specific))