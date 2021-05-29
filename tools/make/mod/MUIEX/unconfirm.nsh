;/**
; * $Revision: 148 $
; *
; * HOWTO:
; * ページを挿入したい場所に !insertmacro MUIEX_UNPAGE_CONFIRM を挿入してください。
;**/

;---
!macro MUIEX_UNPAGE_CONFIRM
	!insertmacro MUI_PAGE_INIT
	!insertmacro MUIEX_UN_PAGEDECLARATION_CONFIRM
!macroend

;---
; インターフェース
!macro MUIEX_UN_CONFIRM_INTERFACE
	!ifndef MUIEX_UN_CONFIRM_INTERFACE
		!define MUIEX_UN_CONFIRM_INTERFACE

		Var muiex.un.sc.ConfirmPage
		Var muiex.un.sc.InfoText
		Var muiex.un.sc.DetailsText
	!endif

	!insertmacro MUI_DEFAULT MUIEX_UN_CONFIRM_HEADER_TEXT		"セットアップ内容の確認"
	!insertmacro MUI_DEFAULT MUIEX_UN_CONFIRM_HEADER_SUB_TEXT	"セットアップ内容の確認をして下さい。"
	!insertmacro MUI_DEFAULT MUIEX_UN_CONFIRM_INFO				"セットアップは以下の内容を実行します。"

	!insertmacro MUI_DEFAULT MUIEX_UN_CONFIRM_INSTALLLOCATION		"インストール先："

	!ifdef MUIEX_UNPAGE_SAVEDATA_USED
		!insertmacro un.MUIEX_SAVEDATA_GetReport
	!endif

!macroend

;---
; 宣言
!macro MUIEX_UN_PAGEDECLARATION_CONFIRM
	!insertmacro MUIEX_UN_CONFIRM_INTERFACE

	PageEx un.custom
		PageCallbacks un.ConfirmEnter_${MUI_UNIQUEID} un.ConfirmLeave_${MUI_UNIQUEID}
	PageExEnd

	!insertmacro MUIEX_UN_FUNCTION_CONFIRM un.ConfirmEnter_${MUI_UNIQUEID} un.ConfirmLeave_${MUI_UNIQUEID}
!macroend

;---
; コールバック関数
!macro MUIEX_UN_FUNCTION_CONFIRM ENTER LEAVE

	Function "${ENTER}"

		Push $0
		Push $1

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM ENTER

		!insertmacro MUI_HEADER_TEXT_PAGE ${MUIEX_UN_CONFIRM_HEADER_TEXT} ${MUIEX_UN_CONFIRM_HEADER_SUB_TEXT}

		; ダイアログ作成
		nsDialogs::Create /NOUNLOAD 1018
		Pop $muiex.un.sc.ConfirmPage

		; ラベルテキスト
		${NSD_CreateLabel} 0 0 100% 15u ${MUIEX_UN_CONFIRM_INFO}
		Pop $muiex.un.sc.InfoText

		; 実行内容テキストの作成
		StrCpy $0 ""

		; インストール先パス
		StrCpy $0 "$0${MUIEX_UN_CONFIRM_INSTALLLOCATION}$\r$\n    $INSTDIR$\r$\n$\r$\n"

		; セーブデータ保存先のレポート
		!ifdef un.MUIEX_SAVEDATA_GetReport
			${un.MUIEX_SAVEDATA_GetReport} $1
			StrCpy $0 "$0$1"
		!endif

		; 内容表示
		nsDialogs::CreateControl /NOUNLOAD "EDIT" \
			${ES_MULTILINE}|${ES_READONLY}|${WS_VISIBLE}|${WS_CHILD}|${WS_VSCROLL} \
			${WS_EX_CLIENTEDGE} 0 20u 100% 120u $0
		Pop $muiex.un.sc.DetailsText

		Pop $0

		nsDialogs::Show

	FunctionEnd

	Function "${LEAVE}"

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM LEAVE

	FunctionEnd

!macroend


