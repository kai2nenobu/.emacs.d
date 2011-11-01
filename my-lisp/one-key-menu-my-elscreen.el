;; one-key menu for my-elscreen


(defvar one-key-menu-my-elscreen-alist nil
  "The `one-key' menu alist for my-elscreen.")

(setq one-key-menu-my-elscreen-alist
      '(
	(("C-a" . "Elscreen Toggle (C-a)") . elscreen-toggle)
	(("C-c" . "Elscreen Create (C-c)") . elscreen-create)
	(("C-f" . "Elscreen Find File (C-f)") . elscreen-find-file)
	(("C-k" . "Elscreen Kill (C-k)") . elscreen-kill)
	(("RET" . "Elscreen Display Last Message (RET)") . elscreen-display-last-message)
	(("C-n" . "Elscreen Next (C-n)") . elscreen-next)
	(("C-p" . "Elscreen Previous (C-p)") . elscreen-previous)
	(("C-r" . "Elscreen Find File Read Only (C-r)") . elscreen-find-file-read-only)
	(("C-s" . "Elscreen Swap (C-s)") . elscreen-swap)
	(("C-t" . "Elscreen Display Time (C-t)") . elscreen-display-time)
	(("C-w" . "Elscreen Display Screen Name List (C-w)") . elscreen-display-screen-name-list)
	;; (("ESC" . "Prefix Command (ESC)") . Prefix Command)
	(("\"" . "Elscreen Select And Goto (\")") . elscreen-select-and-goto)
	(("'" . "Elscreen Goto (')") . elscreen-goto)
	(("0" . "Elscreen Jump 0 (0)") . elscreen-jump-0)
	;; (("1 .. 8" . "Elscreen Jump (1 .. 8)") . elscreen-jump)
	(("9" . "Elscreen Jump 9 (9)") . elscreen-jump-9)
	(("?" . "Elscreen Help (?)") . elscreen-help)
	(("A" . "Elscreen Screen Nickname (A)") . elscreen-screen-nickname)
	(("C" . "Elscreen Clone (C)") . elscreen-clone)
	(("K" . "Elscreen Kill Others (K)") . elscreen-kill-others)
	(("T" . "Elscreen Toggle Display Tab (T)") . elscreen-toggle-display-tab)
	(("a" . "Elscreen Toggle (a)") . elscreen-toggle)
	(("b" . "Elscreen Find And Goto By Buffer (b)") . elscreen-find-and-goto-by-buffer)
	(("c" . "Elscreen Create (c)") . elscreen-create)
	(("d" . "Elscreen Dired (d)") . elscreen-dired)
	(("i" . "Elscreen Toggle Display Screen Number (i)") . elscreen-toggle-display-screen-number)
	(("j" . "Elscreen Link (j)") . elscreen-link)
	(("k" . "Elscreen Kill (k)") . elscreen-kill)
	(("m" . "Elscreen Display Last Message (m)") . elscreen-display-last-message)
	(("n" . "Elscreen Next (n)") . elscreen-next)
	(("p" . "Elscreen Previous (p)") . elscreen-previous)
	(("s" . "Elscreen Split (s)") . elscreen-split)
	(("t" . "Elscreen Display Time (t)") . elscreen-display-time)
	(("v" . "Elscreen Display Version (v)") . elscreen-display-version)
	(("w" . "Elscreen Display Screen Name List (w)") . elscreen-display-screen-name-list)

	(("M-k" . "Elscreen Kill Screen And Buffers (M-k)") . elscreen-kill-screen-and-buffers)
	(("M-x" . "Elscreen Execute Extended Command (M-x)") . elscreen-execute-extended-command)
	))

(defun one-key-menu-my-elscreen ()
  "The `one-key' menu for my-elscreen"
  (interactive)
  (one-key-menu "my-elscreen" one-key-menu-my-elscreen-alist))

;; Use the `one-key-get-menu' command to show menu/keybindings for this buffer.

;; Uncomment and edit following line to set this menu as default for mode.
;;(add-to-list 'one-key-mode-alist '(elscreen . one-key-menu-my-elscreen))
;; Uncomment and edit following line to add this menu to toplevel menu.
;;(add-to-list 'one-key-toplevel-alist '(("type key here" . "my-elscreen") . one-key-menu-my-elscreen))










