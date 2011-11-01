;;; フォント設定
;;; http://nintos.blogspot.com/2010/02/emacs.html
(defun list-rotate-forward (ring)
  (let ((item (car ring))
        (last (last ring)))
    (setcdr last (list item))
    (cdr ring)))

(defun list-rotate-backward (ring)
  (let ((item (car (last ring)))
        (last2 (last ring 2)))
    (setcdr last2 nil)
    (cons item ring)))

;; color-theme を使う。
(require 'color-theme)
(defvar color-theme-set (cdr (cdr (mapcar 'car color-themes))))

(defvar nihongo-font-set
  '("Ricty"
    "TakaoExゴシック"
    "Takaoゴシック"
    "IPAexゴシック"
    "IPA モナー ゴシック"
    "ＭＳ ゴシック"
    "メイリオ"
    "ふい字"
    "みかちゃん"
    "あんずもじ等幅"))

;; (defvar kana-font-set
;;   '("ヒラギノ明朝 Pro"
;;     "ヒラギノ丸ゴ Pro"
;;     "ヒラギノ角ゴ Pro"
;;     "PMinIWA-HW-Md" ;; "PMinIWA-Md" ← 非固定幅
;;     "小塚明朝 Pr6N"
;;     "小塚ゴシック Pr6N"
;;     "IPA明朝"
;;     "IPAゴシック"))

;; (defvar kanji-font-set
;;   (append kana-font-set '("Hanazono Mincho OT xProN")))

(defvar font-size-set '(16 17 18 19 20 22 24 26 28 12 13 14 15))

(defvar ascii-font-set
  '("Ricty"
    "Inconsolata"
    "Modern"
    "DejaVu Sans Mono"
    "IPAexゴシック"
    "IPA モナー ゴシック"
    "ふい字"
    "みかちゃん"
    "あんずもじ等幅"))

(defvar set-rotate-set
  '((ascii-font-set . "ASCII")
    ;(kana-font-set . "かな")
    ;(kanji-font-set . "漢字")
    (nihongo-font-set . "日本語")
    (font-size-set . "フォントサイズ")
    (color-theme-set . "テーマ")))

(defun rotate-rotate-set-forward ()
  (interactive)
  (setq set-rotate-set (list-rotate-forward set-rotate-set))
  (message "Rotate Set = %s" (cdar set-rotate-set)))

(defun rotate-rotate-set-backward ()
  (interactive)
  (setq set-rotate-set (list-rotate-backward set-rotate-set))
  (message "Rotate Set = %s" (cdar set-rotate-set)))

(defun rotate-set-forward ()
  (interactive)
  (let ((set (caar set-rotate-set))
        (name (cdar set-rotate-set)))
    (set set (list-rotate-forward (eval set)))
    (message "%s=%s" name (car (eval set)))
    (update-current-settings)))

(defun rotate-set-backward ()
  (interactive)
  (let ((set (caar set-rotate-set))
        (name (cdar set-rotate-set)))
    (set set (list-rotate-backward (eval set)))
    (message "%s=%s" name (car (eval set)))
    (update-current-settings)))

(global-set-key (kbd "H-f") 'rotate-rotate-set-forward)
(global-set-key (kbd "H-b") 'rotate-rotate-set-backward)
(global-set-key (kbd "H-n") 'rotate-set-forward)
(global-set-key (kbd "H-p") 'rotate-set-backward)

;;; フォント幅テスト用の文字列。|
;;; 1234567890123456789012345678|
;;; 上記の二本の縦棒が揃えば、全角・半角が揃っている。（例：Inconsolata ＆ 小塚・ヒラギノ書体）
;;; サンプル文字列は以下で設定
;;; (list-faces-display) をみると分かりやすいかも
(defun update-current-settings ()
  "自分の好みのフォントセットに変更する。"
  (interactive)
  (let ((sz (car font-size-set))
        (ascii (car ascii-font-set))
        ;(kanji (car kanji-font-set))
        ;(kana (car kana-font-set))
        (nihongo  (car nihongo-font-set))
        (color-theme (car color-theme-set)))
    ;(if (functionp color-theme) (funcall color-theme))
    ;; 下記以外のフォントは、自動選択に任せる。
    (set-fontset-font nil '(    #x0 .   #x6ff) (font-spec :size sz :family ascii)) ;; 日本語向き。
    (set-fontset-font nil '( #x1700 .  #x171f) (font-spec :family "Tagalog Stylized"))
    (set-fontset-font nil '( #x1720 .  #x1c4f) (font-spec :family "Code2000"))
    (set-fontset-font nil '( #x1720 .  #x1c4f) (font-spec :family "MPH 2B Damase") nil 'prepend)
    (set-fontset-font nil '( #x2000 .  #x33ff) (font-spec :family "HanaMin"))
    (set-fontset-font nil 'japanese-jisx0208 (font-spec :family nihongo))
    ;(set-fontset-font nil '( #x2000 .  #x33ff) (font-spec :family kana) nil 'prepend)
    ;(set-fontset-font nil '( #x3400 .  #x9fff) (font-spec :family kanji) nil 'prepend)
    (set-fontset-font nil '( #xa000 .  #xefff) (font-spec :family "MPH 2B Damase"))
    (set-fontset-font nil '( #xf100 .  #xf6ff) (font-spec :family "EUDC2"))
    ;(set-fontset-font nil '( #xff00 .  #xfffd) (font-spec :family kanji) nil)
    (set-fontset-font nil '(#x10000 . #x10fff) (font-spec :family "Code2001"))
    (set-fontset-font nil '(#x18000 . #x1ffff) (font-spec :family "Unicode Symbols"))
    (set-fontset-font nil '(#x2a700 . #x2fff0) (font-spec :family "HanaMin"))
    ))

(provide 'rotate-theme)