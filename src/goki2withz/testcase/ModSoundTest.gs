;/*
; * $Revision$
;**/

*label|

@show_message layer=message0

*label|
@fadein_bgm storage=bgm001.ogg time=2000
ＢＧＭを再生しました。[p][cm]

*label|
@pause_bgm
ＢＧＭを一時停止しました。[p][cm]

*label|
@resume_bgm
ＢＧＭを再開しました。[p][cm]

*label|
@play_se buffer=0 storage=se001
ＳＥを再生しました。[p][cm]

*label|
@play_se buffer=0 storage=se001 loop
ＳＥをループ再生します。[p][cm]

*label|
@stop_se buffer=0
ＳＥを停止します。[p][cm]

*label|
@fadeout_bgm time=2000
ＢＧＭを停止しました。[p][cm]

@free_bgm_buffers
@log message="ＢＧＭバッファを開放しました。"

@hide_message layer=message0

@log message="テスト終了しました。"


