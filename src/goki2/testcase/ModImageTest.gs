
*label|
@using_mod_message

@show_message layer=message0

*label|
@image storage=sampleB page=back

@trans time=2000
@wt
@log message="トランジションのテストに成功しました。"

トランジションのテストに成功しました。[p][cm]

*label|
@image storage=sampleA page=back
@assign_to_mirror
@log message="背景コピーのテスト"

背景コピーのテストに成功しました。[p][cm]

*label|
@quake hmax=10 vmax=10 time=1000
@wq

揺れます。[p][cm]

*label|
@image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible

@trans time=1000
@wt

子レイヤの読み込みに成功しました。[p][cm]

*label|
@image layer=0 center_x=400 center_y=300 grayscale rgamma=1.5 ggamma=1.3 page=back storage=ImageSample visible

@trans time=1000
@wt

子レイヤの色補正のテストです。[p][cm]

*label|
@image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible

@trans time=1000
@wt

@pimage layer=0 page=fore storage=CellImageSample dx=100 dy=100

子レイヤの部分画像読み込みのテストです。[p][cm]

*label|
@ptext layer=0 x=0 y=0 text=hogehoge color=0xFFFF00
子レイヤの文字描画のテストです。[p][cm]

*label|
テストを続けます。[p][cm]

*label|
;@clickskip !enabled

@move layer=0 path="(10, 10, 255), (200, 200, 255)" time=5000
@wm layer=0

子レイヤの移動を行います。[p][cm]

*label|
[cancelskip]

@layer_move layer=0 x=left y=top angle=0 position=0.0 clear children transform
@layer_move layer=0 x=0 y=0 angle=360 scale=1.0 position=0.5
@layer_move layer=0 x=200 y=200 scale=2.0 position=1.0
@layer_move layer=0 time=5000 start
@layopt layer=0 left=200 top=200
@wm layer=0

子レイヤの移動を行います。[p][cm]

*label|
@clickskip enabled

@animstart layer=0

@animstop layer=0 seg=0
@wa layer=0 seg=0
@backlay layer=0

子レイヤのアニメーションテストに成功しました。[p][cm]

*label|
@freeimage page=back

@trans time=2000
@wt

背景がクリアされていれば成功です。[p][cm]

*label|
@freeimage layer=0 page=back
@trans time=1000
@wt

子レイヤがクリアされていれば成功です。[p][cm]

*label|
@image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible
@trans time=1000
@wt

もう一度子レイヤを読み込みます。[p][cm]

*label|
@animstart layer=0

@animstop layer=0 seg=0
@wa layer=0 seg=0
@backlay layer=0

子レイヤのアニメーションテストに成功しました。[p][cm]

*label|
@freeimage layer=0 page=back
@trans time=1000
@wt

子レイヤがクリアされていれば成功です。[p][cm]


