

*label|
@history enabled=false

;@roguelike_option debug 
@roguelike_option debug_dump_map
@roguelike_option debug_show_enemies
;@roguelike_option debug_move_enemies
@roguelike_option debug_mini_map_full_open
;@roguelike_option debug_attack
;@roguelike_option debug_check_pos
;@roguelike_option debug_measure_time
;@roguelike_option debug_not_tracking_mode
;@roguelike_option debug_skip
@roguelike_option debug_show_trap
;@roguelike_option debug_trap
@roguelike_option debug_show_transparent_character
@roguelike_option debug_show_item_name
;@roguelike_option debug_message_to_console

; 効果音設定
@roguelike_sound sort=maou_se_sound22 enter=maou_se_sound19 button=maou_se_sound_pc01 ng=maou_se_onepoint33
@roguelike_sound item_use0=maou_se_sound_drink01 item_use1=maou_se_magical07 item_use2=maou_se_sound_paper01 
@roguelike_sound attack_プレイヤー=maou_se_battle01
@roguelike_sound damage=maou_se_sound01 levelup=maou_se_jingle05
@roguelike_sound イオナズンの巻物=maou_se_battle_explosion06
@roguelike_sound ダメージ罠=maou_se_battle18 巻き込み型ダメージ罠=maou_se_battle18

@roguelike_save_load left=0 top=0 width=800 height=600 margin_left=20 margin_top=80
@roguelike_save_load record_storage=RoguelikeSaveLoadRecord blank_thumbnail_storage=RoguelikeBlankThumbnail
@roguelike_save_load font_height=24 caption_color=0xFFFFFF
@roguelike_save_load thumbnail_left=80 thumbnail_top=10
@roguelike_save_load index_left=250 index_top=20 index_opacity=0
@roguelike_save_load subject_left=280 subject_top=20 subject_opacity=0
@roguelike_save_load date_left=250 date_top=40 date_opacity=0
@roguelike_save_load floor_left=280 floor_top=80 floor_opacity=0
@roguelike_save_load death_left=380 death_top=80 death_opacity=0
@roguelike_save_load delete_button_left=630 delete_button_top=30 delete_button_width=60 delete_button_height=40 delete_button_caption=削除
@roguelike_save_load data_max=10
@roguelike_save_load show
@s

@roguelike_save_load hide

; BGM設定
@roguelike_sound bgm_initial=maou_bgm_acoustic52 bgm_normal=maou_bgm_acoustic54 bgm_monster_house=bgm001 bgm_boss=maou_bgm_neorock83 bgm_shop=maou_bgm_piano40 bgm_steal=maou_bgm_orchestra24

; 基本設定
@roguelike_option grid_width=64 grid_height=64
@roguelike_option map_width=50 map_height=50
@roguelike_option max_floor=99
@roguelike_option room_count_min=4 room_count_max=8
@roguelike_option item_count_min=4 item_count_max=8
@roguelike_option money_count_min=1 money_count_max=3
@roguelike_option enemy_count_min=4 enemy_count_max=8
@roguelike_option trap_lower_floor=1 trap_upper_floor=99 trap_min=1 trap_max=3
@roguelike_option message_layer_name=message1 font_size=16
@roguelike_option enemy_sleeping=20
@roguelike_option enemy_wakeup=20
@roguelike_option monster_house_rate=10
@roguelike_option go_back_target=*go_back
@roguelike_option gameover_target=*gameover
@roguelike_option return_trip
@roguelike_option shop_rate=10

; チップス読み込み
@roguelike_load_chips storage=roguelike_mapchips.dic
@roguelike_load_chips name=StairsDown group_id=100000000 stairs_down
@roguelike_load_chips name=StairsUp group_id=100000001 stairs_up

; 部屋の読み込み
@roguelike_load_room storage=initial_room001.ary initial_room
@roguelike_load_room storage=room999.ary boss_room
@roguelike_load_room storage=room_shop1.ary shop_room
@roguelike_load_room storage=room_shop2.ary shop_room
@roguelike_load_room storage=room001.ary
@roguelike_load_room storage=room002.ary
@roguelike_load_room storage=room003.ary
@roguelike_load_room storage=room004.ary
@roguelike_load_room storage=room005.ary
@roguelike_load_room storage=room006.ary
@roguelike_load_room storage=room007.ary

; キャラクターの読み込み（未配置のため画面には表示されない）
@roguelike_load_character storage=プレイヤー.dic image_storage=roguelike_main_character player
@roguelike_load_character storage=スライム.dic image_storage=roguelike_slime_character min_floor=1 max_floor=10
@roguelike_load_character storage=ドラゴン.dic image_storage=roguelike_dragon_character min_floor=1 max_floor=30
@roguelike_load_character storage=透明な敵.dic image_storage=roguelike_knight_character min_floor=1 max_floor=30
@roguelike_load_character storage=店員.dic image_storage=roguelike_npc_character clerk
@roguelike_load_character storage=ボス.dic image_storage=roguelike_boss_character boss

; メインメニュー
@roguelike_menu storage=RoguelikeMenuBack.png left=10 top=10
@roguelike_menu item_button_caption=アイテム item_button_left=20 item_button_top=20 item_button_width=60 item_button_height=30 item_button_body_opacity=0 item_button_caption_color=0xFFFFFF
@roguelike_menu foot_button_caption=足元 foot_button_left=70 foot_button_top=20 foot_button_width=60 foot_button_height=30 foot_button_body_opacity=0 foot_button_caption_color=0xFFFFFF
@roguelike_menu map_button_caption=マップ map_button_left=20 map_button_top=60 map_button_width=60 map_button_height=30 map_button_body_opacity=0 map_button_caption_color=0xFFFFFF
@roguelike_menu pause_button_caption=中断 pause_button_left=70 pause_button_top=60 pause_button_width=60 pause_button_height=30 pause_button_body_opacity=0 pause_button_caption_color=0xFFFFFF
@roguelike_menu giveup_button_caption=諦める giveup_button_left=120 giveup_button_top=20 giveup_button_width=60 giveup_button_height=30 giveup_button_body_opacity=0 giveup_button_caption_color=0xFFFFFF

; アイテムメニュー
@roguelike_item_menu storage=RoguelikeItemMenuBack.png left=300 top=80 margin_left=50 margin_top=40 margin_right=50
@roguelike_item_menu button_body_opacity=0 button_caption_color=0xFFFFFF
@roguelike_item_menu price_body_opacity=0 price_caption_color=0xFF0000
@roguelike_item_menu equip_icon_storage=RoguelikeStatusEquip.png curse_icon_storage=RoguelikeStatusCurse.png

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
@roguelike_item_sub_menu name_button_caption=名前 name_button_width=60 name_button_height=30 name_button_body_opacity=0 name_button_caption_color=0xFFFFFF
@roguelike_item_sub_menu shooting_button_caption=射撃 shooting_button_width=60 shooting_button_height=30 shooting_button_body_opacity=0 shooting_button_caption_color=0xFFFFFF
@roguelike_item_sub_menu pickup_button_caption=拾う pickup_button_width=60 pickup_button_height=30 pickup_button_body_opacity=0 pickup_button_caption_color=0xFFFFFF

; アイテム名編集
@roguelike_edit_item_name storage=RoguelikeEditItemNameBack.png left=0 top=200 margin_left=70 margin_top=30 character_left=50 character_top=20
@roguelike_edit_item_name viewer_storage=RoguelikeItemNameBack.png viewer_left=0 viewer_top=80 viewer_margin_left=70 viewer_margin_top=30 viewer_margin_right=70 viewer_margin_bottom=30 viewer_font_height=32
@roguelike_edit_item_name history_left=0 history_top=0 history_width=800 history_height=600 history_margin_left=40 history_margin_top=40 history_margin_right=40 history_margin_bottom=40 history_item_button_width=720 history_item_button_height=40 history_font_height=32
@roguelike_edit_item_name kana_button_caption=全角カナ kana_button_left=650 kana_button_top=100 kana_button_width=80 kana_button_height=30
@roguelike_edit_item_name delete_button_caption=削除 delete_button_left=650 delete_button_top=140 delete_button_width=80 delete_button_height=30
@roguelike_edit_item_name cancel_button_caption=キャンセル cancel_button_left=650 cancel_button_top=180 cancel_button_width=80 cancel_button_height=30
@roguelike_edit_item_name history_button_caption=履歴 history_button_left=650 history_button_top=220 history_button_width=80 history_button_height=30
@roguelike_edit_item_name enter_button_caption=決定 enter_button_left=650 enter_button_top=260 enter_button_width=80 enter_button_height=30

; ステータスバー設定
@roguelike_status_bar left=10 top=10 width=780 height=80 body_opacity=0
@roguelike_status_bar floor_number_label_storage=RoguelikeStatusFloor.png floor_number_label_left=0 floor_number_label_top=0
@roguelike_status_bar floor_number_left=70 floor_number_top=0 floor_number_width=40 floor_number_height=20 floor_number_body_opacity=0 floor_number_caption_color=0xFFFFFF
@roguelike_status_bar level_label_storage=RoguelikeStatusLv.png level_label_left=120 level_label_top=0
@roguelike_status_bar level_left=190 level_top=0 level_width=40 level_height=20 level_body_opacity=0 level_caption_color=0xFFFFFF
@roguelike_status_bar hp_label_storage=RoguelikeStatusHP.png hp_label_left=240 hp_label_top=0
@roguelike_status_bar hp_left=310 hp_top=0 hp_width=180 hp_height=20 hp_body_opacity=0 hp_caption_color=0xFFFFFF
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

; 初期部屋を部屋0にする
@roguelike_option initial_room_index=0
@roguelike_option boss_room_index=1

; プレイヤー配置
@roguelike_character name=プレイヤー x=1 y=1

; 階段にイベント設定
;@roguelike_stairs_event name=StairsDown target=*to_down
;@roguelike_stairs_event name=StairsUp target=*to_up

; アイテム読み込み
@roguelike_load_items storage=items.ary
@roguelike_load_item_type storage=itemtype.ary
@roguelike_load_unidentified storage=unidentified.ary

; お金アイコン指定
@roguelike_money storage=お金アイコン

; 罠読み込み
@roguelike_load_trap storage=roguelike_trap.ary

; 初期化
@roguelike initialize

; アイテム所持（初期化後に行う事）
@roguelike_character name=プレイヤー add_item=薬草 correction_value=1
@roguelike_character name=プレイヤー add_item=倍速の草
@roguelike_character name=プレイヤー add_item=ドラゴンキラー correction_value=2
@roguelike_character name=プレイヤー add_item=ドラゴンキラー correction_value=2
@roguelike_character name=プレイヤー add_item=ダメージ罠設置
@roguelike_character name=プレイヤー add_item=敵増殖の罠設置
@roguelike_character name=プレイヤー add_item=即死の杖 correction_value=1
@roguelike_character name=プレイヤー add_item=ワープの壺 correction_value=5
@roguelike_character name=プレイヤー add_item=イオナズンの巻物
@roguelike_character name=プレイヤー add_item=イオナズンの巻物
@roguelike_character name=プレイヤー add_item=鑑定の巻物
@roguelike_character name=プレイヤー add_item=毒草
@roguelike_character name=プレイヤー add_item=強化の巻物
@roguelike_character name=プレイヤー add_item=鉄の矢 correction_value=99
@roguelike_character name=プレイヤー add_item=聖域の巻物
@roguelike_character name=プレイヤー add_item=エニグマの紙 correction_value=5

@roguelike_character name=プレイヤー add_money=10000

; 初期部屋に降りる階段を設置
@roguelike_option x=2 y=1 stairs_down

; ゲーム開始
*label|テストダンジョン
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

@roguelike next_floor

@roguelike show
@wait_roguelike_show

@roguelike start
@s

*no_up
@roguelike_option hide_message
@roguelike_yesno hide

@roguelike start
@s

*go_back
@roguelike_option message=階段を上ります？ !message_auto_hide
@roguelike_yesno yes_target=*go_back_to_up no_target=*no_up
@roguelike_yesno show
@s

*go_back_to_up
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

*gameover
@roguelike_option initial_room_index=0
@roguelike_character name=プレイヤー x=1 y=1
@roguelike initialize
@roguelike_option x=2 y=1 stairs_down

@roguelike show
@wait_roguelike_show

@roguelike start
@s

