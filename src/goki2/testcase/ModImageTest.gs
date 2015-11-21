;/*
; * $Revision: 278 $
;**/

*label|

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

@load_image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible

背景コピーのテストに成功しました。[p][cm]

*label|
@shake horizontal_max=10 vertical_max=10 time=1000
@wait_shake

揺れます。[p][cm]

*label|
@transition time=1000
@wait_transition
@log message="子レイヤ読み込みに成功しました。"

@click_skip !enabled

子レイヤの読み込みに成功しました。[p][cm]

*label|
@move layer=0 path="(10, 10, 255), (500, 500, 255)" time=5000
@wait_move layer=0

子レイヤの移動を行います。[p][cm]

*label|
@click_skip enabled

@start_animation layer=0
@log message="子レイヤでアニメーションを開始しました。"

@stop_animation layer=0 index=0
@wait_animation layer=0 index=0
@assign_image layer=0
@log message="子レイヤのアニメーションを停止しました。"

子レイヤのアニメーションテストに成功しました。[p][cm]

*label|
@clear_image page=back

@transition time=2000
@wait_transition
@log message="背景がクリアされていれば成功です。"

背景がクリアされていれば成功です。[p][cm]

*label|
@clear_image layer=0 page=back
@transition time=1000
@wait_transition
@log message="子レイヤクリアに成功しました。"

子レイヤがクリアされていれば成功です。[p][cm]


