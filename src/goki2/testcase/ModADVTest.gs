;/*
; * $Revision$
;**/

@load_module name=ModADV
@log message="ModADV モジュール読み込みに成功しました。"

@!make_character image=立ち絵有り->true,立ち絵無し->false
@!make_character voice=ボイス有り->true,ボイス無し->false

@make_character name=地文 actual-viewing-name-string=''
@make_character name=ハロ voice_group=halo 立ち絵有り ボイス有り

@!character centerx=左->200,中->400,右->600,中左->300,中右->500,左端->100,右端->700
@!character grayscale=セピア->true rgamma=セピア->1.5 ggamma=セピア->1.3
@!character visible=表示->true,消去->false
@!character no_voice=nv->true

@!ハロ /storage=A_<POSE>_<FACE>
@!ハロ face=表情１->face1
@!ハロ pose=ポーズ１->pose1,ポーズ２->pose2

@message_option layer=message0 left=10 top=400 width=780 height=190 margin_left=10 margin_top=10 margin_right=10 margin_bottom=10 opacity=128 color=0x000000 current

@cr_handling !ignore

*label|
@using_mod_adv
@ハロ ポーズ１ 表情１ 表示

[ハロ]メッセージのテストです。

*label|
@ハロ ポーズ２ 表情１

[ハロ]ポーズ２を表示します。

*label|
@ハロ 消去

[ハロ]テスト終了です。

@not_using_mod_adv


