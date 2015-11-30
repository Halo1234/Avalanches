;/*
; * $Author$
; * $Revision$
;**/

@redirect alias=autowc name=auto_wait_ch
@!autowc /ch=<CHARS>

@redirect alias=clearsysvar name=clear_system_variables

@redirect alias=clickskip name=click_skip
@!clickskip /no_enabled=<NOENABLED>

@!cursor /default_cursor=<DEFAULT> /pointed_cursor=<POINTED> /click_cursor=<CLICK> /draggable_cursor=<DRAGGABLE>

@redirect alias=hidemessage name=hidden_message

@redirect alias=loadplugin name=load_plugin
@!loadplugin /name=<MODULE>

@redirect alias=mappfont name=map_prerendered_font

@redirect alias=nextskip name=next_skip

@redirect alias=quake name=shake
@!quake /horizontal_max=<HMAX> /vertical_max=<VMAX>

@redirect alias=rclick name=right_click
@!rclick /no_enabled=<NOENABLED> no_call=<NOCALL> no_jump=<NOJUMP>

@redirect alias=resetwait name=reset_wait

@redirect alias=stopquake name=stop_shake

@!wait /skip=<CANSKIP> /no_skip=<NOSKIP> /!skip=<!CANSKIP>

@redirect alias=waitclick name=wait_click

@redirect alias=wc name=wait_ch

@redirect alias=wq name=wait_shake
@!wq /skip=<CANSKIP> /no_skip=<NOSKIP> /!skip=<!CANSKIP>

@!checkbox /background_color=<BGCOLOR>

@!edit /background_color=<BGCOLOR> /max_character=<MAXCHARS>

@redirect alias=cancelautomode name=cancel_auto_mode

@redirect alias=cancelskip name=cancel_skip

@redirect alias=deffont name=default_font_parameters
@!deffont /shadow_color=<SHADOWCOLOR> /edge_color=<EDGECOLOR> /ruby_size=<RUBYSIZE> /no_shadow=<NOSHADOW> /no_edge=<NOEDGE> /no_bold=<NOBOLD> /no_strikeout=<NOSTRIKEOUT> /underline=<NOUNDERLINE>

@redirect alias=defstyle name=defulat_line_parameters
@!defstyle /line_size=<LINESIZE> character_space=<PITCH> line_space=<LINESPACING>

@redirect alias=endindent name=end_indent

@redirect alias=endnowait name=end_no_wait

@!font /shadow_color=<SHADOWCOLOR> /edge_color=<EDGECOLOR> /ruby_size=<RUBYSIZE> /no_shadow=<NOSHADOW> /no_edge=<NOEDGE>

@!glyph /page_key=<PAGEKEY> /line_key=<LINEKEY> no_fix=<NOFIX>

@!graph /character=<CHAR>

@redirect alias=hch name=horizontal_ch
@!hch no_expand=<NOEXPAND>

@redirect alias=locklink name=lock_link

@redirect alias=nowait name=no_wait

@redirect alias=position name=message_option
@!position /no_visible=<NOVISIBLE>

@redirect alias=resetfont name=reset_font

@redirect alias=resetstyle name=reset_line_parameters

@redirect alias=style name=line_parameters
@!style /line_size=<LINESIZE> character_space=<PITCH> line_space=<LINESPACING>

@redirect alias=unlocklink name=unlock_link

@redirect alias=endhact name=end_history_action

@redirect alias=hact name=history_action

@redirect alias=history name=history_option
@!history /no_enabled=<NOENABLED> /no_output=<NOOUTPUT>

@redirect alias=hr name=history_reline

@redirect alias=showhistory name=show_history

@!button /expression=<EXP> /click_sound_effect=<CLICKSE> /click_sound_effect_buffer_number=<CLICKSEBUF> /on_enter_expression=<ONENTER> /enter_sound_effect=<ENTERSE> /enter_sound_effect_buffer_number=<ENTERSEBUF> /on_leave_expression=<ONLEAVE> /leave_sound_effect=<LEAVESE> /leave_sound_effect_buffer_number=<LEAVESEBUF> graphic_key=<GRAPHICKEY>

@redirect alias=cclick name=clear_click

@!click /sound_effect=<SE> /sound_effect_buffer_number=<SEBUF>

@redirect alias=ctimeout name=clear_timeout

@redirect alias=cwheel name=clear_wheel

@redirect alias=endlink name=end_link

@!link /expression=<EXP> /click_sound_effect=<CLICKSE> /click_sound_effect_buffer_number=<CLICKSEBUF> /on_enter_expression=<ONENTER> /enter_sound_effect=<ENTERSE> /enter_sound_effect_buffer_number=<ENTERSEBUF> /on_leave_expression=<ONLEAVE> /leave_sound_effect=<LEAVESE> /leave_sound_effect_buffer_number=<LEAVESEBUF>

@!timeout /sound_effect=<SE> /sound_effect_buffer_number=<SEBUF>

@!wheel /sound_effect=<SE> /sound_effect_buffer_number=<SEBUF>

@redirect alias=animstart name=start_animation
@!animstart /index=<SEG>

@redirect alias=animstop name=stop_animation
@!animstop /index=<SEG>

@redirect alias=backlay name=assign_image

;@redirect alias=copylay name=copy_layer
;@!copylay source_layer=<SRCLAYER> destination_layer=<DESTLAYER> source_page=<SRCPAGE> destination_page=<DESTPAGE>

@redirect alias=freeimage name=clear_image

@redirect alias=image name=load_image
@redirect alias=img name=load_image

@!load_image /gray_scale=<GRAYSCALE> /r_gamma=<RGAMMA> /g_gamma=<GGAMMA> /b_gamma=<BGAMMA> /r_floor=<RFLOOR> /g_floor=<GFLOOR> /b_floor=<BFLOOR> /r_ceil=<RCEIL> /g_ceil=<GCEIL> /b_ceil=<BCEIL> /clip_left=<CLIPLEFT> /clip_top=<CLIPTOP> /clip_width=<CLIPWIDTH> /clip_height=<CLIPHEIGHT> /flip_ud=<FLIPUD> /flip_lr=<FLIPLR> /no_flip_ud=<NOFLIPUD> /no_flip_lr=<NOFLIPLR> /no_visible<NOVISIBLE>

@macro name=laycount
@cv_layers count=%layers
@message_layers count=%messages
@endmacro

@redirect alias=layopt name=load_image

@redirect alias=pimage name=load_partial_image
@!pimage /dest_x=<DX> /dest_y=<DY> /src_x=<SX> /src_y=<SY> /src_w=<SW> /src_h=<SH>

@redirect alias=ptext name=partial_text
@!ptext /shadow_color=<SHADOWCOLOR> /edge_color=<EDGECOLOR> /no_vertical=<NOVERTICAL> /no_italic=<NOITALIC> /no_shadow=<NOSHADOW> /no_edge=<NOEDGE> /no_bold=<NOBOLD>

@redirect alias=stopmove name=stop_move

@redirect alias=stoptrans name=stop_transition

@redirect alias=trans name=transition
@!trans /no_children=<NOCHILDREN> /no_exchange=<NOEXCHANGE>

@redirect alias=wa name=wait_animation
@!wa /index=<SEG>

@redirect alias=wm name=wait_move
@!wm /skip=<CANSKIP> /no_skip=<NOCANSKIP>

@redirect alias=wt name=wait_transition
@!wt /skip=<CANSKIP> /no_skip=<NOCANSKIP>

@redirect alias=bgmopt name=bgm_option
@!bgmopt /master_volume=<GVOLUME>

@redirect alias=cancelvideoevent name=cancel_video_event

@redirect alias=cancelvideosegloop name=cancel_video_segment_loop

@redirect alias=clearbgmlabel name=clear_bgm_label

@redirect alias=clearvideolayer name=clear_video_layer

@redirect alias=fadebgm name=fade_bgm

@redirect alias=fadeinbgm name=fadein_bgm
@!fadeinbgm /label=<START>

@redirect alias=fadeinse name=fadein_se
@!fadeinse /buffer=<BUF> /label=<START> /no_loop=<NOLOOP>

@redirect alias=fadeinvo name=fadein_voice
@!fadeinvo /buffer=<BUF> /label=<START>

@redirect alias=fadeoutbgm name=fadeout_bgm

@redirect alias=fadeoutse name=fadeout_se
@!fadeoutse /buffer=<BUF>

@redirect alias=fadeoutvo name=fadeout_voice
@!fadeoutvo /buffer=<BUF>

@redirect alias=fadepausebgm name=fade_pause_bgm

@redirect alias=fadepausese name=fade_pause_se
@!fadepausese /buffer=<BUF>

@redirect alias=fadepausevo name=fade_pause_voice
@!fadepausevo /buffer=<BUF>

@redirect alias=fadebgm name=fade_bgm

@redirect alias=fadese name=fade_se
@!fadese /buffer=<BUF>

@redirect alias=fadevo name=fade_voice
@!fadevo /buffer=<BUF>

@redirect alias=openvideo name=open_video

@redirect alias=pausebgm name=pause_bgm

@redirect alias=pausevideo name=pause_video

@redirect alias=playbgm name=play_bgm
@!playbgm /label=<START> /no_loop=<NOLOOP>

@redirect alias=playse name=play_se
@!playse /buffer=<BUF> /label=<START> /no_loop=<NOLOOP>

@redirect alias=playvo name=play_voice
@!playvo /buffer=<BUF> /label=<START>

@redirect alias=playss name=play_system_sound

@redirect alias=playvideo name=play_video

@redirect alias=preparevideo name=prepare_video

@redirect alias=resumebgm name=resume_bgm

@redirect alias=resumevideo name=resume_video

@redirect alias=seopt name=se_option
@!seopt /buffer=<BUF>

@redirect alias=ssopt name=system_sound_option
@!ssopt /buffer=<BUF>

@redirect alias=setbgmlabel name=set_bgm_label

@redirect alias=setbgmstop name=set_bgm_stop

@redirect alias=stopbgm name=stop_bgm

@redirect alias=stopse name=stop_se
@!stopse /buffer=<BUF>

@redirect alias=stopss name=stop_system_sound
@!stopss /buffer=<BUF>

@redirect alias=stopvideo name=stop_video

@!video /no_visible=<NOVISIBLE>

@!video /play_rate=<PLAYRATE> audio_stream_number=<AUDIOSTREAMNUM>

@redirect alias=videoevent name=set_video_event

@redirect alias=videolayer name=set_video_layer

@redirect alias=videosegloop name=set_video_segment_loop

@redirect alias=wb name=wait_bgm_fade
@!wb /skip=<CANSKIP> /no_skip=<NOCANSKIP>

@redirect alias=wf name=wait_se_fade
@!wf /buffer=<BUF> /skip=<CANSKIP> /no_skip=<NOCANSKIP>

@redirect alias=wsf name=wait_system_sound_fade
@!wsf /buffer=<BUF> /skip=<CANSKIP> /no_skip=<NOCANSKIP>

@redirect alias=wl name=wait_bgm_stop
@!wl /skip=<CANSKIP> /no_skip=<NOCANSKIP>

@redirect alias=wp name=wait_period_event

@redirect alias=ws name=wait_se_stop
@!ws /buffer=<BUF> /skip=<CANSKIP> /no_skip=<NOCANSKIP>

@redirect alias=wss name=wait_system_sound_stop
@!wss /buffer=<BUF> /skip=<CANSKIP> /no_skip=<NOCANSKIP>

@redirect alias=wv name=wait_video
@!wv /skip=<CANSKIP> /no_skip=<NOCANSKIP>

@redirect alias=xchgbgm name=exchange_bgm
@!xchgbgm /no_loop=<NOLOOP>

@redirect alias=clearvar name=clear_variables

@redirect alias=waittrig name=wait_trigger
@!waittrig on_skip=<ONSKIP> skip=<CANSKIP> /no_skip=<NOCANSKIP>

@redirect alias=copybookmark name=copy_bookmark
@!copybookmark /destination=<TO> /source=<FROM>

@redirect alias=disablestore name=disable_store

@redirect alias=erasebookmark name=erase_bookmark
@!erasebookmark /number=<PLACE>

@redirect alias=goback name=go_back
@!goback /no_ask=<NOASK>

@redirect alias=gotostart name=go_to_start
@!gotostart /no_ask=<NOASK>

@!load /no_ask=<NOASK>

@redirect alias=locksnapshot name=lock_snapshot

@!save /no_ask=<NOASK>

@redirect alias=startanchor name=start_anchor
@!startanchor /no_enabled=<NOENABLED>

@!store /no_enabled=<NOENABLED>

@redirect alias=tempload name=load_temporary

@redirect alias=tempsave name=save_temporary

@redirect alias=unlocksnapshot name=unlock_snapshot


