;/*
; * $Revision$
;**/

*label|

@show_message layer=message0

*label|
@fadein_bgm storage=bgm001.ogg time=2000
‚a‚f‚l‚ğÄ¶‚µ‚Ü‚µ‚½B[p][cm]

*label|
@pause_bgm
‚a‚f‚l‚ğˆê’â~‚µ‚Ü‚µ‚½B[p][cm]

*label|
@resume_bgm
‚a‚f‚l‚ğÄŠJ‚µ‚Ü‚µ‚½B[p][cm]

*label|
@play_se buffer=0 storage=se001
‚r‚d‚ğÄ¶‚µ‚Ü‚µ‚½B[p][cm]

*label|
@play_se buffer=0 storage=se001 loop
‚r‚d‚ğƒ‹[ƒvÄ¶‚µ‚Ü‚·B[p][cm]

*label|
@stop_se buffer=0
‚r‚d‚ğ’â~‚µ‚Ü‚·B[p][cm]

*label|
@fadeout_bgm time=2000
‚a‚f‚l‚ğ’â~‚µ‚Ü‚µ‚½B[p][cm]

@free_bgm_buffers
@log message="‚a‚f‚lƒoƒbƒtƒ@‚ğŠJ•ú‚µ‚Ü‚µ‚½B"

@hide_message layer=message0

@log message="ƒeƒXƒgI—¹‚µ‚Ü‚µ‚½B"


