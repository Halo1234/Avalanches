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

!endif


