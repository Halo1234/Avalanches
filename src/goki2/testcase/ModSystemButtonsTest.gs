
*label|
; 出力先をModMessageにする
; これをしないとメッセージが表示されません
@using_mod_message

@show_message layer=message0
@wait_show_message layer=message0

@system_button log_left=10 log_top=390 log_width=60 log_height=20 log_caption=履歴
@system_button skip_left=80 skip_top=390 skip_width=60 skip_height=20 skip_caption=スキップ
@system_button auto_left=150 auto_top=390 auto_width=60 auto_height=20 auto_caption=オート
@system_button hidden_left=220 hidden_top=390 hidden_width=60 hidden_height=20 hidden_caption=消去
@system_button system_left=290 system_top=390 system_width=60 system_height=20 system_caption=システム
@system_button save_left=360 save_top=390 save_width=60 save_height=20 save_caption=セーブ
@system_button load_left=430 load_top=390 load_width=60 load_height=20 load_caption=ロード

@system_button_option visible

*label|
システムボタンのテストです。[p][cm]

@hide_message layer=message0
@wait_hide_message layer=message0


