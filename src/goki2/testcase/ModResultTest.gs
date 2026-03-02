

*label|
@image layer=0 center_x=400 center_y=300 page=fore storage=result_sample visible

*label|
@result_score_layers count=1
@result layer=0 center_x=300 center_y=300 width=200 height=80 font_size=56 score=10000 caption_color=0xFF0000 count_up_sound_storage=se001
@result completed_target=*result_completed time=5000
@result show
@s

*result_completed
@clear_image layer=0
@next

