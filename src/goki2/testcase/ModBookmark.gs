
@using_mod_message

@show_message layer=message0

*label|
[record]

[trace exp=f.test]

[ハロ][emb exp=f.test]入力のテストです。[p][cm]

*label|
[record]
@save place=0
@copybookmark from=0 to=1

セーブデータコピーしました。[p][cm]

*label|
@erasebookmark place=1
セーブデータ削除しました。[p][cm]

@hide_message layer=message0


