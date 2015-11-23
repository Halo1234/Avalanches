;/*
; * $Author$
; * $Revision$
;**/

@redirect alias=autowc name=auto_wait_ch
@!autowc /ch=<CHARS>

@redirect alias=clearsysvar name=clear_system_variables

@redirect alias=clickskip name=click_skip

@!cursor /default_cursor=<DEFAULT> /pointed_cursor=<POINTED> /click_cursor=<CLICK> /draggable_cursor=<DRAGGABLE>

@redirect alias=hidemessage name=hidden_message

@redirect alias=loadplugin name=load_plugin
@!loadplugin /name=<MODULE>

@redirect alias=mappfont name=map_prerendered_font

@redirect alias=nextskip name=next_skip

@redirect alias=quake name=shake
@!quake /horizontal_max=<HMAX> /vertical_max=<VMAX>

@redirect alias=rclick name=right_click

@redirect alias=resetwait name=reset_wait

@redirect alias=stopquake name=stop_shake

@!wait /skip=<CANSKIP>

@redirect alias=waitclick name=wait_click

@redirect alias=wc name=wait_ch

@redirect alias=wq name=wait_shake
@!wq /skip=<CANSKIP>

@!checkbox /background_color=<BGCOLOR>

@!edit /background_color=<BGCOLOR> /max_character=<MAXCHARS>

@redirect alias=cancelautomode name=cancel_auto_mode

@redirect alias=cancelskip name=cancel_skip

@redirect alias=deffont name=default_font_parameters
@!deffont /shadow_color=<SHADOWCOLOR> /edge_color=<EDGECOLOR> /ruby_size=<RUBYSIZE>

@redirect alias=defstyle name=defulat_line_parameters
@!defstyle /line_size=<LINESIZE> character_space=<PITCH> line_space=<LINESPACING>

@redirect alias=endindent name=end_indent

@redirect alias=endnowait name=end_no_wait

@!font /shadow_color=<SHADOWCOLOR> /edge_color=<EDGECOLOR> /ruby_size=<RUBYSIZE>

@!glyph /page_key=<PAGEKEY> /line_key=<LINEKEY>

@!graph /character=<CHAR>

@redirect alias=hch name=horizontal_ch

@redirect alias=locklink name=lock_link

@redirect alias=nowait name=no_wait

@redirect alias=position name=message_option

@redirect alias=resetfont name=reset_font

@redirect alias=resetstyle name=reset_line_parameters

@redirect alias=style name=line_parameters
@!style /line_size=<LINESIZE> character_space=<PITCH> line_space=<LINESPACING>

@redirect alias=unlocklink name=unlock_link


