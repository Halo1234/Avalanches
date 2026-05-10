

*label|
;@roguelike_option debug 
@roguelike_option debug_dump_map
@roguelike_option debug_show_enemies
@roguelike_option debug_move_enemies
@roguelike_option debug_mini_map_full_open
;@roguelike_option debug_attack
;@roguelike_option debug_check_pos
;@roguelike_option debug_measure_time
;@roguelike_option debug_not_tracking_mode

@roguelike_option grid_width=64 grid_height=64
@roguelike_option map_width=50 map_height=50
@roguelike_option max_floor=10
@roguelike_option room_count_min=4 room_count_max=8
@roguelike_option item_count_min=4 item_count_max=8
@roguelike_option enemy_count_min=4 enemy_count_max=8
@roguelike_option message_layer_name=message1 font_size=16

@roguelike_load_character storage=プレイヤー.dic image_storage=roguelike_main_character player
@roguelike_load_character storage=スライム.dic image_storage=roguelike_slime_character

; メインメニュー
@roguelike_menu storage=RoguelikeMenuBack.png left=10 top=10
@roguelike_menu item_button_caption=アイテム item_button_left=20 item_button_top=20 item_button_width=60 item_button_height=30 item_button_body_opacity=0 item_button_caption_color=0xFFFFFF
@roguelike_menu foot_button_caption=足元 foot_button_left=110 foot_button_top=20 foot_button_width=60 foot_button_height=30 foot_button_body_opacity=0 foot_button_caption_color=0xFFFFFF
@roguelike_menu map_button_caption=マップ map_button_left=20 map_button_top=60 map_button_width=60 map_button_height=30 map_button_body_opacity=0 map_button_caption_color=0xFFFFFF

; アイテムメニュー
@roguelike_item_menu storage=RoguelikeItemMenuBack.png left=300 top=80 margin_left=50 margin_top=40 margin_right=50
@roguelike_item_menu button_body_opacity=0 button_caption_color=0xFFFFFF
@roguelike_item_menu equip_icon_storage=RoguelikeStatusEquip.png

; アイテムサブメニュー
@roguelike_item_sub_menu storage=RoguelikeItemSubMenuBack.png left=680 top=100 margin_left=20 margin_top=20
@roguelike_item_sub_menu used_button_caption=使う used_button_width=60 used_button_height=30 used_button_body_opacity=0 used_button_caption_color=0xFFFFFF
@roguelike_item_sub_menu equip_button_caption=装備 equip_button_width=60 equip_button_height=30 equip_button_body_opacity=0 equip_button_caption_color=0xFFFFFF
@roguelike_item_sub_menu remove_equip_button_caption=外す remove_equip_button_width=60 remove_equip_button_height=30 remove_equip_button_body_opacity=0 remove_equip_button_caption_color=0xFFFFFF
@roguelike_item_sub_menu see_button_caption=見る see_button_width=60 see_button_height=30 see_button_body_opacity=0 see_button_caption_color=0xFFFFFF
@roguelike_item_sub_menu input_button_caption=入れる input_button_width=60 input_button_height=30 input_button_body_opacity=0 input_button_caption_color=0xFFFFFF
@roguelike_item_sub_menu output_button_caption=出す output_button_width=60 output_button_height=30 output_button_body_opacity=0 output_button_caption_color=0xFFFFFF
@roguelike_item_sub_menu put_button_caption=置く put_button_width=60 put_button_height=30 put_button_body_opacity=0 put_button_caption_color=0xFFFFFF
@roguelike_item_sub_menu throw_button_caption=投げる throw_button_width=60 throw_button_height=30 throw_button_body_opacity=0 throw_button_caption_color=0xFFFFFF

; チップス読み込み
@roguelike_load_chips storage=roguelike_mapchips.dic
@roguelike_load_chips name=StairsDown group_id=100000000 stairs_down
@roguelike_load_chips name=StairsUp group_id=100000001 stairs_up

; 階段にイベント設定
@roguelike_stairs_event name=StairsDown target=*to_down
@roguelike_stairs_event name=StairsUp target=*to_up

; アイテム読み込み
@roguelike_load_items storage=items.ary

; 部屋の読み込み
@roguelike_load_room storage=initial_room001.ary initial_room_index=0
@roguelike_load_room storage=room001.ary
@roguelike_load_room storage=room002.ary
@roguelike_load_room storage=room003.ary
@roguelike_load_room storage=room004.ary
@roguelike_load_room storage=room005.ary
@roguelike_load_room storage=room006.ary
@roguelike_load_room storage=room007.ary

; 初期部屋を部屋0にする
@roguelike_option initial_room_index=0

; プレイヤー配置
@roguelike_character name=プレイヤー x=1 y=1
; アイテム所持
@roguelike_character name=プレイヤー add_item=薬草
@roguelike_character name=プレイヤー add_item=鉄の剣 correction_value=0
@roguelike_character name=プレイヤー add_item=薬草
@roguelike_character name=プレイヤー add_item=薬草
@roguelike_character name=プレイヤー add_item=薬草
@roguelike_character name=プレイヤー add_item=薬草
@roguelike_character name=プレイヤー add_item=薬草
@roguelike_character name=プレイヤー add_item=薬草
@roguelike_character name=プレイヤー add_item=薬草
@roguelike_character name=プレイヤー add_item=薬草
@roguelike_character name=プレイヤー add_item=エニグマの紙 correction_value=1

; ステータスバー設定
@roguelike_status_bar left=10 top=10 width=780 height=80 body_opacity=0
@roguelike_status_bar floor_number_label_storage=RoguelikeStatusFloor.png floor_number_label_left=0 floor_number_label_top=0
@roguelike_status_bar floor_number_left=70 floor_number_top=0 floor_number_width=40 floor_number_height=20 floor_number_body_opacity=0 floor_number_caption_color=0xFFFFFF
@roguelike_status_bar level_label_storage=RoguelikeStatusLv.png level_label_left=120 level_label_top=0
@roguelike_status_bar level_left=190 level_top=0 level_width=40 level_height=20 level_body_opacity=0 level_caption_color=0xFFFFFF
@roguelike_status_bar hp_label_storage=RoguelikeStatusHP.png hp_label_left=240 hp_label_top=0
@roguelike_status_bar hp_left=310 hp_top=0 hp_width=40 hp_height=20 hp_body_opacity=0 hp_caption_color=0xFFFFFF
@roguelike_status_bar hp_bar_left=310 hp_bar_top=20 hp_bar_width=200 hp_bar_height=10
@roguelike_status_bar money_label_storage=RoguelikeStatusMoney.png money_label_left=720 money_label_top=0
@roguelike_status_bar money_left=640 money_top=0 money_width=80 money_height=20 money_body_opacity=0 money_caption_color=0xFFFFFF

; ステータス設定
@roguelike_status storage=RoguelikeStatusBack.png left=10 top=350
@roguelike_status weapon_power_label_caption=武器の強さ weapon_power_label_left=60 weapon_power_label_top=40 weapon_power_label_body_opacity=0 weapon_power_label_caption_color=0xFFFFFF
@roguelike_status weapon_power_left=140 weapon_power_top=40 weapon_power_caption_color=0xFFFFFF weapon_power_body_opacity=0
@roguelike_status armor_power_label_caption=防具の強さ armor_power_label_left=60 armor_power_label_top=60 armor_power_label_body_opacity=0 armor_power_label_caption_color=0xFFFFFF
@roguelike_status armor_power_left=140 armor_power_top=60 armor_power_caption_color=0xFFFFFF armor_power_body_opacity=0
@roguelike_status player_power_label_caption=力 player_power_label_left=60 player_power_label_top=80 player_power_label_body_opacity=0 player_power_label_caption_color=0xFFFFFF
@roguelike_status player_power_left=140 player_power_top=80 player_power_caption_color=0xFFFFFF player_power_body_opacity=0
@roguelike_status fullness_level_label_caption=満腹度 fullness_level_label_left=220 fullness_level_label_top=40 fullness_level_label_body_opacity=0 fullness_level_label_caption_color=0xFFFFFF
@roguelike_status fullness_level_left=300 fullness_level_top=40 fullness_level_caption_color=0xFFFFFF fullness_level_body_opacity=0
@roguelike_status experience_label_caption=経験値 experience_label_left=220 experience_label_top=60 experience_label_body_opacity=0 experience_label_caption_color=0xFFFFFF
@roguelike_status experience_left=300 experience_top=60 experience_caption_color=0xFFFFFF experience_body_opacity=0

; YesNo選択肢
@roguelike_yesno storage=RoguelikeItemSubMenuBack.png left=680 top=100
@roguelike_yesno yes_caption=はい yes_left=20 yes_top=20 yes_width=60 yes_height=30 yes_body_opacity=0 yes_caption_color=0xFFFFFF
@roguelike_yesno no_caption=いいえ no_left=20 no_top=50 no_width=60 no_height=30 no_body_opacity=0 no_caption_color=0xFFFFFF

; 初期化
@roguelike initialize

; 初期部屋に降りる階段を設置
@roguelike_option x=2 y=1 stairs_down

; ゲーム開始
@roguelike show
@wait_roguelike_show
@roguelike start
@s

*to_down
@roguelike_option message=階段を降りますか？ !message_auto_hide
@roguelike_yesno yes_target=*yes_down no_target=*no_down
@roguelike_yesno show
@s

*yes_down
@roguelike_option hide_message
@roguelike_yesno hide

@roguelike hide
@wait_roguelike_hide

@roguelike next_floor

@roguelike show
@wait_roguelike_show

@roguelike start
@s

*no_down
@roguelike_option hide_message
@roguelike_yesno hide

@roguelike start
@s

*to_up
@roguelike_option message=階段を上ります？ !message_auto_hide
@roguelike_yesno yes_target=*yes_up no_target=*no_up
@roguelike_yesno show
@s

*yes_up
@roguelike_option hide_message
@roguelike_yesno hide

@roguelike hide
@wait_roguelike_hide

@roguelike_option initial_room_index=0
@roguelike_character name=プレイヤー x=1 y=1
@roguelike initialize
@roguelike_option x=2 y=1 stairs_down

@roguelike show
@wait_roguelike_show

@roguelike start
@s

*no_up
@roguelike_option hide_message
@roguelike_yesno hide

@roguelike start
@s

