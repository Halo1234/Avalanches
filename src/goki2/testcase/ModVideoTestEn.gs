
; Set the output destination to ModMessage
; If you do not do this, the message will not be displayed
@using_mod_message

*label|

@show_message layer=message0

*label|
;[cancelskip]
@video left=0 top=0 width=800 height=600 visible
@openvideo storage=sample.wmv
@playvideo
@wv canskip
@stopvideo
@video visible=false

I played the video. [p][cm]

*label|
@videolayer layer=0 page=fore channel=1
@openvideo storage=sample.wmv

@preparevideo
@wp for=prepare
@image layer=0 visible=1 mode=opaque

@playvideo

I played the video in layers. [p][cm]

@wv canskip
@stopvideo
@image layer=0 visible=0 mode=alpha
@clear_image layer=0

@hide_message layer=message0
@wait_hide_message layer=message0


