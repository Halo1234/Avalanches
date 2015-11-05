;/*
; * $Revision$
;**/

*label|
; ModVideo test.
@load_module name=ModVideo
@log message="ModVideo モジュール読み込みに成功しました。"

@show_message layer=message0

@video_buffers count=1

*label|
@video left=0 top=0 width=800 height=600 visible=true
@open_video storage=sample.wmv
@play_video
@wait_video
@stop_video
@video visible=false

ビデオを再生しました。[p][cm]

@hide_message layer=message0

@log message="テスト終了しました。"


