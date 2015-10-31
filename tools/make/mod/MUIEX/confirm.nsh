;/**
; * $Revision: 144 $
; *
; * HOWTO:
; * ページを挿入したい場所に !insertmacro MUIEX_PAGE_CONFIRM を挿入してください。
;**/

;---
!macro MUIEX_PAGE_CONFIRM
	!insertmacro MUI_PAGE_INIT
	!insertmacro MUIEX_PAGEDECLARATION_CONFIRM
!macroend

;---
; インターフェース
!macro MUIEX_CONFIRM_INTERFACE
	!ifndef MUIEX_CONFIRM_INTERFACE
		!define MUIEX_CONFIRM_INTERFACE

		Var muiex.sc.ConfirmPage
		Var muiex.sc.InfoText
		Var muiex.sc.DetailsText
	!endif

	!insertmacro MUI_DEFAULT MUIEX_CONFIRM_HEADER_TEXT		"セットアップ内容の確認"
	!insertmacro MUI_DEFAULT MUIEX_CONFIRM_HEADER_SUB_TEXT	"セットアップ内容の確認をして下さい。"
	!insertmacro MUI_DEFAULT MUIEX_CONFIRM_INFO				"セットアップは以下の内容を実行します。"

	!insertmacro MUI_DEFAULT MUIEX_CONFIRM_INSTALLLOCATION		"インストール先："

	!ifdef MUIEX_PAGE_SAVELOCATION_USED
		!insertmacro MUIEX_SAVELOCATION_GetReport
	!endif

	!ifdef MUIEX_PAGE_SHORTCUTLOCATION_USED
		!insertmacro MUIEX_SHORTCUTLOCATION_GetReport
	!endif

!macroend

;---
; 宣言
!macro MUIEX_PAGEDECLARATION_CONFIRM
	!insertmacro MUIEX_CONFIRM_INTERFACE

	PageEx custom
		PageCallbacks ConfirmEnter_${MUI_UNIQUEID} ConfirmLeave_${MUI_UNIQUEID}
	PageExEnd

	!insertmacro MUIEX_FUNCTION_CONFIRM ConfirmEnter_${MUI_UNIQUEID} ConfirmLeave_${MUI_UNIQUEID}
!macroend

;---
; コールバック関数
!macro MUIEX_FUNCTION_CONFIRM ENTER LEAVE

	Function "${ENTER}"

		Push $0
		Push $1

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM ENTER

		!insertmacro MUI_HEADER_TEXT_PAGE ${MUIEX_CONFIRM_HEADER_TEXT} ${MUIEX_CONFIRM_HEADER_SUB_TEXT}

		; ダイアログ作成
		nsDialogs::Create /NOUNLOAD 1018
		Pop $muiex.sc.ConfirmPage

		; ラベルテキスト
		${NSD_CreateLabel} 0 0 100% 15u ${MUIEX_CONFIRM_INFO}
		Pop $muiex.sc.InfoText

		; 実行内容テキストの作成
		StrCpy $0 ""

		; インストール先パス
		StrCpy $0 "$0${MUIEX_CONFIRM_INSTALLLOCATION}$\r$\n    $INSTDIR$\r$\n$\r$\n"

		; セーブデータ保存先のレポート
		!ifdef MUIEX_SAVELOCATION_GetReport
			${MUIEX_SAVELOCATION_GetReport} $1
			StrCpy $0 "$0$1"
		!endif

		; ショートカット関連のレポート
		!ifdef MUIEX_SHORTCUTLOCATION_GetReport
			${MUIEX_SHORTCUTLOCATION_GetReport} $1
			StrCpy $0 "$0$1"
		!endif

		; 内容表示
		nsDialogs::CreateControl /NOUNLOAD "EDIT" \
			${ES_MULTILINE}|${ES_READONLY}|${WS_VISIBLE}|${WS_CHILD}|${WS_VSCROLL} \
			${WS_EX_CLIENTEDGE} 0 20u 100% 120u $0
		Pop $muiex.sc.DetailsText

		Pop $0

		nsDialogs::Show

	FunctionEnd

	Function "${LEAVE}"

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM LEAVE

	FunctionEnd

!macroend


