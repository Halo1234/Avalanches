
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

*|
@setcharacterpos name=ハロ x=10 y=10
@showmap time=200
@s

