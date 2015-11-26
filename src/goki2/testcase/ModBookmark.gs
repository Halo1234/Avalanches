;/*
; * $Revision$
;**/

@using_mod_message

@show_message layer=message0

*label|
[input name=f.test prompt=入力してください。 title=入力]

[trace exp=f.test]

[ハロ][emb exp=f.test]入力のテストです。[p][cm]

*label|
@save place=0
@copybookmark from=0 to=1

セーブデータコピーしました。[p][cm]

@hide_message layer=message0


