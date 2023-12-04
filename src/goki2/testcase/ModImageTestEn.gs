
*label|
@open_memory

; Set the output destination to ModMessage
; If you do not do this, the message will not be displayed
@using_mod_message

@show_message layer=message0

*label|
@load_cg layer=cg_layer_0 storage=CG_A000.png visible
Displayed CGA-0. [p][cm]

*label|
@load_cg layer=cg_layer_0 storage=CG_A001.png visible
Displayed CGA-1. [p][cm]

*label|
@image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible
@trans time=1000
@wt

The child layer was successfully loaded. [p][cm]

*label|
@layer_move layer=0 position=0.0 x=left y=top scale=1.0 clear children transform !rendering_target_released
@layer_move layer=0 position=1.0 x=200 y=200 scale=2.0
@layer_move layer=0 time=2000 start
;@wm layer=0

Moves the child layer. [p][cm]

*label|
Please save. [p][cm]

@layer_move layer=0 position=0.0 x=200 y=200 scale=2.0 clear children transform !rendering_target_released
@layer_move layer=0 position=1.0 x=300 y=200 scale=1.0
@layer_move layer=0 time=2000 start
@wm layer=0

@stop_move layer=0
@release_rendering_target layer=0

@freeimage layer=0 page=back
@trans time=1000
@wt

*label|
@image storage=sampleB page=back

@trans time=2000
@wt
@log message="Transition test succeeded."

Successfully tested transition. [p][cm]

*label|
@image storage=sampleA page=back
; Assign to mirror layer (back layer → front layer)
@assign_to_mirror
@log message="Test background copy"

The background copy test was successful. [p][cm]

*label|
@quake hmax=10 vmax=10 time=1000
@wq

It shakes. [p][cm]

*label|
@image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible

Load child layer. [p][cm]

@trans time=1000
@wt

The child layer was successfully loaded. [p][cm]

*label|
@image layer=0 center_x=400 center_y=300 grayscale rgamma=1.5 ggamma=1.3 page=back storage=ImageSample visible

I corrected the color of the child layer (back layer). [p][cm]

@trans time=1000
@wt

*label|
This is a test of color correction of child layer. [p][cm]

*label|
@image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible

@trans time=1000
@wt

@pimage layer=0 page=fore storage=CellImageSample dx=100 dy=100

This is a test of loading partial images of child layers. [p][cm]

*label|
@ptext layer=0 x=0 y=0 text=hogehoge color=0xFFFF00
This is a test of character drawing in the child layer. [p][cm]

*label|
Continue testing. [p][cm]

*label|
;@clickskip !enabled

@move layer=0 path="(10, 10, 255), (200, 200, 255)" time=5000
@wm layer=0

Moves the child layer. [p][cm]

*label|
[cancelskip]

; new move tag
; layer : foreground layer number
; position: position from 0.0 to 1.0 (0.0 is immediately after the start and 1.0 is the final state)
; x : left position
; y : top position
; angle : angle
; scale : scale
; children : Whether to move child layers as well
; transform: Whether to use scaling etc.
; time : travel time
; start : start moving
@layer_move layer=0 position=0.0 x=left y=top angle=0 clear children transform rendering_target_released
@layer_move layer=0 position=0.5 x=0 y=0 angle=240 scale=1.0
@layer_move layer=0 position=0.75 x=200 y=200 angle=240 scale=2.0
@layer_move layer=0 position=1.0 x=200 y=200 angle=360 scale=1.0
@layer_move layer=0 time=5000 start
@layopt layer=0 left=200 top=200
@wm layer=0

Moves the child layer. [p][cm]

*label|
@clickskip enabled

;@animstart layer=0

@animstop layer=0 seg=0
@wa layer=0 seg=0
@backlay layer=0

The child layer animation test was successful. [p][cm]

*label|
@freeimage page=back

@trans time=2000
@wt

It is a success if the background is clear. [p][cm]

*label|
@freeimage layer=0 page=back
@trans time=1000
@wt

It is successful if the child layer is cleared. [p][cm]

*label|
@image layer=0 center_x=400 center_y=300 page=back storage=ImageSample visible
@trans time=1000
@wt

Load the child layer again. [p][cm]

*label|
@animstart layer=0 seg=0 target=*fork

@animstop layer=0 seg=0
@wa layer=0 seg=0
@backlay layer=0

The child layer animation test was successful. [p][cm]

*label|
@cancelskip
@freeimage layer=0 page=back
@trans time=1000
@wt

It is successful if the child layer is cleared. [p][cm]

@hide_message layer=message0
@wait_hide_message layer=message0

@end_memory


