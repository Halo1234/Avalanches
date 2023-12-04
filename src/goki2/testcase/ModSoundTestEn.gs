; Set the output destination to ModMessage
; If you do not do this, the message will not be displayed
@using_mod_message

*label|

@show_message layer=message0

*label|
@fadeinbgm storage=bgm001.ogg time=2000
BGM was played. [p][cm]

*label|
BGM is playing. [p][cm]

*label|
@pausebgm
BGM has been temporarily stopped. [p][cm]

*label|
@resumebgm
BGM has resumed. [p][cm]

*label|
@playse buf=0 storage=se001
I played SE. [p][cm]

*label|
@playse buf=0 storage=se001 loop
Play SE in a loop. [p][cm]

*label|
@fadeoutse time=4000 buf=0
@wf canskip buf=0
Fade out SE. [p][cm]

*label|
@fadeoutbgm time=2000
BGM has been stopped. [p][cm]

@hide_message layer=message0
@wait_hide_message layer=message0

@clickskip enabled


