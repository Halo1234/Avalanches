;/*
; * $Revision$
;**/

*label|

@show_message layer=message0

;@click_skip !enabled
*label|
@fadeinbgm storage=bgm001.ogg time=2000
�a�f�l���Đ����܂����B[p][cm]

*label|
�a�f�l�Đ����ł��B[p][cm]

*label|
@pausebgm
�a�f�l���ꎞ��~���܂����B[p][cm]

*label|
@resumebgm
�a�f�l���ĊJ���܂����B[p][cm]

*label|
@playse buf=0 storage=se001
�r�d���Đ����܂����B[p][cm]

*label|
@playse buf=0 storage=se001 loop
�r�d�����[�v�Đ����܂��B[p][cm]

*label|
@stopse buf=0
�r�d���~���܂��B[p][cm]

*label|
@fadeoutbgm time=2000
�a�f�l���~���܂����B[p][cm]

@hide_message layer=message0

@log message="�e�X�g�I�����܂����B"


