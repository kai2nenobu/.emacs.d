;;; ●るびきちEmacs●画面を彩るテキストプロパティとオーバーレイ のサンプル

(progn  ; 複数の式をまとめる
  ;; *test*バッファを新規作成
  (switch-to-buffer (generate-new-buffer "*test*"))
  (insert (propertize "test" 'face 'underline 'a 1)))

(progn
  (switch-to-buffer (generate-new-buffer "*test*"))
  (insert "test2")
  (put-text-property 1 2 'face 'underline)
  (add-text-properties 3 4 '(face underline))
  (set-text-properties 5 6 '(face underline)))


(with-temp-buffer ; 一時バッファを用意し、実行後に削除する
  (insert "Foobarbaz")
  ;; バッファ全体のfaceをhighlightにする
  (put-text-property (point-min) (point-max) 'face 'highlight)
  ;; 1文字目にcapital属性をtに設定する
  (put-text-property 1 2 'capital t)

  ;; 2文字目のface属性の値は？
  (get-char-property 2 'face) ; => highlight
  ;; 1文字目の全テキストプロパティは？
  (text-properties-at 1)      ; => (capital t face highlight)
  )

(let ((properties '(face underline)))
  (switch-to-buffer (generate-new-buffer "*test*"))
  (insert "test3")
  ;; testにアンダーラインをつける
  (add-text-properties 1 5 properties)
  (read-key-sequence "続けるにはキーを押してください")
  ;; tesのアンダーラインを消す
  (remove-text-properties 1 4 properties)
  (read-key-sequence "続けるにはキーを押してください")
  ;; tのテキストプロパティすべてを削除する
  (set-text-properties 4 5 nil)
  )


(progn
  (switch-to-buffer (generate-new-buffer "*test*"))
  (insert "test")
  (let ((o (make-overlay (point-min) (point-max))))
    ;; face属性を設定する
    (overlay-put o 'face 'underline)
    (message "face = %s" (overlay-get o 'face))
    (read-key-sequence "続けるにはキーを押してください")
    ;; オーバーレイを削除する
    (delete-overlay o)
    (read-key-sequence "続けるにはキーを押してください")
    ;; オーバーレイを再配置する
    (move-overlay o 1 2)))

(with-temp-buffer
  (insert "aiueo")
  (let ((o (make-overlay 1 3)))
    (overlay-put o 'foo 1)
    (overlay-put o 'bar 2)
    (overlay-buffer o)     ; => #<buffer  *temp*>
    (overlay-start o)      ; => 1
    (overlay-end o)        ; => 3
    (overlay-properties o) ; => (bar 2 foo 1)
))

(with-current-buffer (get-buffer-create "*property-test*")
  (erase-buffer)
  (insert "# start\n"
          (propertize "* header1\n" 'header t)
          "body1-1\nbody1-2\n"
          (propertize "* header2\n" 'header t)
          "body2-1\nbody2-2\n"
          (propertize "* header3\n" 'header t)
          "body3-1\nbody3-2\n"
          ))

(let ()
  (switch-to-buffer "*property-test*")
  (goto-char (point-min))

  ;; 現在位置からheaderを探す
  (goto-char (next-single-property-change (point) 'header))
  (read-key-sequence "続けるにはキーを押してください")
  (forward-line 1)     ;headerじゃない行へ移動
  (goto-char (next-single-property-change (point) 'header))
  (read-key-sequence "続けるにはキーを押してください")
  (forward-line 1)
  (goto-char (next-single-property-change (point) 'header))
  (read-key-sequence "続けるにはキーを押してください")
  ;; 逆方向
  (goto-char (previous-single-property-change (point) 'header))
  (goto-char (previous-single-property-change (point) 'header))
  )

(require 'cl)  ; loopマクロを使うので
;; 一時的に*property-test*バッファをカレントにする
(with-current-buffer "*property-test*"
  (loop ;; バッファ先頭から探索する
        with pos = (point-min)
        ;; headerプロパティの値が変化する位置を求める
        for next = (next-single-property-change pos 'header)
        ;; headerプロパティの値を求める
        for val  = (and next (get-text-property next 'header))
        while next                      ; 次のヘッダがある限り
        if val          ; headerプロパティが設定されているなら
        ;; collectは各要素を集めたリストを作成する
        collect (save-excursion         ; その行の内容を得る
                  (goto-char next)
                  (buffer-substring-no-properties
                   (point-at-bol) (point-at-eol)))
        do (setq pos next)            ; 探索開始位置を再設定する
        ))    ; => ("* header1" "* header2" "* header3")


