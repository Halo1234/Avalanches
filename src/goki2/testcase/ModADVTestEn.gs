
; Set the output destination to ModADV
; If you don't do this, the standing picture may not be displayed.
@using_mod_adv

; Treat new line code as r tag
@cr_handling !ignore

*label|
@cancelskip
;@show_current_message_layer
;@wait_show_current_message

;Display standing picture
@halo pose1 face1 c v

;@cursor default_cursor=&crCross

[halo] This is a message test.
[ruby text=Kaigyo] Line break 1.
[ruby text=Kaigyo] Line break 2.
[ruby text=Kaigyo] Line break 3.
[ruby text=Kaigyo] Line break 4.
[ruby text=Kaigyo] Line break 5.
[ruby text=Kaigyo] Line break 6.
[ruby text=Kaigyo] Line break 7.
[ruby text=Kaigyo] Line break 8.
[ruby text=Kaigyo] Line break 9.
[ruby text=Kaigyo] Line break 10.
[ruby text=Kaigyo] Line break 11.
[ruby text=Kaigyo] Line break 12.
[ruby text=Kaigyo] Line break 13.
[ruby text=Kaigyo] Line break 14.

*label|
[halo] Halo's lines.

*label|
[halosuke]halosuke's lines.

*label|
@halo pose2 face1

[halo no_voice]Display pose 2.
;@cancelskip
Start a new line.
Start a new line.

*label|
; Specify the time zone
; See /src/goki2/system/config.gs for details
@evening
@halo pose1 face1

[halo] Fill history.

*label|
[cancelautomode]
@night
@halo pose2 face1

[halo][hact exp="System.inform('test');"]Fill history2. [endhact]

*label|
@morning
@black

[halo]Fill history3.

*label|
@white
[halo]Fill history4.

*label|
@red
[halo]Fill history5.

*label|
[halo]Fill history6.

*label|
[halo]Fill history7.

*label|
[halo]Fill history8.

*label|
[cancel_skip]
[halo]Fill history9.

*label|
[halo]Fill history10.

*label|
@black
@halo inv

[halo] Test completed.

@hide_current_message_layer
@wait_hide_current_message
; Restore output destination
@not_using_mod_adv


