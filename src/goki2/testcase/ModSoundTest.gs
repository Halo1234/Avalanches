;/*
; * $Revision$
;**/

*label|
; ModSound test.
@load_module name=ModSound
@log message="ModSound ���W���[���ǂݍ��݂ɐ������܂����B"

@add_bgm_buffer type=WAVE
@log message="�a�f�l�o�b�t�@��ǉ����܂����B"

@se_buffers count=1
@log message="���ʉ��o�b�t�@���ЂƂm�ۂ��܂����B"

@show_message layer=message0

*label|
@fadein_bgm storage=bgm001.ogg time=2000
�a�f�l���Đ����܂����B[p][cm]

*label|
@pause_bgm
�a�f�l���ꎞ��~���܂����B[p][cm]

*label|
@resume_bgm
�a�f�l���ĊJ���܂����B[p][cm]

*label|
@play_se buffer=0 storage=se001
�r�d���Đ����܂����B[p][cm]

*label|
@play_se buffer=0 storage=se001 loop
�r�d�����[�v�Đ����܂��B[p][cm]

*label|
@stop_se buffer=0
�r�d���~���܂��B[p][cm]

*label|
@fadeout_bgm time=2000
�a�f�l���~���܂����B[p][cm]

@free_bgm_buffers
@log message="�a�f�l�o�b�t�@���J�����܂����B"

@hide_message layer=message0

@log message="�e�X�g�I�����܂����B"


