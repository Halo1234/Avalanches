;/*
; * $Revision$
;**/

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

�r�f�I���Đ����܂����B[p][cm]

*label|
@videolayer layer=0 page=fore channel=1
@openvideo storage=sample.wmv

@preparevideo
@wp for=prepare
@image layer=0 visible=1 mode=opaque

@playvideo

���C���Ńr�f�I���Đ����܂����B[p][cm]

@wv canskip
@stopvideo

@hide_message layer=message0


