;/*
; * $Author$
; * $Revision$
;**/

*label|

@using_mod_message
@log message="�o�͐�� ModMessage �ɕύX���܂��B"

@cr_handling ignore

@show_message layer=message0

*label|
@rclick enabled jump target=*right_click_1
�E�N���b�N�̃e�X�g�ł��B[p][cm]

*right_click_1

*label|
@rclick enabled call storage=ModRightClickTest target=*right_click_2
�E�N���b�N�T�u���[�`���̃e�X�g�ł��B[p][cm]

@jump target=*next

*right_click_2
�����͉E�N���b�N�T�u���[�`���̒��ł��B[p]
@return

*next|
�e�X�g�I���ł��B[p][cm]


