(defun match-test (str)
  (save-match-data
    (set-match-data nil)
    (let ((result ""))
      (when (string-match "%[^%]" str)
        (setq result ","))
      (while (string-match "%[^%]" str (match-end 0))
        (setq result (concat result ",")))
      result)))
(match-test "%di %suuu")                            ; => ", , "



(defun multibyte-test ()
  (let ((str "ほげほげ"))
    (multibyte-string-p str)))
(multibyte-test)                        ; => t






