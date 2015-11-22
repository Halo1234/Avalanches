;
; ImageSample.asd
;

@macro name=cell
@option center_x=100 center_y=100 clip_left=%x clip_top=0 clip_width=100 clip_height=100 visible
@wait time=%time|1000
@endmacro

@option center_x=400 center_y=300

@fork index=0 target=*fork
@s


*fork
@looping
@load_cell storage=CellImageSample

@cell x=0
@cell x=100
@cell x=200
@home
@end_looping


