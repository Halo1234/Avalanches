;
; A_pose1_face1.asd
;

@macro name=cell
@option center_x=0 center_y=0 clip_left=%x clip_top=0 clip_width=100 clip_height=100 visible
@wait time=%time|1000
@endmacro

@s


*target
@looping
@load_cell storage=A_pose1

@cell x=0
@cell x=100
@cell x=200
@home
@end_looping


