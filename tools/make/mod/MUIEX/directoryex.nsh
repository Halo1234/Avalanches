;/**
; * $Revision: 144 $
; *
; * HOWTO:
; * ページを挿入したい場所に !insertmacro MUIEX_PAGE_DIRECTORYEX を挿入してください。
;**/

!ifndef GUARD_DIRECTORYEX_NSH
!define GUARD_DIRECTORYEX_NSH

;---
!macro MUIEX_PAGE_DIRECTORYEX
	!insertmacro MUI_PAGE_INIT
	!define MUI_PAGE_CUSTOMFUNCTION_PRE		DirectoryExPre
	!define MUI_PAGE_CUSTOMFUNCTION_SHOW	DirectoryExShow
	!define MUI_PAGE_CUSTOMFUNCTION_LEAVE	DirectoryExLeave

	!insertmacro MUIEX_FUNCTION_DIRECTORYEX DirectoryExPre DirectoryExShow DirectoryExLeave

	!insertmacro MUI_PAGE_DIRECTORY

!macroend

;---
!macro MUIEX_FUNCTION_DIRECTORYEX _PRE _ENTER _LEAVE

	Function "${_PRE}"
		${If} ${MUIEX_IsChangeInstallLocation} == 0
			Abort
		${EndIf}

		; 修復インストールの場合はここを abort する
		${If} ${MUIEX_Installtype} == ${MUIEX_INSTALLTYPE_FULL}
			Abort
		${EndIf}

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM PRE
	FunctionEnd

	Function "${_ENTER}"
		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM ENTER
	FunctionEnd

	Function "${_LEAVE}"
		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM LEAVE
	FunctionEnd

!macroend

!endif


