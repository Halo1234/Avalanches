;/*
; * $Author$
; * $Revision$
;**/

*label|

@message_layers count=1

@message_option layer=message0 left=10 top=400 width=780 height=190 margin_left=10 margin_top=10 margin_right=10 margin_bottom=10 opacity=128 color=0x000000 current
@using_mod_message
@log message="�o�͐�� ModMessage �ɕύX���܂��B"

@cr_handling ignore

@show_message layer=message0

*label|
@right_click enabled jump target=*right_click_1
�E�N���b�N�̃e�X�g�ł��B[p][cm]

*right_click_1

*label|
@right_click enabled call target=*right_click_2
�E�N���b�N�T�u���[�`���̃e�X�g�ł��B[p][cm]

@jump target=*next

*right_click_2
�����͉E�N���b�N�T�u���[�`���̒��ł��B[p][cm]
@return

*next|
�e�X�g�I���ł��B


