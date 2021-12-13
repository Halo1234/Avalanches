
*label|


*|
@mapchip storage=mapchips.chp

*|
@loadmap storage=test2.map
@loadcursor storage=mapcursor moving=movingcursor
@setmapstatus visible font_height=20
@loadcharacter name=ハロ storage=chardata.chr icon_storage=ハロ_icon player
@commandmenu turn_end_caption="ターンエンド" skill_search_caption="スキル探索" troops_caption="部隊表" strategy_caption="作戦目的" system_caption="システム" save_caption="セーブ"
;@commandmenu turn_end_left=200 turn_end_top=50 save_left=200
@charactermenu move_caption="移動" skill_caption="スキル" status_caption="ステータス" item_caption="アイテム"
;@charactermenu move_left=200

@characterstatus name_caption="名前" name_left=10 name_top=10 name_value_left=60 name_value_top=10 name_value_width=40 name_value_height=22 name_value_font_height=20 name_value_caption_color=0xFF0000

@characterstatus move_caption="移動力" move_left=10 move_top=40 move_value_left=60 move_value_top=40 move_value_width=40 move_value_height=22 move_value_font_height=20

@characterstatus level_caption="レベル" level_left=10 level_top=70 level_value_left=60 level_value_top=70 level_value_width=40 level_value_height=22 level_value_font_height=20
@characterstatus max_level_caption="/" max_level_left=80 max_level_top=70 max_level_value_left=100 max_level_value_top=70 max_level_value_width=40 max_level_value_height=22 max_level_value_font_height=20
@characterstatus level_progress_nographic level_progress_left=10 level_progress_top=110 level_progress_width=120 level_progress_height=20

@characterstatus exp_caption="経験値" exp_left=10 exp_top=140 exp_value_left=50 exp_value_top=145 exp_value_width=40 exp_value_height=22 exp_value_font_height=10
@characterstatus exp_table_caption="/" exp_table_left=80 exp_table_top=140 exp_table_value_left=100 exp_table_value_top=145 exp_table_value_width=60 exp_table_value_height=22 exp_table_value_font_height=10
@characterstatus exp_progress_nographic exp_progress_left=10 exp_progress_top=170 exp_progress_width=120 exp_progress_height=20

@characterstatus money_caption="資金" money_left=100 money_top=40 money_value_left=150 money_value_top=45 money_value_width=40 money_value_height=22 money_value_font_height=10

@characterstatus class_left=150 class_top=5 class_font_height=20

@characterstatus id="HP" hp_caption="HP" hp_left=10 hp_top=190 hp_value_left=50 hp_value_top=195 hp_value_width=40 hp_value_height=22 hp_value_font_height=10
@characterstatus id="HP" hp_max_caption="/" hp_max_left=80 hp_max_top=190 hp_max_value_left=100 hp_max_value_top=195 hp_max_value_width=60 hp_max_value_height=22 hp_max_value_font_height=10
@characterstatus id="HP" hp_progress_nographic hp_progress_left=10 hp_progress_top=220 hp_progress_width=120 hp_progress_height=20

@characterstatus id="SP" sp_caption="SP" sp_left=10 sp_top=240 sp_value_left=50 sp_value_top=245 sp_value_width=40 sp_value_height=22 sp_value_font_height=10
@characterstatus id="SP" sp_max_caption="/" sp_max_left=80 sp_max_top=240 sp_max_value_left=100 sp_max_value_top=245 sp_max_value_width=60 sp_max_value_height=22 sp_max_value_font_height=10
@characterstatus id="SP" sp_progress_nographic sp_progress_left=10 sp_progress_top=270 sp_progress_width=120 sp_progress_height=20

@characterstatus id="int" int_caption="int" int_left=10 int_top=290 int_value_left=50 int_value_top=295 int_value_width=40 int_value_height=22 int_value_font_height=10

@characterstatus id="vit" vit_caption="vit" vit_left=10 vit_top=320 vit_value_left=50 vit_value_top=325 vit_value_width=40 vit_value_height=22 vit_value_font_height=10

@characterstatus id="agi" agi_caption="agi" agi_left=10 agi_top=350 agi_value_left=50 agi_value_top=355 agi_value_width=40 agi_value_height=22 agi_value_font_height=10

@characterstatus id="skill0" skill0_left=400 skill0_top=10 skill0_font_height=20
@characterstatus id="skill1" skill1_left=500 skill1_top=10 skill1_font_height=20

*|
@setcharacterpos name=ハロ x=10 y=10
@showmap time=200
@s

