
*label|
; 履歴が邪魔なのでOFFにしておく
@history_option !enabled


;@fadeinbgm storage=bgm001.ogg time=2000

*|
@mapchip storage=mapchips.chp

*|
@slgdebug operation_all=true

@slgconfig hp=HP sp=SP

@loadmap storage=test2.map
@loadcursor storage=mapcursor moving=movingcursor attack=attackcursor item=itemcursor skill=skillcursor
@loaditem item_storage=item weapon_type_storage=weapontype
@loadskilldef storage=skilllist
@loadclassdef storage=classdata

@loadcharacter storage=chardata.chr character_type=player
@loadcharacter storage=player1.chr character_type=player
@loadcharacter storage=maxplayer.chr character_type=player
@loadcharacter storage=villan.chr character_type=enemy
@loadcharacter storage=villan2.chr character_type=enemy
@loadcharacter storage=villan3.chr character_type=enemy
@loadcharacter storage=maxvillan.chr character_type=enemy
@loadcharacter storage=npc.chr character_type=npc

@mapstatus visible width=200 height=120
@mapstatus caption_value_left=0 caption_value_top=0
@mapstatus move_caption="移動負荷" move_left=0 move_top=20 move_value_left=60 move_value_top=20
@mapstatus defense_caption="防御効果" defense_left=0 defense_top=40 defense_value_left=60 defense_value_top=40
@mapstatus avoid_caption="回避効果" avoid_left=0 avoid_top=60 avoid_value_left=60 avoid_value_top=60
@mapstatus axis_caption="座標" axis_left=0 axis_top=80 axis_value_left=60 axis_value_top=80

@commandmenu turn_end_caption="ターンエンド" turn_end_width=60 turn_end_height=20
@commandmenu skill_search_caption="スキル探索" skill_search_width=60 skill_search_height=20
@commandmenu troops_caption="部隊表" troops_width=60 troops_height=20
@commandmenu strategy_caption="作戦目的" strategy_width=60 strategy_height=20
@commandmenu system_caption="システム" system_width=60 system_height=20
@commandmenu load_caption="ロード" load_width=60 load_height=20
@commandmenu save_caption="セーブ" save_width=60 save_height=20
;@commandmenu turn_end_left=200 turn_end_top=50 save_left=200

@charactermenu attack_caption="攻撃" move_caption="移動" skill_caption="スキル" status_caption="ステータス" item_caption="アイテム" standby_caption=待機
;@charactermenu move_left=200

@characterstatus name_caption="名前" name_left=10 name_top=10 name_value_left=60 name_value_top=10 name_value_font_height=20 name_value_caption_color=0xFF0000

@characterstatus move_caption="移動力" move_left=10 move_top=40 move_value_left=60 move_value_top=40 move_value_font_height=20

@characterstatus level_caption="レベル" level_left=10 level_top=70 level_value_left=60 level_value_top=70 level_value_font_height=20
@characterstatus max_level_caption="/" max_level_left=100 max_level_top=70 max_level_value_left=130 max_level_value_top=70 max_level_value_font_height=20
@characterstatus level_progress_nographic level_progress_left=10 level_progress_top=110 level_progress_width=120 level_progress_height=20

@characterstatus exp_caption="経験値" exp_left=10 exp_top=140 exp_value_left=50 exp_value_top=145 exp_value_font_height=10
@characterstatus exp_table_caption="/" exp_table_left=80 exp_table_top=140 exp_table_value_left=100 exp_table_value_top=145 exp_table_value_font_height=10
@characterstatus exp_progress_nographic exp_progress_left=10 exp_progress_top=170 exp_progress_width=120 exp_progress_height=20

@characterstatus money_caption="資金" money_left=100 money_top=40 money_value_left=150 money_value_top=45 money_value_font_height=10

@characterstatus class_left=150 class_top=5 class_font_height=20

@characterstatus id="HP" hp_caption="HP" hp_left=10 hp_top=190 hp_value_left=50 hp_value_top=195 hp_value_font_height=10
@characterstatus id="HP" hp_max_caption="/" hp_max_left=80 hp_max_top=190 hp_max_value_left=100 hp_max_value_top=195 hp_max_value_font_height=10
@characterstatus id="HP" hp_progress_nographic hp_progress_left=10 hp_progress_top=220 hp_progress_width=120 hp_progress_height=20 hp_progress_color=0xFFFFFF hp_progress_bar_color=0xFF0000

@characterstatus id="SP" sp_caption="SP" sp_left=10 sp_top=240 sp_value_left=50 sp_value_top=245 sp_value_font_height=10
@characterstatus id="SP" sp_max_caption="/" sp_max_left=80 sp_max_top=240 sp_max_value_left=100 sp_max_value_top=245 sp_max_value_font_height=10
@characterstatus id="SP" sp_progress_nographic sp_progress_left=10 sp_progress_top=270 sp_progress_width=120 sp_progress_height=20

@characterstatus id="int" int_caption="int" int_left=10 int_top=290 int_value_left=50 int_value_top=295 int_value_font_height=10

@characterstatus id="vit" vit_caption="vit" vit_left=10 vit_top=320 vit_value_left=50 vit_value_top=325 vit_value_font_height=10

@characterstatus id="agi" agi_caption="agi" agi_left=10 agi_top=350 agi_value_left=50 agi_value_top=355 agi_value_font_height=10

@characterstatus id="luk" luk_caption="luk" luk_left=10 luk_top=380 luk_value_left=50 luk_value_top=385 luk_value_font_height=10

@characterstatus id="str" str_caption="str" str_left=10 str_top=410 str_value_left=50 str_value_top=415 str_value_font_height=10

@characterstatusskill left=400 top=10 width=400 height=280
@characterstatusskill id="skill0" skill0_left=0 skill0_top=10 skill0_font_height=20
@characterstatusskill id="skill1" skill1_left=100 skill1_top=10 skill1_font_height=20
@characterstatusskill id="skill2" skill2_left=0 skill2_top=40 skill2_font_height=20
@characterstatusskill id="skill3" skill3_left=100 skill3_top=40 skill3_font_height=20
@characterstatusskill id="skill4" skill4_left=0 skill4_top=70 skill4_font_height=20
@characterstatusskill id="skill5" skill5_left=100 skill5_top=70 skill5_font_height=20

@characterstatusitem left=400 top=310 width=400 height=280 equip_icon_storage=equip_icon
@characterstatusitem id="item0" item0_left=40 item0_top=10 item0_font_height=20
@characterstatusitem id="item1" item1_left=220 item1_top=10 item1_font_height=20
@characterstatusitem id="item2" item2_left=40 item2_top=40 item2_font_height=20
@characterstatusitem id="item3" item3_left=220 item3_top=40 item3_font_height=20
@characterstatusitem id="item4" item4_left=40 item4_top=70 item4_font_height=20
@characterstatusitem id="item5" item5_left=220 item5_top=70 item5_font_height=20

@usedskill left=0 top=200 width=800 height=200
@usedskill id="HP" hp_caption="HP" hp_left=10 hp_top=5 hp_value_left=50 hp_value_top=10 hp_value_font_height=10
@usedskill id="HP" hp_max_caption="/" hp_max_left=80 hp_max_top=5 hp_max_value_left=100 hp_max_value_top=10 hp_max_value_font_height=10
@usedskill id="HP" hp_progress_nographic hp_progress_left=10 hp_progress_top=40 hp_progress_width=120 hp_progress_height=20 hp_progress_color=0xFFFFFF hp_progress_bar_color=0xFF0000

@usedskill id="SP" sp_caption="SP" sp_left=10 sp_top=65 sp_value_left=50 sp_value_top=70 sp_value_font_height=10
@usedskill id="SP" sp_max_caption="/" sp_max_left=80 sp_max_top=65 sp_max_value_left=100 sp_max_value_top=70 sp_max_value_font_height=10
@usedskill id="SP" sp_progress_nographic sp_progress_left=10 sp_progress_top=100 sp_progress_width=120 sp_progress_height=20

@usedskill id="int" int_caption="int" int_left=400 int_top=10 int_value_left=450 int_value_top=15 int_value_font_height=10

@usedskill id="vit" vit_caption="vit" vit_left=400 vit_top=30 vit_value_left=450 vit_value_top=35 vit_value_font_height=10

@usedskill id="agi" agi_caption="agi" agi_left=400 agi_top=50 agi_value_left=450 agi_value_top=55 agi_value_font_height=10

@skilllist id="skill0" skill0_storage=skill_button skill0_left=0 skill0_top=0 skill0_font_height=20
@skilllist id="skill1" skill1_storage=skill_button skill1_left=0 skill1_top=30 skill1_font_height=20
@skilllist id="skill2" skill2_storage=skill_button skill2_left=0 skill2_top=60 skill2_font_height=20
@skilllist id="skill3" skill3_storage=skill_button skill3_left=0 skill3_top=90 skill3_font_height=20
@skilllist id="skill4" skill4_storage=skill_button skill4_left=0 skill4_top=120 skill4_font_height=20
@skilllist id="skill5" skill5_storage=skill_button skill5_left=0 skill5_top=150 skill5_font_height=20

@itemmenu equip_icon_storage=equip_icon
@itemmenu id="item0" item0_storage=item_button item0_left=0 item0_top=0 item0_font_height=20
@itemmenu id="item1" item1_storage=item_button item1_left=0 item1_top=30 item1_font_height=20
@itemmenu id="item2" item2_storage=item_button item2_left=0 item2_top=60 item2_font_height=20
@itemmenu id="item3" item3_storage=item_button item3_left=0 item3_top=90 item3_font_height=20
@itemmenu id="item4" item4_storage=item_button item4_left=0 item4_top=120 item4_font_height=20
@itemmenu id="item5" item5_storage=item_button item5_left=0 item5_top=150 item5_font_height=20

@useditem left=0 top=200 width=800 height=200
@useditem id="HP" hp_caption="HP" hp_left=10 hp_top=5 hp_value_left=50 hp_value_top=10 hp_value_font_height=10
@useditem id="HP" hp_max_caption="/" hp_max_left=80 hp_max_top=5 hp_max_value_left=100 hp_max_value_top=10 hp_max_value_font_height=10
@useditem id="HP" hp_progress_nographic hp_progress_left=10 hp_progress_top=40 hp_progress_width=120 hp_progress_height=20 hp_progress_color=0xFFFFFF hp_progress_bar_color=0xFF0000

@useditem id="SP" sp_caption="SP" sp_left=10 sp_top=65 sp_value_left=50 sp_value_top=70 sp_value_font_height=10
@useditem id="SP" sp_max_caption="/" sp_max_left=80 sp_max_top=65 sp_max_value_left=100 sp_max_value_top=70 sp_max_value_font_height=10
@useditem id="SP" sp_progress_nographic sp_progress_left=10 sp_progress_top=100 sp_progress_width=120 sp_progress_height=20

@useditem id="int" int_caption="int" int_left=400 int_top=10 int_value_left=450 int_value_top=15 int_value_font_height=10

@useditem id="vit" vit_caption="vit" vit_left=400 vit_top=30 vit_value_left=450 vit_value_top=35 vit_value_font_height=10

@useditem id="agi" agi_caption="agi" agi_left=400 agi_top=50 agi_value_left=450 agi_value_top=55 agi_value_font_height=10

@exchangemenu form=owner equip_icon_storage=equip_icon id=pass left=200 top=200
@exchangemenu form=owner id="item0" item0_storage=item_button item0_left=0 item0_top=0 item0_font_height=20
@exchangemenu form=owner id="item1" item1_storage=item_button item1_left=0 item1_top=30 item1_font_height=20
@exchangemenu form=owner id="item2" item2_storage=item_button item2_left=0 item2_top=60 item2_font_height=20
@exchangemenu form=owner id="item3" item3_storage=item_button item3_left=0 item3_top=90 item3_font_height=20
@exchangemenu form=owner id="item4" item4_storage=item_button item4_left=0 item4_top=120 item4_font_height=20
@exchangemenu form=owner id="item5" item5_storage=item_button item5_left=0 item5_top=150 item5_font_height=20
@exchangemenu form=target equip_icon_storage=equip_icon left=400 top=200
@exchangemenu form=target id="item0" item0_storage=item_button item0_left=0 item0_top=0 item0_font_height=20
@exchangemenu form=target id="item1" item1_storage=item_button item1_left=0 item1_top=30 item1_font_height=20
@exchangemenu form=target id="item2" item2_storage=item_button item2_left=0 item2_top=60 item2_font_height=20
@exchangemenu form=target id="item3" item3_storage=item_button item3_left=0 item3_top=90 item3_font_height=20
@exchangemenu form=target id="item4" item4_storage=item_button item4_left=0 item4_top=120 item4_font_height=20
@exchangemenu form=target id="item5" item5_storage=item_button item5_left=0 item5_top=150 item5_font_height=20

@equipmenu equip_caption="装備" equip_width=80 equip_height=20
@equipmenu exchange_caption="交換" exchange_width=80 exchange_height=20
@equipmenu discard_caption="捨てる" discard_width=80 discard_height=20

@usedmenu used_caption="使用"
@usedmenu exchange_caption="交換"
@usedmenu discard_caption="捨てる"

@moveendmenu attack_caption="攻撃"
@moveendmenu item_caption="アイテム"
@moveendmenu standby_caption="待機"

@battleconfig enemy_bg_left=0 enemy_bg_top=200 player_bg_left=400 player_bg_top=200
@battleconfig at_base="at_%s_%s_%s"
@battleconfig player_left=650 player_top=200 enemy_left=0 enemy_top=200

@battleconfig which_side=player status_left=400 status_top=0 status_width=400 status_height=600
@battleconfig which_side=enemy status_left=0 status_top=0 status_width=400 status_height=600

@battleconfig exp_storage=expmoney exp_left=200 exp_top=200
@battleconfig exp_progress_left=15 exp_progress_top=90 exp_progress_width=350 exp_progress_height=20 exp_progress_color=0xFFFF00 hp_progress_bar_color=0x00FF00

@battleconfig which_side=player name_caption="名前" name_left=10 name_top=0 name_value_left=50 name_value_top=5 name_value_font_height=10

@battleconfig which_side=player id="HP" hp_caption="HP" hp_left=10 hp_top=420 hp_value_left=50 hp_value_top=420 hp_value_font_height=10
@battleconfig which_side=player id="HP" hp_max_caption="/" hp_max_left=90 hp_max_top=415 hp_max_value_left=100 hp_max_value_top=420 hp_max_value_font_height=10
@battleconfig which_side=player id="HP" hp_progress_nographic hp_progress_left=10 hp_progress_top=450 hp_progress_width=120 hp_progress_height=20 hp_progress_color=0xFFFFFF hp_progress_bar_color=0xFF0000

@battleconfig which_side=player power_caption="攻撃力" power_left=10 power_top=480 power_value_left=50 power_value_top=485 power_value_font_height=10

@battleconfig which_side=player defense_caption="防御力" defense_left=10 defense_top=500 defense_value_left=50 defense_value_top=505 defense_value_font_height=10

@battleconfig which_side=player critical_caption="クリティカル率" critical_left=10 critical_top=520 critical_value_left=90 critical_value_top=525 critical_value_font_height=10

@battleconfig which_side=player avoid_caption="回避率" avoid_left=10 avoid_top=540 avoid_value_left=90 avoid_value_top=545 avoid_value_font_height=10

@battleconfig which_side=enemy name_caption="名前" name_left=10 name_top=0 name_value_left=50 name_value_top=5 name_value_font_height=10

@battleconfig which_side=enemy id="HP" hp_caption="HP" hp_left=10 hp_top=420 hp_value_left=50 hp_value_top=420 hp_value_font_height=10
@battleconfig which_side=enemy id="HP" hp_max_caption="/" hp_max_left=90 hp_max_top=415 hp_max_value_left=100 hp_max_value_top=420 hp_max_value_font_height=10
@battleconfig which_side=enemy id="HP" hp_progress_nographic hp_progress_left=10 hp_progress_top=450 hp_progress_width=120 hp_progress_height=20 hp_progress_color=0xFFFFFF hp_progress_bar_color=0xFF0000

@battleconfig which_side=enemy power_caption="攻撃力" power_left=10 power_top=480 power_value_left=50 power_value_top=485 power_value_font_height=10

@battleconfig which_side=enemy defense_caption="防御力" defense_left=10 defense_top=500 defense_value_left=50 defense_value_top=505 defense_value_font_height=10

@battleconfig which_side=enemy critical_caption="クリティカル率" critical_left=10 critical_top=520 critical_value_left=90 critical_value_top=525 critical_value_font_height=10

@battleconfig which_side=enemy avoid_caption="回避率" avoid_left=10 avoid_top=540 avoid_value_left=90 avoid_value_top=545 avoid_value_font_height=10

@levelup left=200 top=200 width=400 height=200
@levelup level_caption="Lv" level_left=0 level_top=0 level_value_left=40 level_value_top=0
@levelup money_caption="資金" money_left=200 money_top=0 money_value_left=240 money_value_top=0
@levelup id="HP" hp_caption="HP" hp_left=10 hp_top=10 hp_value_left=50 hp_value_top=10 hp_value_font_height=10
@levelup id="HP" hp_max_caption="/" hp_max_left=40 hp_max_top=5 hp_max_value_left=100 hp_max_value_top=10 hp_max_value_font_height=10
@levelup id="HP" hp_progress_nographic hp_progress_left=10 hp_progress_top=45 hp_progress_width=120 hp_progress_height=20 hp_progress_color=0xFFFFFF hp_progress_bar_color=0xFF0000
@levelup id="SP" sp_caption="SP" sp_left=210 sp_top=10 sp_value_left=250 sp_value_top=10 sp_value_font_height=10
@levelup id="SP" sp_max_caption="/" sp_max_left=280 sp_max_top=5 sp_max_value_left=300 sp_max_value_top=10 sp_max_value_font_height=10
@levelup id="SP" sp_progress_nographic sp_progress_left=210 sp_progress_top=45 sp_progress_width=120 sp_progress_height=20
@levelup id="str" str_caption="str" str_left=10 str_top=75 str_value_left=50 str_value_top=75 str_value_font_height=10
@levelup id="int" int_caption="int" int_left=10 int_top=100 int_value_left=50 int_value_top=100 int_value_font_height=10
@levelup id="vit" vit_caption="vit" vit_left=200 vit_top=75 vit_value_left=250 vit_value_top=75 vit_value_font_height=10
@levelup id="agi" agi_caption="agi" agi_left=200 agi_top=100 agi_value_left=250 agi_value_top=100 agi_value_font_height=10
@levelup id="luk" luk_caption="luk" luk_left=200 luk_top=125 luk_value_left=250 luk_value_top=125 luk_value_font_height=10



@classchange left=200 top=200 width=400 height=200
@classchange id="HP" hp_caption="HP" hp_left=10 hp_top=10 hp_value_left=50 hp_value_top=10 hp_value_font_height=10
@classchange id="HP" hp_max_caption="/" hp_max_left=40 hp_max_top=5 hp_max_value_left=100 hp_max_value_top=10 hp_max_value_font_height=10
@classchange id="HP" hp_progress_nographic hp_progress_left=10 hp_progress_top=45 hp_progress_width=120 hp_progress_height=20 hp_progress_color=0xFFFFFF hp_progress_bar_color=0xFF0000

@classchange id="SP" sp_caption="SP" sp_left=210 sp_top=10 sp_value_left=250 sp_value_top=10 sp_value_font_height=10
@classchange id="SP" sp_max_caption="/" sp_max_left=280 sp_max_top=5 sp_max_value_left=300 sp_max_value_top=10 sp_max_value_font_height=10
@classchange id="SP" sp_progress_nographic sp_progress_left=210 sp_progress_top=45 sp_progress_width=120 sp_progress_height=20

@classchange id="str" str_caption="str" str_left=10 str_top=75 str_value_left=50 str_value_top=75 str_value_font_height=10

@classchange id="int" int_caption="int" int_left=10 int_top=100 int_value_left=50 int_value_top=100 int_value_font_height=10

@classchange id="vit" vit_caption="vit" vit_left=200 vit_top=75 vit_value_left=250 vit_value_top=75 vit_value_font_height=10

@classchange id="agi" agi_caption="agi" agi_left=200 agi_top=100 agi_value_left=250 agi_value_top=100 agi_value_font_height=10

@classchange id="luk" luk_caption="luk" luk_left=200 luk_top=125 luk_value_left=250 luk_value_top=125 luk_value_font_height=10

@skilldata info_caption="説明" info_left=10 info_top=10 info_value_left=50 info_value_top=10 info_value_font_height=10

@itemdata power_caption="攻撃力" power_left=10 power_top=10 power_value_left=50 power_value_top=10 power_value_font_height=10
@itemdata defense_caption="防御力（物理）" defense_left=10 defense_top=40 defense_value_left=100 defense_value_top=40 defense_value_font_height=10
@itemdata magic_defense_caption="防御力（魔法）" magic_defense_left=10 magic_defense_top=70 magic_defense_value_left=100 magic_defense_value_top=70 magic_defense_value_font_height=10
@itemdata info_caption="説明" info_left=10 info_top=100 info_value_left=50 info_value_top=100 info_value_font_height=10

@attackstatus name_left_caption="名前" name_left_left=10 name_left_top=10 name_left_value_left=90 name_left_value_top=10 name_left_value_font_height=10
@attackstatus power_left_caption="攻撃力" power_left_left=10 power_left_top=30 power_left_value_left=90 power_left_value_top=30 power_left_value_font_height=10
@attackstatus defense_left_caption="物理防御力" defense_left_left=10 defense_left_top=50 defense_left_value_left=90 defense_left_value_top=50 defense_left_value_font_height=10
@attackstatus magic_defense_left_caption="魔法防御力" magic_defense_left_left=10 magic_defense_left_top=70 magic_defense_left_value_left=90 magic_defense_left_value_top=70 magic_defense_left_value_font_height=10
@attackstatus avoid_left_caption="回避率" avoid_left_left=10 avoid_left_top=90 avoid_left_value_left=90 avoid_left_value_top=90 avoid_left_value_font_height=10
@attackstatus critical_left_caption="クリティカル率" critical_left_left=10 critical_left_top=110 critical_left_value_left=90 critical_left_value_top=110 critical_left_value_font_height=10
@attackstatus name_right_caption="名前" name_right_left=140 name_right_top=10 name_right_value_left=230 name_right_value_top=10 name_right_value_font_height=10
@attackstatus power_right_caption="攻撃力" power_right_left=140 power_right_top=30 power_right_value_left=230 power_right_value_top=30 power_right_value_font_height=10
@attackstatus defense_right_caption="物理防御力" defense_right_left=140 defense_right_top=50 defense_right_value_left=230 defense_right_value_top=50 defense_right_value_font_height=10
@attackstatus magic_defense_right_caption="魔法防御力" magic_defense_right_left=140 magic_defense_right_top=70 magic_defense_right_value_left=230 magic_defense_right_value_top=70 magic_defense_right_value_font_height=10
@attackstatus avoid_right_caption="回避率" avoid_right_left=140 avoid_right_top=90 avoid_right_value_left=230 avoid_right_value_top=90 avoid_right_value_font_height=10
@attackstatus critical_right_caption="クリティカル率" critical_right_left=140 critical_right_top=110 critical_right_value_left=230 critical_right_value_top=110 critical_right_value_font_height=10

@skillsearch skill_left=10 skill_top=100 skill_width=780 skill_height=540 skill_character_list_color=0xFF0000
;@skillsearch skill_left=10 skill_top=100 skill_width=80 skill_height=80 skill_character_list_color=0xFF0000
@skillsearch info_caption="説明" info_left=10 info_top=10 info_value_left=50 info_value_top=10 info_value_font_height=10
@skillsearch skill_button_width=50 skill_button_height=20
@skillsearch skill_character_width=100 skill_character_height=60
@skillsearch skill_character_list_width=80 skill_character_list_height=20

@troops character_list_left=10 character_list_top=25 character_list_width=780 character_list_height=550
@troops record_width=800 record_height=30
@troops name_left=0 name_top=0
@troops level_left=80 level_top=0
@troops exp_left=120 exp_top=0
@troops id=HP hp_left=160 hp_top=0
@troops id=SP sp_left=200 sp_top=0

@slgsystem enter_key_left=10 enter_key_top=10 enter_key_caption="決定キー" enter_key_conf_left=130 enter_key_conf_top=10 enter_key_conf_width=60 enter_key_conf_height=20 enter_key_conf_body_color=0xFF0000
@slgsystem cancel_key_left=10 cancel_key_top=40 cancel_key_caption="キャンセルキー" cancel_key_conf_left=130 cancel_key_conf_top=40 cancel_key_conf_width=60 cancel_key_conf_height=20 cancel_key_conf_body_color=0xFF0000
@slgsystem enter_button_left=10 enter_button_top=70 enter_button_caption="決定キー（PAD）" enter_button_conf_left=130 enter_button_conf_top=70 enter_button_conf_width=60 enter_button_conf_height=20 enter_button_conf_body_color=0xFF0000
@slgsystem cancel_button_left=10 cancel_button_top=100 cancel_button_caption="キャンセルキー（PAD）" cancel_button_conf_left=130 cancel_button_conf_top=100 cancel_button_conf_width=60 cancel_button_conf_height=20 cancel_button_conf_body_color=0xFF0000

@slgsystem master_left=400 master_top=10 master_caption="マスターボリューム" master_slider_left=530 master_slider_top=10 master_slider_width=160 master_slider_height=20 master_slider_body_color=0xFF0000
@slgsystem bgm_left=400 bgm_top=40 bgm_caption="BGMボリューム" bgm_slider_left=530 bgm_slider_top=40 bgm_slider_width=160 bgm_slider_height=20 bgm_slider_body_color=0xFF0000
@slgsystem se_left=400 se_top=70 se_caption="効果音" se_slider_left=530 se_slider_top=70 se_slider_width=160 se_slider_height=20 se_slider_body_color=0xFF0000
@slgsystem vo_left=400 vo_top=100 vo_caption="ボイス" vo_slider_left=530 vo_slider_top=100 vo_slider_width=160 vo_slider_height=20 vo_slider_body_color=0xFF0000

@slgsaveload saveload_left=10 saveload_top=10 saveload_width=780 saveload_height=580
@slgsaveload record_width=780 record_height=140
@slgsaveload index_left=0 index_top=10
@slgsaveload date_left=180 date_top=10
@slgsaveload thumbnail_left=20 thumbnail_top=0 thumbnail_width=150 thumbnail_height=120 thumbnail_color=0xFF0000

@turnendpanel left=300 top=280 width=200 height=40 caption="ターンエンド" font_size=30 caption_color=0xFF0000

*|
@strategy wins_left=10 wins_top=10 wins_caption="勝利条件" wins_value_left=10 wins_value_top=30
@strategy lose_left=10 lose_top=310 lose_caption="敗北条件" lose_value_left=10 lose_value_top=330
@strategy wins_condition="敵の全滅\r\n敵の全滅\r\n敵の全滅"
@strategy lose_condition="味方の全滅"

@createcharacter id=ハロ icon_storage=ハロ_icon
@createcharacter id=味方１ icon_storage=ハロ_icon
@createcharacter id=味方２ name=味方１ icon_storage=ハロ_icon
@createcharacter id=味方３ name=味方１ icon_storage=ハロ_icon
@createcharacter id=味方４ name=味方１ icon_storage=ハロ_icon
@createcharacter id=味方５ name=味方１ icon_storage=ハロ_icon
@createcharacter id=味方６ name=無敵ハロ icon_storage=ハロ_icon
@createcharacter id=敵１ name=ヴィラン icon_storage=villan_icon
@createcharacter id=敵２ name=ヴィラン２ icon_storage=villan_icon
@createcharacter id=敵３ name=シューター icon_storage=villan_icon
@createcharacter id=敵４ name=最強ヴィラン icon_storage=villan_icon
@createcharacter id=敵５ name=ヴィラン icon_storage=villan_icon
@createcharacter id=敵６ name=ヴィラン icon_storage=villan_icon
;@createcharacter id=NPC name=NPC icon_storage=npc_icon

@characterpos id=ハロ x=10 y=12
@characterpos id=味方１ x=11 y=10
@characterpos id=味方２ x=24 y=12
@characterpos id=味方３ x=2 y=1
@characterpos id=味方４ x=34 y=15
@characterpos id=味方５ x=99 y=99
@characterpos id=味方６ x=12 y=12
@characterpos id=敵１ x=15 y=12
@characterpos id=敵２ x=14 y=11
@characterpos id=敵３ x=10 y=1
@characterpos id=敵４ x=11 y=12
@characterpos id=敵５ x=12 y=11
@characterpos id=敵６ x=20 y=8
;@characterpos id=NPC x=20 y=10

@additem id=ハロ item_name=鉄の剣
@additem id=ハロ item_name=鉄の剣
@additem id=ハロ item_name=薬草
@additem id=ハロ item_name=パラメータ増加
@additem id=ハロ item_name=クラスチェンジ
@additem id=ハロ item_name=星のオーブ

@additem id=味方１ item_name=ファイアの書

@additem id=味方２ item_name=ファイアの書
@additem id=味方２ item_name=薬草
@additem id=味方２ item_name=パラメータ増加

@additem id=味方５ item_name=鉄の剣

@additem id=味方６ item_name=勇者の剣

@additem id=敵１ item_name=鉄の剣

@additem id=敵２ item_name=ロングボウ
@additem id=敵２ item_name=鉄の弓

@additem id=敵３ item_name=投石

@additem id=敵４ item_name=勇者の剣

@additem id=敵６ item_name=鉄の剣

;@additem id=NPC item_name=鉄の剣

*|
@showmap time=200
@s

