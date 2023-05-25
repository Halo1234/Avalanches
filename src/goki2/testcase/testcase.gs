
@load_module name=ModTypingProcessor
@load_module name=ModSLG
@load_module name=ModSystemMenuItems
@load_module name=ModSaveLoadMenuItems

*start|
@start_anchor

;@ask_close base_storage=YesNoBase yes=button yes_left=50 yes_top=150 no=button no_left=150 no_top=150
@system_menu skip_menu auto_mode_menu next_skip_menu message_hide_menu history_menu record_menu go_back_title_menu full_screen_menu exit_menu
@saveload_menu save_menu load_menu

@que storage=ModRightClickTest
@que storage=ModADVTest
@que storage=ModMessageTest
@que storage=ModBookmark
@que storage=ModSoundTest
@que storage=ModImageTest
@que storage=ModVideoTest
@que storage=ModTypingProcessorTest
@que storage=ModSLGTest

@que storage=endoftest


