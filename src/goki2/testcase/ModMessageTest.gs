;/*
; * $Revision$
;**/

*label|

@using_mod_message
@log message="�o�͐�� ModMessage �ɕύX���܂��B"

@cr_handling ignore

@show_message layer=message0

;@click_skip !enabled

*label|
@hidden_message
���b�Z�[�W���C���̃e�X�g�ł��B[p]

*label|
�G����[graph storage=char character alt=(��)]�̃e�X�g�ł��B[p][cm]

*label|
���s�̃e�X�g�ł��B[r][hact exp=System.inform('hoge')]�Q�s�ڂ̃e�L�X�g[endhact]�ł��B[p][cm]

*label|
�����N��[locate x=100 y=100][link storage=ModMessageTest target=*next]�e�X�g[endlink]�ł��B
[button graphic=button target=*next2][checkbox caption=hogehogehoge name=f.test][edit caption=hoge name=f.test2 length=100][p]

[commit]

*next

*label|
@locklink
@clickskip enabled

[autowc enabled chars=�A�B time=10,50]
�����E�F�C�g�́A�e�X�g�ł��B[p]

*label|
@unlocklink
�����N�̃��b�N���������܂��B[p][cm]

@style linesize=24

*label|
����́A[font face='�l�r �o����' shadowcolor=0x000000 size=24][indent]�C���f���g[resetfont]�̃e�X�g�ł��B[r]
�������\������Ă��܂����H[endindent][p][cm]

*label|
�C���f���g�������܂��B[p][cm]

*label|
���r�̃e�X�g�ł��B[r]
�V��[ruby text=�n]�s[ruby text=�R]�m[ruby text=��]�B[ruby text=��]��Ƒ�[r]
��[ruby text=�z�e���E���t���V�A]���h[p][cm]

@deffont size=24
@resetfont

*label|
���[�h���b�v�̃e�X�g�ł��B���[�h���b�v�̃e�X�g�ł��B���[�h���b�v�̃e�X�g�ł��B���[�h���b�v�̃e�X�g�ł��B���[�h���b�v�̃e�X�g�ł��B[p][cm]

@message_option layout_mode=vertical

*label|
�c������[link storage=ModMessageTest target=*next2]�e�X�g[endlink]�ł��B[p][cm]

*next2|
�c�����̃e�X�g�ł��B[hch text=12]��[hch text='31-----' expand]���B[r]
���s���܂��������������������������B[p]

@deffont size=12
@resetfont

*label|
[ruby text=����]��[ruby text=���傤]�s�̃e�X�g�ł��B[r]
[ruby text=����]��[ruby text=���傤]�s�̃e�X�g�ł��B[r]
[ruby text=����]��[ruby text=���傤]�s�̃e�X�g�I���ł��B[p][cm]

@message_option layout_mode=horizontal

*label|
�e�X�g�I���ł��B[p][cm]

@hide_message layer=message0
@log message="���b�Z�[�W���C���O���������܂����B"


