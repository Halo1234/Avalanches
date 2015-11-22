;/*
; * $Author$
; * $Revision$
;**/

*label|

@message_layers count=1

@history_option storage=HistoryBack margin_left=10 margin_top=10 margin_right=10 margin_bottom=10
@message_option layer=message0 left=10 top=400 width=780 height=190 margin_left=20 margin_top=20 margin_right=20 margin_bottom=20 opacity=128 color=0x000000 shadow_color=0xFFFF0000 current
@using_mod_message
@log message="出力先を ModMessage に変更します。"

@cr_handling ignore

@show_message layer=message0

*label|
@right_click enabled jump target=*right_click_1
右クリックのテストです。[p][cm]

*right_click_1

*label|
@right_click enabled call target=*right_click_2
右クリックサブルーチンのテストです。[p][cm]

@jump target=*next

*right_click_2
ここは右クリックサブルーチンの中です。[p]
@return

*next|
テスト終了です。[p][cm]


