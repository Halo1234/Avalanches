;/*
; * $Revision$
;**/

*label|

@using_mod_message
@log message="出力先を ModMessage に変更します。"

@cr_handling ignore

@show_message layer=message0

@click_skip !enabled

*label|
@hidden_message
メッセージレイヤのテストです。[p]

*label|
絵文字[graph storage=char character alt=(赤)]のテストです。[p][cm]

*label|
改行のテストです。[r][hact exp=System.inform('hoge')]２行目のテキスト[endhact]です。[p][cm]

*label|
リンクの[locate x=100 y=100][link storage=ModMessageTest target=*next]テスト[endlink]です。
[button graphic=button target=*next2][checkbox caption=hogehogehoge name=f.test][edit caption=hoge name=f.test2 length=100][p]

[commit]

*next

*label|
@locklink
@clickskip enabled

[autowc enabled chars=、。 time=10,50]
自動ウェイトの、テストです。[p]

*label|
@unlocklink
リンクのロックを解除します。[p][cm]

@style linesize=24

*label|
これは、[font face='ＭＳ Ｐ明朝' shadowcolor=0x000000 size=24][indent]インデント[resetfont]のテストです。[r]
正しく表示されていますか？[endindent][p][cm]

*label|
インデント解除します。[p][cm]

*label|
ルビのテストです。[r]
天上[ruby text=ハ]不[ruby text=コ]知[ruby text=ワ]唯[ruby text=レ]我独損[r]
暗[ruby text=ホテル・ラフレシア]い宿[p][cm]

@deffont size=24
@resetfont

*label|
ワードラップのテストです。ワードラップのテストです。ワードラップのテストです。ワードラップのテストです。ワードラップのテストです。[p][cm]

@message_option layout_mode=vertical

*label|
縦書きの[link storage=ModMessageTest target=*next2]テスト[endlink]です。[p][cm]

*next2|
縦中横のテストです。[hch text=12]月[hch text='31-----' expand]日。[r]
改行しますうううううううううううう。[p]

@deffont size=12
@resetfont

*label|
[ruby text=かい]改[ruby text=ぎょう]行のテストです。[r]
[ruby text=かい]改[ruby text=ぎょう]行のテストです。[r]
[ruby text=かい]改[ruby text=ぎょう]行のテスト終了です。[p][cm]

@message_option layout_mode=horizontal

*label|
テスト終了です。[p][cm]

@hide_message layer=message0
@log message="メッセージレイヤ０を消去しました。"


