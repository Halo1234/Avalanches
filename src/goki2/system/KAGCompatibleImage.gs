
@macro name=laycount
@cv_layers *
@message_layers *
@endmacro

@cv_layers /count=<LAYERS> /base=<LAYBASE> /step=<LAYSTEP>

@redirect alias=cglayers name=cg_layers

@redirect alias=image name=load_image
@redirect alias=img name=load_image

@!load_image /gray_scale=<GRAYSCALE> /no_gray_scale=<NO_GRAYSCALE> /!gray_scale=<!GRAYSCALE> /r_gamma=<RGAMMA> /g_gamma=<GGAMMA> /b_gamma=<BGAMMA> /r_floor=<RFLOOR> /g_floor=<GFLOOR> /b_floor=<BFLOOR> /r_ceil=<RCEIL> /g_ceil=<GCEIL> /b_ceil=<BCEIL> /clip_left=<CLIPLEFT> /clip_top=<CLIPTOP> /clip_width=<CLIPWIDTH> /clip_height=<CLIPHEIGHT> /flip_ud=<FLIPUD> /no_flip_ud=<NO_FLIPUD> /!flip_ud=<!FLIPUD> /flip_lr=<FLIPLR> /no_flip_lr=<NO_FLIPLR> /!flip_lr=<!FLIPLR> /center_x=<CX> /center_y=<CY>

@redirect alias=layopt name=load_image

@redirect alias=pimage name=load_partial_image
@!load_partial_image /dest_x=<DX> /dest_y=<DY> /src_x=<SX> /src_y=<SY> /src_w=<SW> /src_h=<SH>

@redirect alias=ptext name=partial_text
@!partial_text /shadow_color=<SHADOWCOLOR> /edge_color=<EDGECOLOR>

@redirect alias=freeimage name=clear_image

@redirect alias=backlay name=assign_image

@redirect alias=copylay name=copy_layer
@!copylay source_layer=<SRCLAYER> destination_layer=<DESTLAYER> source_page=<SRCPAGE> destination_page=<DESTPAGE>

@redirect alias=animstart name=start_animation
@!start_animation /index=<SEG>

@redirect alias=animstop name=stop_animation
@!stop_animation /index=<SEG>

@redirect alias=quake name=shake
@!quake /horizontal_max=<HMAX> /vertical_max=<VMAX>

@redirect alias=stopquake name=stop_shake

@redirect alias=trans name=transition

@redirect alias=stoptrans name=stop_transition

@redirect alias=stopmove name=stop_move

@redirect alias=wt name=wait_transition
@!wait_transition /skip=<CANSKIP> /no_skip=<NO_CANSKIP> /!skip=<!CANSKIP>

@redirect alias=wa name=wait_animation
@!wa /index=<SEG>

@redirect alias=wq name=wait_shake
@!wq /skip=<CANSKIP> /no_skip=<NO_SKIP> /!skip=<!CANSKIP>

@redirect alias=wm name=wait_move
@!wm /skip=<CANSKIP> /no_skip=<NO_CANSKIP> /!skip=<!CANSKIP>

@redirect alias=loadcg name=load_cg

@!load_cg /gray_scale=<GRAYSCALE> /no_gray_scale=<NO_GRAYSCALE> /!gray_scale=<!GRAYSCALE> /r_gamma=<RGAMMA> /g_gamma=<GGAMMA> /b_gamma=<BGAMMA> /r_floor=<RFLOOR> /g_floor=<GFLOOR> /b_floor=<BFLOOR> /r_ceil=<RCEIL> /g_ceil=<GCEIL> /b_ceil=<BCEIL> /clip_left=<CLIPLEFT> /clip_top=<CLIPTOP> /clip_width=<CLIPWIDTH> /clip_height=<CLIPHEIGHT> /flip_ud=<FLIPUD> /no_flip_ud=<NO_FLIPUD> /!flip_ud=<!FLIPUD> /flip_lr=<FLIPLR> /no_flip_lr=<NO_FLIPLR> /!flip_lr=<!FLIPLR> /center_x=<CX> /center_y=<CY>


