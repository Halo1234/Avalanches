
*label|
; History is a nuisance, so turn it off
@history_option !enabled


;@slgfadeinbgm storage=bgm001.ogg time=2000
@slgclear

*|
@slgmapchip storage=mapchips.chp

*|
;@slgdebug operation_all=true

@slgconfig hp=HP sp=SP
@slgconfig item_max_count=6 skill_max_count=6
@slgconfig game_over_label=*gameover money=10000
@slgconfig enemy_count=0 enemy_count_label=*enemy_count
@slgconfig sound_buffer=0 enter_sound=se002.ogg
@slgconfig cursor_sound_buffer=0 cursor_enter_sound=se002.ogg
@slgconfig bgm_storage=bgm001.ogg battle_bgm_storage=bgm002.ogg
;@slgconfig rebirth_character

@slgloadmap storage=test2.map
@slgloadcursor storage=mapcursor moving=movingcursor attack=attackcursor item=itemcursor skill=skillcursor talk=talkcursor
@slgloaditem item_storage=item weapon_type_storage=weapontype
@slgloadskilldef storage=skilllist
@slgloadclassdef storage=classdata

@slgloadcharacter storage=chardata.chr character_type=player icon_storage=ハロ_icon
@slgloadcharacter storage=player1.chr character_type=player icon_storage=ハロ_icon
@slgloadcharacter storage=player2.chr character_type=player icon_storage=ハロ_icon
@slgloadcharacter storage=player3.chr character_type=player icon_storage=ハロ_icon
@slgloadcharacter storage=player4.chr character_type=player icon_storage=ハロ_icon
@slgloadcharacter storage=maxplayer.chr character_type=player icon_storage=ハロ_icon
@slgloadcharacter storage=ゲームマスター.chr character_type=player icon_storage=ハロ_icon
@slgloadcharacter storage=villan.chr character_type=enemy icon_storage=villan_icon
@slgloadcharacter storage=villan2.chr character_type=enemy icon_storage=villan_icon
@slgloadcharacter storage=villan3.chr character_type=enemy icon_storage=villan_icon
@slgloadcharacter storage=villan4.chr character_type=enemy icon_storage=villan_icon
@slgloadcharacter storage=maxvillan.chr character_type=enemy icon_storage=villan_icon
@slgloadcharacter storage=npc.chr character_type=npc icon_storage=npc_icon

;@slgmapstatus storage=commandmenu
@slgmapstatus visible width=200 height=120
@slgmapstatus caption_value_left=0 caption_value_top=0
@slgmapstatus move_caption="Moving load" move_left=0 move_top=20 move_value_left=60 move_value_top=20
@slgmapstatus defense_caption="Defense effect" defense_left=0 defense_top=40 defense_value_left=60 defense_value_top=40
@slgmapstatus avoid_caption="Avoid effect" avoid_left=0 avoid_top=60 avoid_value_left=60 avoid_value_top=60
@slgmapstatus axis_caption="coordinates" axis_left=0 axis_top=80 axis_value_left=60 axis_value_top=80

;@slgcommandmenu storage=commandmenu
@slgcommandmenu turn_end_caption="Turn End" turn_end_width=60 turn_end_height=20
@slgcommandmenu skill_search_caption="Skill Search" skill_search_width=60 skill_search_height=20
@slgcommandmenu troops_caption="troop table" troops_width=60 troops_height=20
@slgcommandmenu strategy_caption="Operation Objective" strategy_width=60 strategy_height=20
@slgcommandmenu system_caption="System" system_width=60 system_height=20
@slgcommandmenu load_caption="Load" load_width=60 load_height=20
@slgcommandmenu save_caption="Save" save_width=60 save_height=20
;@slgcommandmenu turn_end_left=200 turn_end_top=50 save_left=200

;@slgcharactermenu storage=commandmenu
@slgcharactermenu attack_caption="Attack" rest_caption="Stand" weapon_shop_caption="Weapon Shop" armor_shop_caption="Armor Shop" item_shop_caption="Tool Shop" arena_caption="Arena" door_caption="Door" talk_caption="Speak" visit_caption="Visit " control_caption="Conquer" treasure_caption="Open treasure chest" move_caption="Move" skill_caption="Skill" status_caption="Status" item_caption="Item" exchange_caption="Exchange" hangar_caption="Warehouse" standby_caption=Standby
;@slgcharactermenu move_left=200

;@slgcharacterstatus storage=background
@slgcharacterstatus name_caption="Name" name_left=10 name_top=10 name_value_left=60 name_value_top=10 name_value_font_height=20 name_value_caption_color=0xFF0000

@slgcharacterstatus move_caption="Movement power" move_left=10 move_top=40 move_value_left=60 move_value_top=40 move_value_font_height=20

@slgcharacterstatus level_caption="Level" level_left=10 level_top=70 level_value_left=60 level_value_top=70 level_value_font_height=20
@slgcharacterstatus max_level_caption="/" max_level_left=100 max_level_top=70 max_level_value_left=130 max_level_value_top=70 max_level_value_font_height=20
@slgcharacterstatus level_progress_nographic level_progress_left=10 level_progress_top=110 level_progress_width=120 level_progress_height=20

@slgcharacterstatus exp_caption="Experience Points" exp_left=10 exp_top=140 exp_value_left=50 exp_value_top=145 exp_value_font_height=10
@slgcharacterstatus exp_table_caption="/" exp_table_left=80 exp_table_top=140 exp_table_value_left=100 exp_table_value_top=145 exp_table_value_font_height=10
@slgcharacterstatus exp_progress_nographic exp_progress_left=10 exp_progress_top=170 exp_progress_width=120 exp_progress_height=20

@slgcharacterstatus money_caption="Funds" money_left=100 money_top=40 money_value_left=150 money_value_top=45 money_value_font_height=10

@slgcharacterstatus class_left=150 class_top=5 class_font_height=20

@slgcharacterstatus id="HP" hp_caption="HP" hp_left=10 hp_top=190 hp_value_left=50 hp_value_top=195 hp_value_font_height=10
@slgcharacterstatus id="HP" hp_max_caption="/" hp_max_left=80 hp_max_top=190 hp_max_value_left=100 hp_max_value_top=195 hp_max_value_font_height=10
@slgcharacterstatus id="HP" hp_progress_nographic hp_progress_left=10 hp_progress_top=220 hp_progress_width=120 hp_progress_height=20 hp_progress_color=0xFFFFFF hp_progress_bar_color=0xFF0000

@slgcharacterstatus id="SP" sp_caption="SP" sp_left=10 sp_top=240 sp_value_left=50 sp_value_top=245 sp_value_font_height=10
@slgcharacterstatus id="SP" sp_max_caption="/" sp_max_left=80 sp_max_top=240 sp_max_value_left=100 sp_max_value_top=245 sp_max_value_font_height=10
@slgcharacterstatus id="SP" sp_progress_nographic sp_progress_left=10 sp_progress_top=270 sp_progress_width=120 sp_progress_height=20

@slgcharacterstatus id="int" int_caption="int" int_left=180 int_top=140 int_value_left=220 int_value_top=145 int_value_font_height=10 int_append_left=250 int_append_top=145 int_append_value_left=270 int_append_value_top=145

@slgcharacterstatus id="vit" vit_caption="vit" vit_left=180 vit_top=170 vit_value_left=220 vit_value_top=175 vit_value_font_height=10 vit_append_left=250 vit_append_top=175 vit_append_value_left=270 vit_append_value_top=175

@slgcharacterstatus id="agi" agi_caption="agi" agi_left=180 agi_top=200 agi_value_left=220 agi_value_top=205 agi_value_font_height=10 agi_append_left=250 agi_append_top=205 agi_append_value_left=270 agi_append_value_top=205

@slgcharacterstatus id="luk" luk_caption="luk" luk_left=180 luk_top=230 luk_value_left=220 luk_value_top=235 luk_value_font_height=10 luk_append_left=250 luk_append_top=235 luk_append_value_left=270 luk_append_value_top=235

@slgcharacterstatus id="str" str_caption="str" str_left=180 str_top=260 str_value_left=220 str_value_top=265 str_value_font_height=10 str_append_left=250 str_append_top=265 str_append_value_left=270 str_append_value_top=265

@slgcharacterstatusinfo left=10 top=290 width=380 height=180
@slgcharacterstatusinfo name_value_left=10 name_value_top=0 count_value_left=50 count_value_top=0
@slgcharacterstatusinfo power_left=10 power_top=20 power_caption=Attack power power_value_left=70 power_value_top=20
@slgcharacterstatusinfo range_left=10 range_top=40 range_caption=Attack range range_value_left=70 range_value_top=40
@slgcharacterstatusinfo info_value_left=10 info_value_top=60
;@slgcharacterstatusskill storage=background2
@slgcharacterstatusskill left=400 top=10 width=400 height=280
@slgcharacterstatusskill skill_width=400 skill_height=20 skill_color=0xFF0000

;@slgcharacterstatusitem storage=background2
@slgcharacterstatusitem left=400 top=310 width=400 height=280 equip_icon_storage=equip_icon font_height=20
@slgcharacterstatusitem item_width=400 item_height=20

;@slgcharacterstatusabnormal storage=background2
@slgcharacterstatusabnormal left=10 top=450 width=380 height=100
@slgcharacterstatusabnormal abnormal_width=380 abnormal_height=30 abnormal_color=0xFF0000
;@slgcharacterstatusabnormal no_action_storage=noActionIcon seal_magic_storage=sealMagicIcon panic_storage=panicIcon

;@slgusedskill storage=background3
@slgusedskill left=0 top=200 width=800 height=200
@slgusedskill id="HP" hp_caption="HP" hp_left=10 hp_top=5 hp_value_left=50 hp_value_top=10 hp_value_font_height=10
@slgusedskill id="HP" hp_max_caption="/" hp_max_left=80 hp_max_top=5 hp_max_value_left=100 hp_max_value_top=10 hp_max_value_font_height=10
@slgusedskill id="HP" hp_progress_nographic hp_progress_left=10 hp_progress_top=40 hp_progress_width=120 hp_progress_height=20 hp_progress_color=0xFFFFFF hp_progress_bar_color=0xFF0000

@slgusedskill id="SP" sp_caption="SP" sp_left=10 sp_top=65 sp_value_left=50 sp_value_top=70 sp_value_font_height=10
@slgusedskill id="SP" sp_max_caption="/" sp_max_left=80 sp_max_top=65 sp_max_value_left=100 sp_max_value_top=70 sp_max_value_font_height=10
@slgusedskill id="SP" sp_progress_nographic sp_progress_left=10 sp_progress_top=100 sp_progress_width=120 sp_progress_height=20

@slgusedskill id="int" int_caption="int" int_left=400 int_top=10 int_value_left=450 int_value_top=15 int_value_font_height=10

@slgusedskill id="vit" vit_caption="vit" vit_left=400 vit_top=30 vit_value_left=450 vit_value_top=35 vit_value_font_height=10

@slgusedskill id="agi" agi_caption="agi" agi_left=400 agi_top=50 agi_value_left=450 agi_value_top=55 agi_value_font_height=10

;@slgskillmenu storage=background3
@slgskillmenu skill_storage=skill_button font_height=20

;@slgitemmenu storage=background3
@slgitemmenu equip_icon_storage=equip_icon
@slgitemmenu item_storage=item_button

;@slgweaponmenu storage=background3
@slgweaponmenu weapon_storage=item_button

;@slgrestweaponmenu storage=background3
@slgrestweaponmenu rest_weapon_storage=item_button

;@slguseditem storage=background3
@slguseditem left=0 top=200 width=800 height=200
@slguseditem id="HP" hp_caption="HP" hp_left=10 hp_top=5 hp_value_left=50 hp_value_top=10 hp_value_font_height=10
@slguseditem id="HP" hp_max_caption="/" hp_max_left=80 hp_max_top=5 hp_max_value_left=100 hp_max_value_top=10 hp_max_value_font_height=10
@slguseditem id="HP" hp_progress_nographic hp_progress_left=10 hp_progress_top=40 hp_progress_width=120 hp_progress_height=20 hp_progress_color=0xFFFFFF hp_progress_bar_color=0xFF0000

@slguseditem id="SP" sp_caption="SP" sp_left=10 sp_top=65 sp_value_left=50 sp_value_top=70 sp_value_font_height=10
@slguseditem id="SP" sp_max_caption="/" sp_max_left=80 sp_max_top=65 sp_max_value_left=100 sp_max_value_top=70 sp_max_value_font_height=10
@slguseditem id="SP" sp_progress_nographic sp_progress_left=10 sp_progress_top=100 sp_progress_width=120 sp_progress_height=20

@slguseditem id="int" int_caption="int" int_left=400 int_top=10 int_value_left=450 int_value_top=15 int_value_font_height=10

@slguseditem id="vit" vit_caption="vit" vit_left=400 vit_top=30 vit_value_left=450 vit_value_top=35 vit_value_font_height=10

@slguseditem id="agi" agi_caption="agi" agi_left=400 agi_top=50 agi_value_left=450 agi_value_top=55 agi_value_font_height=10

;@slgexchangemenu form=owner storage=background3
@slgexchangemenu form=owner equip_icon_storage=equip_icon left=200 top=200
@slgexchangemenu form=owner item_storage=item_button
;@slgexchangemenu form=target storage=background3
@slgexchangemenu form=target equip_icon_storage=equip_icon left=420 top=200
@slgexchangemenu form=target item_storage=item_button
;@slgexchangemenu form=hangar storage=background3
@slgexchangemenu form=hangar left=420 top=200 font_height=20
@slgexchangemenu form=hangar item_storage=item_button

;@slgitemsubmenu storage=background2
@slgitemsubmenu used_caption="Used"
@slgitemsubmenu equip_caption="Equipment"
@slgitemsubmenu donot_equip_caption="Unequip"
@slgitemsubmenu discard_caption="Discard"

@slgbattle storage=background
@slgbattle enemy_bg_left=0 enemy_bg_top=200 player_bg_left=400 player_bg_top=200
@slgbattle move_character=false
@slgbattle player_left=450 player_top=200 enemy_left=200 enemy_top=200
;@slgbattle player_attack_left=450 enemy_attack_left=150

@slgbattle which_side=player status_left=400 status_top=0 status_width=400 status_height=600
@slgbattle which_side=enemy status_left=0 status_top=0 status_width=400 status_height=600

@slgbattle exp_storage=expmoney exp_left=200 exp_top=200
@slgbattle exp_progress_left=15 exp_progress_top=90 exp_progress_width=350 exp_progress_height=20 exp_progress_color=0xFFFF00 hp_progress_bar_color=0x00FF00

@slgbattle which_side=player name_caption="Name" name_left=10 name_top=0 name_value_left=50 name_value_top=5 name_value_font_height=10

@slgbattle which_side=player id="HP" hp_caption="HP" hp_left=10 hp_top=420 hp_value_left=50 hp_value_top=420 hp_value_font_height=10
@slgbattle which_side=player id="HP" hp_max_caption="/" hp_max_left=90 hp_max_top=415 hp_max_value_left=100 hp_max_value_top=420 hp_max_value_font_height=10
@slgbattle which_side=player id="HP" hp_progress_nographic hp_progress_left=10 hp_progress_top=450 hp_progress_width=120 hp_progress_height=20 hp_progress_color=0xFFFFFF hp_progress_bar_color=0xFF0000

@slgbattle which_side=player power_caption="Attack Power" power_left=10 power_top=480 power_value_left=50 power_value_top=485 power_value_font_height=10

@slgbattle which_side=player defense_caption="Defense" defense_left=10 defense_top=500 defense_value_left=50 defense_value_top=505 defense_value_font_height=10

@slgbattle which_side=player critical_caption="Critical rate" critical_left=10 critical_top=520 critical_value_left=90 critical_value_top=525 critical_value_font_height=10

@slgbattle which_side=player avoid_caption="Avoidance rate" avoid_left=10 avoid_top=540 avoid_value_left=90 avoid_value_top=545 avoid_value_font_height=10

@slgbattle which_side=enemy name_caption="Name" name_left=10 name_top=0 name_value_left=50 name_value_top=5 name_value_font_height=10

@slgbattle which_side=enemy id="HP" hp_caption="HP" hp_left=10 hp_top=420 hp_value_left=50 hp_value_top=420 hp_value_font_height=10
@slgbattle which_side=enemy id="HP" hp_max_caption="/" hp_max_left=90 hp_max_top=415 hp_max_value_left=100 hp_max_value_top=420 hp_max_value_font_height=10
@slgbattle which_side=enemy id="HP" hp_progress_nographic hp_progress_left=10 hp_progress_top=450 hp_progress_width=120 hp_progress_height=20 hp_progress_color=0xFFFFFF hp_progress_bar_color=0xFF0000

@slgbattle which_side=enemy power_caption="Attack Power" power_left=10 power_top=480 power_value_left=50 power_value_top=485 power_value_font_height=10

@slgbattle which_side=enemy defense_caption="Defense" defense_left=10 defense_top=500 defense_value_left=50 defense_value_top=505 defense_value_font_height=10

@slgbattle which_side=enemy critical_caption="Critical rate" critical_left=10 critical_top=520 critical_value_left=90 critical_value_top=525 critical_value_font_height=10

@slgbattle which_side=enemy avoid_caption="Escape rate" avoid_left=10 avoid_top=540 avoid_value_left=90 avoid_value_top=545 avoid_value_font_height=10

@slgsimplebattle which_side=player status_left=200 status_top=450 status_width=200 status_height=60
@slgsimplebattle which_side=enemy status_left=400 status_top=450 status_width=200 status_height=60

@slgsimplebattle exp_storage=expmoney exp_left=200 exp_top=200
@slgsimplebattle exp_progress_left=15 exp_progress_top=90 exp_progress_width=350 exp_progress_height=20 exp_progress_color=0xFFFF00 hp_progress_bar_color=0x00FF00

@slgsimplebattle which_side=player name_value_left=5 name_value_top=5 name_value_font_height=10
@slgsimplebattle which_side=player id="HP" hp_progress_nographic hp_progress_left=5 hp_progress_top=20 hp_progress_width=160 hp_progress_height=20 hp_progress_color=0xFFFFFF hp_progress_bar_color=0xFF0000

@slgsimplebattle which_side=enemy name_value_left=5 name_value_top=5 name_value_font_height=10
@slgsimplebattle which_side=enemy id="HP" hp_progress_nographic hp_progress_left=5 hp_progress_top=20 hp_progress_width=160 hp_progress_height=20 hp_progress_color=0xFFFFFF hp_progress_bar_color=0xFF0000

;@slglevelup levelup_storage=background3
@slglevelup levelup_left=200 levelup_top=200 levelup_width=400 levelup_height=200
@slglevelup level_caption="Lv" level_left=0 level_top=0 level_value_left=40 level_value_top=0
@slglevelup money_caption="Funds" money_left=200 money_top=0 money_value_left=240 money_value_top=0
@slglevelup id="HP" hp_caption="HP" hp_left=10 hp_top=10 hp_value_left=50 hp_value_top=10 hp_value_font_height=10
@slglevelup id="HP" hp_max_caption="/" hp_max_left=40 hp_max_top=5 hp_max_value_left=100 hp_max_value_top=10 hp_max_value_font_height=10
@slglevelup id="HP" hp_progress_nographic hp_progress_left=10 hp_progress_top=45 hp_progress_width=120 hp_progress_height=20 hp_progress_color=0xFFFFFF hp_progress_bar_color=0xFF0000
@slglevelup id="SP" sp_caption="SP" sp_left=210 sp_top=10 sp_value_left=250 sp_value_top=10 sp_value_font_height=10
@slglevelup id="SP" sp_max_caption="/" sp_max_left=280 sp_max_top=5 sp_max_value_left=300 sp_max_value_top=10 sp_max_value_font_height=10
@slglevelup id="SP" sp_progress_nographic sp_progress_left=210 sp_progress_top=45 sp_progress_width=120 sp_progress_height=20
@slglevelup id="str" str_caption="str" str_left=10 str_top=75 str_value_left=50 str_value_top=75 str_value_font_height=10
@slglevelup id="int" int_caption="int" int_left=10 int_top=100 int_value_left=50 int_value_top=100 int_value_font_height=10
@slglevelup id="vit" vit_caption="vit" vit_left=200 vit_top=75 vit_value_left=250 vit_value_top=75 vit_value_font_height=10
@slglevelup id="agi" agi_caption="agi" agi_left=200 agi_top=100 agi_value_left=250 agi_value_top=100 agi_value_font_height=10
@slglevelup id="luk" luk_caption="luk" luk_left=200 luk_top=125 luk_value_left=250 luk_value_top=125 luk_value_font_height=10



;@slgclasschange storage=background
@slgclasschange parameter_left=200 parameter_top=200 parameter_width=400 parameter_height=200
@slgclasschange id="HP" hp_caption="HP" hp_left=10 hp_top=10 hp_value_left=50 hp_value_top=10 hp_value_font_height=10
@slgclasschange id="HP" hp_max_caption="/" hp_max_left=40 hp_max_top=5 hp_max_value_left=100 hp_max_value_top=10 hp_max_value_font_height=10
@slgclasschange id="HP" hp_progress_nographic hp_progress_left=10 hp_progress_top=45 hp_progress_width=120 hp_progress_height=20 hp_progress_color=0xFFFFFF hp_progress_bar_color=0xFF0000

@slgclasschange id="SP" sp_caption="SP" sp_left=210 sp_top=10 sp_value_left=250 sp_value_top=10 sp_value_font_height=10
@slgclasschange id="SP" sp_max_caption="/" sp_max_left=280 sp_max_top=5 sp_max_value_left=300 sp_max_value_top=10 sp_max_value_font_height=10
@slgclasschange id="SP" sp_progress_nographic sp_progress_left=210 sp_progress_top=45 sp_progress_width=120 sp_progress_height=20

@slgclasschange id="str" str_caption="str" str_left=10 str_top=75 str_value_left=50 str_value_top=75 str_value_font_height=10

@slgclasschange id="int" int_caption="int" int_left=10 int_top=100 int_value_left=50 int_value_top=100 int_value_font_height=10

@slgclasschange id="vit" vit_caption="vit" vit_left=200 vit_top=75 vit_value_left=250 vit_value_top=75 vit_value_font_height=10

@slgclasschange id="agi" agi_caption="agi" agi_left=200 agi_top=100 agi_value_left=250 agi_value_top=100 agi_value_font_height=10

@slgclasschange id="luk" luk_caption="luk" luk_left=200 luk_top=125 luk_value_left=250 luk_value_top=125 luk_value_font_height=10

@slgskilldata info_caption="Description" info_left=10 info_top=10 info_value_left=50 info_value_top=10 info_value_font_height=10

;@slgitemdata storage=background3
@slgitemdata power_caption="Attack power" power_left=10 power_top=10 power_value_left=50 power_value_top=10 power_value_font_height=10
@slgitemdata defense_caption="Defense (Physical)" defense_left=10 defense_top=40 defense_value_left=100 defense_value_top=40 defense_value_font_height=10
@slgitemdata magic_defense_caption="Defense power (magic)" magic_defense_left=10 magic_defense_top=70 magic_defense_value_left=100 magic_defense_value_top=70 magic_defense_value_font_height=10
@slgitemdata info_caption="Description" info_left=10 info_top=100 info_value_left=50 info_value_top=100 info_value_font_height=10

;@slgattackstatus storage=background3
@slgattackstatus name_left_caption="Name" name_left_left=10 name_left_top=10 name_left_value_left=90 name_left_value_top=10 name_left_value_font_height=10
@slgattackstatus hp_left_caption="HP" hp_left_left=10 hp_left_top=30 hp_left_value_left=90 hp_left_value_top=30 hp_left_value_font_height=10
@slgattackstatus power_left_caption="Attack Power" power_left_left=10 power_left_top=50 power_left_value_left=90 power_left_value_top=50 power_left_value_font_height=10
@slgattackstatus defense_left_caption="Physical Defense" defense_left_left=10 defense_left_top=70 defense_left_value_left=90 defense_left_value_top=70 defense_left_value_font_height=10
@slgattackstatus magic_defense_left_caption="Magic Defense" magic_defense_left_left=10 magic_defense_left_top=90 magic_defense_left_value_left=90 magic_defense_left_value_top=90 magic_defense_left_value_font_height=10
@slgattackstatus avoid_left_caption="Avoidance rate" avoid_left_left=10 avoid_left_top=110 avoid_left_value_left=90 avoid_left_value_top=110 avoid_left_value_font_height=10
@slgattackstatus critical_left_caption="Critical rate" critical_left_left=10 critical_left_top=130 critical_left_value_left=90 critical_left_value_top=130 critical_left_value_font_height=10
@slgattackstatus name_right_caption="Name" name_right_left=140 name_right_top=10 name_right_value_left=230 name_right_value_top=10 name_right_value_font_height=10
@slgattackstatus hp_right_caption="HP" hp_right_left=140 hp_right_top=30 hp_right_value_left=230 hp_right_value_top=30 hp_right_value_font_height=10
@slgattackstatus power_right_caption="Attack Power" power_right_left=140 power_right_top=50 power_right_value_left=230 power_right_value_top=50 power_right_value_font_height=10
@slgattackstatus defense_right_caption="Physical Defense" defense_right_left=140 defense_right_top=70 defense_right_value_left=230 defense_right_value_top=70 defense_right_value_font_height=10
@slgattackstatus magic_defense_right_caption="Magic Defense" magic_defense_right_left=140 magic_defense_right_top=90 magic_defense_right_value_left=230 magic_defense_right_value_top=90 magic_defense_right_value_font_height=10
@slgattackstatus avoid_right_caption="Avoidance rate" avoid_right_left=140 avoid_right_top=110 avoid_right_value_left=230 avoid_right_value_top=110 avoid_right_value_font_height=10
@slgattackstatus critical_right_caption="Critical rate" critical_right_left=140 critical_right_top=130 critical_right_value_left=230 critical_right_value_top=130 critical_right_value_font_height=10

;@slgskillsearch storage=background
@slgskillsearch skill_list_left=10 skill_list_top=100 skill_list_width=780 skill_list_height=540 skill_character_list_color=0xFF0000
;@slgskillsearch skill_list_left=10 skill_list_top=100 skill_list_width=160 skill_list_height=40 skill_character_list_color=0xFF0000
@slgskillsearch info_caption="Description" info_left=10 info_top=10 info_value_left=50 info_value_top=10 info_value_font_height=10
@slgskillsearch skill_button_width=50 skill_button_height=20
@slgskillsearch skill_character_list_width=100 skill_character_list_height=60
;@slgskillsearch skill_character_list_count=8
@slgskillsearch skill_character_list_button_width=80 skill_character_list_button_height=20
;@slgskillsearch skill_enter_sound_storage=se002.ogg
;@slgskillsearch skill_character_list_enter_sound_storage=se002.ogg

;@slgtroops storage=background
@slgtroops character_list_left=10 character_list_top=25 character_list_width=780 character_list_height=100
@slgtroops record_width=800 record_height=30
@slgtroops name_left=0 name_top=0
@slgtroops level_left=80 level_top=0
@slgtroops exp_left=120 exp_top=0
@slgtroops id=HP hp_left=160 hp_top=0
@slgtroops id=SP sp_left=200 sp_top=0
;@slgtroops record_enter_sound_storage=se002.ogg

@slgturnendpanel left=300 top=280 width=200 height=40 caption="Turn End" font_height=30 caption_color=0xFF0000
@slgturnstartpanel left=300 top=280 width=200 height=40 caption="Turn Start" font_height=30 caption_color=0xFF0000
@slgai level=3 search=25

;@slgrevival storage=background2
@slgrevival record_width=380 record_height=40
@slgrevival left=200 top=150 width=400 height=300 character_list_left=10 character_list_top=25 character_list_width=380 character_list_height=220
@slgrevival name_left=0 name_top=0
@slgrevival level_left=80 level_top=0
@slgrevival exp_left=120 exp_top=0
@slgrevival id=HP hp_left=160 hp_top=0
@slgrevival id=SP sp_left=200 sp_top=0
;@slgrevival status_caption="Status" status_left=300 status_top=0 status_width=60 status_height=20

@slgshop left=0 top=0 width=800 height=600 list_left=560 list_top=10 list_width=220 list_height=280
@slgshop money_caption="Money you have" money_left=10 money_top=10 money_value_left=80 money_value_top=10 money_value_width=200 money_value_height=20
@slgshop buy_caption="Buy" buy_left=10 buy_top=560 buy_width=50 buy_height=20
@slgshop sell_caption="Sell" sell_left=70 sell_top=560 sell_width=50 sell_height=20
@slgshop shop_storage=item_button caption_color=0x000000

@slgweaponshop color=0xFF0000
;@slgweaponshop storage=background
@slgweaponshop x=13 y=12 item_name="鉄の剣" count=1
@slgweaponshop x=13 y=12 item_name="鉄の剣" count=1
@slgweaponshop x=13 y=12 item_name="鉄の剣" count=1
@slgweaponshop x=13 y=12 item_name="鉄の剣" count=1
@slgweaponshop x=13 y=12 item_name="鉄の剣" count=1
@slgweaponshop x=13 y=12 item_name="鉄の剣" count=1
@slgweaponshop x=13 y=12 item_name="エクスカリバー" count=1
@slgweaponshop x=13 y=12 item_name="エクスカリバー" count=1
@slgweaponshop x=13 y=12 item_name="エクスカリバー" count=1
@slgweaponshop x=13 y=12 item_name="エクスカリバー" count=1
@slgweaponshop x=13 y=12 item_name="エクスカリバー" count=1
@slgweaponshop x=13 y=12 item_name="エクスカリバー" count=1
@slgweaponshop x=13 y=12 item_name="エクスカリバー" count=1
@slgweaponshop x=13 y=12 item_name="エクスカリバー" count=1
@slgweaponshop x=13 y=12 item_name="薬草" count=1
@slgweaponshop x=13 y=12 item_name="薬草" count=1
@slgweaponshop x=13 y=12 item_name="薬草" count=1
@slgarmorshop color=0x00FF00
;@slgarmorshop storage=background
@slgitemshop color=0x0000FF
;@slgitemshop storage=background

;@slgarenainfo storage=background
@slgarenainfo width=800 height=600
@slgarenainfo ok_caption="Battle begins" ok_left=600 ok_top=550
@slgarenainfo cancel_caption="Cancel" cancel_left=670 cancel_top=550

@slgarenainfo name_left_value_left=10 name_left_value_top=10
@slgarenainfo level_left_caption="Level" level_left_left=10 level_left_top=40 level_left_value_left=50 level_left_value_top=40
@slgarenainfo class_left_value_left=10 class_left_value_top=70
@slgarenainfo id="HP" hp_left_caption="HP" hp_left_left=10 hp_left_top=100 hp_left_value_left=50 hp_left_value_top=100
@slgarenainfo power_left_caption="Attack Power" power_left_left=10 power_left_top=130 power_left_value_left=50 power_left_value_top=130
@slgarenainfo defense_left_caption="Physical Defense" defense_left_left=10 defense_left_top=160 defense_left_value_left=80 defense_left_value_top=160
@slgarenainfo magic_defense_left_caption="Magic Defense" magic_defense_left_left=10 magic_defense_left_top=190 magic_defense_left_value_left=80 magic_defense_left_value_top=190

@slgarenainfo name_right_value_left=300 name_right_value_top=10
@slgarenainfo level_right_caption="Level" level_right_left=300 level_right_top=40 level_right_value_left=340 level_right_value_top=40
@slgarenainfo class_right_value_left=300 class_right_value_top=70
@slgarenainfo id="HP" hp_right_caption="HP" hp_right_left=300 hp_right_top=100 hp_right_value_left=340 hp_right_value_top=100
@slgarenainfo power_right_caption="Attack Power" power_right_left=300 power_right_top=130 power_right_value_left=340 power_right_value_top=130
@slgarenainfo defense_right_caption="Physical Defense" defense_right_left=300 defense_right_top=160 defense_right_value_left=370 defense_right_value_top=160
@slgarenainfo magic_defense_right_caption="Magic Defense" magic_defense_right_left=300 magic_defense_right_top=190 magic_defense_right_value_left=370 magic_defense_right_value_top=190

*|
;@slgstrategy storage=background
@slgstrategy wins_left=10 wins_top=10 wins_caption="Win condition" wins_value_left=10 wins_value_top=30 wins_font_height=20
@slgstrategy lose_left=10 lose_top=310 lose_caption="defeat condition" lose_value_left=10 lose_value_top=340
@slgstrategy wins_condition="Enemy annihilation\r\nEnemy annihilation\r\nEnemy annihilation"
@slgstrategy lose_condition="All allies destroyed"

@slgitem item_name="鉄の剣" sound_buffer=0 attack_sound=se001.ogg avoid_sound=se001.ogg damage_zero_sound=se002.ogg
@slgitem item_name="パラメータ増加" sound_buffer=0 used_sound=se001.ogg

@slgskill name="ひらめき" used_sound=se001.ogg

@slginitpos x=95 y=8
@slginitpos x=11 y=1
@slginitpos x=94 y=12
@slginitpos x=99 y=1
@slginitpos x=94 y=15
;@slginitpos x=99 y=99
;@slginitpos x=12 y=12
@slginitpos x=99 y=11
@slginitpos x=92 y=14
@slginitpos x=90 y=11

@slgcreatecharacter id="ハロ" attacker_base="at_%s_%s"
@slgcreatecharacter id="味方１" attacker_base="at_%s_%s"
@slgcreatecharacter id="味方２" name="味方１" attacker_base="at_%s_%s"
@slgcreatecharacter id="味方３" name="味方１" attacker_base="at_%s_%s"
@slgcreatecharacter id="味方４" name="味方１" attacker_base="at_%s_%s"
@slgcreatecharacter id="味方５" name="味方１" attacker_base="at_%s_%s"
@slgcreatecharacter id="味方６" name="無敵ハロ" hero hangar attacker_base="at_%s_%s"
@slgcreatecharacter id="味方７" name="シスター" attacker_base="at_%s_%s"
@slgcreatecharacter id="味方８" name="シスター" attacker_base="at_%s_%s"
@slgcreatecharacter id="味方９" name="ペガサスナイト" attacker_base="at_%s_%s"
@slgcreatecharacter id="味方１０" name="味方シューター" attacker_base="at_%s_%s"
@slgcreatecharacter id="ゲームマスター" name="ゲームマスター" attacker_base="at_%s_%s"
@slgcreatecharacter id="敵１" name="ヴィラン" attacker_base="at_%s_%s"
@slgcreatecharacter id="敵２" name="ヴィラン２" attacker_base="at_%s_%s"
@slgcreatecharacter id="敵３" name="シューター" attacker_base="at_%s_%s"
@slgcreatecharacter id="敵４" name="最強ヴィラン" attacker_base="at_%s_%s"
@slgcreatecharacter id="敵５" name="ヴィラン" attacker_base="at_%s_%s"
@slgcreatecharacter id="敵６" name="ヴィラン" attacker_base="at_%s_%s"
@slgcreatecharacter id="敵７" name="敵シスター" attacker_base="at_%s_%s"
@slgcreatecharacter id="敵８" name="ヴィラン" attacker_base="at_%s_%s"
@slgcreatecharacter id="敵９" name="ヴィラン" attacker_base="at_%s_%s"
@slgcreatecharacter id="敵１０" name="ヴィラン" attacker_base="at_%s_%s"
@slgcreatecharacter id="敵１１" name="ヴィラン" attacker_base="at_%s_%s"
@slgcreatecharacter id="敵１２" name="ヴィラン" attacker_base="at_%s_%s"
@slgcreatecharacter id="敵１３" name="ヴィラン" attacker_base="at_%s_%s"
@slgcreatecharacter id="敵１４" name="ヴィラン" attacker_base="at_%s_%s"
@slgcreatecharacter id="敵１５" name="ヴィラン" attacker_base="at_%s_%s"
@slgcreatecharacter id="敵１６" name="ヴィラン" attacker_base="at_%s_%s"
;@slgcreatecharacter id="NPC" name="NPC" attacker_base="at_%s_%s"

@slgaddfighter level=1 id="ファイター１" storage=villan.chr
@slgaddfighter level=1 id="ファイター２" storage=villan2.chr
@slgaddfighter level=1 id="ファイター３" storage=villan3.chr
@slgaddfighter level=1 id="ファイター４" storage=villan4.chr

@slgfighterinfo id="ファイター１" attacker_base="at_%s_%s"
@slgfighterinfo id="ファイター２" attacker_base="at_%s_%s"
@slgfighterinfo id="ファイター３" attacker_base="at_%s_%s"
@slgfighterinfo id="ファイター４" attacker_base="at_%s_%s"

;@slgcharacterpos id="ハロ" x=10 y=12
;@slgcharacterpos id="味方１" x=11 y=10
;@slgcharacterpos id="味方２" x=24 y=12
;@slgcharacterpos id="味方３" x=2 y=1
;@slgcharacterpos id="味方４" x=34 y=15
;@slgcharacterpos id="味方５" x=99 y=99
@slgcharacterpos id="味方６" x=12 y=12
@slgcharacterpos id="ゲームマスター" x=14 y=12
;@slgcharacterpos id="味方７" x=9 y=11
@slgcharacterpos id="敵１" x=15 y=12
@slgcharacterpos id="敵２" x=14 y=11
@slgcharacterpos id="敵３" x=10 y=1
@slgcharacterpos id="敵４" x=11 y=12
@slgcharacterpos id="敵５" x=12 y=11
@slgcharacterpos id="敵６" x=20 y=8
@slgcharacterpos id="敵７" x=10 y=13
@slgcharacterpos id="敵８" x=11 y=13
@slgcharacterpos id="敵９" x=12 y=13
@slgcharacterpos id="敵１０" x=13 y=13
@slgcharacterpos id="敵１１" x=14 y=13
@slgcharacterpos id="敵１２" x=15 y=13
@slgcharacterpos id="敵１３" x=13 y=14
@slgcharacterpos id="敵１４" x=14 y=14
@slgcharacterpos id="敵１５" x=15 y=14
@slgcharacterpos id="敵１６" x=16 y=14
;@slgcharacterpos id="NPC" x=20 y=10

;@slgaddabnormalstate id="味方６" name=行動不可の杖 no_action turn=3
@slgaddabnormalstate id="味方６" name=混乱の杖 panic turn=9
@slgaddabnormalstate id="敵４" name=混乱の杖 panic turn=3
;@slgaddabnormalstate id="敵４" name=行動不可の杖 no_action turn=3

@slgcharacter id="ハロ" die_label=*ハロ死亡
@slgcharacter id="味方８" die_after_label=*シスター死亡後
;@slgcharacter id="敵２" do_not_move
@slgcharacter id="敵４" die_label=*敵４死亡 attack_label=*敵４攻撃
@slgcharacter id="敵６" wait_turn=2 strikes_back

@slgmap type="visit" x=13 y=5 label=*村訪問
@slgmap type="normal" x=13 y=5 label=*マップイベント
@slgmap type="destroy" x=13 y=5 label=*村破壊
@slgmap type="steal" x=15 y=7 label=*宝箱盗む item=薬草
@slgmap type="treasure" x=15 y=7 label=*宝箱獲得 item=薬草 no_key

@slgmap turn=1 label=*ターン１開始

@slgmap character="味方６" target="敵４" label=*話す

@slgmap door_x=14 door_y=9 label=*扉イベント

@slgmap exit_x=17 exit_y=0
@slgmap player_exit_x=11 player_exit_y=0 icon_storage=exiticon label=*離脱

@slgadditemtohangar item_name="鉄の剣"
@slgadditemtohangar item_name="鉄の剣"
@slgadditemtohangar item_name="パラメータ増加"
@slgadditemtohangar item_name="ファイアの書"
@slgadditemtohangar item_name="ファイアの書"
@slgadditemtohangar item_name="薬草"
@slgadditemtohangar item_name="薬草"
@slgadditemtohangar item_name="ライブの杖"
@slgadditemtohangar item_name="鉄の弓"

@slgadditem id="ハロ" item_name="鉄の剣"
@slgadditem id="ハロ" item_name="エクスカリバー"
@slgadditem id="ハロ" item_name="薬草"
@slgadditem id="ハロ" item_name="パラメータ増加"
@slgadditem id="ハロ" item_name="クラスチェンジ"
@slgadditem id="ハロ" item_name="星のオーブ"

@slgadditem id="味方１" item_name="エクスカリバー"
@slgadditem id="味方１" item_name="ファイアの書"
@slgadditem id="味方１" item_name="鉄の剣"
@slgadditem id="味方１" item_name="鉄の鎧"

@slgadditem id="味方２" item_name="エクスカリバー"
@slgadditem id="味方２" item_name="ファイアの書"
@slgadditem id="味方２" item_name="全体回復"
@slgadditem id="味方２" item_name="パラメータ増加"
@slgadditem id="味方２" item_name="鉄の剣"

@slgadditem id="味方５" item_name="鉄の剣"
@slgadditem id="味方５" item_name="エクスカリバー"

@slgadditem id="味方６" item_name="勇者の剣"
@slgadditem id="味方６" item_name="鍵"
@slgadditem id="味方６" item_name="ファイアの書"

@slgadditem id="味方７" item_name="ライブの杖"
@slgadditem id="味方７" item_name="行動不可の杖"
@slgadditem id="味方７" item_name="魔法封じの杖"
@slgadditem id="味方７" item_name="混乱の杖"
@slgadditem id="味方７" item_name="状態異常回復の杖"

@slgadditem id="味方８" item_name="ワープの杖"
@slgadditem id="味方８" item_name="レスキューの杖"
@slgadditem id="味方８" item_name="復活の杖"

@slgadditem id="味方９" item_name="鉄の剣"

@slgadditem id="味方１０" item_name="投石"

@slgadditem id="敵１" item_name="鉄の剣"

@slgadditem id="敵２" item_name="ロングボウ"
@slgadditem id="敵２" item_name="鉄の弓"

@slgadditem id="敵３" item_name="投石"

@slgadditem id="敵４" item_name="勇者の剣"

@slgadditem id="敵６" item_name="鉄の剣" drop

@slgadditem id="敵５" item_name="鉄の剣"

@slgadditem id="敵７" item_name="行動不可の杖"
@slgadditem id="敵７" item_name="ライブの杖"

@slgadditem id="敵８" item_name="鉄の剣"

@slgadditem id="敵９" item_name="鉄の剣"

@slgadditem id="敵１０" item_name="鉄の剣"

@slgadditem id="敵１１" item_name="鉄の剣"

@slgadditem id="敵１２" item_name="鉄の剣"

@slgadditem id="敵１３" item_name="鉄の剣"

@slgadditem id="敵１４" item_name="鉄の剣"

@slgadditem id="敵１５" item_name="鉄の剣"

@slgadditem id="敵１６" item_name="鉄の剣"

;@slgadditem id="NPC" item_name="鉄の剣"

@slgadditemtofighter id="ファイター１" item_name="鉄の剣"
@slgadditemtofighter id="ファイター２" item_name="鉄の弓"
@slgadditemtofighter id="ファイター３" item_name="投石"
@slgadditemtofighter id="ファイター４" item_name="ライブの杖"

@slgarena x=7 y=11

@slgdiecharacter id="味方７"

*|
@slgshowmap time=200
@slgwaitshowmap
@slgprepare record_width=380 record_height=40
@slgprepare left=200 top=150 width=400 height=300 character_list_left=10 character_list_top=25 character_list_width=380 character_list_height=220
@slgprepare name_left=0 name_top=0
@slgprepare level_left=80 level_top=0
@slgprepare exp_left=120 exp_top=0
@slgprepare id="HP" hp_left=160 hp_top=0
@slgprepare id="SP" sp_left=200 sp_top=0
@slgprepare hangar_caption="Hangar" hangar_left=280 hangar_top=0 hangar_width=40 hangar_height=20
@slgprepare index_left=330 index_top=0
@slgprepare game_start_caption="Start" game_start_left=350 game_start_top=240 game_start_width=40 game_start_height=20
@slgprepare show_map_caption="Map" show_map_left=300 show_map_top=240 show_map_width=40 show_map_height=20
;@slgprepare record_enter_sound_storage=se002.ogg
@slgprepare start

*force_store|
@s

*gameover
@slghidemap
@slgwaithidemap

@using_mod_message

@base_layer_transparent
@base_layer_pos topmost

@show_message layer=message0

Game over.[p][cm]
@go_to_start
@s

*敵４攻撃
;@slghidemap
;@slgwaithidemap

@wait time=1000

@using_mod_message

@base_layer_transparent
@base_layer_pos topmost

@show_message layer=message0

@image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible

@trans time=2000
@wt

The child layer was successfully loaded. [p][cm]

@freeimage layer=0 page=back
@trans time=1000
@wt

@hide_message layer=message0

@base_layer_pos bottom

;@slgshowmap
@slgctrl restart
@s

*敵４死亡
@slghidemap
@slgwaithidemap

@wait time=1000

@slgshowmap
@slgwaitshowmap

@slgctrl restart
@s

*ハロ死亡
@slghidemap
@slgwaithidemap

@wait time=1000

@slgshowmap
@slgwaitshowmap

@slgctrl restart
@s

*シスター死亡後
@wait time=1000

@using_mod_message

@base_layer_transparent
@base_layer_pos topmost

@show_message layer=message0

[halo]die.[p][cm]

@hide_message layer=message0

@base_layer_pos bottom

@slgctrl restart
@s

*村訪問
@slghidemap
@slgwaithidemap

@wait time=1000

@slgshowmap
@slgwaitshowmap

@slgctrl restart
@s

*マップイベント
@wait time=1000

@using_mod_message

@base_layer_transparent
@base_layer_pos topmost

@show_message layer=message0

@image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible

@trans time=2000
@wt

The child layer was successfully loaded. [p][cm]

@freeimage layer=0 page=back
@trans time=1000
@wt

@hide_message layer=message0

@base_layer_pos bottom

;@slgshowmap
@slgctrl restart
@s

*村破壊
@wait time=1000

@using_mod_message

@base_layer_transparent
@base_layer_pos topmost

@show_message layer=message0

@image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible

@trans time=2000
@wt

@slgreplacemapcell x=13 y=5 cell=005

The village was destroyed. [p][cm]

@freeimage layer=0 page=back
@trans time=1000
@wt

@hide_message layer=message0

@base_layer_pos bottom

;@slgshowmap
@slgctrl restart
@s

*宝箱盗む
@wait time=1000

@using_mod_message

@base_layer_transparent
@base_layer_pos topmost

@show_message layer=message0

@image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible

@trans time=2000
@wt

@slgreplacemapcell x=15 y=7 cell=007

I stole a treasure chest. [p][cm]

@freeimage layer=0 page=back
@trans time=1000
@wt

@hide_message layer=message0

@base_layer_pos bottom

;@slgshowmap
@slgctrl restart
@s

*宝箱獲得
;@slghidemap
;@slgwaithidemap

;@wait time=1000

@slgreplacemapcell x=15 y=7 cell=007

;@slgshowmap
;@slgwaitshowmap

@slgctrl restart
@s

*ターン１開始

@wait time=1000

@using_mod_message

@base_layer_transparent
@base_layer_pos topmost

@show_message layer=message0

@image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible

@trans time=2000
@wt

Begin your turn. [p][cm]

@freeimage layer=0 page=back
@trans time=1000
@wt

@hide_message layer=message0

@base_layer_pos bottom

;@slgshowmap
@slgctrl restart
@s

*話す

@wait time=1000

@using_mod_message

@base_layer_transparent
@base_layer_pos topmost

@show_message layer=message0

@image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible

@trans time=2000
@wt

@slgcharacter id="敵４" character_type=player icon_storage=ハロ_icon

The 最強ヴィラン has become a friend. [p][cm]

@freeimage layer=0 page=back
@trans time=1000
@wt

@hide_message layer=message0

@base_layer_pos bottom

;@slgshowmap
@slgctrl restart
@s

*扉イベント
@using_mod_message

@base_layer_transparent
@base_layer_pos topmost

@show_message layer=message0

@image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible

@trans time=2000
@wt

The door opened. [p][cm]

@freeimage layer=0 page=back
@trans time=1000
@wt

@hide_message layer=message0

@slgreplacemapcell x=14 y=9 cell=003

@base_layer_pos bottom

;@slgshowmap
@slgctrl restart
@s


*離脱ハロ
@slgctrl restart
@s

*離脱味方１
@slgctrl restart
@s

*離脱味方２
@slgctrl restart
@s

*離脱味方３
@slgctrl restart
@s

*離脱味方４
@slgctrl restart
@s

*離脱味方５
@slgctrl restart
@s

*離脱味方６
@slgctrl restart
@s

*離脱味方７
@slgctrl restart
@s

*enemy_count|
@slghidemap
@slgwaithidemap

@slgclear

@using_mod_message

@show_message layer=message0

The number of enemies has fallen below the specified number. [p][cm]

@hide_message layer=message0

@slgloadmap storage=test3.map

@slgshowmap time=200
@slgwaitshowmap

@slginitpos x=8 y=8
@slginitpos x=7 y=7
@slginitpos x=6 y=6

@slgconfig game_over_label=*gameover money=10000

@slgcreatecharacter id="敵１" name=ヴィラン attacker_base="at_%s_%s"
@slgcreatecharacter id="敵２" name=ヴィラン２ attacker_base="at_%s_%s"
@slgcreatecharacter id="敵３" name=シューター attacker_base="at_%s_%s"
@slgcreatecharacter id="敵４" name=最強ヴィラン attacker_base="at_%s_%s" destroyer escape bandit
@slgcreatecharacter id="敵５" name=ヴィラン attacker_base="at_%s_%s"
@slgcreatecharacter id="敵６" name=ヴィラン attacker_base="at_%s_%s"
@slgcreatecharacter id="敵７" name=敵シスター attacker_base="at_%s_%s"

@slgcharacterpos id="敵１" x=1 y=1
@slgcharacterpos id="敵２" x=2 y=1
@slgcharacterpos id="敵３" x=3 y=1
@slgcharacterpos id="敵４" x=4 y=1
@slgcharacterpos id="敵５" x=5 y=1
@slgcharacterpos id="敵６" x=6 y=1
@slgcharacterpos id="敵７" x=7 y=1

@slgadditem id="敵４" item_name="勇者の剣"

@slglookupmap x=50 y=50

@slgprepare start

*|
@s

