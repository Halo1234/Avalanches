
*label|

@load_roman_table language=japanese
@log message="���{�ꃍ�[�}���Ή��\�ǂݍ��݂ɐ������܂����B"

*game_start
@hide_typing_target

@add_typing_word caption="�V��s�m�B��Ƒ�" ruby="�n�R����"
@add_typing_word caption="�Â��h" ruby="�z�e���E���t���V�A"
@add_typing_word caption="�d���Ή�" ruby="�f���R�E�Z�b�J"
@add_typing_word caption="����" ruby="�C�Y�c�V"
@add_typing_word caption="�_��" ruby="�J������"
@add_typing_word caption="����" ruby="�i���J�~"
@add_typing_word caption="�����v��" ruby="�V�b�v�E�W�����C"

@dump_typing_word_list

;@remove_typing_word caption="�d���Ή�"
;@remove_typing_word ruby="�C�Y�c�V"
;@remove_typing_word caption="�_��" ruby="�J������"
@log message="���[�h���R�폜���܂����B"

@dump_typing_word_list

;@clear_typing_word_list
@log message="���[�h�S�č폜���܂����B"

@dump_typing_word_list

@load_typing_words storage=HAMON_Skills.dic
@load_typing_words storage=Vampire_Skils.dic
@log message="���[�h���X�g��ǂݍ��݂܂����B"

@dump_typing_word_list

@typing_config target_image=TypingTarget000
@typing_config accept_target=*accept end_target=*end

*label|
@typing_start
@log message="�^�C�s���O�̎�t���J�n���܂����B"

@show_typing_target position=center count=1
@log message="�^�C�s���O�^�[�Q�b�g�������_���ň�\�����܂����B"

@wait_typing target_count=0


*label|
@show_typing_target left=100 top=100
@show_typing_target left=200 top=100
@show_typing_target left=300 top=100
@show_typing_target left=400 top=100
@show_typing_target left=100 top=200
@show_typing_target left=200 top=200
@show_typing_target left=300 top=200
@show_typing_target left=400 top=200

; �^�[�Q�b�g���c��P�ɂȂ�܂ő҂B
@wait_typing target_count=1


*label|
;@show_typing_target position=random ruby="�C�Y�c�V"
;@show_typing_target position=random caption="�_��"
;@log message="���݂��Ȃ��^�C�s���O�^�[�Q�b�g���w�肵�܂����B���[�j���O���Q���O�ɕ\������Ă���ΐ����ł��B"

@wait_typing target_count=0


@log message="�S�Ẵ^�[�Q�b�g�̓��͂��������܂����B"
@s

*accept|

@wait_typing target_count=0

@show_typing_target left=100 top=100
@show_typing_target left=200 top=100
@show_typing_target left=300 top=100
@show_typing_target left=400 top=100
@show_typing_target left=100 top=200
@show_typing_target left=200 top=200
@show_typing_target left=300 top=200
@show_typing_target left=400 top=200
@s


*end|
@log message="�^�C�s���O�̎�t���I�����܂����B"

@jump target=*game_start


