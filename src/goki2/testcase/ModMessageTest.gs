;/*
; * $Revision$
;**/

*label|
; ModMessage test.
@load_module name=ModMessage
@log message="ModMessage ���W���[���ǂݍ��݂ɐ������܂����B"

@message_layers count=1

@message_option layer=message0 left=10 top=400 width=780 height=190 margin_left=10 margin_top=10 margin_right=10 margin_bottom=10 opacity=128 color=0x000000 current
@using_mod_message
@log message="�o�͐�� ModMessage �ɕύX���܂��B"

@cr_handling ignore

@line_parameters line_size=24

@show_message layer=message0
@log message="���b�Z�[�W���C���O��\�����܂����B"

@click_skip !enabeld

*label|
���b�Z�[�W���C���̃e�X�g�ł��B[p]

*label|
���s�̃e�X�g�ł��B[r]�Q�s�ڂ̃e�L�X�g�ł��B[p][cm]

*label|
@click_skip enabeld

@auto_wait_ch enabled chars=�A�B time=10,50
�����E�F�C�g�́A�e�X�g�ł��B[p][cm]

*label|
����́A[font face='�l�r �o����' shadow_color=0x000000 size=24][indent]�C���f���g[reset_font]�̃e�X�g�ł��B[r]
�������\������Ă��܂����H[end_indent][p][cm]

*label|
�C���f���g�������܂��B[p][cm]

*label|
���r�̃e�X�g�ł��B[r]
�V��[ruby text=�n]�s[ruby text=�R]�m[ruby text=��]�B[ruby text=��]��Ƒ�[r]
��[ruby text=�z�e���E���t���V�A]���h[p][cm]

@default_font_parameters size=24
@reset_font

*label|
���[�h���b�v�̃e�X�g�ł��B���[�h���b�v�̃e�X�g�ł��B���[�h���b�v�̃e�X�g�ł��B���[�h���b�v�̃e�X�g�ł��B���[�h���b�v�̃e�X�g�ł��B[p][cm]

@message_option layout_mode=vertical

*label|
�c�����̃e�X�g�ł��B[p][cm]

@default_font_parameters size=12
@reset_font

*label|
[ruby text=����]��[ruby text=���傤]�s�̃e�X�g�ł��B[r]
[ruby text=����]��[ruby text=���傤]�s�̃e�X�g�ł��B[r]
[ruby text=����]��[ruby text=���傤]�s�̃e�X�g�I���ł��B[p][cm]

@message_option layout_mode=horizontal

*label|
�e�X�g�I���ł��B[p][cm]

@hide_message layer=message0
@log message="���b�Z�[�W���C���O���������܂����B"


