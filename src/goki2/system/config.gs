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
@window width=800 height=600 fix-position-to-center alt-enter


; ���������E�F�C�g
@wait time=400 !skip !click


; ���e���W���[���ݒ�
;
; �ǂݍ��񂾃��W���[���̐ݒ肪�K�v�ł���΂����ōs���Ă��������B
; ���W���[���̐ݒ�ɂ��Ă͊e���W���[���̐������Q�Ƃ��Ă��������B
;
; �R�R����

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


