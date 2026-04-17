

*label|
@roguelike_option debug debug_dump_map

@roguelike_option grid_width=64 grid_height=64
@roguelike_option map_width=50 map_height=50
@roguelike_option max_floor=10
@roguelike_option room_count_min=4 room_count_max=8
@roguelike_option item_count_min=4 item_count_max=8
@roguelike_option message=message1

@roguelike_load_character name=ハロ storage=rouglelike_main_character player

@roguelike_menu storage=RoguelikeMenuBack.png left=10 top=10
@roguelike_menu item_button_caption=アイテム item_button_left=20 item_button_top=20 item_button_width=60 item_button_height=30
@roguelike_menu foot_button_caption=足元 foot_button_left=110 foot_button_top=20 foot_button_width=60 foot_button_height=30
@roguelike_menu map_button_caption=マップ map_button_left=20 map_button_top=60 map_button_width=60 map_button_height=30

@roguelike_item_menu storage=RoguelikeItemMenuBack.png left=300 top=80 margin_left=50 margin_top=40 margin_right=50

@roguelike_item_sub_menu storage=RoguelikeItemSubMenuBack.png left=680 top=100
@roguelike_item_sub_menu used_button_caption=使う used_button_left=20 used_button_top=20 used_button_width=60 used_button_height=30
@roguelike_item_sub_menu put_button_caption=置く put_button_left=20 put_button_top=60 put_button_width=60 put_button_height=30
@roguelike_item_sub_menu throw_button_caption=投げる throw_button_left=20 throw_button_top=100 throw_button_width=60 throw_button_height=30

@roguelike_load_chips storage=roguelike_mapchips.dic
@roguelike_load_chips name=StairsDown group_id=100000000 stairs_down
@roguelike_load_chips name=StairsUp group_id=100000001 stairs_up

@roguelike_stairs_event name=StairsDown target=*to_down
@roguelike_stairs_event name=StairsUp target=*to_up

@roguelike_load_items storage=items.ary

@roguelike_load_room storage=initial_room001.ary initial_room_index=0
@roguelike_load_room storage=room001.ary
@roguelike_load_room storage=room002.ary
@roguelike_load_room storage=room003.ary
@roguelike_load_room storage=room004.ary
@roguelike_load_room storage=room005.ary
@roguelike_load_room storage=room006.ary
@roguelike_load_room storage=room007.ary

@roguelike_option initial_room_index=0

@roguelike_character name=ハロ add_item=薬草
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

