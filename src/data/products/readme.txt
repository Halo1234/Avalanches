/**
**/



--- �ڎ�

 �E�ڎ�
 �E���̃t�H���_�̐���
 �Einstall/master/update �t�H���_���ł̓���ȃt�@�C�����ɂ���


--- ���̃t�H���_�̐���

���̃t�H���_���� make �c�[���̃^�[�Q�b�g���쐬���鎖���ł��܂��B
�^�[�Q�b�g�t�H���_�̓��e�͈ȉ��̂悤�Ȏd�l�ɂȂ�܂��B

 +--+ [target-name]
    +---+ [header-images]
    +   +---+ page_header_l.bmp
    +   +---+ page_header_r.bmp
    +   +---+ side_banner.bmp
    +   +---+ unpage_header_l.bmp
    +   +---+ unpage_header_r.bmp
    +   +---+ unside_banner.bmp
    +
    +---+ [icons]
    +   +---+ installer.ico
    +   +---+ uninstaller.ico
    +
    +---+ [install]
    +   +---+ �C��
    +
    +---+ [key]
    +   +---+ priv
    +   +---+ pub
    +
    +---+ [master]
    +   +---+ �C��
    +
    +---+ [update]
    +   +---+ �C��
    +
    +---+ override.ini

target-name �� /tools/make/make.rb �ւ̈����ɂȂ�܂��B
�ڂ����� /tools/make/readme.txt ���Q�Ƃ��Ă��������B

header-images �t�H���_�ɂ̓C���X�g�[���^�A���C���X�g�[���ŗ��p����w�b�_�摜��
 �o�i�[�摜�Ȃǂ�z�u���܂��B

icons �t�H���_�ɂ̓C���X�g�[���^�A���C���X�g�[�����̂��߂̃A�C�R����z�u���܂��B

install �t�H���_�ɂ͒ǉ��ŃC���X�g�[�����������o�C�i���f�[�^��z�u���܂��B
 ���̃t�H���_�̓��e�̓T�u�t�H���_���܂߂đS�Ă��̂܂܃C���X�g�[������܂��B

key �t�H���_�ɂ͏����p�̃L�[�t�@�C����z�u���܂��B

master �t�H���_�ɂ̓}�X�^�[�f�[�^�ɒǉ��Ŏ��^���������o�C�i����z�u���܂��B
 ���̃t�H���_�̓��e�̓T�u�t�H���_���܂߂đS�Ă��̂܂܃}�X�^�[�f�[�^�Ɋ܂܂�鎖�ɂȂ�܂��B

update �t�H���_�ɂ̓A�b�v�f�[�g�v���O�����ɒǉ��Ŏ��^���������o�C�i���f�[�^����z�u���܂��B
 ���̃t�H���_�̓��e�̓T�u�t�H���_���܂߂đS�Ă��̂܂܃A�b�v�f�[�g�v���O�����Ɋ܂܂�鎖�ɂȂ�܂��B

override.ini �� /tools/make/config.ini �̊e���ڂ��I�[�o�[���C�h���܂��B
 �ڂ����� /tools/make.config.sample.ini �̊e���ڂ̐������Q�Ƃ��Ă��������B


--- install/master/update �t�H���_���ł̓���ȃt�@�C�����ɂ���

�����̃t�H���_���ł́A�������̓��ʂȈӖ������t�@�C����������܂��B

 [readme.txt]
  make �c�[���͂��̃t�@�C���ɑ΂��ĒP���ȃe�L�X�g�u���������s���܂��B
  �u�������e�L�X�g�̍\���͈ȉ��̒ʂ�ł��B

  #{SECTION-NAME.VALUE-NAME}

  SECTION-NAME �� config.ini �܂��� override.ini �Œ�`����Ă���Z�N�V�������ł��B
  VALUE-NAME �� config.ini �܂��� override.ini �Œ�`����Ă���l�̖��O�ł��B
  readme.txt ���̊Y������e�L�X�g�͊Y������l�Œu���������܂��B

  �܂��A�ȉ��̒l�� config.ini �܂��� override.ini �Œ�`����Ȃ��g�ݍ��݂̒l�Œu������܂��B

   #{UPDATEINFO.log}
    config.ini �܂��� override.ini �Œ�`����Ă��� UPDATE1 �` UPDATAn �܂ł� log �l�̓�
    �p�b�P�[�W�����Ɏw�肳�ꂽ�͈͂� log �l�̏W���ł��B

    �Ⴆ�΁Aoverride.ini �� UPDATA1 �` UPDATA5 �܂ł���`����Ă��āA
    ���� UPDATA1 �` UPDATA3 �܂ł��p�b�P�[�W�������ꍇ�B
    #{UPDATAINFO.log} �� UPDATA1 �` UPDATA3 �܂ł� log �l�����������e�L�X�g�Œu������܂��B

 [krkr.*]
  �t�@�C������ krkr �̕������^�[�Q�b�g���Œu���������܂��B
  �t�@�C�����̈ꕔ�� krkr ���܂܂�Ă���ꍇ�͉����s���܂���B
  �܂� krkrHoge.exe �Ƃ����t�@�C���� krkrHoge.exe �̂܂܂ɂȂ�܂��B
 


