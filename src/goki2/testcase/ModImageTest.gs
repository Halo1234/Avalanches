;/*
; * $Revision: 278 $
;**/

*label|
; ModImage test.
@load_module name=ModImage
@log message="ModImage モジュール読み込みに成功しました。"

@cv_layers count=1

@show_message layer=message0

*label|
@load_image storage=sampleA page=fore
@load_image storage=sampleB page=back

@transition time=2000
@wait_transition
@log message="トランジションのテストに成功しました。"

トランジションのテストに成功しました。[p][cm]

*label|
@load_image storage=sampleA page=back
@assign_to_mirror
@log message="背景コピーのテスト"

@load_image layer=cv_layer0 center_x=400 center_y=300 page=back storage=ImageSample visible

背景コピーのテストに成功しました。[p][cm]

*label|
@transition time=1000
@wait_transition
@log message="子レイヤ読み込みに成功しました。"

子レイヤの読み込みに成功しました。[p][cm]

*label|
@start_animation layer=cv_layer0
@log message="子レイヤでアニメーションを開始しました。"

@stop_animation layer=cv_layer0 index=0
@wait_animation layer=cv_layer0 index=0
@assign_image layer=cv_layer0
@log message="子レイヤのアニメーションを停止しました。"

子レイヤのアニメーションテストに成功しました。[p][cm]

*label|
@clear_image page=back

@transition time=2000
@wait_transition
@log message="背景がクリアされていれば成功です。"

背景がクリアされていれば成功です。[p][cm]

*label|
@clear_image layer=cv_layer0 page=back
@transition time=1000
@wait_transition
@log message="子レイヤクリアに成功しました。"

子レイヤがクリアされていれば成功です。[p][cm]


