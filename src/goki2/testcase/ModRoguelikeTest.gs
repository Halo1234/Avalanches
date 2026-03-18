

*label|
@roguelike_option grid_width=64 grid_height=64
@roguelike_option map_width=50 map_height=50

@rouglelike_load_character name=ハロ storage=rouglelike_main_character player
@roguelike_load_chips storage=roguelike_mapchips.chp

@roguelike_load_room storage=initial_room001.map initial_room_index=0
@roguelike_load_room storage=room001.map
@roguelike_load_room storage=room002.map
@roguelike_load_room storage=room003.map

@roguelike_option initial_room_index=0

@roguelike show
@roguelike start
@s

