
*label|
@using_mod_message

@show_message layer=message0

*label|
@image storage=sampleB page=back

@trans time=2000
@wt
@log message="�g�����W�V�����̃e�X�g�ɐ������܂����B"

�g�����W�V�����̃e�X�g�ɐ������܂����B[p][cm]

*label|
@image storage=sampleA page=back
@assign_to_mirror
@log message="�w�i�R�s�[�̃e�X�g"

�w�i�R�s�[�̃e�X�g�ɐ������܂����B[p][cm]

*label|
@quake hmax=10 vmax=10 time=1000
@wq

�h��܂��B[p][cm]

*label|
@image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible

@trans time=1000
@wt

�q���C���̓ǂݍ��݂ɐ������܂����B[p][cm]

*label|
@image layer=0 center_x=400 center_y=300 grayscale rgamma=1.5 ggamma=1.3 page=back storage=ImageSample visible

@trans time=1000
@wt

�q���C���̐F�␳�̃e�X�g�ł��B[p][cm]

*label|
@image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible

@trans time=1000
@wt

@pimage layer=0 page=fore storage=CellImageSample dx=100 dy=100

�q���C���̕����摜�ǂݍ��݂̃e�X�g�ł��B[p][cm]

*label|
@ptext layer=0 x=0 y=0 text=hogehoge color=0xFFFF00
�q���C���̕����`��̃e�X�g�ł��B[p][cm]

*label|
�e�X�g�𑱂��܂��B[p][cm]

*label|
;@clickskip !enabled

@move layer=0 path="(10, 10, 255), (200, 200, 255)" time=5000
@wm layer=0

�q���C���̈ړ����s���܂��B[p][cm]

*label|
[cancelskip]

@layer_move layer=0 x=left y=top angle=0 position=0.0 clear children transform
@layer_move layer=0 x=0 y=0 angle=360 scale=1.0 position=0.5
@layer_move layer=0 x=200 y=200 scale=2.0 position=1.0
@layer_move layer=0 time=5000 start
@layopt layer=0 left=200 top=200
@wm layer=0

�q���C���̈ړ����s���܂��B[p][cm]

*label|
@clickskip enabled

@animstart layer=0

@animstop layer=0 seg=0
@wa layer=0 seg=0
@backlay layer=0

�q���C���̃A�j���[�V�����e�X�g�ɐ������܂����B[p][cm]

*label|
@freeimage page=back

@trans time=2000
@wt

�w�i���N���A����Ă���ΐ����ł��B[p][cm]

*label|
@freeimage layer=0 page=back
@trans time=1000
@wt

�q���C�����N���A����Ă���ΐ����ł��B[p][cm]

*label|
@image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible
@trans time=1000
@wt

������x�q���C����ǂݍ��݂܂��B[p][cm]

*label|
@animstart layer=0

@animstop layer=0 seg=0
@wa layer=0 seg=0
@backlay layer=0

�q���C���̃A�j���[�V�����e�X�g�ɐ������܂����B[p][cm]

*label|
@freeimage layer=0 page=back
@trans time=1000
@wt

�q���C�����N���A����Ă���ΐ����ł��B[p][cm]


