;;; java-options --- Summary
;;; Commentary: 
;;; Code:

(require 'mag-menu)

;;;###autoload
(defun java-options ()
  "Java option menu."
  (interactive)
  (mag-menu
   '(java-options
     (actions
      ("RET" "Run java application" java-options-execute)
      ("v" "Display version" java-options-version)
      ("h" "Display help" java-options-help)
      ("c" "Copy to `kill-ring'" java-options-copy))
     (switches      ("-pfi" "Print JVM initial flags" "-XX:+PrintFlagsInitial")
      ("-pff" "Print JVM final flags" "-XX:+PrintFlagsFinal")
      ("-ucf" "Use commercial features" "-XX:+UnlockCommercialFeatures")
      ("-fr" "Use Flight Recorder" "-XX:+FlightRecorder"))
     (arguments
      ("=ms" "Initial heap size" "-Xms=" mag-menu-read-generic)
      ("=mx" "Max heap size" "-Xmx=" mag-menu-read-generic)
      ("=ps" "Initial permanent generation size" "-XX:PermSize=" mag-menu-read-generic)
      ("=px" "Max permanent generation size" "-XX:MaxPermSize=" mag-menu-read-generic)
      ("=Ms" "Initial meta space size" "-XX:MetaspaceSize=" mag-menu-read-generic)
      ("=Mx" "Max meta space size" "-XX:MaxMetaspaceSize=" mag-menu-read-generic)
      ("=enc" "File encoding" "-Dfile.enconding=" mag-menu-read-generic)
      ("=lang" "User language" "-Duser.language=" mag-menu-read-generic)
      ("=ph" "Proxy host" "-Dhttp.proxyHost=" mag-menu-read-generic)
      ("=pp" "Proxy port" "-Dhttp.proxyPort=" mag-menu-read-generic)
      ("=pu" "Proxy user" "-Dhttp.proxyUser=" mag-menu-read-generic)
      ("=pP" "Proxy password" "-Dhttp.proxyPassword=" mag-menu-read-generic))
     )))

(defun java-options-list (opt-alist)
  (mapcar #'(lambda (elm)
              (if (null (cdr elm))
                  (car elm)
                (format "%s=%s" (car elm) (cdr elm))))
          opt-alist))

(defun java-options-help (opt-alist)
  (let ((buf (get-buffer-create "*java-options*"))
        (args (java-options-list opt-alist)))
    (add-to-list 'args "-help" t)
    (with-current-buffer buf
      (erase-buffer)
      (apply 'call-process "java" nil buf nil args)
      (goto-char (point-min)))
    (display-buffer buf)))

(defun java-options-copy (opt-alist)
  (let ((args (java-options-list opt-alist)))
    (add-to-list 'args "java")
    (kill-new (mapconcat #'identity args " ")))
  (message "Copy a command line to `kill-ring'"))

(defun java-options-execute (opt-alist)
  (let ((buf (get-buffer-create "*java-options*"))
        (args (java-options-list opt-alist)))
    (with-current-buffer buf
      (erase-buffer)
      (apply 'call-process "java" nil buf nil args)
      (goto-char (point-min)))
    (display-buffer buf)))

(defun java-options-version (opt-alist)
  (let ((buf (get-buffer-create "*java-options*"))
        (args (java-options-list opt-alist)))
    (add-to-list 'args "-version" t)
    (with-current-buffer buf
      (erase-buffer)
      (apply 'call-process "java" nil buf nil args)
      (goto-char (point-min)))
    (display-buffer buf)))
(provide 'java-options)

;;; java-options ends here
