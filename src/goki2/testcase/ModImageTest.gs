;/*
; * $Revision: 278 $
;**/

*label|

@cv_layers count=1

@show_message layer=message0

*label|
@load_image storage=sampleA page=fore
@load_image storage=sampleB page=back

@transition time=2000
@wait_transition
@log message="�g�����W�V�����̃e�X�g�ɐ������܂����B"

�g�����W�V�����̃e�X�g�ɐ������܂����B[p][cm]

*label|
@load_image storage=sampleA page=back
@assign_to_mirror
@log message="�w�i�R�s�[�̃e�X�g"

�w�i�R�s�[�̃e�X�g�ɐ������܂����B[p][cm]

*label|
@shake horizontal_max=10 vertical_max=10 time=1000
@wait_shake

�h��܂��B[p][cm]

*label|
@click_skip !enabled

@load_image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible

@transition time=1000
@wait_transition

�q���C���̓ǂݍ��݂ɐ������܂����B[p][cm]

*label|
@load_image layer=0 center_x=400 center_y=300 gray_scale rgamma=1.5 ggamma=1.3 page=back storage=ImageSample visible

@transition time=1000
@wait_transition

�q���C���̐F�␳�̃e�X�g�ł��B[p][cm]

*label|
@load_image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible

@transition time=1000
@wait_transition

@load_partial_image layer=0 page=fore storage=CellImageSample dest_x=100 dest_y=100

�q���C���̕����摜�ǂݍ��݂̃e�X�g�ł��B[p][cm]

*label|
@partial_text layer=0 x=0 y=0 text=hogehoge color=0xFFFF00
�q���C���̕����`��̃e�X�g�ł��B[p][cm]

*label|
�e�X�g�𑱂��܂��B[p][cm]

*label|
@move layer=0 path="(10, 10, 255), (200, 200, 255)" time=5000
@wait_move layer=0

�q���C���̈ړ����s���܂��B[p][cm]

*label|
@click_skip enabled

@start_animation layer=0
@log message="�q���C���ŃA�j���[�V�������J�n���܂����B"

@stop_animation layer=0 index=0
@wait_animation layer=0 index=0
@assign_image layer=0
@log message="�q���C���̃A�j���[�V�������~���܂����B"

�q���C���̃A�j���[�V�����e�X�g�ɐ������܂����B[p][cm]

*label|
@clear_image page=back

@transition time=2000
@wait_transition
@log message="�w�i���N���A����Ă���ΐ����ł��B"

�w�i���N���A����Ă���ΐ����ł��B[p][cm]

*label|
@clear_image layer=0 page=back
@transition time=1000
@wait_transition
@log message="�q���C���N���A�ɐ������܂����B"

�q���C�����N���A����Ă���ΐ����ł��B[p][cm]


