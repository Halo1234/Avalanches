
; Set the output destination to ModMessage
; If you do not do this, the message will not be displayed
@using_mod_message

;Display message layer 0
@show_message layer=message0

*label|
; Save the state to go back one step
[record]

; Display the execution results of f.test in the log
[trace exp=f.test]

; Embed variable value
[halo][emb exp=f.test]This is an input test. [p][cm]

*label|
[record]
@save place=0
@copy_bookmark source=0 destination=1

I copied the save data. [p][cm]

*label|
@erase_bookmark number=1
I deleted my save data. [p][cm]

; hide message layer
@hide_message layer=message0
@wait_hide_message layer=message0


