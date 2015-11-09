;/*
; * $Revision$
;**/

*label|
; ModMessage test.
@load_module name=ModMessage
@log message="ModMessage モジュール読み込みに成功しました。"

@message_layers count=1

@message_option layer=message0 left=10 top=400 width=780 height=190 margin_left=10 margin_top=10 margin_right=10 margin_bottom=10 opacity=128 color=0x000000 current
@using_mod_message
@log message="出力先を ModMessage に変更します。"

@cr_handling ignore

@line_parameters line_size=24

@show_message layer=message0
@log message="メッセージレイヤ０を表示しました。"

@click_skip !enabeld

*label|
メッセージレイヤのテストです。[p]

*label|
改行のテストです。[r]２行目のテキストです。[p][cm]

*label|
@click_skip enabeld

@auto_wait_ch enabled chars=、。 time=10,50
自動ウェイトの、テストです。[p][cm]

*label|
これは、[font face='ＭＳ Ｐ明朝' shadow_color=0x000000 size=24][indent]インデント[reset_font]のテストです。[r]
正しく表示されていますか？[end_indent][p][cm]

*label|
インデント解除します。[p][cm]

*label|
ルビのテストです。[r]
天上[ruby text=ハ]不[ruby text=コ]知[ruby text=ワ]唯[ruby text=レ]我独損[r]
暗[ruby text=ホテル・ラフレシア]い宿[p][cm]

@default_font_parameters size=24
@reset_font

*label|
ワードラップのテストです。ワードラップのテストです。ワードラップのテストです。ワードラップのテストです。ワードラップのテストです。[p][cm]

@message_option layout_mode=vertical

*label|
縦書きのテストです。[p][cm]

@default_font_parameters size=12
@reset_font

*label|
[ruby text=かい]改[ruby text=ぎょう]行のテストです。[r]
[ruby text=かい]改[ruby text=ぎょう]行のテストです。[r]
[ruby text=かい]改[ruby text=ぎょう]行のテスト終了です。[p][cm]

@message_option layout_mode=horizontal

*label|
テスト終了です。[p][cm]

@hide_message layer=message0
@log message="メッセージレイヤ０を消去しました。"


