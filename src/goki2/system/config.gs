;/*
; * $Revision: 288 $
;**/


; ���X�N���v�g�L���[
;
; storage: �ǉ��������X�N���v�g�t�@�C�����ł��B
;
@que storage=testcase


; �����s�̈�����
;
; ignore: ���s�R�[�h�� r �^�O�Ƃ��Ĉ������ǂ���
@cr_handling ignore


; ���E�C���h�E�̐ݒ�
;
;                caption: �E�C���h�E�̃^�C�g���o�[�ɕ\�����镶����ł��B
;                  width: �E�C���h�E�̕��ł��B�i���m�ɂ̓N���C�A���g�̈�̕��ł��j
;                 height: �E�C���h�E�̍����ł��B�i���m�ɂ̓N���C�A���g�̈�̍����ł��j
; fix-position-to-center: �w�肷��ƃE�C���h�E�����ʒu���f�X�N�g�b�v�����ɐݒ肳��܂��B
;              alt-enter: �w�肷��� Alt+Enter �ŃX�N���[�����[�h��؂�ւ��鎖���ł���悤�ɂȂ�܂��B
;                visible: �w�肷��ƃE�C���h�E��\�����܂��B
;
@window width=800 height=600 fix_position_to_center alt_enter


; ���������E�F�C�g
@wait time=400 !skip !click


; ���e���W���[���ݒ�
;
; �ǂݍ��񂾃��W���[���̐ݒ肪�K�v�ł���΂����ōs���Ă��������B
; ���W���[���̐ݒ�ɂ��Ă͊e���W���[���̐������Q�Ƃ��Ă��������B
;
; �R�R����

; �O�i���C���̐�
@cv_layers count=1

; ���b�Z�[�W���C���̐�
@message_layers count=1

; ���ʉ��o�b�t�@�̐�
@se_buffers count=1

; �{�C�X�o�b�t�@�̐�
@voice_buffers count=1

; �r�f�I�o�b�t�@�̐�
@video_buffers count=1

; ���b�Z�[�W����ݒ�
@history_option storage=HistoryBack margin_left=10 margin_top=10 margin_right=10 margin_bottom=10

; ���b�Z�[�W���C���ݒ�
@message_option layer=message0 left=10 top=400 width=780 height=190 margin_left=10 margin_top=10 margin_right=10 margin_bottom=10 opacity=128 color=0x000000 shadow_color=0xFFFF0000 current

; BGM�o�b�t�@�ǉ�
@add_bgm_buffer type=WAVE

; �L�����N�^�[��`
;
; �^�O���� ! �Ŏn�܂�^�O�̓^�O�̐ݒ���s������ȃ^�O�ɂȂ�܂��B
; ����͂��ׂẴ^�O�ɑ΂��ėL���Ȑݒ�ł��B
;
; ������=���O->�l �̌`���Œu�����s�������ł��܂��B
; ���̎w��̓^�O�̑������Ɂu���O�v�����ꂽ���� ������=�l �ɒu������܂��B
;
; ��F
;  @!make_character image=�����G�L��->true
;   ^ ! �}�[�N���u�L��v���ɒ���
;  ;
;  ; ����� image=true �ɒu������܂��B
;  @make_character name=�n�� �����G�L��
;   ^ ! �}�[�N���u�����v���ɒ���
;
; ����ɒu���̓J���}�ŋ�؂��ĕ��������Ɏw�肷�鎖���ł��܂��B
;
; ��F
;  @!make_character image=�����G�L��->true,�����G����->true
;
; /�Ŏn�܂鑮���ɂ̓p�^�[����ݒ�ł��܂��B
; <VALUE> �ň͂܂ꂽ�l�͂��̑����l�Œu������܂��B
; �܂��p�^�[�����̂��ׂĂ̒l���w�肳��Ă��Ȃ�����p�^�[���͐�������܂���B
;
; ��F
;  @!�n�� /storage=A_<POSE>_<FACE>
;         ^ / ���u�L��v���ɒ���
;  ;
;  ; ����� storage=A_�|�[�Y�P_�\��P �ɒu������܂��B
;  @�n�� pose=�|�[�Y�P face=�\��P
;  ;
;  ; ����ɒu����ݒ肷�鎖���ł��܂��B
;  @!�n�� pose=�|�[�Y�P->pose1 face=�\��P->face1
;  ;
;  ; ����� storage=A_pose1_face1 �ɒu������܂��B
;  @�n�� �|�[�Y�P �\��P
;
@!make_character image=�����G�L��->true,�����G����->false
@!make_character voice=�{�C�X�L��->true,�{�C�X����->false

; �L�����N�^�[�쐬
@make_character name=�n�� actual_viewing_name_string=''
@make_character name=�n�� voice_group=halo �����G�L�� �{�C�X�L��

; character �^�O�͂��ׂẴL�����N�^�^�O�̎��̂ł��B
; ���̃^�O�ɑ΂��Đݒ肷��Ƃ��ׂẴL�����N�^�^�O�ɓK������܂��B
;
; ��F
;  @!character gray_scale=�Z�s�A->true r_gamma=�Z�s�A->1.5 g_gamma=�Z�s�A->1.3
;   ^ ! �}�[�N�ɒ���
;  ;
;  ; ����� gray_scale=true r_gamma=1.5 g_gamma=1.3 �ɒu������܂��B
;  @�n�� �Z�s�A
;  ;
;  ; ��������l�ɒu������܂��B
;  @�n�� �Z�s�A
@!character centerx=��->200,��->400,�E->600,����->300,���E->500,���[->100,�E�[->700
@!character gray_scale=�Z�s�A->true r_gamma=�Z�s�A->1.5 g_gamma=�Z�s�A->1.3
@!character visible=�\��->true,����->false
@!character no_voice=nv->true

; �T���v���L�����N�^�[�ݒ�
@!�n�� /storage=A_<POSE>_<FACE>
@!�n�� face=�\��P->face1
@!�n�� pose=�|�[�Y�P->pose1,�|�[�Y�Q->pose2

; ���s�R�[�h�𖳎����邩�ǂ���
@cr_handling !ignore

; �R�R�܂�


; ���o�[�W�������
;
; message: �v���Z�b�g���A�܂��͔C�ӂ̕�������w�肵�܂��B
;
@notice message=version
@notice message=�V�X�e���������������܂����B


; ���E�C���h�E�̕\��
;
; ����őS�Ă̐ݒ肪�I������̂ŃE�C���h�E��\������B
;
@window visible


