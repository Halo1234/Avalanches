
; 出力先をModMessageにする
; これをしないとメッセージが表示されません
@using_mod_message

; メッセージレイヤ０を表示する
@show_message layer=message0

*label|
; ひとつ前に戻る用に状態を保存する
[record]

; ログにf.testの実行結果を表示する
[trace exp=f.test]

; 変数値埋め込み
[ハロ][emb exp=f.test]入力のテストです。[p][cm]

*label|
[record]
@save place=0
@copy_bookmark source=0 destination=1

セーブデータコピーしました。[p][cm]

*label|
@erase_bookmark number=1
セーブデータ削除しました。[p][cm]

; メッセージレイヤを非表示にする
@hide_message layer=message0
;@wait_hide_message layer=message0



