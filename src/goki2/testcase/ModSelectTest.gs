
*label|

; 出力先をModMessageにする
; これをしないとメッセージが表示されません
@using_mod_message
@log message="出力先を ModMessage に変更します。"

; 改行コードをrタグとして扱わない
@cr_handling ignore

@show_message layer=message0
@wait_show_message
;@show_message layer=message1
;@wait_show_message layer=message1

*label|
選択肢のテストです。
;[copy_message_layer source_layer=message0 destination_layer=message1]
[p][cm]

*label|
@select_option base_left=320 base_top=100 base_top_step=40
@select_option button_width=160 button_height=30

選択肢の設定を行いました。[p][cm]

*label|
@select caption=選択肢１ target=*select1
@select caption=選択肢２ target=*select2

選択肢を作成しました。[p][cm]

*label|
セーブロードが正しく行われるかテスト。[p][cm]

*label|
@hide_message layer=message0
@wait_hide_message

@select show
@s

*select1|
@show_message layer=message0
@wait_show_message

選択肢１を選択しました。[p][cm]

@jump target=*end

*select2|
@show_message layer=message0
@wait_show_message

選択肢２を選択しました。[p][cm]

*end|
選択肢のテスト終了です。[p][cm]

@hide_message layer=message0
@wait_hide_message

