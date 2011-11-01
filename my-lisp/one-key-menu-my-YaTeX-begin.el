;;; one-key-menu-my-YaTeX-begin.el

(defvar one-key-menu-my-YaTeX-begin-alist nil
  "The `one-key' menu alist for my YaTeX-begin.")

(setq one-key-menu-my-YaTeX-begin-alist
      '(
        (("C-t" . "table environment (C-t)") . (lambda (arg) (interactive "P") (YaTeX-insert-begin-end "table" arg)))
        (("SPC" . "Yatex Make Begin End (SPC)") . YaTeX-make-begin-end)
        (("D" . "description environment (D)") . (lambda (arg) (interactive "P") (YaTeX-insert-begin-end "description" arg)))
        (("E" . "equation environment (E)") . (lambda (arg) (interactive "P") (YaTeX-insert-begin-end "equation" arg)))
        (("Q" . "Quotation environment (Q)") . (lambda (arg) (interactive "P") (YaTeX-insert-begin-end "Quatation" arg)))
        (("T" . "tabular environment (T)") . (lambda (arg) (interactive "P") (YaTeX-insert-begin-end "tabular" arg)))
        (("V" . "verse environment (V)") . (lambda (arg) (interactive "P") (YaTeX-insert-begin-end "verse" arg)))
        (("c" . "center environment (c)") . (lambda (arg) (interactive "P") (YaTeX-insert-begin-end "center" arg)))
        (("d" . "document environment (d)") . (lambda (arg) (interactive "P") (YaTeX-insert-begin-end "document" arg)))
        (("e" . "enumerate environment (e)") . (lambda (arg) (interactive "P") (YaTeX-insert-begin-end "enumerate" arg)))
        (("i" . "itemize environment (i)") . (lambda (arg) (interactive "P") (YaTeX-insert-begin-end "itemize" arg)))
        (("l" . "flushleft environment (l)") . (lambda (arg) (interactive "P") (YaTeX-insert-begin-end "flushleft" arg)))
        (("m" . "minipage environment (m)") . (lambda (arg) (interactive "P") (YaTeX-insert-begin-end "minipage" arg)))
        (("p" . "picture environment(p)") . (lambda (arg) (interactive "P") (YaTeX-insert-begin-end "picture" arg)))
        (("q" . "quote environment (q)") . (lambda (arg) (interactive "P") (YaTeX-insert-begin-end "quote" arg)))
        (("r" . "flushright environment (r)") . (lambda (arg) (interactive "P") (YaTeX-insert-begin-end "flushright" arg)))
        (("t" . "tabbing environment (t)") . (lambda (arg) (interactive "P") (YaTeX-insert-begin-end "tabbing" arg)))
        (("v" . "verbatim environment (v)") . (lambda (arg) (interactive "P") (YaTeX-insert-begin-end "verbatim" arg)))
        ))

(defun one-key-menu-my-YaTeX-begin ()
  "The `one-key' menu for YaTeX-begin"
  (interactive)
  (one-key-menu "YaTeX-begin" one-key-menu-my-YaTeX-begin-alist))

;; Use the `one-key-get-menu' command to show menu/keybindings for this buffer.

;; Uncomment and edit following line to set this menu as default for mode.
;;(add-to-list 'one-key-mode-alist '( . one-key-menu-YaTeX-begin))
;; Uncomment and edit following line to add this menu to toplevel menu.
;;(add-to-list 'one-key-toplevel-alist '(("type key here" . "YaTeX-begin") . one-key-menu-YaTeX-begin))
