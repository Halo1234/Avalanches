
*label|

; Set the output destination to ModMessage
; If you do not do this, the message will not be displayed
@using_mod_message
@log message="Change output destination to ModMessage."

; Do not treat newline code as r tag
@cr_handling ignore

@show_message layer=message0
@wait_show_message
;@show_message layer=message1
;@wait_show_message layer=message1

*label|
It's a choice test.
;[copy_message_layer source_layer=message0 destination_layer=message1]
[p][cm]

*label|
@select_option base_left=320 base_top=100 base_top_step=40
@select_option button_width=160 button_height=30

I have set the options. [p][cm]

*label|
@select caption="choice 1" target=*select1
@select caption="choice 2" target=*select2

I created a choice. [p][cm]

*label|
Test whether saving and loading is done correctly. [p][cm]

*label|
@hide_message layer=message0
@wait_hide_message

@select show
@s

*select1|
@show_message layer=message0
@wait_show_message

I chose option 1. [p][cm]

@jump target=*end

*select2|
@show_message layer=message0
@wait_show_message

I chose option 2. [p][cm]

*end|
The test of options is complete. [p][cm]

@hide_message layer=message0
@wait_hide_message

