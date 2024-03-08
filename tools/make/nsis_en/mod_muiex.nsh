/**
 * $Revision: 148 $
**/

!ifndef GUARD_MODMUIEX_NSH
!define GUARD_MODMUIEX_NSH

; MUI2 に依存
!include "MUI2.nsh"

!insertmacro MUI_DEFAULT MUIEX_LOCATION_DOCUMENTSFOLDER	"$$(personalpath)"
!insertmacro MUI_DEFAULT MUIEX_LOCATION_APPDATAFOLDER	"$$(appdatapath)"
!insertmacro MUI_DEFAULT MUIEX_LOCATION_INSTALLFOLDER	"$INSTDIR"

!include "MUIEX\muiexbasic.nsh"
!include "MUIEX\setupmenu.nsh"
!include "MUIEX\directoryex.nsh"
!include "MUIEX\savelocation.nsh"
!include "MUIEX\shortcutlocation.nsh"
!include "MUIEX\confirm.nsh"

!include "MUIEX\unmuiexbasic.nsh"
!include "MUIEX\unsavedata.nsh"
!include "MUIEX\unconfirm.nsh"

!endif


