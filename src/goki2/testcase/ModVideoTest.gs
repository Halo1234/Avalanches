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
@video left=0 top=0 width=800 height=600 visible
@open_video storage=sample.wmv
@play_video
@wait_video
@stop_video
@video visible=false
@close_video

ビデオを再生しました。[p][cm]

*label|
@set_video_layer layer=base page=fore channel=1
@open_video storage=sample.wmv
@prepare_video
@wait_period_event for=prepare
@play_video

レイヤでビデオを再生しました。[p][cm]

@wait_video
@stop_video
@close_video

@hide_message layer=message0

@log message="テスト終了しました。"


