
@!video /play_rate=<PLAYRATE> audio_stream_number=<AUDIOSTREAMNUM>

@redirect alias=videolayer name=set_video_layer

@redirect alias=clearvideolayer name=clear_video_layer

@redirect alias=openvideo name=open_video

@redirect alias=preparevideo name=prepare_video

@redirect alias=playvideo name=play_video

@redirect alias=rewindvideo name=rewind_video

@redirect alias=pausevideo name=pause_video

@redirect alias=resumevideo name=resume_video

@redirect alias=videoevent name=set_video_event

@redirect alias=videosegloop name=set_video_segment_loop

@redirect alias=wv name=wait_video
@!wait_video /skip=<CANSKIP> /no_skip=<NO_CANSKIP> !skip=<!CANSKIP>

@redirect alias=stopvideo name=stop_video

@redirect alias=closevideo name=close_video

@redirect alias=cancelvideoevent name=cancel_video_event

@redirect alias=cancelvideosegloop name=cancel_video_segment_loop

@redirect alias=wp name=wait_period_event

