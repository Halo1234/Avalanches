;/*
; * $Revision$
;**/

*label|

@show_message layer=message0

*label|
@fadeinbgm storage=bgm001.ogg time=2000
ＢＧＭを再生しました。[p][cm]

*label|
ＢＧＭ再生中です。[p][cm]

*label|
@pausebgm
ＢＧＭを一時停止しました。[p][cm]

*label|
@resumebgm
ＢＧＭを再開しました。[p][cm]

*label|
@playse buf=0 storage=se001
ＳＥを再生しました。[p][cm]

*label|
@playse buf=0 storage=se001 loop
ＳＥをループ再生します。[p][cm]

*label|
@fadeoutse time=4000 buf=0
@wf buf=0
ＳＥをフェードアウトします。[p][cm]

*label|
@fadeoutbgm time=2000
ＢＧＭを停止しました。[p][cm]

@hide_message layer=message0

@clickskip enabled


