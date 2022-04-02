
*label|


*|
@mapchip storage=mapchips.chp

*|
@slgdebug operation_all=true

@slgconfig hp=HP sp=SP

@loadmap storage=test2.map
@loadcursor storage=mapcursor moving=movingcursor attack=attackcursor item=itemcursor skill=skillcursor
@loaditem item_storage=item weapon_type_storage=weapontype
@loadskilldef storage=skilllist

@setmapstatus visible font_height=20

@loadcharacter name=ハロ storage=chardata.chr character_type=player
@loadcharacter name=味方１ storage=player1.chr character_type=player
@loadcharacter name=ヴィラン storage=villan.chr character_type=enemy
@loadcharacter name=ヴィラン２ storage=villan2.chr character_type=enemy
@loadcharacter name=シューター storage=villan3.chr character_type=enemy

@commandmenu turn_end_caption="ターンエンド" skill_search_caption="スキル探索" troops_caption="部隊表" strategy_caption="作戦目的" system_caption="システム" save_caption="セーブ"
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

@characterstatus id="skill0" skill0_left=400 skill0_top=10 skill0_font_height=20
@characterstatus id="skill1" skill1_left=500 skill1_top=10 skill1_font_height=20
@characterstatus id="skill2" skill2_left=400 skill2_top=40 skill2_font_height=20
@characterstatus id="skill3" skill3_left=500 skill3_top=40 skill3_font_height=20
@characterstatus id="skill4" skill4_left=400 skill4_top=70 skill4_font_height=20
@characterstatus id="skill5" skill5_left=500 skill5_top=70 skill5_font_height=20

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

@equipmenu equip_caption="装備"
@equipmenu exchange_caption="交換"
@equipmenu discard_caption="捨てる"

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

@itemdata width=280 height=180
@itemdata power_caption="攻撃力" power_left=10 power_top=10 power_value_left=50 power_value_top=10 power_value_font_height=10
@itemdata defense_caption="防御力（物理）" defense_left=10 defense_top=40 defense_value_left=100 defense_value_top=40 defense_value_font_height=10
@itemdata magic_defense_caption="防御力（魔法）" magic_defense_left=10 magic_defense_top=70 magic_defense_value_left=100 magic_defense_value_top=70 magic_defense_value_font_height=10
@itemdata info_caption="説明" info_left=10 info_top=100 info_value_left=50 info_value_top=100 info_value_font_height=10

@attackstatus width=300 height=200
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

*|
@createcharacter id=player1 name=ハロ icon_storage=ハロ_icon
@createcharacter id=player2 name=味方１ icon_storage=ハロ_icon
@createcharacter id=enemy1 name=ヴィラン icon_storage=villan_icon
@createcharacter id=enemy2 name=ヴィラン２ icon_storage=villan_icon
@createcharacter id=enemy3 name=シューター icon_storage=villan_icon

@setcharacterpos id=player1 x=10 y=12
@setcharacterpos id=player2 x=11 y=10
@setcharacterpos id=enemy1 x=15 y=12
@setcharacterpos id=enemy2 x=14 y=11
@setcharacterpos id=enemy3 x=10 y=1

@additem id=player1 item_name=鉄の剣
@additem id=player1 item_name=鉄の剣
@additem id=player1 item_name=薬草
@additem id=player1 item_name=パラメータ増加
@additem id=player1 item_name=クラスチェンジ
@additem id=player1 item_name=星のオーブ

@additem id=player2 item_name=ファイアの書

@additem id=enemy1 item_name=鉄の剣

@additem id=enemy2 item_name=ロングボウ
@additem id=enemy2 item_name=鉄の弓

@additem id=enemy3 item_name=投石

@showmap time=200
@s

