

*label|
@roguelike_option debug debug_dump_map

@roguelike_option grid_width=64 grid_height=64
@roguelike_option map_width=50 map_height=50
@roguelike_option max_floor=10
@roguelike_option room_count_min=4 room_count_max=8

@roguelike_load_character name=ハロ storage=rouglelike_main_character player

@roguelike_load_chips storage=roguelike_mapchips.dic
@roguelike_load_chips name=StairsDown group_id=100000000 stairs_down
@roguelike_load_chips name=StairsUp group_id=100000001 stairs_up

@roguelike_stairs_event name=StairsDown target=*to_down
@roguelike_stairs_event name=StairsUp target=*to_up

@roguelike_load_room storage=initial_room001.ary initial_room_index=0
@roguelike_load_room storage=room001.ary
@roguelike_load_room storage=room002.ary
@roguelike_load_room storage=room003.ary
@roguelike_load_room storage=room004.ary
@roguelike_load_room storage=room005.ary
@roguelike_load_room storage=room006.ary
@roguelike_load_room storage=room007.ary

@roguelike_option initial_room_index=0

@roguelike_character name=ハロ x=1 y=1

@roguelike initialize

@roguelike_option x=2 y=1 stairs_down

@roguelike show
@wait_roguelike_show
@roguelike start
@s

*to_down
@roguelike hide
@wait_roguelike_hide

@roguelike next_floor

@roguelike show
@wait_roguelike_show

@roguelike start
@s

*to_up
@roguelike hide
@wait_roguelike_hide

@roguelike_option initial_room_index=0
@roguelike_character name=ハロ x=1 y=1
@roguelike initialize
@roguelike_option x=2 y=1 stairs_down

@roguelike show
@wait_roguelike_show

@roguelike start
@s

