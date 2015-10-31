;/*
; * $Revision$
;**/

@load_module name=ModADV
@log message="ModADV モジュール読み込みに成功しました。"

@make_character name=ハロ
@!ハロ

@message_option layer=message0 left=10 top=400 width=780 height=190 margin_left=10 margin_top=10 margin_right=10 margin_bottom=10 opacity=128 color=0x000000 current

@cr_handling !ignore

*label|
@using_mod_adv

[ハロ]メッセージのテストです。

*label|
[ハロ]テスト終了です。

@not_using_mod_adv


