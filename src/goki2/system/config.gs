;/*
; * $Revision: 288 $
;**/


; ���X�N���v�g�L���[
;
; storage: �ǉ��������X�N���v�g�t�@�C�����ł��B
;
@que storage=KAGCompatible,testcase


; �����s�̈�����
;
; ignore: false ���w�肷��Ɖ��s�R�[�h�� r �^�O�Ƃ��Ĉ����܂��B
@cr_handling ignore


; ���E�C���h�E�̐ݒ�
;
;                caption: �E�C���h�E�̃^�C�g���o�[�ɕ\�����镶����ł��B
;                  width: �E�C���h�E�̕��ł��B�i���m�ɂ̓N���C�A���g�̈�̕��ł��j
;                 height: �E�C���h�E�̍����ł��B�i���m�ɂ̓N���C�A���g�̈�̍����ł��j
; fix_position_to_center: �w�肷��ƃE�C���h�E�����ʒu���f�X�N�g�b�v�����ɐݒ肳��܂��B
;              alt_enter: �w�肷��� Alt+Enter �ŃX�N���[�����[�h��؂�ւ��鎖���ł���悤�ɂȂ�܂��B
;                visible: �w�肷��ƃE�C���h�E��\�����܂��B
;
@window width=800 height=600 fix_position_to_center alt_enter


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
@history_option width=800 height=600 margin_left=18 margin_top=18 margin_right=18 margin_bottom=18 color=0x000000

; ���b�Z�[�W���C���ݒ�
@message_option layer=message0 left=10 top=400 width=780 height=190 margin_left=10 margin_top=10 margin_right=10 margin_bottom=10 opacity=128 color=0x000000 shadow_color=0xFFFF0000 current

; BGM�o�b�t�@�ǉ�
@add_bgm_buffer type=WAVE

; �L�����N�^�[��`
;
; �^�O���� ! �Ŏn�܂�^�O�̓^�O�̊g���\���ݒ���s������ȃ^�O�ɂȂ�܂��B
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

@redirect alias=mob name=make_character
@!mob /mob=true

; �L�����N�^�[�쐬
;
;                 name: �L�����N�^�[�����w�肵�܂��B
;                       �����Ŏw�肵�����O�����̂܂܃^�O���ɂȂ�܂��B
;                  mob: true ���w�肷��ƂP�̃X�N���v�g�t�@�C�����ł̂ݗL���ȃL�����N�^�[���쐬���܂��B
;           auto_voice: �����{�C�X�Đ����s���ꍇ�� true ���w�肵�܂��B
; voice_storage_format: �{�C�X�t�@�C���̃t�H�[�}�b�g���w�肵�܂��B
;                       ����͈�̔ԍ��������Ƃ��Ď󂯎�� sprintf() �̈����ł��B
;                       ��F halo_voice_%03d
;                       �f�t�H���g�ł́u���O%03d�v�ł��B�i���O�� name �Ŏw�肵��������j
;                image: �����G�Ȃǂ̃O���t�B�b�N�����ꍇ�� true ���w�肵�܂��B
;                voice: �{�C�X�����ꍇ�� true ���w�肵�܂��B
@make_character name=�n��
@make_character name=�n�� �����G�L�� �{�C�X�L��

; character �^�O�͂��ׂẴL�����N�^�^�O�̎��̂ł��B
; ���̃^�O�ɑ΂��Ċg���\����ݒ肷��Ƃ��ׂẴL�����N�^�^�O�ɓK������܂��B
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
;
; character �^�O�̎d�l
;
;      storage: �摜�t�@�C�������w�肵�܂��B
;          key: �摜�̃L�[�l���w�肵�܂��B
;  asd_storage: ASD�t�@�C�������w�肵�܂��B
;   gray_scale: true ���w�肷��ƃO���C�X�P�[�������܂��B
;      r_gamma: Gamma�l���w�肵�܂��B
;      g_gamma: Gamma�l���w�肵�܂��B
;      b_gamma: Gamma�l���w�肵�܂��B
;      r_floor: Floor�l���w�肵�܂��B
;      g_floor: Floor�l���w�肵�܂��B
;      b_floor: Floor�l���w�肵�܂��B
;       r_ceil: Ceil�l���w�肵�܂��B
;       g_ceil: Ceil�l���w�肵�܂��B
;       b_ceil: Ceil�l���w�肵�܂��B
;       mcolor: �u�����h����F���w�肵�܂��B
;     mopacity: �u�����h����F�̕s�����x���w�肵�܂��B
;         mode: ���߃��[�h���w�肵�܂��B
;      flip_ud: true ���w�肷��Ə㉺�����ւ��܂��B
;      flip_lr: true ���w�肷��ƍ��E�����ւ��܂��B
;    clip_left: �摜�̃N���b�s���O���W���w�肵�܂��B
;     clip_top: �摜�̃N���b�s���O���W���w�肵�܂��B
;   clip_width: �摜�̃N���b�s���O���W���w�肵�܂��B
;  clip_height: �摜�̃N���b�s���O���W���w�肵�܂��B
;     center_x: �摜���S�ʒu��X���W�l�ł��B
;     center_y: �摜���S�ʒu��Y���W�l�ł��B
;         left: �摜�̍�����\���ʒu���w�肵�܂��B
;          top: �摜�̍�����\���ʒu���w�肵�܂��B
;        right: �摜�̉E�����\���ʒu���w�肵�܂��B
;       bottom: �摜�̉E�����\���ʒu���w�肵�܂��B
;      opacity: �摜�̕s�����x���w�肵�܂��B
;        index: �摜�̏d�ˍ��킹�������w�肵�܂��B
;        voice: true ���w�肷��ƃ{�C�X���Đ����܂��B�����w�肵�Ȃ���� true �Ƃ݂Ȃ��܂��B
; voice_number: �{�C�X�ԍ����w�肵�܂��B�����w�肵�Ȃ���Ύ����Ŋ��蓖�Ă��܂��B
;         time: �g�����W�V�����̎��Ԃ��w�肵�܂��B�����w�肵�Ȃ���� 200 �ɂȂ�܂��B
;        vague: �g�����W�V�����̞B���l���w�肵�܂��B�����w�肵�Ȃ���� 128 �ɂȂ�܂��B
;       method: �g�����W�V�����̃^�C�v���w�肵�܂��B�����w�肵�Ȃ���Α��̒l���琄������܂��B    
;         from: �X�N���[���g�����W�V�����̈����ł��Bleft, top, right, bottom �̂����ꂩ���w�肵�܂��B
;         stay: �X�N���[���g�����W�V�����̈����ł��Bstayfore, stayback, nostay �̂����ꂩ���w�肵�܂��B
;         rule: ���[���摜���w�肵�܂��B
;     children: �g�����W�V�����̑ΏۂɎq���C�����܂߂邩�ǂ������w�肵�܂��B�����w�肵�Ȃ���� true �ɂȂ�܂��B
@!character center_x=��->200,��->400,�E->600,����->300,���E->500,���[->100,�E�[->700
@!character gray_scale=�Z�s�A->true r_gamma=�Z�s�A->1.5 g_gamma=�Z�s�A->1.3
@!character visible=�\��->true,����->false
@!character no_voice=nv->true

; �T���v���L�����N�^�[�ݒ�
;
; �^�O�̎d�l�� character �^�O�Ɠ����ł��B
@!�n�� /storage=A_<POSE>_<FACE>
@!�n�� face=�\��P->face1
@!�n�� pose=�|�[�Y�P->pose1,�|�[�Y�Q->pose2

; ���ԑт��`���܂��B
;
;   name: ���ԑі����w�肵�܂��B�����Ŏw�肵�����O�����̂܂܃^�O�ɂȂ�܂��B
; prefix: �����G�̃t�@�C�����Ȃǂ̖����ɂ��镶������w�肵�܂��B
@make_time_zone name=�� prefix=''
@make_time_zone name=�[ prefix=ev
@make_time_zone name=�� prefix=ng

; �T���v���w�i
;
;    name: ���O���w�肵�܂��B���̖��O�����̂܂܃^�O���ɂȂ�܂��B
; storage: �w�i�Ƃ��ēǂݍ��ރt�@�C�������w�肵�܂��B
@make_stage name=�� storage=��
@make_stage name=�� storage=��
@make_stage name=�� storage=��

; �R�R�܂�


; ���������E�F�C�g
@wait time=400 !skip !click


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


