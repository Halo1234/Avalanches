
; 出力先をModMessageにする
; これをしないとメッセージが表示されません
@using_mod_message

*label|

@show_message layer=message0

;*label|
;@play_bgm buffer=1 storage=bgm001.mid
;MIDI演奏のテスト。[p][cm]

;*label|
;@stop_bgm buffer=1
;MIDI演奏停止のテスト。[p][cm]

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
@wf canskip buf=0
ＳＥをフェードアウトします。[p][cm]

*label|
@fadeoutbgm time=2000
ＢＧＭを停止しました。[p][cm]

@hide_message layer=message0
@wait_hide_message layer=message0

@clickskip enabled


