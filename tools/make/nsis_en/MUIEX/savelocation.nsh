;/**
; * $Revision: 148 $
; *
; * HOWTO:
; * ページを挿入したい場所に !insertmacro MUIEX_PAGE_SAVELOCATION を挿入してください。
; *
; * NOTE:
; * ${MUIEX_SAVELOCATION_GetReport} でこのページで選択された内容について
; * 人間が読める形でレポートを取得する事ができます。
; * この関数マクロを使うには事前に !insertmacro ${MUIEX_SAVELOCATION_GetReport} を挿入する必要があります。
; * ただし、MUIEX_PAGE_CONFIRM か MUIEX_PAGE_SETUPMENU を使う場合は自動的に !insertmacro されます。
; *
; * NOTE:
; * MUIEX_PAGE_SAVELOCATION を !insertmacro する前に定義を追加する事で
; * 各項目の表示状態と選択されたパスのサフィックスを変更する事ができます。
; * 何も定義しなければデフォルト値が使われます。
; *
; * 表示状態を定義する定義名とデフォルト値です。
; * +--------+-------+
; * | status | value |
; * +--------+-------+
; * | show   |     1 |
; * | hide   |     0 |
; * +--------+-------+
; * +-----------------------------------------------+---+
; * | MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SHOW       | 1 |
; * | MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_SHOW | 1 |
; * | MUIEX_SAVELOCATION_INSTALLFOLDER_SHOW         | 1 |
; * | MUIEX_SAVELOCATION_OPTIONALFOLDER_SHOW        | 1 |
; * +-----------------------------------------------+---+
; * ※１．現在 MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SHOW をどのように定義しても常に表示されます。
; * ※２．現在 MUIEX_SAVELOCATION_OPTIONALFOLDER_SHOW をどのように定義しても常に非表示になります。
; * ※　　このオプションは未実装です。
; *
; * サフィックスの定義名とデフォルト値です。
; * +--------------------------------+----+
; * | MUIEX_SAVELOCATION_PATH_SUFFIX | "" |
; * +--------------------------------+----+
; *
; * さらに個別にサフィックスを上書きする事ができます。
; * 例えば、インストール先のみサフィックスを変更するには以下のようにします。
; *
; * EXAMPLE:
; * !define MUIEX_SAVELOCATION_PATH_SUFFIX          "vender\product"
; * !define MUIEX_SAVELOCATION_INSTALLFOLDER_SUFFIX "product\save"
; * !insertmacro MUIEX_PAGE_SAVELOCATION
; *
; * 各項目別の定義名です。
; * 定義されていなければ MUIEX_SAVELOCATION_PATH_SUFFIX が利用されます。
; * +-------------------------------------------------+
; * | MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SUFFIX       |
; * | MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_SUFFIX |
; * | MUIEX_SAVELOCATION_INSTALLFOLDER_SUFFIX         |
; * | MUIEX_SAVELOCATION_OPTIONALFOLDER_SUFFIX        |
; * +-------------------------------------------------+
; *
;**/


!ifndef GUARD_MODSAVELOCATION_NSH
!define GUARD_MODSAVELOCATION_NSH

;---
!macro MUIEX_PAGE_SAVELOCATION
	!ifndef MUIEX_PAGE_SAVELOCATION_USED
		!define MUIEX_PAGE_SAVELOCATION_USED
	!endif

	!insertmacro MUI_PAGE_INIT
	!insertmacro MUIEX_PAGEDECLARATION_SAVELOCATION
!macroend

;---
; インターフェース
!macro MUIEX_SAVELOCATION_INTERFACE
	!ifndef MUIEX_SAVELOCATION_INTERFACE
		!define MUIEX_SAVELOCATION_INTERFACE

		Var muiex.sl.SaveLocationPage
		Var muiex.sl.InfoText
		Var muiex.sl.SaveLocationPathEditBox
		Var muiex.sl.DocumentsFolderRadioButton
		Var muiex.sl.ApplicationDataFolderRadioButton
		Var muiex.sl.InstallFolderRadioButton
		Var muiex.sl.OptionalFolderRadioButton

		Var muiex.sl.DocumentsFolderEnabled
		Var muiex.sl.ApplicationDataFolderEnabled
		Var muiex.sl.InstallFolderEnabled
		Var muiex.sl.OptionalFolderEnabled
	!endif

	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_PATH_SUFFIX						""
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SUFFIX			`${MUIEX_SAVELOCATION_PATH_SUFFIX}`
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_SUFFIX	`${MUIEX_SAVELOCATION_PATH_SUFFIX}`
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_INSTALLFOLDER_SUFFIX			`${MUIEX_SAVELOCATION_PATH_SUFFIX}`
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_OPTIONALFOLDER_SUFFIX			`${MUIEX_SAVELOCATION_PATH_SUFFIX}`

	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SHOW		1
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_SHOW	1
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_INSTALLFOLDER_SHOW			1
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_OPTIONALFOLDER_SHOW			0

	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_DOCUMENTSFOLDER_VALUE		"${MUIEX_LOCATION_DOCUMENTSFOLDER}${MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SUFFIX}"
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_VALUE	"${MUIEX_LOCATION_APPDATAFOLDER}${MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_SUFFIX}"
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_INSTALLFOLDER_VALUE			"${MUIEX_LOCATION_INSTALLFOLDER}${MUIEX_SAVELOCATION_INSTALLFOLDER_SUFFIX}"

	; 常に表示
	!ifdef MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SHOW
		!undef MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SHOW
	!endif
	!define MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SHOW 1

	; 利用できないオプション
	!ifdef MUIEX_SAVELOCATION_OPTIONALFOLDER_SHOW
		!undef MUIEX_SAVELOCATION_OPTIONALFOLDER_SHOW
	!endif
	!define MUIEX_SAVELOCATION_OPTIONALFOLDER_SHOW	0

	!insertmacro MUIEX_SAVELOCATION_InitializeVariables
	!insertmacro MUIEX_SAVELOCATION_GetSaveLocationPath
	!insertmacro MUIEX_SAVELOCATION_GetCurrentSaveLocationPath

!macroend

;---
; 宣言
!macro MUIEX_PAGEDECLARATION_SAVELOCATION
	!insertmacro MUIEX_SAVELOCATION_INTERFACE

	PageEx custom
		PageCallbacks SaveLocationEnter_${MUI_UNIQUEID} SaveLocationLeave_${MUI_UNIQUEID}
	PageExEnd

	!insertmacro MUIEX_FUNCTION_SAVELOCATION SaveLocationEnter_${MUI_UNIQUEID} SaveLocationLeave_${MUI_UNIQUEID}
!macroend

;---
; コールバック関数
!macro MUIEX_FUNCTION_SAVELOCATION ENTER LEAVE

	; チェック状態
	; 1 : DocumentsFolder
	; 2 : ApplicationDataFolder
	; 3 : InstallFolder
	; 4 : OptionalFolder
	Var muiex.sl.SaveLocationNumber

	Function "${ENTER}"

		; ワーニング対策
		StrCpy $muiex.sl.DocumentsFolderRadioButton 0
		StrCpy $muiex.sl.ApplicationDataFolderRadioButton 0
		StrCpy $muiex.sl.InstallFolderRadioButton 0
		StrCpy $muiex.sl.OptionalFolderRadioButton 0

		Push $0

		; enable 状態
		StrCpy $muiex.sl.DocumentsFolderEnabled 1
		${If} ${MUIEX_IsAvailableAppDataFolderForSave} != 0
			StrCpy $muiex.sl.ApplicationDataFolderEnabled 1
		${Else}
			StrCpy $muiex.sl.ApplicationDataFolderEnabled 0
		${EndIf}
		${If} ${MUIEX_IsAvailableInstallFolderForSave} != 0
			StrCpy $muiex.sl.InstallFolderEnabled 1
		${Else}
			StrCpy $muiex.sl.InstallFolderEnabled 0
		${EndIf}
		StrCpy $muiex.sl.OptionalFolderEnabled 1

		${If} ${MUIEX_SaveLocation} == `${MUIEX_SAVELOCATION_DOCUMENTSFOLDER_VALUE}`
			StrCpy $muiex.sl.SaveLocationNumber 1
		${ElseIf} ${MUIEX_SaveLocation} == `${MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_VALUE}`
			StrCpy $muiex.sl.SaveLocationNumber 2
		${ElseIf} ${MUIEX_SaveLocation} == `${MUIEX_SAVELOCATION_INSTALLFOLDER_VALUE}`
			StrCpy $muiex.sl.SaveLocationNumber 3
		${ElseIf} ${MUIEX_SaveLocation} == ""
			; セーブ場所が決まっていないのでデフォルトとする
			StrCpy $muiex.sl.SaveLocationNumber 1
			${MUIEX_SetSaveLocation} "${MUIEX_SAVELOCATION_DOCUMENTSFOLDER_VALUE}"
		${Else}
			; 任意フォルダ
			StrCpy $muiex.sl.SaveLocationNumber 4
		${EndIf}

		${MUIEX_SAVELOCATION_GetSaveLocationPath} $0
		${MUIEX_SetSaveLocationPath} $0

		; NOTE:
		; この場合、前のページに戻ってインストール先を変更している可能性があるので更新する。
		${If} $muiex.sl.SaveLocationNumber == 3
			${MUIEX_SetSaveLocation} "${MUIEX_SAVELOCATION_INSTALLFOLDER_VALUE}"
		${EndIf}

		; セーブデータ保存先の変更が要求されていなければすぐ戻る
		${If} ${MUIEX_IsChangeSaveLocation} == 0
			Return
		${EndIf}
		; セーブデータが既にあるが再配置セクションが定義されていない場合はすぐ戻る
		!ifndef MUIEX_SECID_RELOCATIONSAVEDATA

			${If} ${MUIEX_CurrentSaveLocation} != ""
				Return
			${EndIf}

		!endif

		; 現在のセーブ場所パスの初期化
		${MUIEX_SAVELOCATION_GetCurrentSaveLocationPath} $0
		${MUIEX_SetCurrentSaveLocationPath} $0

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM ENTER

		!insertmacro MUI_HEADER_TEXT_PAGE "Select save data destination" "You can select the save data destination from several options."

		; ダイアログ作成
		nsDialogs::Create /NOUNLOAD 1018
		Pop $muiex.sl.SaveLocationPage

		; ラベルテキスト
		${NSD_CreateLabel} 0 0 100% 30u "Please select the save data destination. $\r$\nIf save data already exists, it will be moved to the new location."
		Pop $muiex.sl.InfoText

		; パス表示用エディット
		${MUIEX_SAVELOCATION_GetSaveLocationPath} $0
		nsDialogs::CreateControl /NOUNLOAD "EDIT" ${ES_READONLY}|${WS_VISIBLE}|${WS_CHILD} ${WS_EX_CLIENTEDGE} 0 55 100% 12u $0
		Pop $muiex.sl.SaveLocationPathEditBox

		; マイドキュメントに保存（デフォルトチェック）
		!if ${MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SHOW} == 1

			${NSD_CreateRadioButton} 10 65u 100% 12u "Save to My Documents. (Recommendation)"
			Pop $muiex.sl.DocumentsFolderRadioButton

			EnableWindow $muiex.sl.DocumentsFolderRadioButton $muiex.sl.DocumentsFolderEnabled
			GetFunctionAddress $0 onDocumentsFolderClick
			nsDialogs::OnClick /NOUNLOAD $muiex.sl.DocumentsFolderRadioButton $0
			${If} $muiex.sl.SaveLocationNumber == 1
				${NSD_Check} $muiex.sl.DocumentsFolderRadioButton
			${EndIf}

		!endif

		; AppData フォルダに保存
		!if ${MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_SHOW} == 1

			${NSD_CreateRadioButton} 10 80u 100% 12u "Save to AppData folder."
			Pop $muiex.sl.ApplicationDataFolderRadioButton

			EnableWindow $muiex.sl.ApplicationDataFolderRadioButton $muiex.sl.ApplicationDataFolderEnabled
			GetFunctionAddress $0 onApplicationDataFolderClick
			nsDialogs::OnClick /NOUNLOAD $muiex.sl.ApplicationDataFolderRadioButton $0
			${If} $muiex.sl.SaveLocationNumber == 2
				${NSD_Check} $muiex.sl.ApplicationDataFolderRadioButton
			${EndIf}

		!endif

		; インストール先に保存
		!if ${MUIEX_SAVELOCATION_INSTALLFOLDER_SHOW} == 1

			${NSD_CreateRadioButton} 10 95u 100% 12u "Save it to the installation destination."
			Pop $muiex.sl.InstallFolderRadioButton

			EnableWindow $muiex.sl.InstallFolderRadioButton $muiex.sl.InstallFolderEnabled
			GetFunctionAddress $0 onInstallFolderClick
			nsDialogs::OnClick /NOUNLOAD $muiex.sl.InstallFolderRadioButton $0
			${If} $muiex.sl.SaveLocationNumber == 3
				${NSD_Check} $muiex.sl.InstallFolderRadioButton
			${EndIf}

		!endif

		; 任意のフォルダに保存
		!if ${MUIEX_SAVELOCATION_OPTIONALFOLDER_SHOW} == 1

			${NSD_CreateRadioButton} 10 110u 100% 12u "Save it in any folder."
			Pop $muiex.sl.OptionalFolderRadioButton

			EnableWindow $muiex.sl.OptionalFolderRadioButton $muiex.sl.OptionalFolderEnabled
			GetFunctionAddress $0 onOptionalFolderClick
			nsDialogs::OnClick /NOUNLOAD $muiex.sl.OptionalFolderRadioButton $0
			${If} $muiex.sl.SaveLocationNumber == 4
				${NSD_Check} $muiex.sl.OptionalFolderRadioButton
			${EndIf}

		!endif

		Pop $0

		nsDialogs::Show

	FunctionEnd

	Function "${LEAVE}"

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM LEAVE

		; セーブデータの再配置セクションがあれば実行するかどうか判定する。
		!ifdef MUIEX_SECID_RELOCATIONSAVEDATA

			${If} ${MUIEX_CurrentSaveLocation} != ""
				${AndIf} ${MUIEX_CurrentSaveLocation} != ${MUIEX_SaveLocation}
				!insertmacro SelectSection ${MUIEX_SECID_RELOCATIONSAVEDATA}
			${Else}
				!insertmacro UnselectSection ${MUIEX_SECID_RELOCATIONSAVEDATA}
			${EndIf}

		!endif

		Push $0

		; 正式なパスを決定する
		${MUIEX_SAVELOCATION_GetSaveLocationPath} $0
		${MUIEX_SetSaveLocationPath} $0

		Pop $0

	FunctionEnd

	;---
	; イベントハンドラー
	!if ${MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SHOW} == 1

		Function onDocumentsFolderClick

			# $0 == Control handle
			Pop $0

			StrCpy $muiex.sl.SaveLocationNumber 1
			${MUIEX_SetSaveLocation} "${MUIEX_SAVELOCATION_DOCUMENTSFOLDER_VALUE}"

			${MUIEX_SAVELOCATION_GetSaveLocationPath} $0
			${NSD_SetText} $muiex.sl.SaveLocationPathEditBox $0

		FunctionEnd

	!endif

	!if ${MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_SHOW} == 1

		Function onApplicationDataFolderClick

			# $0 == Control handle
			Pop $0

			StrCpy $muiex.sl.SaveLocationNumber 2
			${MUIEX_SetSaveLocation} "${MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_VALUE}"

			${MUIEX_SAVELOCATION_GetSaveLocationPath} $0
			${NSD_SetText} $muiex.sl.SaveLocationPathEditBox $0

		FunctionEnd

	!endif

	!if ${MUIEX_SAVELOCATION_INSTALLFOLDER_SHOW} == 1

		Function onInstallFolderClick

			# $0 == Control handle
			Pop $0

			StrCpy $muiex.sl.SaveLocationNumber 3

			${MUIEX_SetSaveLocation} "${MUIEX_SAVELOCATION_INSTALLFOLDER_VALUE}"

			${MUIEX_SAVELOCATION_GetSaveLocationPath} $0
			${NSD_SetText} $muiex.sl.SaveLocationPathEditBox $0

		FunctionEnd

	!endif

	!if ${MUIEX_SAVELOCATION_OPTIONALFOLDER_SHOW} == 1

		Function onOptionalFolderClick

			# $0 == Control handle
			Pop $0

			StrCpy $muiex.sl.SaveLocationNumber 4

			; とりあえず、以前のフォルダを使う
			${MUIEX_SAVELOCATION_GetSaveLocationPath} $0
			${MUIEX_SetSaveLocation} "$0"

			; 「参照」ボタン有効化

		FunctionEnd

	!endif

!macroend


;---
; ${MUIEX_SAVELOCATION_GetReport} VAR
; レポートを VAR に返す。
!macro MUIEX_SAVELOCATION_GetReportCaller _VAR
	Call MUIEX_SAVELOCATION_GetReport
	Pop `${_VAR}`
!macroend

!macro MUIEX_SAVELOCATION_GetReport
	!ifndef MUIEX_SAVELOCATION_GetReport
		!define MUIEX_SAVELOCATION_GetReport	`!insertmacro MUIEX_SAVELOCATION_GetReportCaller`

		!insertmacro MUIEX_SAVELOCATION_GetSaveLocationPath
		!insertmacro MUIEX_SAVELOCATION_GetCurrentSaveLocationPath

		Function MUIEX_SAVELOCATION_GetReport

			Push $0
			Push $1

			${MUIEX_SAVELOCATION_GetSaveLocationPath} $1
			StrCpy $0 "Save data destination:$\r$\n    $1$\r$\n"

			${If} ${MUIEX_CurrentSaveLocation} != ""
				${AndIf} ${MUIEX_CurrentSaveLocation} != ${MUIEX_SaveLocation}

				${MUIEX_SAVELOCATION_GetCurrentSaveLocationPath} $1
				StrCpy $0 "$0    Move save data.$\r$\n"
				StrCpy $0 "$0Old save data storage location:$\r$\n    $1$\r$\n"

			${EndIf}

			StrCpy $0 "$0$\r$\n"

			Pop $1
			Exch $0

		FunctionEnd
	!endif
!macroend


;---
; 内部用ユーティリティ

;---
; ${MUIEX_SAVELOCATION_InitializeVariables
!macro MUIEX_SAVELOCATION_InitializeVariablesCaller
	Call MUIEX_SAVELOCATION_InitializeVariables
!macroend

!macro MUIEX_SAVELOCATION_InitializeVariables
	!ifndef MUIEX_SAVELOCATION_InitializeVariables
		!define MUIEX_SAVELOCATION_InitializeVariables	`!insertmacro MUIEX_SAVELOCATION_InitializeVariablesCaller`

		Function MUIEX_SAVELOCATION_InitializeVariables

			; 初期化の必要がなければすぐに戻る
			${If} ${MUIEX_SaveLocation} != ""
				Return
			${EndIf}

			${If} ${MUIEX_CurrentSaveLocation} == `${MUIEX_SAVELOCATION_DOCUMENTSFOLDER_VALUE}`
				${MUIEX_SetSaveLocation} "${MUIEX_SAVELOCATION_DOCUMENTSFOLDER_VALUE}"
			${ElseIf} ${MUIEX_CurrentSaveLocation} == `${MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_VALUE}`
				${MUIEX_SetSaveLocation} "${MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_VALUE}"
			${ElseIf} ${MUIEX_CurrentSaveLocation} == `${MUIEX_SAVELOCATION_INSTALLFOLDER_VALUE}`
				${MUIEX_SetSaveLocation} "${MUIEX_SAVELOCATION_INSTALLFOLDER_VALUE}"
			${ElseIf} ${MUIEX_CurrentSaveLocation} == ""
				; セーブ場所が決まっていないのでデフォルトとする
				${MUIEX_SetSaveLocation} "${MUIEX_SAVELOCATION_DOCUMENTSFOLDER_VALUE}"
			${Else}
				; 任意フォルダ
				${MUIEX_SetSaveLocation} "${MUIEX_CurrentSaveLocation}"
			${EndIf}

		FunctionEnd
	!endif
!macroend


;---
; ${MUIEX_SAVELOCATION_GetSaveLocationPath} _PATH
!macro MUIEX_SAVELOCATION_GetSaveLocationPathCaller _PATH
	Call MUIEX_SAVELOCATION_GetSaveLocationPath
	Pop `${_PATH}`
!macroend

!macro MUIEX_SAVELOCATION_GetSaveLocationPath
	!ifndef MUIEX_SAVELOCATION_GetSaveLocationPath
		!define MUIEX_SAVELOCATION_GetSaveLocationPath	`!insertmacro MUIEX_SAVELOCATION_GetSaveLocationPathCaller`

		Function MUIEX_SAVELOCATION_GetSaveLocationPath

			${If} ${MUIEX_SaveLocation} == ${MUIEX_SAVELOCATION_DOCUMENTSFOLDER_VALUE}
				Push "$DOCUMENTS${MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SUFFIX}"
			${ElseIf} ${MUIEX_SaveLocation} == ${MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_VALUE}
				Push "$APPDATA${MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_SUFFIX}"
			${Else}
				Push ${MUIEX_SaveLocation}
			${EndIf}

		FunctionEnd
	!endif
!macroend

;---
; ${MUIEX_SAVELOCATION_GetCurrentSaveLocationPath} _PATH
!macro MUIEX_SAVELOCATION_GetCurrentSaveLocationPathCaller _PATH
	Call MUIEX_SAVELOCATION_GetCurrentSaveLocationPath
	Pop `${_PATH}`
!macroend

!macro MUIEX_SAVELOCATION_GetCurrentSaveLocationPath
	!ifndef MUIEX_SAVELOCATION_GetCurrentSaveLocationPath
		!define MUIEX_SAVELOCATION_GetCurrentSaveLocationPath	`!insertmacro MUIEX_SAVELOCATION_GetCurrentSaveLocationPathCaller`

		Function MUIEX_SAVELOCATION_GetCurrentSaveLocationPath

			${If} ${MUIEX_CurrentSaveLocation} == ${MUIEX_SAVELOCATION_DOCUMENTSFOLDER_VALUE}
				Push "$DOCUMENTS${MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SUFFIX}"
			${ElseIf} ${MUIEX_CurrentSaveLocation} == ${MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_VALUE}
				Push "$APPDATA${MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_SUFFIX}"
			${Else}
				Push ${MUIEX_CurrentSaveLocation}
			${EndIf}

		FunctionEnd
	!endif
!macroend

!endif


