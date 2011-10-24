;; one-key menu for my-wl-folder

(defvar one-key-menu-my-wl-folder-alist nil
  "The `one-key' menu alist for my-wl-folder.")

(setq one-key-menu-my-wl-folder-alist
      '(
	;; (("C-c" . "Prefix Command (C-c)") . Prefix Command)
	(("TAB" . "Wl Folder Revisit Last Visited Folder (TAB)") . wl-folder-revisit-last-visited-folder)
	(("C-k" . "Wl Fldmgr Cut (C-k)") . wl-fldmgr-cut)
	(("RET" . "Wl Folder Jump To Current Entity (RET)") . wl-folder-jump-to-current-entity)
	(("C-t" . "Wl Plugged Change (C-t)") . wl-plugged-change)
	(("C-w" . "Wl Fldmgr Cut Region (C-w)") . wl-fldmgr-cut-region)
	;; (("C-x" . "Prefix Command (C-x)") . Prefix Command)
	(("C-y" . "Wl Fldmgr Yank (C-y)") . wl-fldmgr-yank)
	;; (("ESC" . "Prefix Command (ESC)") . Prefix Command)
	(("SPC" . "Wl Folder Jump To Current Entity (SPC)") . wl-folder-jump-to-current-entity)
	(("*" . "Wl Fldmgr Make Multi (*)") . wl-fldmgr-make-multi)
	(("+" . "Wl Fldmgr Make Group (+)") . wl-fldmgr-make-group)
	(("/" . "Wl Folder Open Close (/)") . wl-folder-open-close)
	(("<" . "Beginning Of Buffer (<)") . beginning-of-buffer)
	((">" . "End Of Buffer (>)") . end-of-buffer)
	(("?" . "Wl Folder Pick (?)") . wl-folder-pick)
	(("E" . "Wl Folder Empty Trash (E)") . wl-folder-empty-trash)
	(("F" . "Wl Folder Flush Queue (F)") . wl-folder-flush-queue)
	(("G" . "Wl Folder Goto Folder Sticky (G)") . wl-folder-goto-folder-sticky)
	(("I" . "Wl Folder Prefetch Current Entity (I)") . wl-folder-prefetch-current-entity)
	(("J" . "Wl Folder Jump Folder (J)") . wl-folder-jump-folder)
	(("L" . "Wl Fldmgr Access Display All (L)") . wl-fldmgr-access-display-all)
	(("N" . "Wl Folder Next Unread (N)") . wl-folder-next-unread)
	(("P" . "Wl Folder Prev Unread (P)") . wl-folder-prev-unread)
	(("R" . "Wl Fldmgr Rename (R)") . wl-fldmgr-rename)
	(("S" . "Wl Folder Sync Current Entity (S)") . wl-folder-sync-current-entity)
	(("U" . "Wl Fldmgr Unsubscribe Region (U)") . wl-fldmgr-unsubscribe-region)
	(("V" . "Wl Folder Virtual (V)") . wl-folder-virtual)
	(("W" . "Wl Folder Write Current Folder (W)") . wl-folder-write-current-folder)
	(("Z" . "Wl Status Update (Z)") . wl-status-update)
	(("[" . "Wl Folder Open All ([)") . wl-folder-open-all)
	(("]" . "Wl Folder Close All (])") . wl-folder-close-all)
	(("c" . "Wl Folder Mark As Read All Current Entity (c)") . wl-folder-mark-as-read-all-current-entity)
	(("e" . "Wl Folder Expire Current Entity (e)") . wl-folder-expire-current-entity)
	(("f" . "Wl Folder Goto First Unread Folder (f)") . wl-folder-goto-first-unread-folder)
	(("g" . "Wl Folder Goto Folder (g)") . wl-folder-goto-folder)
	(("j" . "Wl Folder Jump To Current Entity (j)") . wl-folder-jump-to-current-entity)
	(("l" . "Wl Fldmgr Access Display Normal (l)") . wl-fldmgr-access-display-normal)
	(("m" . "Wl Fldmgr Mode Map (m)") . wl-fldmgr-mode-map)
	(("n" . "Wl Folder Next Entity (n)") . wl-folder-next-entity)
	(("o" . "Wl Folder Open All Unread Folder (o)") . wl-folder-open-all-unread-folder)
	(("p" . "Wl Folder Prev Entity (p)") . wl-folder-prev-entity)
	(("q" . "Wl Exit (q)") . wl-exit)
	;; (("r" . "Prefix Command (r)") . Prefix Command)
	(("s" . "Wl Folder Check Current Entity (s)") . wl-folder-check-current-entity)
	(("u" . "Wl Fldmgr Unsubscribe (u)") . wl-fldmgr-unsubscribe)
	(("v" . "Wl Folder Toggle Disp Summary (v)") . wl-folder-toggle-disp-summary)
	(("w" . "Wl Draft (w)") . wl-draft)
	(("x" . "Wl Execute Temp Marks (x)") . wl-execute-temp-marks)
	(("z" . "Wl Folder Suspend (z)") . wl-folder-suspend)
	(("|" . "Wl Fldmgr Make Filter (|)") . wl-fldmgr-make-filter)
	(("<S-mouse-4>" . "Wl Folder Prev Unread (<S-mouse-4>)") . wl-folder-prev-unread)
	(("<S-mouse-5>" . "Wl Folder Next Unread (<S-mouse-5>)") . wl-folder-next-unread)
	(("<S-return>" . "Wl Folder Jump To Current Entity With Arg (<S-return>)") . wl-folder-jump-to-current-entity-with-arg)
	(("<mouse-2>" . "Wl Folder Click (<mouse-2>)") . wl-folder-click)
	(("<mouse-4>" . "Wl Folder Prev Entity (<mouse-4>)") . wl-folder-prev-entity)
	(("<mouse-5>" . "Wl Folder Next Entity (<mouse-5>)") . wl-folder-next-entity)
	;; (("<tool-bar>" . "Prefix Command (<tool-bar>)") . Prefix Command)

	;; (("<tool-bar> <wl-draft>" . "Wl Draft (<tool-bar> <wl-draft>)") . wl-draft)
	;; (("<tool-bar> <wl-exit>" . "Wl Exit (<tool-bar> <wl-exit>)") . wl-exit)
	;; <tool-bar> <wl-folder-check-current-entity>
	;; wl-folder-check-current-entity
	;; <tool-bar> <wl-folder-empty-trash>
	;; wl-folder-empty-trash
	;; <tool-bar> <wl-folder-goto-draft-folder>
	;; wl-folder-goto-draft-folder
	;; <tool-bar> <wl-folder-jump-to-current-entity>
	;; wl-folder-jump-to-current-entity
	;; <tool-bar> <wl-folder-next-entity>
	;; wl-folder-next-entity
	;; <tool-bar> <wl-folder-prev-entity>
	;; wl-folder-prev-entity
	;; <tool-bar> <wl-folder-sync-current-entity>
	;; wl-folder-sync-current-entity

	;; (("C-x C-s" . "Wl Save (C-x C-s)") . wl-save)
	;; (("C-x k" . "Wl Folder Mimic Kill Buffer (C-x k)") . wl-folder-mimic-kill-buffer)

	;; (("m C-s" . "Wl Fldmgr Save Folders (m C-s)") . wl-fldmgr-save-folders)
	;; (("m C-w" . "Wl Fldmgr Cut Region (m C-w)") . wl-fldmgr-cut-region)
	;; (("m A" . "Wl Fldmgr Make Access Group (m A)") . wl-fldmgr-make-access-group)
	;; (("m L" . "Wl Fldmgr Access Display All (m L)") . wl-fldmgr-access-display-all)
	;; (("m R" . "Wl Fldmgr Rename (m R)") . wl-fldmgr-rename)
	;; (("m U" . "Wl Fldmgr Unsubscribe Region (m U)") . wl-fldmgr-unsubscribe-region)
	;; (("m W" . "Wl Fldmgr Copy Region (m W)") . wl-fldmgr-copy-region)
	;; (("m a" . "Wl Fldmgr Add (m a)") . wl-fldmgr-add)
	;; (("m c" . "Wl Fldmgr Copy (m c)") . wl-fldmgr-copy)
	;; (("m d" . "Wl Fldmgr Delete (m d)") . wl-fldmgr-delete)
	;; (("m f" . "Wl Fldmgr Make Filter (m f)") . wl-fldmgr-make-filter)
	;; (("m g" . "Wl Fldmgr Make Group (m g)") . wl-fldmgr-make-group)
	;; (("m k" . "Wl Fldmgr Cut (m k)") . wl-fldmgr-cut)
	;; (("m l" . "Wl Fldmgr Access Display Normal (m l)") . wl-fldmgr-access-display-normal)
	;; (("m m" . "Wl Fldmgr Make Multi (m m)") . wl-fldmgr-make-multi)
	;; (("m p" . "Wl Fldmgr Set Petname (m p)") . wl-fldmgr-set-petname)
	;; (("m q" . "Wl Fldmgr Clear Cut Entity List (m q)") . wl-fldmgr-clear-cut-entity-list)
	;; (("m r" . "Wl Fldmgr Reconst Entity Hashtb (m r)") . wl-fldmgr-reconst-entity-hashtb)
	;; (("m s" . "Wl Fldmgr Sort (m s)") . wl-fldmgr-sort)
	;; (("m u" . "Wl Fldmgr Unsubscribe (m u)") . wl-fldmgr-unsubscribe)
	;; (("m y" . "Wl Fldmgr Yank (m y)") . wl-fldmgr-yank)

	;; (("C-c C-a" . "Wl Addrmgr (C-c C-a)") . wl-addrmgr)
	;; (("C-c C-n" . "Wl Folder Jump To Next Summary (C-c C-n)") . wl-folder-jump-to-next-summary)
	;; (("C-c C-o" . "Wl Jump To Draft Buffer (C-c C-o)") . wl-jump-to-draft-buffer)
	;; (("C-c C-p" . "Wl Folder Jump To Previous Summary (C-c C-p)") . wl-folder-jump-to-previous-summary)

	;; (("r S" . "Wl Folder Sync Region (r S)") . wl-folder-sync-region)
	;; (("r c" . "Wl Folder Mark As Read All Region (r c)") . wl-folder-mark-as-read-all-region)
	;; (("r s" . "Wl Folder Check Region (r s)") . wl-folder-check-region)
	;; (("r u" . "Wl Fldmgr Unsubscribe Region (r u)") . wl-fldmgr-unsubscribe-region)

	(("C-M-a" . "Wl Folder Goto Top Of Current Folder (C-M-a)") . wl-folder-goto-top-of-current-folder)
	(("C-M-e" . "Wl Folder Goto Bottom Of Current Folder (C-M-e)") . wl-folder-goto-bottom-of-current-folder)
	(("M-RET" . "Wl Folder Update Recursive Current Entity (M-RET)") . wl-folder-update-recursive-current-entity)
	(("M-c" . "Wl Fldmgr Copy (M-c)") . wl-fldmgr-copy)
	(("M-s" . "Wl Save (M-s)") . wl-save)
	(("M-t" . "Wl Toggle Plugged (M-t)") . wl-toggle-plugged)
	(("M-w" . "Wl Fldmgr Copy Region (M-w)") . wl-fldmgr-copy-region)
	))

(defun one-key-menu-my-wl-folder ()
  "The `one-key' menu for my-wl-folder"
  (interactive)
  (one-key-menu "my-wl-folder" one-key-menu-my-wl-folder-alist))

;; Use the `one-key-get-menu' command to show menu/keybindings for this buffer.

;; Uncomment and edit following line to set this menu as default for mode.
;;(add-to-list 'one-key-mode-alist '(wl-folder-mode . one-key-menu-my-wl-folder))
;; Uncomment and edit following line to add this menu to toplevel menu.
;;(add-to-list 'one-key-toplevel-alist '(("type key here" . "my-wl-folder") . one-key-menu-my-wl-folder))