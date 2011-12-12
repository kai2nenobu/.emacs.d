;; one-key menu for my-wl-summary

(defvar one-key-menu-my-wl-summary-alist nil
  "The `one-key' menu alist for my-wl-summary.")

(setq one-key-menu-my-wl-summary-alist
      '(
	;; (("0 .. 9" . "Digit Argument (0 .. 9)") . digit-argument)

	;; (("C-c" . "Prefix Command (C-c)") . Prefix Command)
	(("TAB" . "Wl Summary Goto Last Displayed Msg (TAB)") . wl-summary-goto-last-displayed-msg)
	(("RET" . "Wl Summary Enter Handler (RET)") . wl-summary-enter-handler)
	(("C-o" . "Wl Summary Auto Refile (C-o)") . wl-summary-auto-refile)
	(("C-t" . "Wl Plugged Change (C-t)") . wl-plugged-change)
	;; (("C-x" . "Prefix Command (C-x)") . Prefix Command)
	(("C-y" . "Wl Summary Yank Saved Message (C-y)") . wl-summary-yank-saved-message)
	;; (("ESC" . "Prefix Command (ESC)") . Prefix Command)
	(("SPC" . "Wl Summary Read (SPC)") . wl-summary-read)
	(("!" . "Wl Summary Mark As Unread (!)") . wl-summary-mark-as-unread)
	(("#" . "Wl Summary Print Message (#)") . wl-summary-print-message)
	(("$" . "Wl Summary Mark As Important ($)") . wl-summary-mark-as-important)
	(("&" . "Wl Summary Mark As Answered (&)") . wl-summary-mark-as-answered)
	(("*" . "Wl Summary Target Mark (*)") . wl-summary-target-mark)
	(("," . "Wl Summary Display Raw (,)") . wl-summary-display-raw)
	(("-" . "Wl Summary Prev Line Content (-)") . wl-summary-prev-line-content)
	(("." . "Wl Summary Redisplay (.)") . wl-summary-redisplay)
	(("/" . "Wl Thread Open Close (/)") . wl-thread-open-close)
	(("<" . "Wl Summary Display Top (<)") . wl-summary-display-top)
	((">" . "Wl Summary Display Bottom (>)") . wl-summary-display-bottom)
	(("?" . "Wl Summary Pick (?)") . wl-summary-pick)
	(("@" . "Wl Summary Edit Addresses (@)") . wl-summary-edit-addresses)
	(("A" . "Wl Summary Reply With Citation (A)") . wl-summary-reply-with-citation)
	(("B" . "Wl Summary Burst (B)") . wl-summary-burst)
	(("C" . "Wl Summary Cancel Message (C)") . wl-summary-cancel-message)
	(("D" . "Wl Summary Delete (D)") . wl-summary-delete)
	(("E" . "Wl Summary Reedit (E)") . wl-summary-reedit)
	(("F" . "Wl Summary Set Flags (F)") . wl-summary-set-flags)
	(("G" . "Wl Summary Goto Folder Sticky (G)") . wl-summary-goto-folder-sticky)
	(("H" . "Wl Summary Toggle All Header (H)") . wl-summary-toggle-all-header)
	(("I" . "Wl Summary Incorporate (I)") . wl-summary-incorporate)
	(("J" . "Wl Thread Jump To Msg (J)") . wl-thread-jump-to-msg)
	(("K" . "Wl Summary Increase Score (K)") . wl-summary-increase-score)
	(("L" . "Wl Summary Lower Score (L)") . wl-summary-lower-score)
	(("M" . "Wl Summary Toggle Mime (M)") . wl-summary-toggle-mime)
	(("N" . "Wl Summary Down (N)") . wl-summary-down)
	(("O" . "Wl Summary Copy (O)") . wl-summary-copy)
	(("P" . "Wl Summary Up (P)") . wl-summary-up)
	(("Q" . "Wl Summary Force Exit (Q)") . wl-summary-force-exit)
	(("R" . "Wl Summary Mark As Read (R)") . wl-summary-mark-as-read)
	(("S" . "Wl Summary Sort (S)") . wl-summary-sort)
	(("T" . "Wl Summary Toggle Thread (T)") . wl-summary-toggle-thread)
	(("U" . "Wl Summary Unmark All (U)") . wl-summary-unmark-all)
	(("V" . "Wl Summary Virtual (V)") . wl-summary-virtual)
	(("W" . "Wl Summary Write Current Folder (W)") . wl-summary-write-current-folder)
	(("Z" . "Wl Status Update (Z)") . wl-status-update)
	(("[" . "Wl Thread Open All ([)") . wl-thread-open-all)
	(("]" . "Wl Thread Close All (])") . wl-thread-close-all)
	(("^" . "Wl Summary Jump To Parent Message (^)") . wl-summary-jump-to-parent-message)
	(("a" . "Wl Summary Reply (a)") . wl-summary-reply)
	(("c" . "Wl Summary Mark As Read All (c)") . wl-summary-mark-as-read-all)
	(("d" . "Wl Summary Dispose (d)") . wl-summary-dispose)
	(("e" . "Wl Summary Save (e)") . wl-summary-save)
	(("f" . "Wl Summary Forward (f)") . wl-summary-forward)
	(("g" . "Wl Summary Goto Folder (g)") . wl-summary-goto-folder)
	;; (("h" . "Prefix Command (h)") . Prefix Command)
	(("i" . "Wl Summary Prefetch (i)") . wl-summary-prefetch)
	(("j" . "Wl Summary Jump To Current Message (j)") . wl-summary-jump-to-current-message)
	(("l" . "Wl Summary Toggle Disp Folder (l)") . wl-summary-toggle-disp-folder)
	;; (("m" . "Prefix Command (m)") . Prefix Command)
	(("n" . "Wl Summary Next (n)") . wl-summary-next)
	(("o" . "Wl Summary Refile (o)") . wl-summary-refile)
	(("p" . "Wl Summary Prev (p)") . wl-summary-prev)
	(("q" . "Wl Summary Exit (q)") . wl-summary-exit)
	;; (("r" . "Prefix Command (r)") . Prefix Command)
	(("s" . "Wl Summary Sync (s)") . wl-summary-sync)
	;; (("t" . "Prefix Command (t)") . Prefix Command)
	(("u" . "Wl Summary Unmark (u)") . wl-summary-unmark)
	(("v" . "Wl Summary Toggle Disp Msg (v)") . wl-summary-toggle-disp-msg)
	(("w" . "Wl Summary Write (w)") . wl-summary-write)
	(("x" . "Wl Summary Exec (x)") . wl-summary-exec)
	(("y" . "Wl Summary Save (y)") . wl-summary-save)
	(("z" . "Wl Summary Suspend (z)") . wl-summary-suspend)
	(("|" . "Wl Summary Pipe Message (|)") . wl-summary-pipe-message)
	(("~" . "Wl Summary Resend (~)") . wl-summary-resend)
	(("DEL" . "Wl Summary Prev Page (DEL)") . wl-summary-prev-page)
	(("<S-mouse-4>" . "Wl Summary Up (<S-mouse-4>)") . wl-summary-up)
	(("<S-mouse-5>" . "Wl Summary Down (<S-mouse-5>)") . wl-summary-down)
	(("<S-mouse-wheel1>" . "Wl Summary Wheel Dispatcher (<S-mouse-wheel1>)") . wl-summary-wheel-dispatcher)
	(("<backspace>" . "Wl Summary Prev Page (<backspace>)") . wl-summary-prev-page)
	(("<mouse-2>" . "Wl Summary Click (<mouse-2>)") . wl-summary-click)
	(("<mouse-4>" . "Wl Summary Prev (<mouse-4>)") . wl-summary-prev)
	(("<mouse-5>" . "Wl Summary Next (<mouse-5>)") . wl-summary-next)
	(("<mouse-wheel1>" . "Wl Summary Wheel Dispatcher (<mouse-wheel1>)") . wl-summary-wheel-dispatcher)
	;; (("<remap>" . "Prefix Command (<remap>)") . Prefix Command)
	;; (("<tool-bar>" . "Prefix Command (<tool-bar>)") . Prefix Command)

	;; (("C-c C-a" . "Wl Addrmgr (C-c C-a)") . wl-addrmgr)
	;; (("C-c C-f" . "Wl Summary Toggle Header Narrowing (C-c C-f)") . wl-summary-toggle-header-narrowing)
	;; (("C-c C-n" . "Wl Summary Next Buffer (C-c C-n)") . wl-summary-next-buffer)
	;; (("C-c C-o" . "Wl Jump To Draft Buffer (C-c C-o)") . wl-jump-to-draft-buffer)
	;; (("C-c C-p" . "Wl Summary Previous Buffer (C-c C-p)") . wl-summary-previous-buffer)
	;; (("C-c m" . "Wl Summary Toggle Mime Buttons (C-c m)") . wl-summary-toggle-mime-buttons)

	;; (("C-x C-s" . "Wl Summary Save Status (C-x C-s)") . wl-summary-save-status)
	;; (("C-x k" . "Wl Summary Mimic Kill Buffer (C-x k)") . wl-summary-mimic-kill-buffer)

	(("M-RET" . "Wl Summary Prev Line Content (M-RET)") . wl-summary-prev-line-content)
	(("M-E" . "Wl Summary Resend Bounced Mail (M-E)") . wl-summary-resend-bounced-mail)
	(("M-e" . "Wl Summary Expire (M-e)") . wl-summary-expire)
	(("M-j" . "Wl Summary Jump To Msg By Message Id (M-j)") . wl-summary-jump-to-msg-by-message-id)
	(("M-k" . "Wl Summary Toggle Persistent Mark (M-k)") . wl-summary-toggle-persistent-mark)
	(("M-o" . "Wl Summary Refile Prev Destination (M-o)") . wl-summary-refile-prev-destination)
	(("M-s" . "Wl Summary Stick (M-s)") . wl-summary-stick)
	(("M-t" . "Wl Toggle Plugged (M-t)") . wl-toggle-plugged)
	(("M-w" . "Wl Summary Save Current Message (M-w)") . wl-summary-save-current-message)

	;; (("h F" . "Wl Score Flush Cache (h F)") . wl-score-flush-cache)
	;; (("h R" . "Wl Summary Rescore (h R)") . wl-summary-rescore)
	;; (("h c" . "Wl Score Change Score File (h c)") . wl-score-change-score-file)
	;; (("h e" . "Wl Score Edit Current Scores (h e)") . wl-score-edit-current-scores)
	;; (("h f" . "Wl Score Edit File (h f)") . wl-score-edit-file)
	;; (("h m" . "Wl Score Set Mark Below (h m)") . wl-score-set-mark-below)
	;; (("h x" . "Wl Score Set Expunge Below (h x)") . wl-score-set-expunge-below)

	;; (("m ESC" . "Prefix Command (m ESC)") . Prefix Command)
	;; (("m !" . "Wl Summary Target Mark Mark As Unread (m !)") . wl-summary-target-mark-mark-as-unread)
	;; (("m #" . "Wl Summary Target Mark Print (m #)") . wl-summary-target-mark-print)
	;; (("m $" . "Wl Summary Target Mark Mark As Important (m $)") . wl-summary-target-mark-mark-as-important)
	;; (("m &" . "Wl Summary Target Mark Mark As Answered (m &)") . wl-summary-target-mark-mark-as-answered)
	;; (("m ?" . "Wl Summary Target Mark Pick (m ?)") . wl-summary-target-mark-pick)
	;; (("m A" . "Wl Summary Target Mark Reply With Citation (m A)") . wl-summary-target-mark-reply-with-citation)
	;; (("m D" . "Wl Summary Target Mark Delete (m D)") . wl-summary-target-mark-delete)
	;; (("m F" . "Wl Summary Target Mark Set Flags (m F)") . wl-summary-target-mark-set-flags)
	;; (("m O" . "Wl Summary Target Mark Copy (m O)") . wl-summary-target-mark-copy)
	;; (("m R" . "Wl Summary Target Mark Mark As Read (m R)") . wl-summary-target-mark-mark-as-read)
	;; (("m U" . "Wl Summary Target Mark Uudecode (m U)") . wl-summary-target-mark-uudecode)
	;; (("m a" . "Wl Summary Target Mark All (m a)") . wl-summary-target-mark-all)
	;; (("m d" . "Wl Summary Target Mark Dispose (m d)") . wl-summary-target-mark-dispose)
	;; (("m f" . "Wl Summary Target Mark Forward (m f)") . wl-summary-target-mark-forward)
	;; (("m i" . "Wl Summary Target Mark Prefetch (m i)") . wl-summary-target-mark-prefetch)
	;; (("m o" . "Wl Summary Target Mark Refile (m o)") . wl-summary-target-mark-refile)
	;; (("m r" . "Wl Summary Target Mark Region (m r)") . wl-summary-target-mark-region)
	;; (("m t" . "Wl Summary Target Mark Thread (m t)") . wl-summary-target-mark-thread)
	;; (("m u" . "Wl Summary Delete All Temp Marks (m u)") . wl-summary-delete-all-temp-marks)
	;; (("m y" . "Wl Summary Target Mark Save (m y)") . wl-summary-target-mark-save)
	;; (("m |" . "Wl Summary Target Mark Pipe (m |)") . wl-summary-target-mark-pipe)
	;; (("m ~" . "Wl Summary Target Mark Resend (m ~)") . wl-summary-target-mark-resend)

	;; (("r ESC" . "Prefix Command (r ESC)") . Prefix Command)
	;; (("r !" . "Wl Summary Mark As Unread Region (r !)") . wl-summary-mark-as-unread-region)
	;; (("r $" . "Wl Summary Mark As Important Region (r $)") . wl-summary-mark-as-important-region)
	;; (("r &" . "Wl Summary Mark As Answered Region (r &)") . wl-summary-mark-as-answered-region)
	;; (("r *" . "Wl Summary Target Mark Region (r *)") . wl-summary-target-mark-region)
	;; (("r D" . "Wl Summary Delete Region (r D)") . wl-summary-delete-region)
	;; (("r F" . "Wl Summary Set Flags Region (r F)") . wl-summary-set-flags-region)
	;; (("r O" . "Wl Summary Copy Region (r O)") . wl-summary-copy-region)
	;; (("r R" . "Wl Summary Mark As Read Region (r R)") . wl-summary-mark-as-read-region)
	;; (("r d" . "Wl Summary Dispose Region (r d)") . wl-summary-dispose-region)
	;; (("r i" . "Wl Summary Prefetch Region (r i)") . wl-summary-prefetch-region)
	;; (("r o" . "Wl Summary Refile Region (r o)") . wl-summary-refile-region)
	;; (("r u" . "Wl Summary Unmark Region (r u)") . wl-summary-unmark-region)
	;; (("r x" . "Wl Summary Exec Region (r x)") . wl-summary-exec-region)
	;; (("r y" . "Wl Summary Save Region (r y)") . wl-summary-save-region)
	;; (("r ~" . "Wl Summary Resend Region (r ~)") . wl-summary-resend-region)

	;; (("t ESC" . "Prefix Command (t ESC)") . Prefix Command)
	;; (("t !" . "Wl Thread Mark As Unread (t !)") . wl-thread-mark-as-unread)
	;; (("t $" . "Wl Thread Mark As Important (t $)") . wl-thread-mark-as-important)
	;; (("t &" . "Wl Thread Mark As Answered (t &)") . wl-thread-mark-as-answered)
	;; (("t *" . "Wl Thread Target Mark (t *)") . wl-thread-target-mark)
	;; (("t D" . "Wl Thread Delete (t D)") . wl-thread-delete)
	;; (("t F" . "Wl Thread Set Flags (t F)") . wl-thread-set-flags)
	;; (("t O" . "Wl Thread Copy (t O)") . wl-thread-copy)
	;; (("t R" . "Wl Thread Mark As Read (t R)") . wl-thread-mark-as-read)
	;; (("t d" . "Wl Thread Dispose (t d)") . wl-thread-dispose)
	;; (("t i" . "Wl Thread Prefetch (t i)") . wl-thread-prefetch)
	;; (("t o" . "Wl Thread Refile (t o)") . wl-thread-refile)
	;; (("t s" . "Wl Thread Set Parent (t s)") . wl-thread-set-parent)
	;; (("t u" . "Wl Thread Unmark (t u)") . wl-thread-unmark)
	;; (("t x" . "Wl Thread Exec (t x)") . wl-thread-exec)
	;; (("t y" . "Wl Thread Save (t y)") . wl-thread-save)
	;; (("t ~" . "Wl Thread Resend (t ~)") . wl-thread-resend)

	;; <tool-bar> <wl-summary-dispose>
	;; wl-summary-dispose
	;; ;; (("<tool-bar> <wl-summary-exit>" . "Wl Summary Exit (<tool-bar> <wl-summary-exit>)") . wl-summary-exit)
	;; <tool-bar> <wl-summary-forward>
	;; wl-summary-forward
	;; <tool-bar> <wl-summary-jump-to-current-message>
	;; wl-summary-jump-to-current-message
	;; (("<tool-bar> <wl-summary-next>" . "Wl Summary Next (<tool-bar> <wl-summary-next>)") . wl-summary-next)
	;; (("<tool-bar> <wl-summary-prev>" . "Wl Summary Prev (<tool-bar> <wl-summary-prev>)") . wl-summary-prev)
	;; (("<tool-bar> <wl-summary-read>" . "Wl Summary Read (<tool-bar> <wl-summary-read>)") . wl-summary-read)
	;; (("<tool-bar> <wl-summary-reply>" . "Wl Summary Reply (<tool-bar> <wl-summary-reply>)") . wl-summary-reply)
	;; <tool-bar> <wl-summary-reply-with-citation>
	;; wl-summary-reply-with-citation
	;; <tool-bar> <wl-summary-set-flags>
	;; wl-summary-set-flags
	;; <tool-bar> <wl-summary-sync-force-update>
	;; wl-summary-sync-force-update
	;; <tool-bar> <wl-summary-write-current-folder>
	;; wl-summary-write-current-folder

	;; (("m M-o" . "Wl Summary Target Mark Refile Prev Destination (m M-o)") . wl-summary-target-mark-refile-prev-destination)

	;; (("r M-o" . "Wl Summary Refile Prev Destination Region (r M-o)") . wl-summary-refile-prev-destination-region)

	;; (("t M-o" . "Wl Thread Refile Prev Destination (t M-o)") . wl-thread-refile-prev-destination)
	))

(defun one-key-menu-my-wl-summary ()
  "The `one-key' menu for my-wl-summary"
  (interactive)
  (one-key-menu "my-wl-summary" one-key-menu-my-wl-summary-alist))

;; Use the `one-key-get-menu' command to show menu/keybindings for this buffer.

;; Uncomment and edit following line to set this menu as default for mode.
;;(add-to-list 'one-key-mode-alist '(wl-summary-mode . one-key-menu-my-wl-summary))
;; Uncomment and edit following line to add this menu to toplevel menu.
;;(add-to-list 'one-key-toplevel-alist '(("type key here" . "my-wl-summary") . one-key-menu-my-wl-summary))