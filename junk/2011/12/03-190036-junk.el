;; trial and error about anything

(defvar org-src-my-lang-candidates
   '("asymptote" "awk" "calc" "C" "C++" "clojure" "css" "ditaa" "dot" "emacs-lisp"
     "gnuplot" "haskell" "java" "js" "latex" "ledger" "lisp" "lilypond" "matlab"
     "mscgen" "ocaml" "octave" "org" "oz" "perl" "plantuml" "python" "R" "ruby"
     "sass" "scheme" "screen" "sh" "sql" "sqlite"))

(defvar anything-c-source-org-src-lang
  '((name . "Available language in Org-mode src block")
    (candidates . org-src-my-lang-candidates)
    (action ("Return as string" . eval)
            ("Return as symbol" . intern)
            ("Insert string" . insert))))

(anything-other-buffer '(anything-c-source-org-src-lang) "*anything src lang*") ; => "ditaa"

