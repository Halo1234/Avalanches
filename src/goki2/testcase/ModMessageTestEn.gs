
*label|
@open_memory

; Set the output destination to ModMessage
; If you do not do this, the message will not be displayed
@using_mod_message
@log message="Change output destination to ModMessage."

@cr_handling ignore

@!show_message type=vista

@show_message layer=message0 vista
@wait_show_message

;@click_skip !enabled
;@message_option !auto_mode_click_cancel

;[message_option normal_speed=30]

*label|
@history_icon left=18 storage=history_icon_ハロ
This is a [l][history_reline] test for the message layer. [p]

;@hidden_message
;@waitclick

*label|
;[init_history_data]
This is a test of graph [graph storage=char alt=(red)]. [r]
This is a test of graph [graph storage=char character=0 alt=(red)]. [p]

*label|
Please save and check if the emojis are restored. [p][cm]

*label|
[nowait]
This is a line break test. [r][hact exp=System.inform('hoge')]The second line of text is [endhact]. [p][cm]

*label|
;@fadeinbgm storage=bgm001.ogg time=10

[endnowait]
This is[locate x=100 y=100][link storage=ModMessageTest target=*next]a link[endlink]test.
[button graphic=button target=*next][checkbox caption=hogehogehoge name=f.test][edit caption=hoge name=f.test2 length=100][r]
[slider name=window.modules.modSound.bgmBuffers.volume width=100 height=20 min=0 max=100000][p]

[commit]

*next

*label|
@locklink
@clickskip enabled

[autowc enabled chars=,. time=10,50]
This is a test of automatic weight. [p]

*label|
@unlocklink
Unlock links. [p][cm]

@style linesize=24

*label|
[autowc !enabled]
This is a test of [font face='MS PMincho' shadowcolor=0x000000 size=24][indent]indent [resetfont]. [r]
Is it displayed correctly? [endindent][p][cm]

*label|
Remove indentation. [p][cm]

*label|
This is a ruby test. [r]
The heavens [ruby text=ha] no [ruby text=ko] knowledge [ruby text=wa] only [ruby text=re] I am alone [r]
Dark [ruby text="Hotel Rafflesia"] Inn [p] [cm]

@deffont size=24
@resetfont

*label|
This is a word wrap test. This is a word wrap test. This is a word wrap test. This is a word wrap test. This is a word wrap test. [p][cm]

@message_option layout_mode=vertical

*label|
Vertical [link storage=ModMessageTest target=*next2] test [endlink]. [p][cm]

*next2|
This is a horizontal in vertical writing test. [hch text=12] month [hch text='31-----' expand] day. [r]
I'm going to start a new line. [p]

@deffont size=12
@resetfont

*label|
This is a test of the [ruby text=kai] modified [ruby text=gyo] line. [r]
This is a test of the [ruby text=kai] modified [ruby text=gyo] line. [r]
The test for the [ruby text=kai] modified [ruby text=gyo] line is complete. [p][cm]

@message_option layout_mode=horizontal
@deffont size=24
@resetfont

*label|
@cancelskip
The test is over. [p][cm]

@hide_message layer=message0
@wait_hide_message layer=message0
@log message="Message layer 0 has been deleted."

@end_memory


