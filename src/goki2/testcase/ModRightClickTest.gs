;/*
; * $Author$
; * $Revision$
;**/

*label|

@using_mod_message
@log message="出力先を ModMessage に変更します。"

@cr_handling ignore

@show_message layer=message0

*label|
@rclick enabled jump target=*right_click_1
右クリックのテストです。[p][cm]

*right_click_1

*label|
@rclick enabled call storage=ModRightClickTest target=*right_click_2
右クリックサブルーチンのテストです。[p][cm]

@jump target=*next

*right_click_2
ここは右クリックサブルーチンの中です。[p]
@return

*next|
テスト終了です。[p][cm]


