;;; postit.el --- a tiny memorandum
;;; Copyright (C) 1996 TAMAKOSHI Hiroki <tama@is.s.u-tokyo.ac.jp>

;;; Last modified on Mon Oct 21 23:56:02 1996

;; Author: TAMAKOSHI Hiroki <tama@is.s.u-tokyo.ac.jp>
;; Maintainer: TAMAKOSHI Hiroki <tama@is.s.u-tokyo.ac.jp>
;; Created: 25 Aug 1996
;; Version: 1.2
;; Keywords: data matching mouse processes

;; This software is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY.  No author or distributor
;; accepts responsibility to anyone for the consequences of using it
;; or for whether it serves any particular purpose or works at all,
;; unless he says so in writing.  Refer to the GNU Emacs General Public
;; License for full details.

;; Everyone is granted permission to copy, modify and redistribute
;; this software, but only under the conditions described in the
;; GNU Emacs General Public License.   A copy of this license is
;; supposed to have been given to you along with this software so you
;; can know your rights and responsibilities.  It should be in a
;; file named COPYING.  Among other things, the copyright notice
;; and this notice must be preserved on all copies.

;; In this program, I refered to gnus5/browse-url.el to Start Netscape,
;; thank you.

;;; Special Thanks:
;; TOKUYO Masanaga <tokuyo@flab.fujitsu.co.jp>
;; Shunichiro Cho <scho@yan.hp.com>
;; Tsutomu Mieno <mieno@csis.oita-u.ac.jp>
;; Koichi Inoue <inoue@moon.ap.kyushu-u.ac.jp>
;; Shinichi Baba <vava@AURORA.CIS.UPENN.EDU>
;; Yamamoto Hirotaka <ymmt@is.s.u-tokyo.ac.jp>
;;
;;   Thank you for using this program.

;;; Comentary:

;; postit.el is a tiny memorandum. it shows Titles, and their final
;; update time or file links or URLs, and Categories.
;; To use, place this under the name `postit.el' and put
;; the following line to your `.emacs'.

;;	(autoload 'postit "postit" nil t)

;; or if `postit.el' exists in your `load-path',
;;	(require 'postit)

;; Here is full usage:

;; 1) To invoke, type `M-x postit' or `M-x postit-other-frame'.
;;     postit-other-frame make a new frame and postit starts on it.

;; 2) List of key bindings:
;;  in *Postit* buffer,
;; `m' : make new memo at the current line. we can create plain text,
;;       file link, ftp link, and URL.
;;       After entering the title, choose the kind of contents.
;;       title length is not limited, but is truncated to 29 letters at
;;       showing titles.
;;       if `text', write a memo(and `Ctl-c Ctl-c' to enter),
;;       if `link', input the file name, 
;;       if `ftp', input the remote host, user name on the remote host,
;;       the file name you want to see exactly. if incorrect, this
;;       program may curse a error.
;;       if `url', input URL you want to see.
;; `e' : edit the memo at the current line. if the memo is
;;       * a plain text,
;;            the window is divided, and you can edit the contents.
;;       * a link, and if any command is defined in postit-link-command,
;;            - modify the file name.
;;           if is not defined,
;;            - get the file althought it is a binary file.
;;       * a ftp link, and if any command is defined in
;;         postit-link-command,
;;            - modify the remote host name, user name, and file name.
;;           if is not defined,
;;            - get the file althought it is a binary file.
;;       * URL,
;;            modify it.

;; `r' : rename title.
;; `d' : delete the memo at the current line.

;; `n' : move to next memo, if the next memo is not a plain text,
;;       doesn't show the contents.
;; `p' : move to previous memo, if the previous memo is not a plain
;;       text, doesn't show the contents.
;; ` ' : show the contents, or scroll it. if the memo is URL, start
;;       processing the browser. it's chosen from netscape or w3.
;; `backspace' or DEL : if showing the contents, scroll down it.
;; `Ctl-n' : move to next memo without showing the contents.
;; `Ctl-p' : move to previous memo without showing the contents.
;; `N' : skip 5 lines forward.
;; `P' : skip 5 lines backward.
;; `,' or `<' : goto the top memo.
;; `.' or `>' : goto the bottom memo.

;; `o' : show the contents in any condition.

;; `Ctl-k' : yank the current memo, and delete it from postit.
;; `Ctl-y' : paste the yank at the current line.

;; `h' : toggle *Header* buffer visible/invisible.

;; `c' : close the contents and header windows.

;; `x' or `w' : a plain text memo is able to been saved to a file. only the
;;              contents is saved, header is not.
;; `S' : save memos.
;; `q' : save memos, and quit postit-mode.
;; `Q' : quit postit-mode without saving memos.
;; `A' : if you start this program by `postit-other-frame', quit from
;;       postit with deleting the frame.

;; `s' : search a string in *all* plain text memos, files not specified
;;       by postit-link-command, and show the result. search space is
;;       only contents, not in header.
;; `k' : category selection. set the category, and show the memos which
;;       have the category. you can use regular expression.

;;  in *Postit Edit* buffer
;; `Ctl-c Ctl-c' : enter the editing memo into postit buffer.
;; `Ctl-c q' : enter the editing memo into postit buffer, and quit postit.
;; `Ctl-c Q' : quit postit without entering memos, saving postit.
;; `Ctl-c Ctl-s' : enter the editing memo into postit buffer,
;;                 and save postit.

;;  in *Postit Show* buffer
;; `mouse button 2' : make Netscape go to the URL. doesn't use w3.

;;  in *Postit Search* buffer
;; `mouse button 2' : click at the `Found in ***' cause showing the memo.

;; 3) To customize, you can modify some variables.
;; `postit-file' : the name says everything.
;; `postit-file-mode-string' : postit-file's permission.
;; `postit-directory' : ftp link file, if defined in
;;                      postit-link-command, will be saved in this
;;                      directory.
;; `postit-auto-save' : chose auto-save/no-save at the time killing emacs,
;;                      if postit buffer remains.
;; `postit-compress-command' : postit can compress the file. This is
;;                         compress command. if you don't want to
;;                         compress, set it `nil'.
;; `postit-compress-suffix' : compressed file's suffix.
;; `postit-uncompress-command' : set GNU's `zcat' command.

;; `postit-win-div' : this value determinate the title buffer's height.
;;                     it becomes (whole frame height)/(postit-win-div).
;; `postit-browser' : we can use "netscape" or "w3" now. if you want to
;;                    set the browser corresponed to each memo, set
;;                    this "".
;; `postit-link-command' : command alist to see the link file.
;;                         ("file suffix" . "command") style. the order
;;                         is in your taste.
;; `postit-link-command-option' : command option alist correspond to
;;                                "command". the style is
;;                                ("file suffix" . "option"). the order
;;                                is in your taste, but if defined
;;                                postit-link-command, you must define
;;                                the command option.

;; `postit-colorize' : determine the colorization style of the Title
;;                     buffer. 'light use light background setting,
;;                     'dark use dark background setting, `nil' doesn't
;;                     colorize the Title buffer.
;; the color setting is ("for light background" . "for dark background")
;; `postit-title-color' : color name for `Title'
;; `postit-time-color' : color name for `Update time/ Link / URL'
;; `postit-link-color' : color name for `Link'
;; `postit-ftp-color' : color name for `ftp'
;; `postit-url-color' : color name for `URL'
;; `postit-category-color' : color name for `Categories'
;; `postit-search-hilight-color' : color name for hilighting searched
;;                                 string.


;;; Code:
;; Variables
(defvar postit-file
  (concat (getenv "HOME")
	  "/.postit")
  "File name for postit mode.")
;;(defvar postit-file "~/.postit")
(defvar postit-directory
  "/tmp/"
  "Directory name for store files got by ftp link")
(defvar postit-auto-save t)

(defvar postit-file-mode-string "600")
(defvar postit-compress-command "gzip") ; or compress
(defvar postit-compress-suffix ".gz") ; or .Z
(defvar postit-uncompress-command "zcat")

(defvar postit-win-div 3)
(defvar postit-browser "netscape") ; or w3, only
;; set exactly "netscape" or "w3".

(defvar postit-link-command
  '(("dvi" . "xdvi") ("ps" . "ghostview") ("gif" . "xv") ("jpg" . "display")))
(defvar postit-link-command-option
  '(("dvi" . "") ("ps" . "-portrait") ("gif" . "-dither") ("jpg" . "")))

;; hooks
(defvar postit-mode-hook nil)
(defvar postit-edit-mode-hook nil)
(defvar postit-show-mode-hook nil)
(defvar postit-search-mode-hook nil)

;; Colors
(defvar postit-colorize 'light) ; or 'dark or nil
;; the color setting is ("for light background" . "for dark background")
(defvar postit-title-color '("dark green" . "yellow"))
(defvar postit-time-color '("blue" . "light green"))
(defvar postit-link-color '("blue violet" . "Misty Rose"))
(defvar postit-ftp-color '("dark orange" . "sky blue"))
(defvar postit-url-color '("brown3" . "aquamarine"))
(defvar postit-category-color '("DarkGoldenrod" . "tomato"))
(defvar postit-search-hilight-color '("light green" . "MediumPurple1"))

;; inner use.  *DO NOT* change.
(defconst postit-title-buffer-name "*Postit*")
(defconst postit-edit-buffer-name "*Postit Edit*")
(defconst postit-show-buffer-name "*Postit Show*")
(defconst postit-header-buffer-name "*Postit Header*")
(defconst postit-sub-process-buffer-name " *Postit Sub Process*")
(defconst postit-buffer-name " *Postit Background*")
(defconst postit-process-buffer-name " *Postit Background Processing*")
(defconst postit-search-buffer-name "*Postit Search*")
(defconst postit-urls "http:/\\|ftp:/\\|file:/\\|gopher:/\\|news:/\\|mailto:/\\|telnet:/")

(defvar postit-prev-win-conf nil)
(defvar postit-save-files '())

(defvar postit-line 1)
(defvar postit-ab-line 3)
(defvar postit-prev-line nil)
(defvar postit-prev-memo-is-shown nil)
(defvar postit-edit-or-make nil) ; t:make, nil:edit
(defvar postit-yank nil)

(defvar postit-showing nil)
(defvar postit-always-show nil)
(defvar postit-showing-header nil)
(defvar postit-selected-category nil)
(defvar postit-selected-list nil)
(defvar postit-time-or-link-or-ftp-or-url nil)
;; 0 = time, 1 = link, 2 = ftp, 3 = url

;; keymap
(defvar postit-mode-map nil)
(defvar postit-edit-mode-map nil)
(defvar postit-show-mode-map nil)
(defvar postit-search-mode-map nil)

;; faces
(and postit-colorize
     (progn
       (make-face 'postit-title-face)
       (make-face 'postit-time-face)
       (make-face 'postit-link-face)
       (make-face 'postit-ftp-face)
       (make-face 'postit-url-face)
       (make-face 'postit-category-face)
       (make-face 'postit-search-face)
       (set-face-foreground 'postit-title-face (if (eq 'dark postit-colorize)
						   (cdr postit-title-color)
						 (car postit-title-color)))
       (set-face-foreground 'postit-time-face (if (eq 'dark postit-colorize)
						  (cdr postit-time-color)
						(car postit-time-color)))
       (set-face-foreground 'postit-link-face (if (eq 'dark postit-colorize)
						  (cdr postit-link-color)
						(car postit-link-color)))
       (set-face-foreground 'postit-ftp-face (if (eq 'dark postit-colorize)
						 (cdr postit-ftp-color)
					       (car postit-ftp-color)))
       (set-face-foreground 'postit-url-face (if (eq 'dark postit-colorize)
						 (cdr postit-url-color)
					       (car postit-url-color)))
       (set-face-foreground 'postit-category-face (if (eq 'dark postit-colorize)
						      (cdr postit-category-color)
						    (car postit-category-color)))
       (set-face-background 'postit-search-face (if (eq 'dark postit-colorize)
						    (cdr postit-search-hilight-color)
						  (car postit-search-hilight-color)))))

(if postit-mode-map
    nil
  (setq postit-mode-map (make-sparse-keymap))
  (define-key postit-mode-map "A" 'postit-kill-self)
  (define-key postit-mode-map "S" 'postit-save)
  (define-key postit-mode-map "Q" 'postit-quit)
  (define-key postit-mode-map "q" 'postit-save-and-quit)
  (define-key postit-mode-map "m" 'postit-make-memo)
  (define-key postit-mode-map "M" 'postit-make-text-memo)
  (define-key postit-mode-map "e" 'postit-edit-memo)
  (define-key postit-mode-map "r" 'postit-rename-title)
  (define-key postit-mode-map "d" 'postit-delete-memo)
  (define-key postit-mode-map "n" 'postit-next-memo)
  (define-key postit-mode-map "p" 'postit-prev-memo)
  (define-key postit-mode-map " " 'postit-show-memo)
  (define-key postit-mode-map "o" 'postit-show-memo-always)
  (define-key postit-mode-map [mouse-2] 'postit-show-memo-by-mouse-click)
  (define-key postit-mode-map [backspace] 'postit-memo-backscroll)
  (define-key postit-mode-map [delete] 'postit-memo-backscroll)
  (define-key postit-mode-map "\C-n" 'postit-next-title)
  (define-key postit-mode-map [down] 'postit-next-title)
  (define-key postit-mode-map "\C-p" 'postit-prev-title)
  (define-key postit-mode-map [up] 'postit-prev-title)
  (define-key postit-mode-map "\C-k" 'postit-send-to-yank)
  (define-key postit-mode-map "\C-y" 'postit-get-from-yank)
  (define-key postit-mode-map "\C-r" 'postit-restart)
  ;; (define-key postit-mode-map "c" 'postit-close-other-windows)
  (define-key postit-mode-map "v" 'postit-close-other-windows)
  (define-key postit-mode-map "\C-x1" 'postit-close-other-windows)
  (define-key postit-mode-map "x" 'postit-extract)
  (define-key postit-mode-map "w" 'postit-extract)
  (define-key postit-mode-map "h" 'postit-toggle-header)
  (define-key postit-mode-map "H" 'postit-describe-mode)
  (define-key postit-mode-map "N" 'postit-5-next-title)
  (define-key postit-mode-map "P" 'postit-5-prev-title)
  (define-key postit-mode-map "," 'postit-goto-top)
  (define-key postit-mode-map "<" 'postit-goto-top)
  (define-key postit-mode-map "." 'postit-goto-bottom)
  (define-key postit-mode-map ">" 'postit-goto-bottom)
  (define-key postit-mode-map "s" 'postit-search)
  (define-key postit-mode-map "\C-s" 'postit-isearch)
  (define-key postit-mode-map "k" 'postit-select))

(if postit-edit-mode-map
    nil
  (setq postit-edit-mode-map (make-sparse-keymap))
  (define-key postit-edit-mode-map "\C-c\C-c" 'postit-entry-save)
  (define-key postit-edit-mode-map "\C-x\C-s" 'postit-entry-save)
  (define-key postit-edit-mode-map "\C-cq" 'postit-entry-save-and-quit)
  (define-key postit-edit-mode-map "\C-cQ" 'postit-quit)
  (define-key postit-edit-mode-map "\C-c\C-s" 'postit-entry-save-and-save))

(if postit-show-mode-map
    nil
  (setq postit-show-mode-map (make-sparse-keymap))
  (define-key postit-show-mode-map " " 'postit-url-browse)
  (define-key postit-show-mode-map [mouse-2] 'postit-url-browse-by-mouse))

(if postit-search-mode-map
    nil
  (setq postit-search-mode-map (make-sparse-keymap))
  (define-key postit-search-mode-map [mouse-2] 'postit-show-searched-memo))

;; misc
(defun postit-absolute-line ()
  "return the current line in the current buffer."
  (+ (count-lines (point-min) (point))
     (if (= (current-column) 0) 1 0)))

(defun postit-current-line ()
  "return the `postit-line' which indicate the memo's order"
  (let ((line (- (postit-absolute-line) 2))
	(list postit-selected-list))
    (if postit-selected-category
	(progn
	  (while (not (= 1 line))
	    (setq list (cdr list))
	    (setq line (1- line)))
	  (car list))
      line)))

;; postit-mode
(defun postit-save ()
  "save the memos to postit-file with permission postit-file-mode-string.

if defined `postit-compress-command', postit-file will be compressed."
  (interactive)
  (set-buffer postit-buffer-name)
  (let ((file-z (expand-file-name (concat postit-file
					  postit-compress-suffix)))
	(file-u (expand-file-name postit-file))
	(mode 0))
    (let ((n (length postit-file-mode-string))
	  (c 0))
      (while (/= c n)
	(setq mode (+ (* mode 8)
		      (string-to-int (substring postit-file-mode-string
						c (1+ c)))))
	(setq c (1+ c))))
    (write-region (point-min) (point-max)
		  file-u)
    (set-file-modes file-u mode)
    (and (file-exists-p file-z)
	 (delete-file file-z))
    (cond ((string= "gzip" postit-compress-command)
	   (call-process postit-compress-command
			 nil nil nil "-q" file-u))
	  ((string= "compress" postit-compress-command)
	   (call-process postit-compress-command
			 nil nil nil file-u)))))

(defun postit-quit ()
  "quit from postit."
  (interactive)
  (kill-buffer (get-buffer-create postit-title-buffer-name))
  (kill-buffer (get-buffer-create postit-edit-buffer-name))
  (kill-buffer (get-buffer-create postit-show-buffer-name))
  (kill-buffer (get-buffer-create postit-header-buffer-name))
  (kill-buffer (get-buffer-create postit-sub-process-buffer-name))
  (kill-buffer (get-buffer-create postit-buffer-name))
  (kill-buffer (get-buffer-create postit-process-buffer-name))
  (kill-buffer (get-buffer-create postit-search-buffer-name))
  (while (not (null postit-save-files))
    (delete-file (car postit-save-files))
    (setq postit-save-files (cdr postit-save-files)))
  (set-window-configuration postit-prev-win-conf)
  (setq postit-prev-win-conf nil)
  (setq postit-showing nil)
  (setq postit-showing-header nil)
  (setq postit-selected-category nil)
  (setq postit-selected-list nil)
  (setq postit-ab-line 3)
  (setq postit-yank nil)
  (setq postit-line 1))

(defun postit-save-and-quit ()
  "quit from postit after saving to postit-file."
  (interactive)
  (postit-save)
  (postit-quit))

(defun postit-restart ()
  "restart postit."
  (interactive)
  (postit-quit)
  (postit))

(defun postit-make-memo (title category)
  "make a memo.

the memo is plain text or link to file or link to file on remote host(ftp) or URL."
  (interactive "sInput title: \ncCategory t(text), l(link), f(ftp), u(URL): ")
  (toggle-read-only 0) ; make writable
  (cond ((= category ?t)
	 (setq postit-edit-or-make t)
	 (kill-buffer (get-buffer-create postit-edit-buffer-name))
	 (delete-other-windows)
	 (split-window-vertically (/ (window-height) postit-win-div))
	 (other-window 1)
	 (switch-to-buffer postit-edit-buffer-name)
	 (insert (concat "Title: " title "\n"))
	 (insert (concat "Category: " "text" "\n"))
	 (insert (concat "Comments: " "\n"))
	 (insert "--text follows this line--\n")
	 (postit-edit-mode))
	((= category ?l)
	 (let (file)
	   (setq file (read-file-name "Filename: "))
	   (set-buffer postit-buffer-name)
	   (goto-char (point-min))
	   (search-forward "\n\n" nil t postit-line)
	   (insert (concat "Title: " title "\n"))
	   (insert (concat "Date: " (current-time-string) "\n"))
	   (insert (concat "Category: " "link" "\n"))
	   (insert (concat "Link: " file "\n"))
	   (insert "\n\n"))
	 (postit-show-titles))
	((= category ?f)
	 (let (host user file)
	   (setq host (read-from-minibuffer "ftp host: "))
	   (setq user (read-from-minibuffer "user name: "))
	   (setq file (let ((fullfile (read-file-name
				       "file name: "
				       (concat "/" user "@" host ":~/"))))
			(substring fullfile (1+ (string-match ":" fullfile)))))
	   (set-buffer postit-buffer-name)
	   (goto-char (point-min))
	   (search-forward "\n\n" nil t postit-line)
	   (insert (concat "Title: " title "\n"))
	   (insert (concat "Date: " (current-time-string) "\n"))
	   (insert (concat "Category: " "ftp" "\n"))
	   (insert (concat "Host: " host "\n"))
	   (insert (concat "User: " user "\n"))
	   (insert (concat "File: " file "\n"))
	   (insert "\n\n"))
	 (postit-show-titles))
	((= category ?u)
	 (let (url browser)
	   (setq url (read-from-minibuffer "URL: "))
	   (if (string= "" postit-browser)
	       (setq browser (if (y-or-n-p "(y)Netscape, (n)w3: ")
				 "netscape"
			       "w3"))
	     (setq browser ""))
	   (set-buffer postit-buffer-name)
	   (goto-char (point-min))
	   (search-forward "\n\n" nil t postit-line)
	   (insert (concat "Title: " title "\n"))
	   (insert (concat "Date: " (current-time-string) "\n"))
	   (insert (concat "Category: " "url" "\n"))
	   (insert (concat "URL: " url "\n"))
	   (or (string= "" browser)
	       (insert (concat "Browser: " browser "\n")))
	   (insert "\n\n"))
	 (postit-show-titles))))

(defun postit-make-text-memo (title)
  "make a plain text memo."
  (interactive "sTitle: ")
  (postit-make-memo title ?t))

(defun postit-change-header (alist)
  (let (temp header)
    (save-excursion
      (set-buffer postit-buffer-name)
      (goto-char (point-min))
      (search-forward "\n\n" nil t postit-line)
      (save-excursion
	(goto-char (1- (search-forward "\n\n" nil t 1)))
	(setq temp (point)))
      (setq header (buffer-substring (point) temp))
      (delete-region (point) temp)
      (kill-buffer (get-buffer-create postit-process-buffer-name))
      (set-buffer (get-buffer-create postit-process-buffer-name))
      (insert header)
      (while (not (null alist))
	(let ((top (car alist)))
	  (goto-char (point-min))
	  (if (search-forward (car top) nil t 1)
	      (progn
		(if (string= "" (cdr top))
		    (progn
		      (beginning-of-line)
		      (kill-line))
		  (kill-line)
		  (insert (cdr top))))
	    (goto-char (point-max))
	    (insert (concat (car top) (cdr top) "\n")))
	  (setq alist (cdr alist))))
      (setq header (buffer-substring (point-min) (point-max)))
      (set-buffer postit-buffer-name)
      (insert header))))

(defun postit-edit-memo ()
  "edit the memo.

if the memo is
 * plain text, start editing the contents.
 * link to a file, and the file's suffix is
       - used in `postit-link-command', edit the file name.
       - not used in `postit-link-command', get the file, and you can edit it.
 * link to a file on remote host, get the file, and you can edit it.
 * URL, edit the URL."
  (interactive)
  (if (= (point) (point-max))
      (message "no memo.")
    (setq postit-edit-or-make nil)
    (let ((categories
	   (cdr (assoc "Category: " (postit-get-headers	'("Category: "))))))
      (cond ((string-match "url" categories)
	     (let* ((headers (postit-get-headers '("URL: ")))
		    (url (cdr (assoc "URL: " headers)))
		    browser)
	       (setq url (read-from-minibuffer "New URL: "
					       url)) ; renew
	       (if (string= "" postit-browser)
		   (setq browser (if (y-or-n-p "(y)Netscape, (n)w3: ")
				     "netscape"
				   "w3"))
		 (setq browser ""))
	       (postit-change-header (list
				      (cons "URL: " url)
				      (cons "Browser: " browser)))
	       (postit-show-titles)))
	    ((string-match "link" categories)
	     (let* ((headers (postit-get-headers '("Link: ")))
		    (link-file (cdr (assoc "Link: " headers)))
		    (ab-link-file (expand-file-name link-file))
		    (non-editable
		     (assoc (substring ab-link-file
				       (+ (string-match "\.[^\.]*$"
							ab-link-file)
					  1))
			    postit-link-command)))
	       (if non-editable
		   (progn
		     (setq link-file (read-file-name "New link file: " "" nil nil link-file)) ; renew
		     (postit-change-header (list
					    (cons "Link: " link-file)))
		     (postit-show-titles))
		 (find-file ab-link-file))))
	    ((string-match "ftp" categories)
	     (let* ((headers (postit-get-headers
			      '("Host: " "User: " "File: ")))
		    (host (cdr (assoc "Host: " headers)))
		    (user (cdr (assoc "User: " headers)))
		    (file (cdr (assoc "File: " headers)))
		    (non-editable
		     (assoc (substring file
				       (+ (string-match "\.[^\.]*$"
							file)
					  1))
			    postit-link-command)))
	       (if non-editable
		   (progn
		     (setq host (read-from-minibuffer "New Host: " host))
		     (setq user (read-from-minibuffer "New user name: " user))
		     (setq file (let ((fullfile (read-file-name
						 "New file: "
						 (concat "/" user "@" host ":" file))))
				  (substring fullfile (1+ (string-match ":" fullfile)))))
		     (postit-change-header (list
					    (cons "Host: " host)
					    (cons "User: " user)
					    (cons "File: " file)))
		     (postit-show-titles))
		 (find-file (concat "/" user "@" host ":" file)))))
	    (t (let* ((headers
		       (postit-get-headers '("Title: " "Category: " "Comments: " "Misc: ")))
		      (title (cdr (assoc "Title: " headers)))
		      (category (cdr (assoc "Category: " headers)))
		      (comment (cdr (assoc "Comments: " headers)))
		      (misc (cdr (assoc "Misc: " headers))))
		 (setq postit-edit-or-make nil)
		 (setq postit-showing nil)
		 (kill-buffer (get-buffer-create postit-edit-buffer-name))
		 (delete-other-windows)
		 (split-window-vertically (/ (window-height) postit-win-div))
		 (let (temp
		       (memo (postit-get-contents)))
		   (other-window 1)
		   (set-buffer (get-buffer-create postit-edit-buffer-name))
		   (insert (concat "Title: " title "\n"))
		   (insert (concat "Category: " category "\n"))
		   (insert (concat "Comments: " comment "\n"))
		   (if misc
		       (insert (concat "Misc: " misc "\n")))
		   (insert "--text follows this line--\n")
		   (setq temp (point))
		   (insert memo)
		   (goto-char temp)
		   (switch-to-buffer postit-edit-buffer-name))
		 (postit-edit-mode)))))))

(defun postit-rename-title ()
  "rename the title."
  (interactive)
  (let ((title (cdr (assoc "Title: "
			   (postit-get-headers '("Title: "))))))
    (setq title (read-from-minibuffer "Input new title: "
				      title)) ; renew the title.
    (set-buffer postit-buffer-name)
    (goto-char (point-min))
    (search-forward "\n\n" nil t postit-line)
    (search-forward "Title: " nil t 1)
    (kill-line)
    (insert title))
  (postit-show-titles))

(defun postit-delete-memo ()
  "delete the memo."
  (interactive)
  (if (= (point) (point-max))
      (message "no more memo.")
    (if (y-or-n-p "really delete? ")
	(progn
	  (set-buffer postit-buffer-name)
	  (goto-char (point-min))
	  (search-forward "\n\n" nil t postit-line)
	  (let (temp)
	    (save-excursion
	      (search-forward "\n\n" nil t 1)
	      (setq temp (point)))
	    (delete-region (point) temp))
	  (postit-show-titles)))))

(defun postit-inner-function-for-toggle-header ()
  (let (temp header win-low)
    (save-excursion
      (set-buffer postit-buffer-name)
      (goto-char (point-min))
      (search-forward "\n\n" nil t postit-line)
      (save-excursion
	(search-forward "\n\n" nil t 1)
	(backward-char 2)
	(setq temp (point)))
      (setq header (buffer-substring (point) temp))
      (kill-buffer (get-buffer-create postit-header-buffer-name))
      (set-buffer (get-buffer-create postit-header-buffer-name))
      (insert header)
      (setq win-low (postit-absolute-line)))
    (split-window-vertically (- (- (window-height) win-low) 2))
    (other-window 1)
    (switch-to-buffer postit-header-buffer-name)
    (toggle-read-only 1)
    (other-window -1)))
  
(defun postit-toggle-header ()
  "toggle `*Postit Header*' buffer visible/invisible."
  (interactive)
  (or (= (point) (point-max))
      (progn
	(setq postit-showing-header (not postit-showing-header))
	(if postit-showing-header
	    (if postit-showing
		(progn
		  (other-window 1)
		  (postit-inner-function-for-toggle-header)
		  (other-window -1))
	      (postit-inner-function-for-toggle-header))
	  (if postit-showing
	      (progn
		(other-window 1)
		(other-window 1)
		(delete-window (selected-window))
		(switch-to-buffer postit-title-buffer-name))
	    (other-window 1)
	    (delete-window (selected-window)))))))

(defun postit-describe-mode ()
  (interactive)
  (postit-close-other-windows)
  (setq postit-showing t)
  (describe-mode)
  (shrink-window (/ (* (- postit-win-div 2) (frame-height))
		    (* postit-win-div 2))))

(defun postit-url-faces-set ()
  (goto-char (point-max))
  (let (temp)
    (while (re-search-backward postit-urls nil t 1)
      (setq temp (point))
      (save-excursion
	(re-search-forward " \\|\t\\|\n\\|\"" nil t 1)
	(forward-char -1)
	(put-text-property temp (point) 'face 'bold)
	(put-text-property temp (point) 'mouse-face 'highlight))))
  (goto-char (point-min)))

(defun postit-show-if-showing ()
  (and postit-showing
       (let* ((hds (postit-get-headers '("Category: " "Title: ")))
	      (category (cdr (assoc "Category: " hds)))
	      (title (cdr (assoc "Title: " hds))))
	 (other-window 1)
	 (switch-to-buffer postit-show-buffer-name)
	 (toggle-read-only 0)
	 (erase-buffer)
	 (cond ((string-match "link" category)
		(let* ((headers (postit-get-headers '("Link: ")))
		       (link-file
			(expand-file-name
			 (cdr (assoc "Link: " headers))))
		       (suffix
			(substring link-file
				   (+ (string-match "\.[^\.]*$"
						    link-file)
				      1)))
		       (command (cdr (assoc suffix postit-link-command)))
		       (option (cdr (assoc suffix postit-link-command-option))))
		  (if postit-always-show
		      (if command
			  (progn
			    (start-process suffix postit-sub-process-buffer-name command link-file option)
			    (insert (concat "Command " command " started.")))
			(insert-file-contents link-file)
			(and window-system
			     (postit-url-faces-set)))
		    (if command
			(insert (concat "Type `o' to start Command " command "."))
		      (insert "Type `o' to get the file.")
		      (setq postit-prev-memo-is-shown nil)))))
	       ((string-match "ftp" category)
		(let* ((headers (postit-get-headers
				 '("Host: " "User: " "File: ")))
		       (host (cdr (assoc "Host: " headers)))
		       (user (cdr (assoc "User: " headers)))
		       (file (cdr (assoc "File: " headers)))
		       (save-file (make-temp-name (file-name-as-directory postit-directory)))
		       (suffix
			(substring file
				   (+ (string-match "\.[^\.]*$"
						    file)
				      1)))
		       (command (cdr (assoc suffix postit-link-command)))
		       (option (cdr (assoc suffix postit-link-command-option))))
		  (if postit-always-show
		      (if command
			  (progn
			    (save-excursion
			      (kill-buffer (get-buffer-create postit-process-buffer-name))
			      (set-buffer (get-buffer-create postit-process-buffer-name))
			      (insert-file-contents (concat "/" user "@" host ":" file))
			      (write-file (expand-file-name save-file))
			      (kill-buffer (file-name-nondirectory save-file))
			      (start-process suffix postit-sub-process-buffer-name command save-file option)
			      (setq postit-save-files (cons save-file postit-save-files)))
			    (insert "Command " command " started."))
			(insert-file-contents (concat "/" user "@" host ":" file)))
		    (if command
			(insert (concat "Type `o' to start Command " command "."))
		      (insert "Type `o' to get the file.")
		      (setq postit-prev-memo-is-shown nil)))))
	       ((string-match "url" category)
		(let* ((headers (postit-get-headers '("URL: "
						      "Browser: ")))
		       (url (cdr (assoc "URL: " headers)))
		       (browser (cdr (assoc "Browser: " headers))))
		  (if postit-always-show
		      (cond ((string= "w3" (if browser
					       browser
					     postit-browser))
			     (if (fboundp 'w3)
				 (w3-fetch url)
			       (message "Can't use w3.")))
			    ((string= "netscape" (if browser
						     browser
						   postit-browser))
			     (or (zerop
				  (apply 'call-process "netscape" nil nil nil
					 (list "-remote" 
					       (concat "openURL(" url ")"))))
				 (progn ; Netscape not running - start it
				   (message "Starting Netscape...")
				   (apply 'start-process "netscape" nil "netscape"
					  (list url))))
			     (insert "Look at Netscape.")))
		    (insert "Type `o' to start browser.")
		    (setq postit-prev-memo-is-shown nil))))
	       (t (let ((memo (postit-get-contents)))
		    (insert memo)
		    (setq postit-prev-memo-is-shown t)
		    (and window-system
			 (postit-url-faces-set)))))
	 (postit-show-mode)
	 (setq mode-line-format (list (cons 50 title) "  ("
				      mode-name minor-mode-alist ")"))
	 (force-mode-line-update)
	 (toggle-read-only 1)))
  (if postit-showing-header
      (let (temp header win-low)
	(other-window 1)
	(save-excursion
	  (set-buffer postit-buffer-name)
	  (goto-char (point-min))
	  (search-forward "\n\n" nil t postit-line)
	  (save-excursion
	    (search-forward "\n\n" nil t 1)
	    (backward-char 2)
	    (setq temp (point)))
	  (setq header (buffer-substring (point) temp))
	  (kill-buffer (get-buffer-create postit-header-buffer-name))
	  (set-buffer (get-buffer-create postit-header-buffer-name))
	  (insert header)
	  (setq win-low (postit-absolute-line))
	  (enlarge-window (- win-low (- (window-height) 2))))
	(switch-to-buffer postit-header-buffer-name)
	(toggle-read-only 1)
	(other-window -1)
	(and postit-showing
	     (other-window -1)))
    (other-window -1)))

(defun postit-show-if-showing-header ()
  (and postit-showing-header
       (if postit-showing
	   (progn
	     (other-window 1)
	     (postit-inner-function-for-toggle-header)
	     (other-window -1))
	 (postit-inner-function-for-toggle-header))))

(defun postit-next-memo ()
  "goto next line, and if showing the contents or header, they become the next contents and the next header."
  (interactive)
  (if (= (point) (point-max))
      (message "no more memo.")
    (forward-line)
    (setq postit-ab-line (1+ postit-ab-line))
    (setq postit-line (postit-current-line))
    (setq postit-prev-line postit-line)
    (if (= (point) (point-max))
	(message "no memo.")
      (postit-show-if-showing))))

(defun postit-next-title ()
  "move to the next memo without changing the Showing buffer."
  (interactive)
  (if (= (point) (point-max))
      (message "no more memo.")
    (forward-line)
    (setq postit-ab-line (1+ postit-ab-line))
    (setq postit-line (postit-current-line))))

(defun postit-5-next-title ()
  "skip 5 memos forward without changing the Showing buffer."
  (interactive)
  (forward-line 5)
  (or (and (= 3 (postit-absolute-line))
	   (= (point) (point-max)))
      (forward-line -1))
  (setq postit-ab-line (postit-absolute-line))
  (setq postit-line (postit-current-line)))

(defun postit-prev-memo ()
  "goto previous line, and if showing the contents or header, they become the previous contents and the previous header."
  (interactive)
  (if (= (postit-absolute-line) 3)
      (message "no more memo.")
    (forward-line -1)
    (setq postit-ab-line (1- postit-ab-line))
    (setq postit-line (postit-current-line))
    (setq postit-prev-line postit-line)
    (postit-show-if-showing)))

(defun postit-prev-title ()
  "move to the previous memo without changing the Showing buffer."
  (interactive)
  (if (= (postit-absolute-line) 3)
      (message "no more memo.")
    (forward-line -1)
    (setq postit-ab-line (1- postit-ab-line))
    (setq postit-line (postit-current-line))))

(defun postit-5-prev-title ()
  "skip 5 memos backward without changing the Showing buffer."
  (interactive)
  (forward-line -5)
  (let ((n (postit-absolute-line)))
    (and (or (= n 1) (= n 2))
	 (forward-line (- 3 n))))
  (setq postit-ab-line (postit-absolute-line))
  (setq postit-line (postit-current-line)))

(defun postit-goto-top ()
  "skip to the first memo in the current Postit title buffer."
  (interactive)
  (goto-char (point-min))
  (forward-line 2)
  (setq postit-ab-line 3)
  (setq postit-line (postit-current-line)))

(defun postit-goto-bottom ()
  "skip to the bottom memo in the current Postit title buffer."
  (interactive)
  (goto-char (point-max))
  (or (and (= 3 (postit-absolute-line))
	   (= (point) (point-max)))
      (forward-line -1))
  (setq postit-ab-line (postit-absolute-line))
  (setq postit-line (postit-current-line)))

(defun postit-divide-window-to-show ()
  (split-window-vertically (/ (frame-height) postit-win-div))
  (recenter))

(defun postit-show-memo ()
  "show the memo's contents. and if it is a plain text, scroll it."
  (interactive)
  (if (= (point) (point-max))
      (message "no memo.")
    (if postit-showing
	(if (and (= postit-prev-line postit-line)
		 postit-prev-memo-is-shown)
	    (scroll-other-window)
	  (setq postit-prev-line postit-line)
	  (setq postit-prev-memo-is-shown t)
	  (setq postit-always-show t)
	  (postit-show-if-showing))
      (setq postit-showing t)
      (setq postit-prev-line postit-line)
      (setq postit-prev-memo-is-shown t)
      (setq postit-always-show t)
      (postit-divide-window-to-show)
      (postit-show-if-showing)))
  (setq postit-always-show nil))

(defun postit-show-memo-always ()
  "show the memo's contents in any condition."
  (interactive)
  (if (= (point) (point-max))
      (message "no memo.")
    (setq postit-always-show t)
    (setq postit-prev-line postit-line)
    (or postit-showing
	(postit-divide-window-to-show))
    (setq postit-showing t)
    (postit-show-if-showing)
    (setq postit-always-show nil)))

(defun postit-show-memo-by-mouse-click (click)
  "show the memo's contents by mouse-2 click in any condition."
  (interactive "e")
  (goto-char (posn-point (event-start click)))
  (setq postit-line (postit-current-line))
  (postit-show-memo-always))

(defun postit-memo-backscroll ()
  "backscroll the contents if showing."
  (interactive)
  (and postit-showing
       (scroll-other-window-down nil)))

(defun postit-send-to-yank ()
  "put the current memo into the postit yank, and delete from buffer."
  (interactive)
  (if (= (point) (point-max))
      (message "no memo.")
    (save-excursion
      (set-buffer postit-buffer-name)
      (goto-char (point-min))
      (search-forward "\n\n" nil t postit-line)
      (let (temp)
	(save-excursion
	  (search-forward "\n\n" nil t 1)
	  (setq temp (point)))
	(setq postit-yank (buffer-substring (point) temp))
	(delete-region (point) temp)))
    (postit-show-titles)))

(defun postit-get-from-yank ()
  "put the postit yank at the current line."
  (interactive)
  (save-excursion
    (set-buffer postit-buffer-name)
    (goto-char (point-min))
    (search-forward "\n\n" nil t postit-line)
    (and postit-yank
	 (insert postit-yank)))
  (postit-show-titles))

(defun postit-extract ()
  "plain text memos are able to been saved to files.
if the current memo is not a plain text memo, nothing is done."
  (interactive)
  (let ((category (cdr (assoc "Category: "
			      (postit-get-headers '("Category: "))))))
    (and (string-match "text" category)
	 (let (temp contents
	       (filename (read-file-name "File Name: ")))
	   (save-excursion
	     (set-buffer postit-buffer-name)
	     (goto-char (point-min))
	     (search-forward "\n\n" nil t postit-line)
	     (search-forward "\n\n" nil t 1)
	     (save-excursion
	       (goto-char (- (search-forward "\n\n" nil t 1) 3))
	       (setq temp (point)))
	     (setq contents (buffer-substring (point) temp))
	     (kill-buffer (get-buffer-create postit-process-buffer-name))
	     (set-buffer (get-buffer-create postit-process-buffer-name))
	     (insert contents)
	     (write-file (expand-file-name filename))
	     (kill-buffer (file-name-nondirectory filename)))))))
	   
(defun postit-close-other-windows ()
  "close the other windows."
  (interactive)
  (setq postit-showing nil)
  (setq postit-showing-header nil)
  (delete-other-windows))

(defun postit-search (string)
  "Search a string in plain text memos."
  (interactive "sSearch String: ")
  (or (string= "" string)
      (progn
	(postit-close-other-windows)
	(kill-buffer (get-buffer-create postit-search-buffer-name))
	(split-window-vertically (/ (window-height) postit-win-div))
	(other-window 1)
      (switch-to-buffer (get-buffer-create postit-search-buffer-name))
      (set-buffer postit-buffer-name)
      (goto-char (point-min))
      (search-forward "\n\n" nil t 1)
      (let (temp header title contents text	file link line
		 (count 0))
	(while (not (eobp))
	  (setq text nil)		; flag
	  (setq link nil)		; flag
	  (setq temp (point))
	  (goto-char (- (search-forward "\n\n" nil t 1) 1))
	  (setq header (buffer-substring temp (point)))
	  (save-excursion
	    (kill-buffer (get-buffer-create postit-process-buffer-name))
	    (set-buffer (get-buffer-create postit-process-buffer-name))
	    (insert header)
	    (goto-char (point-min))
	    (search-forward "Category: " nil t 1)
	    (save-excursion
	      (end-of-line)
	      (setq temp (point)))
	    (if (or (and (string-match "text"
				       (buffer-substring (point) temp))
			 (setq text t))
		    (and (string-match "link"
				       (buffer-substring (point) temp))
			 (progn
			   (goto-char (point-min))
			   (search-forward "Link: " nil t 1)
			   (setq temp (point))
			   (end-of-line)
			   (setq file (expand-file-name (buffer-substring temp (point))))
			   (or (assoc (substring file
						 (+ (string-match "\.[^\.]*$"
								  file)
						    1))
				      postit-link-command)
			       (setq link t)))))
		(progn
		  (goto-char (point-min))
		  (search-forward "Title: " nil t 1)
		  (save-excursion
		    (end-of-line)
		    (setq temp (point)))
		  (setq title (buffer-substring (point) temp)))
	      (setq text nil)
	      (setq link nil)))
	  (setq temp (point))
	  (search-forward "\n\n" nil t 1)
	  (and (or text
		   link)
	       (progn
		 (and text
		      (setq contents (buffer-substring temp (point))))
		 (save-excursion
		   (kill-buffer (get-buffer-create postit-process-buffer-name))
		   (set-buffer (get-buffer-create postit-process-buffer-name))
		   (if text
		       (progn
			 (insert contents)
			 (goto-char (point-min)))
		     (insert-file-contents file))
		   (and (search-forward string nil t 1)
			(progn
			  (goto-char (point-min))
			  (save-excursion
			    (set-buffer postit-search-buffer-name)
			    (insert (concat "\nFound in " title "\n"))
			    (forward-line -1)
			    (setq temp (point))
			    (end-of-line)
			    (and window-system
				 (progn
				   (put-text-property temp (point) 'face 'bold)
				   (put-text-property temp (point) 'mouse-face 'highlight)))
			    (forward-line 1))
			  (while (search-forward string nil t 1)
			    (beginning-of-line)
			    (setq temp (point))
			    (end-of-line)
			    (setq line (buffer-substring temp (point)))
			    (save-excursion
			      (set-buffer postit-search-buffer-name)
			      (insert (concat "++  " line "\n"))
			      (and window-system
				   (progn
				     (search-backward string nil t 1)
				     (put-text-property (point) (+ (point) (length string))
							'face 'postit-search-face)
				     (forward-line))))
			    (setq count (1+ count)))))))))
	(set-buffer postit-search-buffer-name)
	(insert (concat "\nHit " count " counts for \"" string "\"."))
	(setq postit-showing t)
	(postit-search-mode))
      (other-window -1))))

(defun postit-select (category)
  "set the category, and show the titles which have the category."
  (interactive "sWhat Category: ")
  (if (string= "" category)
      (setq postit-selected-category nil)
    (set-buffer postit-buffer-name)
    (goto-char (point-min))
    (search-forward "\n\n" nil t 1)
    (setq postit-selected-list '())
    (let ((count 1)
	  temp)
      (while (not (eobp))
	(search-forward "Category: " nil t 1)
	(setq temp (point))
	(end-of-line)
	(and (string-match category (buffer-substring temp (point)))
	     (setq postit-selected-list (cons count postit-selected-list)))
	(setq count (1+ count))
	(search-forward "\n\n" nil t 1)))
    (if (null postit-selected-list)
	(setq postit-selected-category nil)
      (setq postit-selected-category category)
      (setq postit-selected-list (reverse postit-selected-list))))
  (postit-show-titles))

(defun postit-isearch ()
  "search a string in the Postit title buffer."
  (interactive)
  (isearch-forward)
  (setq postit-ab-line (postit-absolute-line))
  (setq postit-line (postit-current-line))
  (beginning-of-line))

;; postit-edit-mode
(defun postit-entry-save ()
  "In editing a plain text, enter the memo into postit."
  (interactive)
  (set-buffer (get-buffer-create postit-edit-buffer-name))
  (goto-char (point-min))
  (let (temp
	(headers (progn
		   (let (temp)
		     (save-excursion
		       (search-forward "--text follows this line--\n" nil t 1)
		       (forward-line -1)
		       (setq temp (point)))
		     (buffer-substring (point) temp))))
	(memo (progn
		(search-forward "--text follows this line--\n" nil t 1)
		(buffer-substring (point) (point-max)))))
    (set-buffer postit-buffer-name)
    (goto-char (point-min))
    (search-forward "\n\n" nil t postit-line)
    (if postit-edit-or-make
	(progn
	  (insert (concat headers
			  "Date: " (current-time-string) "\n"
			  "\n"))
	  (insert (concat memo "\n\n")))
      (let (temp)
	(save-excursion
	  (search-forward "\n\n" nil t 1)
	  (setq temp (point)))
	(delete-region (point) temp))
      (insert (concat headers
		      "Date: " (current-time-string) "\n"
		      "\n"))
      (insert (concat memo "\n\n"))))
  (kill-buffer (get-buffer-create postit-edit-buffer-name))
  (setq postit-showing nil)
  (postit-show-titles))

(defun postit-entry-save-and-quit ()
  "In editing a plain text, quit from postit after entering the memo into postit"
  (interactive)
  (postit-entry-save)
  (postit-save-and-quit))

(defun postit-entry-save-and-save ()
  "In editing a plain text, save the editting memo, and postit."
  (interactive)
  (postit-entry-save)
  (postit-save))

;; postit-show-mode
(defun postit-url-browse-by-mouse (event)
  "Browse the URL at point."
  (interactive "e")
  (let ((posn (event-start event)))
    (set-buffer (window-buffer (posn-window posn)))
    (goto-char (posn-point posn))
    (postit-url-browse)))
;    (let ((url (progn
;		 (re-search-backward postit-urls nil t 1)
;		 (re-search-forward (concat "\\(\\(" postit-urls "\\)[!#-~]*\\)") nil t 1)
;		 (buffer-substring (match-beginning 1)
;				   (match-end 1)))))
;      (or (zerop
;	   (apply 'call-process "netscape" nil nil nil
;		  (list "-remote" 
;			(concat "openURL(" url ")"))))
;	  (progn ; Netscape not running - start it
;	    (message "Starting Netscape...")
;	    (apply 'start-process "netscape" nil "netscape"
;		   (list url)))))))

(defun postit-url-browse ()
  "decode URL and execute Netscape."
  (interactive)
  (let ((url (progn
	       (re-search-backward postit-urls nil t 1)
	       (re-search-forward (concat "\\(\\(" postit-urls "\\)[!#-~]*\\)") nil t 1)
	       (buffer-substring (match-beginning 1)
				 (match-end 1)))))
    (or (zerop
	 (apply 'call-process "netscape" nil nil nil
		(list "-remote" 
		      (concat "openURL(" url ")"))))
	(progn ; Netscape not running - start it
	  (message "Starting Netscape...")
	  (apply 'start-process "netscape" nil "netscape"
		 (list url))))))
  
;; postit-search-mode
(defun postit-show-searched-memo (event)
  "Show the clicked memo."
  (interactive "e")
  (let (temp header
	(posn (event-start event)))
    (set-buffer (window-buffer (posn-window posn)))
    (goto-char (posn-point posn))
    (let ((find nil)
	  (count 0)
	  (title (progn
		   (beginning-of-line)
		   (search-forward "Found in " nil t 1)
		   (setq temp (point))
		   (end-of-line)
		   (buffer-substring temp (point)))))
      (set-buffer postit-buffer-name)
      (goto-char (point-min))
      (search-forward "\n\n" nil t 1)
      (while (not find)
	(setq temp (point))
	(goto-char (- (search-forward "\n\n" nil t 1) 1))
	(setq header (buffer-substring temp (point)))
	(save-excursion
	  (kill-buffer (get-buffer-create postit-process-buffer-name))
	  (set-buffer (get-buffer-create postit-process-buffer-name))
	  (insert header)
	  (goto-char (point-min))
	  (and (search-forward (concat "Title: " title) nil t 1)
	       (setq find t)))
	(setq count (1+ count))
	(search-forward "\n\n" nil t 1))
      (setq postit-line count)
      (set-buffer postit-title-buffer-name)
      (postit-show-memo-always))))

;; modes
(defun postit-mode ()
  "*Major mode for displaying and editing `postit'.

Special commands:
\\{postit-mode-map}

Turning on postit-mode runs hook `postit-mode-hook'."
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'postit-mode)
  (setq mode-name "Postit")
  (use-local-map postit-mode-map)
  (run-hooks 'postit-mode-hook))

(defun postit-edit-mode ()
  "*Major mode for editing `postit'.

Special commands:
\\{postit-edit-mode-map}

Turning on postit-edit-mode runs hook `postit-edit-mode-hook'."
  (kill-all-local-variables)
  (setq major-mode 'postit-edit-mode)
  (setq mode-name "Postit-Edit")
  (use-local-map postit-edit-mode-map)
  (run-hooks 'text-mode-hook)
  (run-hooks 'postit-edit-mode-hook))

(defun postit-show-mode ()
  "*Major mode for showing contents of `postit'.

Special commands:
\\{postit-show-mode-map}

Turing on postit-show-mode runs hook `postit-show-mode-hook'."
  (kill-all-local-variables)
  (setq major-mode 'postit-show-mode)
  (setq mode-name "Postit-Show")
  (use-local-map postit-show-mode-map)
  (run-hooks 'postit-show-mode-hook))

(defun postit-search-mode ()
  "*Major mode for showing the result of searching the string in memos.

Spacial commands:
\\{postit-search-mode-map}

Turing on postit-search-mode runs hook `postit-search-mode-hook'."
  (kill-all-local-variables)
  (setq major-mode 'postit-search-mode)
  (setq mode-name "Postit-Search")
  (use-local-map postit-search-mode-map)
  (run-hooks 'postit-search-mode-hook))

;; initialization
(defun postit-make-header ()
  (insert "Post-it version 1.2  by tama\n\n"))

(defun postit-get-headers (header-name-list)
  "return association list of nth header.
association list consists of only which is specified by `header-name-list'"
  (save-excursion
    (set-buffer postit-buffer-name)
    (goto-char (point-min))
    (search-forward "\n\n" nil t postit-line)
    (let (headers temp)
      (save-excursion
	(search-forward "\n\n" nil t 1)
	(setq temp (point)))
      (setq headers (buffer-substring (point) temp))
      (kill-buffer (get-buffer-create postit-process-buffer-name))
      (set-buffer (get-buffer-create postit-process-buffer-name))
      (insert headers)
      (goto-char (point-min))
      (let (found (alist '()))
	(while (not (null header-name-list))
	  (if (search-forward (car header-name-list) nil t 1)
	      (setq found t)
	    (setq found nil))
	  (save-excursion
	    (end-of-line)
	    (setq temp (point)))
	  (setq alist
		(cons (cons (car header-name-list)
			    (if found
				(buffer-substring (point) temp)
			      nil))
		      alist))
	  (setq header-name-list (cdr header-name-list))
	  (goto-char (point-min)))
	alist))))

(defun postit-get-contents ()
  (save-excursion
    (set-buffer (get-buffer-create postit-buffer-name))
    (goto-char (point-min))
    (search-forward "\n\n" nil t postit-line)
    (search-forward "\n\n" nil t 1)
    (let (temp)
      (save-excursion
	(goto-char (- (search-forward "\n\n" nil t 1) 3))
	(setq temp (point)))
      (buffer-substring (point) temp))))

(defun postit-get-title () ; the length is 30(to be seen).
  (goto-char (point-min))
  (search-forward "Title: " nil t 1)
  (end-of-line)
  (if (< (current-column) 37)
      (progn
	(beginning-of-line)
	(forward-char 7)
	(let (temp space)
	  (save-excursion
	    (end-of-line)
	    (setq temp (point))
 	    (setq space (- 37 (current-column))))
	  (concat (buffer-substring (point) temp) (make-string space ? ))))
    (let (temp
	  (half nil))
      (beginning-of-line)
      (forward-char 7)
      (save-excursion
	(while (< (current-column) 37) ; includeing the length of "Title: "
	  (forward-char))
	(backward-char)
	(setq temp (point))
	(if (= (current-column) 35)
	    (setq half t)))
      (if half
	  (concat (buffer-substring (point) temp) "  ")
	(concat (buffer-substring (point) temp) " ")))))

(defun postit-get-time () ; always length = 24
  (goto-char (point-min))
  (search-forward "Category: " nil t 1)
  (let (temp category string)
    (save-excursion
      (end-of-line)
      (setq temp (point)))
    (setq category (buffer-substring (point) temp))
    (goto-char (point-min))
    (cond ((string-match "link" category)
	   (search-forward "Link: " nil t 1)
	   (setq postit-time-or-link-or-ftp-or-url 1))
	  ((string-match "ftp" category)
	   (search-forward "File: " nil t 1)
	   (setq postit-time-or-link-or-ftp-or-url 2))
	  ((string-match "url" category)
	   (search-forward "URL: " nil t 1)
	   (setq postit-time-or-link-or-ftp-or-url 3))
	  (t (search-forward "Date: " nil t 1)
	     (setq postit-time-or-link-or-ftp-or-url 0)))
    (save-excursion
      (end-of-line)
      (setq temp (point)))
    (setq string (buffer-substring (point) temp))
    (if (> (length string) 24)
	(substring string 0 24)
      (concat string (make-string (- 24 (length string)) ? )))))

(defun postit-get-category () ; add one space to be easy to see. length=11
  (goto-char (point-min))
  (search-forward "Category: " nil t 1)
  (let (temp string)
    (save-excursion
      (end-of-line)
      (setq temp (point)))
    (setq string (buffer-substring (point) temp))
    (if (> (length string) 15)
	(concat " " (substring string 0 15))
      (concat " " string))))

(defun postit-show-titles ()
  (kill-buffer (get-buffer-create postit-title-buffer-name))
  (set-buffer (get-buffer-create postit-title-buffer-name))
  (delete-other-windows)
  (insert "Post-it version 1.2  - tiny memorandum -  by tama(tama@is.s.u-tokyo.ac.jp)\n")
  (insert "Title                         Update time/ Link / URL  Categories\n")
  (set-buffer postit-buffer-name)
  (goto-char (point-min))
  (search-forward "\n\n" nil t 1)
  (let (headers title time category temp)
    (while (not (eobp))
      (save-excursion
	(search-forward "\n\n" nil t 1)
	(forward-line -1)
	(setq temp (point)))
      (setq headers (buffer-substring (point) temp))
      (kill-buffer (get-buffer-create postit-process-buffer-name))
      (set-buffer (get-buffer-create postit-process-buffer-name))
      (insert headers)
      (setq title (postit-get-title))
      (setq time (postit-get-time))
      (setq category (postit-get-category))
      (set-buffer postit-title-buffer-name)
      (and (or (not postit-selected-category)
	       (and postit-selected-category
		    (string-match postit-selected-category category)))
	   (progn
	     (insert title)
	     (insert time) ; always the length is 24.
	     (insert category)
	     (insert "\n")
	     (and window-system
		  postit-colorize
		  (progn
		    (setq temp (1- (point)))
		    (forward-line -1)
		    (put-text-property (point) (+ (point) (length title))
				       'face 'postit-title-face)
		    (put-text-property (+ (point) (length title))
				       (+ (point) (length title) 24)
				       'face (cond ((= 0 postit-time-or-link-or-ftp-or-url)
						    'postit-time-face)
						   ((= 1 postit-time-or-link-or-ftp-or-url)
						    'postit-link-face)
						   ((= 2 postit-time-or-link-or-ftp-or-url)
						    'postit-ftp-face)
						   ((= 3 postit-time-or-link-or-ftp-or-url)
						    'postit-url-face)))
		    (put-text-property (+ (point) (length title) 24)
				       (+ (point) (length title) 24 (length category))
				       'face 'postit-category-face)
		    (put-text-property (point) temp 'mouse-face 'highlight)
		    (forward-line)))))
      (set-buffer postit-buffer-name)
      (search-forward "\n\n" nil t 1)))
  (kill-buffer (get-buffer-create postit-process-buffer-name))
  (switch-to-buffer postit-title-buffer-name)
  (goto-char (point-min))
  (forward-line (- postit-ab-line 1))
  (setq postit-line (postit-current-line))
  (toggle-read-only 1)
  (setq postit-showing nil)
  (setq postit-showing-header nil)
  (postit-mode))

(defun postit ()
  "postit is a tiny memorandum which has much feature.

Postit can
 * not only make a plain text memo, but also
 * link to a file and see it, start process a command correspond to the
   file (*.dvi > xdvdi, *.ps > ghostview, *.gif > xv, etc...),
 * link to a file on remote hosts and see it, start process a command
   correspond to the file, 
 * set a URL to invoke a browser(netscape, w3)."
  (interactive)
  (or postit-prev-win-conf
      (progn
	(kill-buffer (get-buffer-create postit-buffer-name))
	(kill-buffer (get-buffer-create postit-process-buffer-name))
	(kill-buffer (get-buffer-create postit-title-buffer-name))
	(kill-buffer (get-buffer-create postit-show-buffer-name))
	(set-buffer (get-buffer-create postit-buffer-name))
	(or postit-prev-win-conf
	    (setq postit-prev-win-conf (current-window-configuration)))
	(delete-other-windows)
	(let ((file-z (expand-file-name (concat postit-file
						postit-compress-suffix)))
	      (file-u (expand-file-name postit-file)))
	  (if postit-compress-command
	      (if (file-exists-p file-z)
		  (call-process postit-uncompress-command
				file-z
				t ;postit-buffer-name
				nil)
		(if (file-exists-p file-u)
		    (insert-file-contents file-u)
		  (postit-make-header)))
	    (if (file-exists-p file-u)
		(insert-file-contents file-u)
	      (postit-make-header))))
	(if (string-match "Post-it version 1..  by tama\n\n"
			  (buffer-substring (point-min) (+ (point-min) 31)))
	    (postit-show-titles)
	  (message "Incorrect postit file")))))

(defun postit-other-frame ()
  (interactive)
  (and window-system
       (or postit-prev-win-conf
	   (let ((pop-up-frames t)
		 (pop-up-frame-alist
		  '((menu-bar-lines . 1))))
	     (pop-to-buffer nil)
	     (postit)))))

(defun postit-kill-self ()
  (interactive)
  (and (and (string-equal (cdr (assq 'name (frame-parameters (selected-frame))))
			  "*Postit*")
	    (not (null (cdr (frame-list)))))
       (delete-frame (selected-frame)))
  (postit-quit))

;; for save at emacs(mule) immediate killing.
(add-hook 'kill-emacs-hook
	  (function (lambda ()
		      (and postit-prev-win-conf
			   (progn
			     (and (member postit-edit-buffer-name
					  (mapcar (function buffer-name)
						  (buffer-list)))
				  (or postit-auto-save
				      (y-or-n-p "Save Postit? "))
				  (postit-entry-save))
			     (postit-save)
			     (message "Postit is saved to the file.")
			     (sit-for 0.8)
			     (while (not (null postit-save-files))
			       (delete-file (car postit-save-files))
			       (setq postit-save-files (cdr postit-save-files))))))))

(provide 'postit)

;;; end of postit.el
