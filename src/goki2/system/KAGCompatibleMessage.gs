
@redirect alias=position name=message_option
@!message_option /storage=<FRAME> /key=<FRAMEKEY> /margin_left=<MARGINL> /margin_top=<MARGINT> /margin_right=<MARGINR> /margin_bottom=<MARGINB>

@redirect alias=history name=history_option
@!history_option /margin_left=<MARGINL> /margin_top=<MARGINT> /margin_right=<MARGINR> /margin_bottom=<MARGINB>

@redirect alias=deffont name=default_font_parameters
@!default_font_parameters /shadow_color=<SHADOWCOLOR> /edge_color=<EDGECOLOR> /ruby_size=<RUBYSIZE>

@redirect alias=defstyle name=default_line_parameters
@!default_line_parameters /line_size=<LINESIZE> character_space=<PITCH> line_space=<LINESPACING>

@redirect alias=style name=line_parameters
@!line_parameters /line_size=<LINESIZE> character_space=<PITCH> line_space=<LINESPACING>

@!font /shadow_color=<SHADOWCOLOR> /edge_color=<EDGECOLOR> /ruby_size=<RUBYSIZE>

@redirect alias=resetfont name=reset_font

@redirect alias=resetstyle name=reset_line_parameters

@redirect alias=hch name=horizontal_ch

@redirect alias=hr name=history_reline

@redirect alias=endindent name=end_indent

@!link /expression=<EXP> /click_sound_effect=<CLICKSE> /click_sound_effect_buffer_number=<CLICKSEBUF> /on_enter_expression=<ONENTER> /enter_sound_effect=<ENTERSE> /enter_sound_effect_buffer_number=<ENTERSEBUF> /on_leave_expression=<ONLEAVE> /leave_sound_effect=<LEAVESE> /leave_sound_effect_buffer_number=<LEAVESEBUF>

@redirect alias=endlink name=end_link

@!button /expression=<EXP> /click_sound_effect=<CLICKSE> /click_sound_effect_buffer_number=<CLICKSEBUF> /on_enter_expression=<ONENTER> /enter_sound_effect=<ENTERSE> /enter_sound_effect_buffer_number=<ENTERSEBUF> /on_leave_expression=<ONLEAVE> /leave_sound_effect=<LEAVESE> /leave_sound_effect_buffer_number=<LEAVESEBUF> graphic_key=<GRAPHICKEY>

@!checkbox /background_color=<BGCOLOR>

@!edit /background_color=<BGCOLOR> /max_character=<MAXCHARS>

@redirect alias=locklink name=lock_link

@redirect alias=unlocklink name=unlock_link

@redirect alias=autowc name=auto_wait_ch
@!auto_wait_ch /ch=<CHARS>

@redirect alias=clickskip name=click_skip

@redirect alias=hidemessage name=hidden_message

@redirect alias=mappfont name=map_prerendered_font

@redirect alias=nextskip name=next_skip

@redirect alias=wc name=wait_ch

@redirect alias=cancelautomode name=cancel_auto_mode

@redirect alias=cancelskip name=cancel_skip

@redirect alias=nowait name=no_wait

@redirect alias=endnowait name=end_no_wait

@!glyph /page_key=<PAGEKEY> /line_key=<LINEKEY>

@!graph /character=<CHAR>

@redirect alias=waittrig name=wait_trigger
@!wait_trigger /on_skip=<ONSKIP> /skip=<CANSKIP> /no_skip=<NO_CANSKIP> /!skip=<!CANSKIP>

@!wheel /sound_effect=<SE> /sound_effect_buffer_number=<SEBUF>

@redirect alias=cwheel name=clear_wheel

@!timeout /sound_effect=<SE> /sound_effect_buffer_number=<SEBUF>

@redirect alias=ctimeout name=clear_timeout

@!click /sound_effect=<SE> /sound_effect_buffer_number=<SEBUF>

@redirect alias=cclick name=clear_click

@redirect alias=showhistory name=show_history

@redirect alias=hact name=history_action

@redirect alias=endhact name=end_history_action

