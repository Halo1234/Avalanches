
@redirect alias=fadeinss name=fadein_system_sound
@!fadein_system_sound /buffer=<BUF> /label=<START>

@redirect alias=fadeoutss name=fadeout_system_sound
@!fadeout_system_sound /buffer=<BUF>

@redirect alias=fadess name=fade_system_sound
@!fade_system_sound /buffer=<BUF>

@redirect alias=playss name=play_system_sound
@!play_system_sound /buffer=<BUF> /label=<START>

@redirect alias=stopss name=stop_system_sound
@!stop_system_sound /buffer=<BUF>

@redirect alias=ssopt name=system_sound_option
@!ssopt /buffer=<BUF>

@redirect alias=wsf name=wait_system_sound_fade
@!wait_system_sound_fade /buffer=<BUF> /skip=<CANSKIP> /no_skip=<NO_CANSKIP> /!skip=<!CANSKIP>

@redirect alias=wss name=wait_system_sound_stop
@!wait_system_sound_stop /buffer=<BUF> /skip=<CANSKIP> /no_skip=<NO_CANSKIP> /!skip=<!CANSKIP>

@redirect alias=fadeinse name=fadein_se
@!fadein_se /buffer=<BUF> /label=<START>

@redirect alias=fadeoutse name=fadeout_se
@!fadeout_se /buffer=<BUF>

@redirect alias=fadepausese name=fade_pause_se
@!fade_pause_se /buffer=<BUF>

@redirect alias=fadese name=fade_se
@!fade_se /buffer=<BUF>

@redirect alias=playse name=play_se
@!play_se /buffer=<BUF> /label=<START>

@redirect alias=stopse name=stop_se
@!stopse /buffer=<BUF>

@redirect alias=seopt name=se_option
@!se_option /buffer=<BUF>

@redirect alias=wf name=wait_se_fade
@!wf /buffer=<BUF> /skip=<CANSKIP> /no_skip=<NO_CANSKIP> /!skip=<!CANSKIP>

@redirect alias=ws name=wait_se_stop
@!ws /buffer=<BUF> /skip=<CANSKIP> /no_skip=<NO_CANSKIP> /!skip=<!CANSKIP>

@redirect alias=fadeinvo name=fadein_voice
@!fadein_voice /buffer=<BUF> /label=<START>

@redirect alias=fadeoutvo name=fadeout_voice
@!fadeout_voice /buffer=<BUF>

@redirect alias=fadepausevo name=fade_pause_voice
@!fade_pause_voice /buffer=<BUF>

@redirect alias=fadevo name=fade_voice
@!fade_voice /buffer=<BUF>

@redirect alias=playvo name=play_voice
@!play_voice /buffer=<BUF> /label=<START>

@redirect alias=stopvo name=stop_voice
@!stop_voice /buffer=<BUF>

@redirect alias=voopt name=voice_option
@!voice_option /buffer=<BUF>

@redirect alias=wvf name=wait_voice_fade
@!wait_voice_fade /buffer=<BUF> /skip=<CANSKIP> /no_skip=<NO_CANSKIP> /!skip=<!CANSKIP>

@redirect alias=wvs name=wait_voice_stop
@!wait_voice_stop /buffer=<BUF> /skip=<CANSKIP> /no_skip=<NO_CANSKIP> /!skip=<!CANSKIP>

@redirect alias=bgmopt name=bgm_option
@!bgm_option /master_volume=<GVOLUME>

@redirect alias=setbgmlabel name=set_bgm_label

@redirect alias=setbgmstop name=set_bgm_stop

@redirect alias=fadeinbgm name=fadein_bgm
@!fadein_bgm /buffer=<BUF> /label=<START>

@redirect alias=fadeoutbgm name=fadeout_bgm
@!fadeout_bgm /buffer=<BUF>

@redirect alias=fadepausebgm name=fade_pause_bgm
@!fade_pause_bgm /buffer=<BUF>

@redirect alias=fadebgm name=fade_bgm
@!fade_bgm /buffer=<BUF>

@redirect alias=pausebgm name=pause_bgm
@!pause_bgm /buffer=<BUF>

@redirect alias=resumebgm name=resume_bgm
@!resume_bgm /buffer=<BUF>

@redirect alias=playbgm name=play_bgm
@!play_bgm /buffer=<BUF> /label=<START>

@redirect alias=stopbgm name=stop_bgm
@!stop_bgm /buffer=<BUF>

@redirect alias=xchgbgm name=exchange_bgm
@!exchange_bgm /buffer=<BUF> /label=<START>

@redirect alias=clearbgmlabel name=clear_bgm_label

@redirect alias=clearbgmstop name=clear_bgm_stop

@redirect alias=wb name=wait_bgm_fade
@!wait_bgm_fade /skip=<CANSKIP> /no_skip=<NO_CANSKIP> !skip=<!CANSKIP>

@redirect alias=wl name=wait_bgm_stop
@!wait_bgm_stop /skip=<CANSKIP> /no_skip=<NO_CANSKIP> !skip=<!CANSKIP>

