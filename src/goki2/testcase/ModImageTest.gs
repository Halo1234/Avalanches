;/*
; * $Revision: 278 $
;**/

*label|
; ModImage test.
@load_module name=ModImage
@log message="ModImage ���W���[���ǂݍ��݂ɐ������܂����B"

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

@load_image layer=cv_layer0 center_x=400 center_y=300 page=back storage=ImageSample visible

�w�i�R�s�[�̃e�X�g�ɐ������܂����B[p][cm]

*label|
@transition time=1000
@wait_transition
@log message="�q���C���ǂݍ��݂ɐ������܂����B"

�q���C���̓ǂݍ��݂ɐ������܂����B[p][cm]

*label|
@start_animation layer=cv_layer0
@log message="�q���C���ŃA�j���[�V�������J�n���܂����B"

@stop_animation layer=cv_layer0 index=0
@wait_animation layer=cv_layer0 index=0
@assign_image layer=cv_layer0
@log message="�q���C���̃A�j���[�V�������~���܂����B"

�q���C���̃A�j���[�V�����e�X�g�ɐ������܂����B[p][cm]

*label|
@clear_image page=back

@transition time=2000
@wait_transition
@log message="�w�i���N���A����Ă���ΐ����ł��B"

�w�i���N���A����Ă���ΐ����ł��B[p][cm]

*label|
@clear_image layer=cv_layer0 page=back
@transition time=1000
@wait_transition
@log message="�q���C���N���A�ɐ������܂����B"

�q���C�����N���A����Ă���ΐ����ł��B[p][cm]


