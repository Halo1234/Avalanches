;/*
; * $Revision$
;**/

@message_option layer=message0 left=10 top=400 width=780 height=190 margin_left=10 margin_top=10 margin_right=10 margin_bottom=10 opacity=128 color=0x000000 current
@using_mod_message

@show_message layer=message0

*label|
@input name=f.test prompt=入力してください。 title=入力

@trace exp=f.test

@save place=0

[ハロ][emb exp=f.test]入力のテストです。[p][cm]

*label|
@copy_bookmark source=0 destination=1

セーブデータコピーしました。[p][cm]

@hide_message layer=message0


