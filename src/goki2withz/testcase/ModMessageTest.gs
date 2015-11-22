;/*
; * $Revision$
;**/

*label|

@message_layers count=1

@message_option layer=message0 left=10 top=400 width=780 height=190 margin_left=20 margin_top=20 margin_right=20 margin_bottom=20 opacity=128 color=0x000000 current
@using_mod_message
@log message="出力先を ModMessage に変更します。"

@cr_handling ignore

@show_message layer=message0
@log message="メッセージレイヤ０を表示しました。"

@click_skip !enabled

*label|
@hidden_message
メッセージレイヤのテストです。[p]

*label|
絵文字[graph storage=char character alt=(赤)]のテストです。[p][cm]

*label|
改行のテストです。[r][history_action exp=System.inform('hoge')]２行目のテキスト[end_history_action]です。[p][cm]

*label|
リンクの[locate x=100 y=100][link storage=ModMessageTest target=*next]テスト[end_link]です。
[button graphic=button target=*next2][checkbox caption=hogehogehoge name=f.test][edit caption=hoge name=f.test2 length=100][p]

[commit]

*next

*label|
@lock_link
@click_skip enabled

@auto_wait_ch enabled chars=、。 time=10,50
自動ウェイトの、テストです。[p]

*label|
@unlock_link
リンクのロックを解除します。[p][cm]

@line_parameters line_size=24

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
縦書きの[link storage=ModMessageTest target=*next2]テスト[end_link]です。[p][cm]

*next2|
縦中横のテストです。[horizontal_ch text=12]月[horizontal_ch text='31-----' expand]日。[r]
改行しますうううううううううううう。[p]

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


