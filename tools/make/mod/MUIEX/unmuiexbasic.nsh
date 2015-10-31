/**
 * $Revision: 144 $
**/

!ifndef GUARD_UNMODMUIEXBASIC_NSH
!define GUARD_UNMODMUIEXBASIC_NSH

!include "MUI2.nsh"

;---
; UN_MUIEX 全体で利用する変数
Var muiex.un.CurrentSaveLocation
Var muiex.un.CurrentSaveLocationPath

!macro un.MUIEX_VARIABLES
!macroend

;---
; ${un.MUIEX_Initialize} SAVELOCATION
; UN_MUIEX を使う場合は必ず un.onInit でこれを呼び出してください。
;
; SAVELOCATION には現在のセーブ場所を指定してください。
; セーブデータが無い場合は空文字列を指定します。
!macro un.MUIEX_InitializeCaller _SAVELOCATION
	Push `${_SAVELOCATION}`
	Call un.MUIEX_Initialize
!macroend

!macro un.MUIEX_Initialize
	!ifndef un.MUIEX_Initialize
		!insertmacro un.MUIEX_VARIABLES

		!define un.MUIEX_Initialize	`!insertmacro un.MUIEX_InitializeCaller`

		Function un.MUIEX_Initialize

			Exch $0 ; _SAVELOCATION

			StrCpy $muiex.un.CurrentSaveLocation $0
			StrCpy $muiex.un.CurrentSaveLocationPath ""

			Pop $0

		FunctionEnd
	!endif
!macroend


;---
!macro un.MUIEX_PAGE_FUNCTION_CUSTOM TYPE
	!ifdef un.MUIEX_PAGE_CUSTOMFUNCTION_${TYPE}
		Call "${un.MUIEX_PAGE_CUSTOMFUNCTION_${TYPE}}"
		!undef un.MUIEX_PAGE_CUSTOMFUNCTION_${TYPE}
	!endif
!macroend


;---
; 読取専用インターフェース
; 実装上、書き込みもできますが UN_MUIEX の仕様上では読取専用です。
; 将来にわたって書き込みが可能かどうかは保証されません。
!define un.MUIEX_CurrentSaveLocation		`$muiex.un.CurrentSaveLocation`
!define un.MUIEX_CurrentSaveLocationPath	`$muiex.un.CurrentSaveLocationPath`

;---
; 各種値変更用インターフェース

;---
; ${un.MUIEX_SetCurrentSaveLocationPath} PATH
; MUIEX_UNPAGE_SAVEDATA によって正式なパスをセットするために使われる。
!macro un.MUIEX_SetCurrentSaveLocationPathCaller _PATH
	Push `${_PATH}`
	Call un.MUIEX_SetCurrentSaveLocationPath
!macroend

!macro un.MUIEX_SetCurrentSaveLocationPath
	!ifndef un.MUIEX_SetCurrentSaveLocationPath
		!define un.MUIEX_SetCurrentSaveLocationPath	`!insertmacro un.MUIEX_SetCurrentSaveLocationPathCaller`

		Function un.MUIEX_SetCurrentSaveLocationPath
			Pop $muiex.un.CurrentSaveLocationPath
		FunctionEnd
	!endif
!macroend

!endif


