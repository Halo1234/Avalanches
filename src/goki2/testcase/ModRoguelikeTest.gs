

*label|
@roguelike_option debug debug_dump_map

@roguelike_option grid_width=64 grid_height=64
@roguelike_option map_width=100 map_height=100

@rouglelike_load_character name=ハロ storage=rouglelike_main_character player

@roguelike_load_chips storage=roguelike_mapchips.chp
@roguelike_load_chips name=StairsDown group_id=100000000 stairs_down
@roguelike_load_chips name=StairsUp group_id=100000001 stairs_up

@roguelike_load_room storage=initial_room001.map initial_room_index=0
@roguelike_load_room storage=room001.map
@roguelike_load_room storage=room002.map
@roguelike_load_room storage=room003.map initial_room_index=1

@roguelike_option initial_room_index=1

@roguelike_character name=ハロ x=1 y=1

@roguelike initialize

@roguelike_option x=9 y=1 stairs_down

@roguelike show
@roguelike start
@s

