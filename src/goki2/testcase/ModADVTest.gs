;/*
; * $Revision$
;**/

@load_module name=ModADV
@log message="ModADV ���W���[���ǂݍ��݂ɐ������܂����B"

@!make_character image=�����G�L��->true,�����G����->false
@!make_character voice=�{�C�X�L��->true,�{�C�X����->false

@make_character name=�n�� actual-viewing-name-string=''
@make_character name=�n�� voice_group=halo �����G�L�� �{�C�X�L��

@!character centerx=��->200,��->400,�E->600,����->300,���E->500,���[->100,�E�[->700
@!character grayscale=�Z�s�A->true rgamma=�Z�s�A->1.5 ggamma=�Z�s�A->1.3
@!character visible=�\��->true,����->false
@!character no_voice=nv->true

@!�n�� /storage=A_<POSE>_<FACE>
@!�n�� face=�\��P->face1
@!�n�� pose=�|�[�Y�P->pose1,�|�[�Y�Q->pose2

@message_option layer=message0 left=10 top=400 width=780 height=190 margin_left=10 margin_top=10 margin_right=10 margin_bottom=10 opacity=128 color=0x000000 current

@cr_handling !ignore

*label|
@using_mod_adv
@�n�� �|�[�Y�P �\��P �\��

[�n��]���b�Z�[�W�̃e�X�g�ł��B

*label|
@�n�� �|�[�Y�Q �\��P

[�n��]�|�[�Y�Q��\�����܂��B

*label|
@�n�� ����

[�n��]�e�X�g�I���ł��B

@not_using_mod_adv


