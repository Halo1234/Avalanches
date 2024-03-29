
*label|

; Set the output destination to ModMessage
; If you do not do this, the message will not be displayed
@using_mod_message
@log message="Change output destination to ModMessage."

; Do not treat newline code as r tag
@cr_handling ignore

@show_message layer=message0

*label|
@rclick enabled jump storage=ModRightClickTestEn target=*right_click_1
Right click test. [p][cm]

*right_click_1

*label|
@rclick enabled call storage=ModRightClickTestEn target=*right_click_2
This is a test of the right click subroutine. [p][cm]

@jump target=*next

*right_click_2
This is inside the right-click subroutine. [p]
@return

*next|
The test is over. [p][cm]

@rclick !call !jump
@hide_message layer=message0
@wait_hide_message


