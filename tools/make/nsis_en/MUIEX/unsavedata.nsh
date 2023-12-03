;/**
; * $Revision: 148 $
; *
; * HOWTO:
; * ページを挿入したい場所に !insertmacro MUIEX_UNPAGE_SAVEDATA を挿入してください。
; *
; * このページを使う場合はセーブデータ削除用のセクションを定義する必要があります。
; * セクションの ID を MUIEX_UN_SECID_REMOVESAVEDATA と定義してください。
; * セクションの ID が定義されなかった場合このページは表示されません。
; *
; * NOTE:
; * ${un.MUIEX_SAVEDATA_GetReport} でこのページで選択された内容について
; * 人間が読める形でレポートを取得する事ができます。
; * この関数マクロを使うには事前に !insertmacro ${un.MUIEX_SAVEDATA_GetReport} を挿入する必要があります。
; * ただし、MUIEX_UNPAGE_CONFIRM を使う場合はこれらを使う必要はないでしょう。
; *
; * NOTE:
; * MUIEX_UNPAGE_SAVEDATA を !insertmacro する前に定義を追加する事で
; * 各コントロールの enable 状態を変更する事ができます。
; * 何も定義しなければデフォルト値が使われます。
; *
; * 各定義の名前とデフォルト値です。
; * +---------+-------+
; * | status  | value |
; * +---------+-------+
; * | enable  |     1 |
; * | disable |     0 |
; * +---------+-------+
; * +-------------------------------+---+
; * | MUIEX_SAVEDATA_REMOVE_ENABLED | 1 |
; * | MUIEX_SAVEDATA_KEEP_ENABLED   | 1 |
; * +-------------------------------+---+
; *
;**/


!ifndef GUARD_MODUNSAVEDATA_NSH
!define GUARD_MODUNSAVEDATA_NSH

;---
!macro MUIEX_UNPAGE_SAVEDATA
	!ifndef MUIEX_UNPAGE_SAVEDATA_USED
		!define MUIEX_UNPAGE_SAVEDATA_USED
	!endif

	!insertmacro MUI_UNPAGE_INIT
	!insertmacro MUIEX_UN_PAGEDECLARATION_SAVEDATA
!macroend

;---
; インターフェース
!macro MUIEX_UN_SAVEDATA_INTERFACE
	!ifndef MUIEX_UN_SAVEDATA_INTERFACE
		!define MUIEX_UN_SAVEDATA_INTERFACE

		Var muiex.un.sd.SaveDataPage
		Var muiex.un.sd.InfoText
		Var muiex.un.sd.SaveDataPathEditBox
		Var muiex.un.sd.OpenLink
		Var muiex.un.sd.RemoveRadioButton
		Var muiex.un.sd.KeepRadioButton
	!endif

	!insertmacro MUI_DEFAULT MUIEX_UN_SAVEDATA_PATH_SUFFIX					""
	!insertmacro MUI_DEFAULT MUIEX_UN_SAVEDATA_DOCUMENTSFOLDER_SUFFIX		`${MUIEX_UN_SAVEDATA_PATH_SUFFIX}`
	!insertmacro MUI_DEFAULT MUIEX_UN_SAVEDATA_APPLICATIONDATAFOLDER_SUFFIX	`${MUIEX_UN_SAVEDATA_PATH_SUFFIX}`
	!insertmacro MUI_DEFAULT MUIEX_UN_SAVEDATA_INSTALLFOLDER_SUFFIX			`${MUIEX_UN_SAVEDATA_PATH_SUFFIX}`
	!insertmacro MUI_DEFAULT MUIEX_UN_SAVEDATA_OPTIONALFOLDER_SUFFIX		`${MUIEX_UN_SAVEDATA_PATH_SUFFIX}`

	!insertmacro MUI_DEFAULT MUIEX_UN_SAVEDATA_REMOVE_ENABLED	1
	!insertmacro MUI_DEFAULT MUIEX_UN_SAVEDATA_KEEP_ENABLED	1

	!define MUIEX_UN_SAVEDATA_DOCUMENTSFOLDER_VALUE			"${MUIEX_LOCATION_DOCUMENTSFOLDER}${MUIEX_UN_SAVEDATA_DOCUMENTSFOLDER_SUFFIX}"
	!define MUIEX_UN_SAVEDATA_APPLICATIONDATAFOLDER_VALUE	"${MUIEX_LOCATION_APPDATAFOLDER}${MUIEX_UN_SAVEDATA_APPLICATIONDATAFOLDER_SUFFIX}"
	!define MUIEX_UN_SAVEDATA_INSTALLFOLDER_VALUE			"${MUIEX_LOCATION_INSTALLFOLDER}${MUIEX_UN_SAVEDATA_INSTALLFOLDER_SUFFIX}"

	!insertmacro un.MUIEX_SAVEDATA_SyncRadioButton
	!insertmacro un.MUIEX_SAVEDATA_GetSaveLocationPath

	!insertmacro un.MUIEX_SetCurrentSaveLocationPath

!macroend

;---
; 宣言
!macro MUIEX_UN_PAGEDECLARATION_SAVEDATA

	; セーブデータ削除用のセクションが定義されていなければページを表示しない
	!ifdef MUIEX_UN_SECID_REMOVESAVEDATA

		!insertmacro MUIEX_UN_SAVEDATA_INTERFACE

		PageEx un.custom
			PageCallbacks un.SaveDataEnter_${MUI_UNIQUEID} un.SaveDataLeave_${MUI_UNIQUEID}
		PageExEnd

		!insertmacro MUIEX_UN_FUNCTION_SAVEDATA un.SaveDataEnter_${MUI_UNIQUEID} un.SaveDataLeave_${MUI_UNIQUEID}

	!endif
!macroend

;---
; コールバック関数
!macro MUIEX_UN_FUNCTION_SAVEDATA ENTER LEAVE

	Function "${ENTER}"

		Push $0

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM ENTER

		!insertmacro MUI_HEADER_TEXT_PAGE "Save data" "You can choose whether to delete the save data or keep it."

		; ダイアログ作成
		nsDialogs::Create /NOUNLOAD 1018
		Pop $muiex.un.sd.SaveDataPage

		; ラベルテキスト
		${NSD_CreateLabel} 0 0 100% 30u "Save data can also be deleted later from 'Add/Remove Programs'. $\nOnce saved data is deleted, it cannot be recovered."
		Pop $muiex.un.sd.InfoText

		; 正式なセーブデータ保存場所のパスをセットする
		${un.MUIEX_SAVEDATA_GetSaveLocationPath} $0
		${un.MUIEX_SetCurrentSaveLocationPath} $0

		; パス表示用エディット
		nsDialogs::CreateControl /NOUNLOAD "EDIT" ${ES_READONLY}|${WS_VISIBLE}|${WS_CHILD} ${WS_EX_CLIENTEDGE} 0 55 100% 12u $0
		Pop $muiex.un.sd.SaveDataPathEditBox

		; セーブデータ保存先を開くリンク
		${NSD_CreateLink} 0 55u 100% 12u "Open save data destination"
		Pop $muiex.un.sd.OpenLink
		GetFunctionAddress $0 un.onOpenClick
		nsDialogs::OnClick /NOUNLOAD $muiex.un.sd.OpenLink $0

		; セーブデータを削除する。
		${NSD_CreateRadioButton} 10u 80u 100% 12u "Delete save data."
		Pop $muiex.un.sd.RemoveRadioButton

		EnableWindow $muiex.un.sd.RemoveRadioButton ${MUIEX_UN_SAVEDATA_REMOVE_ENABLED}
		GetFunctionAddress $0 un.onRemoveClick
		nsDialogs::OnClick /NOUNLOAD $muiex.un.sd.RemoveRadioButton $0

		; セーブデータを残す。（デフォルトチェック）
		${NSD_CreateRadioButton} 10u 95u 100% 12u "Leave save data."
		Pop $muiex.un.sd.KeepRadioButton

		EnableWindow $muiex.un.sd.KeepRadioButton ${MUIEX_UN_SAVEDATA_KEEP_ENABLED}
		GetFunctionAddress $0 un.onKeepClick
		nsDialogs::OnClick /NOUNLOAD $muiex.un.sd.KeepRadioButton $0

		; チェック状態設定
		${un.MUIEX_SAVEDATA_SyncRadioButton} $muiex.un.sd.RemoveRadioButton $muiex.un.sd.KeepRadioButton

		Pop $0

		nsDialogs::Show

	FunctionEnd

	Function "${LEAVE}"

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM LEAVE

	FunctionEnd

	;---
	; イベントハンドラー

	Function un.onOpenClick

		# $0 == Control handle
		Pop $0

		${un.MUIEX_SAVEDATA_GetSaveLocationPath} $0
		ExecShell "open" $0

	FunctionEnd

	Function un.onRemoveClick

		# $0 == Control handle
		Pop $0

		${NSD_GetState} $muiex.un.sd.RemoveRadioButton $0
		${If} $0 == ${BST_CHECKED}
			!insertmacro SelectSection ${MUIEX_UN_SECID_REMOVESAVEDATA}
		${EndIf}

	FunctionEnd

	Function un.onKeepClick

		# $0 == Control handle
		Pop $0

		${NSD_GetState} $muiex.un.sd.KeepRadioButton $0
		${If} $0 == ${BST_CHECKED}
			!insertmacro UnselectSection ${MUIEX_UN_SECID_REMOVESAVEDATA}
		${EndIf}

	FunctionEnd

!macroend


;---
; ${MUIEX_SAVEDATA_GetReport} VAR
; レポートを VAR に返す。
!macro un.MUIEX_SAVEDATA_GetReportCaller _VAR
	Call un.MUIEX_SAVEDATA_GetReport
	Pop `${_VAR}`
!macroend

!macro un.MUIEX_SAVEDATA_GetReport
	!ifndef un.MUIEX_SAVEDATA_GetReport
		!define un.MUIEX_SAVEDATA_GetReport	`!insertmacro un.MUIEX_SAVEDATA_GetReportCaller`

		Function un.MUIEX_SAVEDATA_GetReport

			Push $0

			${un.MUIEX_SAVEDATA_GetSaveLocationPath} $0
			StrCpy $0 "Save data destination:$\r$\n    $0$\r$\n"

			!insertmacro SectionFlagIsSet ${MUIEX_UN_SECID_REMOVESAVEDATA} ${SF_SELECTED} SyncRadioButton_selected SyncRadioButton_notselected

			SyncRadioButton_selected:
				StrCpy $0 "$0    Delete save data.$\r$\n"
				GoTo GetReport_done

			SyncRadioButton_notselected:
				StrCpy $0 "$0    Leave the save data.$\r$\n"
				StrCpy $0 "$0    If you want to delete it later, you can do it from 'Add/Remove Programs'.$\r$\n"
				GoTo GetReport_done

			GetReport_done:

			StrCpy $0 "$0$\r$\n"

			Exch $0

		FunctionEnd
	!endif
!macroend


;---
; 内部用ユーティリティ

;---
; ${un.MUIEX_SAVEDATA_SyncRadioButton} SECID RMID KPID
!macro un.MUIEX_SAVEDATA_SyncRadioButtonCaller _RMID _KPID
	Push `${_KPID}`
	Push `${_RMID}`
	Call un.MUIEX_SAVEDATA_SyncRadioButton
!macroend

!macro un.MUIEX_SAVEDATA_SyncRadioButton
	!ifndef un.MUIEX_SAVEDATA_SyncRadioButton
		!define un.MUIEX_SAVEDATA_SyncRadioButton	`!insertmacro un.MUIEX_SAVEDATA_SyncRadioButtonCaller`
		Function un.MUIEX_SAVEDATA_SyncRadioButton

			Exch $0	; _RMID
			Exch
			Exch $1 ; _KPID

			!insertmacro SectionFlagIsSet ${MUIEX_UN_SECID_REMOVESAVEDATA} ${SF_SELECTED} SyncRadioButton_selected SyncRadioButton_notselected

			SyncRadioButton_selected:
				${NSD_Check} $0
				${NSD_Uncheck} $1
				Return

			SyncRadioButton_notselected:
				${NSD_Check} $1
				${NSD_Uncheck} $0
				Return

		FunctionEnd
	!endif
!macroend

;---
; ${MUIEX_SAVEDATA_GetSaveLocationPath} _PATH
!macro un.MUIEX_SAVEDATA_GetSaveLocationPathCaller _PATH
	Call un.MUIEX_SAVEDATA_GetSaveLocationPath
	Pop `${_PATH}`
!macroend

!macro un.MUIEX_SAVEDATA_GetSaveLocationPath
	!ifndef un.MUIEX_SAVEDATA_GetSaveLocationPath
		!define un.MUIEX_SAVEDATA_GetSaveLocationPath	`!insertmacro un.MUIEX_SAVEDATA_GetSaveLocationPathCaller`

		Function un.MUIEX_SAVEDATA_GetSaveLocationPath

			${If} ${un.MUIEX_CurrentSaveLocation} == ${MUIEX_UN_SAVEDATA_DOCUMENTSFOLDER_VALUE}
				Push "$DOCUMENTS${MUIEX_UN_SAVEDATA_DOCUMENTSFOLDER_SUFFIX}"
			${ElseIf} ${un.MUIEX_CurrentSaveLocation} == ${MUIEX_UN_SAVEDATA_APPLICATIONDATAFOLDER_VALUE}
				Push "$APPDATA${MUIEX_UN_SAVEDATA_APPLICATIONDATAFOLDER_SUFFIX}"
			${Else}
				Push ${un.MUIEX_CurrentSaveLocation}
			${EndIf}

		FunctionEnd
	!endif
!macroend

!endif


