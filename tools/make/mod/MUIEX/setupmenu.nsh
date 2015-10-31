;/**
; * $Revision: 144 $
; *
; * HOWTO:
; * ページを挿入したい場所に !insertmacro MUIEX_PAGE_SETUPMENU を挿入してください。
; *
; * NOTE:
; * MUIEX_PAGE_SETUPMENU を !insertmacro する前に定義を追加する事で
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
; * +------------------------------------------+---+
; * | MUIEX_SETUPMENU_INSTALLLOCATION_ENABLED  | 0 |
; * | MUIEX_SETUPMENU_SAVEDATALOCATION_ENABLED | 1 |
; * | MUIEX_SETUPMENU_SHORTCUTLOCATION_ENABLED | 1 |
; * +------------------------------------------+---+
; *
;**/


!ifndef GUARD_MODSETUPMENU_NSH
!define GUARD_MODSETUPMENU_NSH

;---
!macro MUIEX_PAGE_SETUPMENU
	!insertmacro MUI_PAGE_INIT
	!insertmacro MUIEX_PAGEDECLARATION_SETUPMENU
!macroend

;---
; インターフェース
!macro MUIEX_SETUPMENU_INTERFACE
	!ifndef MUIEX_SETUPMENU_INTERFACE
		!define MUIEX_SETUPMENU_INTERFACE

		Var muiex.sm.SetupMenuPage
		Var muiex.sm.InfoText
		Var muiex.sm.DetailsText
		Var muiex.sm.InstallLocationCheckBox
		Var muiex.sm.SaveDataLocationCheckBox
		Var muiex.sm.ShortcutLocationCheckBox
	!endif

	!insertmacro MUI_DEFAULT MUIEX_SETUPMENU_HEADER_TEXT		"セットアップメニュー"
	!insertmacro MUI_DEFAULT MUIEX_SETUPMENU_HEADER_SUB_TEXT	"セットアップ中にいくつか変更できる設定があります。"
	!insertmacro MUI_DEFAULT MUIEX_SETUPMENU_INFO				\
		"変更したい項目を選んでチェックをいれてください。$\nチェックを入れた項目は次のページ以降で設定を変更する事ができます。"

	!insertmacro MUI_DEFAULT MUIEX_SETUPMENU_INSTALLLOCATION	"インストール先を変更する。"
	!insertmacro MUI_DEFAULT MUIEX_SETUPMENU_SAVEDATALOCATION	"セーブデータの保存場所を変更する。"
	!insertmacro MUI_DEFAULT MUIEX_SETUPMENU_SHORTCUTLOCATION	"ショートカットの作成場所を変更する。"

	; 各コントロールの enable 状態
	!insertmacro MUI_DEFAULT MUIEX_SETUPMENU_INSTALLLOCATION_ENABLED	1
	!insertmacro MUI_DEFAULT MUIEX_SETUPMENU_SAVEDATALOCATION_ENABLED	1
	!insertmacro MUI_DEFAULT MUIEX_SETUPMENU_SHORTCUTLOCATION_ENABLED	1

	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_PATH_SUFFIX						""
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SUFFIX			`${MUIEX_SAVELOCATION_PATH_SUFFIX}`
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_SUFFIX	`${MUIEX_SAVELOCATION_PATH_SUFFIX}`
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_INSTALLFOLDER_SUFFIX			`${MUIEX_SAVELOCATION_PATH_SUFFIX}`
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_OPTIONALFOLDER_SUFFIX			`${MUIEX_SAVELOCATION_PATH_SUFFIX}`

	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_DOCUMENTSFOLDER_VALUE		"${MUIEX_LOCATION_DOCUMENTSFOLDER}${MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SUFFIX}"
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_VALUE	"${MUIEX_LOCATION_APPDATAFOLDER}${MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_SUFFIX}"
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_INSTALLFOLDER_VALUE			"${MUIEX_LOCATION_INSTALLFOLDER}${MUIEX_SAVELOCATION_INSTALLFOLDER_SUFFIX}"

	; 各ページに依存する
	!ifmacrodef MUIEX_SAVELOCATION_InitializeVariables
		!insertmacro MUIEX_SAVELOCATION_InitializeVariables
	!endif
	!insertmacro MUIEX_SAVELOCATION_InitializeVariables
	!ifmacrodef MUIEX_SAVELOCATION_GetReport
		!insertmacro MUIEX_SAVELOCATION_GetReport
	!endif
	!ifmacrodef MUIEX_SHORTCUTLOCATION_GetReport
		!insertmacro MUIEX_SHORTCUTLOCATION_GetReport
	!endif

!macroend

;---
; 宣言
!macro MUIEX_PAGEDECLARATION_SETUPMENU
	!insertmacro MUIEX_SETUPMENU_INTERFACE

	PageEx custom
		PageCallbacks SetupMenuEnter_${MUI_UNIQUEID} SetupMenuLeave_${MUI_UNIQUEID}
	PageExEnd

	!insertmacro MUIEX_FUNCTION_SETUPMENU SetupMenuEnter_${MUI_UNIQUEID} SetupMenuLeave_${MUI_UNIQUEID}
!macroend

;---
; コールバック関数
!macro MUIEX_FUNCTION_SETUPMENU ENTER LEAVE

	Function "${ENTER}"

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM ENTER

		!insertmacro MUI_HEADER_TEXT_PAGE ${MUIEX_SETUPMENU_HEADER_TEXT} ${MUIEX_SETUPMENU_HEADER_SUB_TEXT}

		; ダイアログ作成
		nsDialogs::Create /NOUNLOAD 1018
		Pop $muiex.sm.SetupMenuPage

		; ラベルテキスト
		${NSD_CreateLabel} 0 0 100% 30u ${MUIEX_SETUPMENU_INFO}
		Pop $muiex.sm.InfoText

		; $0 退避
		Push $0

		; 実行内容テキストの作成
		StrCpy $0 ""

		; インストール先パス
		StrCpy $0 "$0インストール先：$\r$\n    $INSTDIR$\r$\n$\r$\n"

		; セーブデータ保存先のレポート
		!ifdef MUIEX_SAVELOCATION_GetReport
			${MUIEX_SAVELOCATION_InitializeVariables}
			${MUIEX_SAVELOCATION_GetReport} $1
			StrCpy $0 "$0$1"
		!endif

		; ショートカット関連のレポート
		!ifdef MUIEX_SHORTCUTLOCATION_GetReport
			${MUIEX_SHORTCUTLOCATION_GetReport} $1
			StrCpy $0 "$0$1"
		!endif

		; 現在の内容表示
		nsDialogs::CreateControl /NOUNLOAD "EDIT" \
			${ES_MULTILINE}|${ES_READONLY}|${WS_VISIBLE}|${WS_CHILD}|${WS_VSCROLL} \
			${WS_EX_CLIENTEDGE} 0 30u 100% 55u $0
		Pop $muiex.sm.DetailsText

		; インストール先を変更するかどうか
		${NSD_CreateCheckBox} 20u 95u 100% 12u ${MUIEX_SETUPMENU_INSTALLLOCATION}
		Pop $muiex.sm.InstallLocationCheckBox

		; 既にインストールされている場合はインストール先の変更はできない
		${If} ${MUIEX_Installtype} == ${MUIEX_INSTALLTYPE_FULL}
			EnableWindow $muiex.sm.InstallLocationCheckBox 0
		${Else}
			EnableWindow $muiex.sm.InstallLocationCheckBox ${MUIEX_SETUPMENU_INSTALLLOCATION_ENABLED}
			${If} ${MUIEX_IsChangeInstallLocation} != 0
				${NSD_Check} $muiex.sm.InstallLocationCheckBox
			${EndIf}
		${EndIf}
		GetFunctionAddress $0 OnInstallLocationClick
		nsDialogs::OnClick /NOUNLOAD $muiex.sm.InstallLocationCheckBox $0

		; セーブ場所を変更するかどうか
		${NSD_CreateCheckBox} 20u 110u 100% 12u ${MUIEX_SETUPMENU_SAVEDATALOCATION}
		Pop $muiex.sm.SaveDataLocationCheckBox

		; 既にインストールされている、かつセーブデータの再配置セクションが存在しないならば変更はできない
		${If} ${MUIEX_CurrentSaveLocation} != ""

			!ifndef MUIEX_SECID_RELOCATIONSAVEDATA
				EnableWindow $muiex.sm.SaveDataLocationCheckBox 0
			!else
				${If} ${MUIEX_IsChangeSaveLocation} != 0
					${NSD_Check} $muiex.sm.SaveDataLocationCheckBox
				${EndIf}
			!endif

		${Else}
			EnableWindow $muiex.sm.SaveDataLocationCheckBox ${MUIEX_SETUPMENU_SAVEDATALOCATION_ENABLED}
			${If} ${MUIEX_IsChangeSaveLocation} != 0
				${NSD_Check} $muiex.sm.SaveDataLocationCheckBox
			${EndIf}
		${EndIf}
		GetFunctionAddress $0 OnSaveDataLocationClick
		nsDialogs::OnClick /NOUNLOAD $muiex.sm.SaveDataLocationCheckBox $0

		; ショートカットの場所を変更するかどうか
		${NSD_CreateCheckBox} 20u 125u 100% 12u ${MUIEX_SETUPMENU_SHORTCUTLOCATION}
		Pop $muiex.sm.ShortcutLocationCheckBox

		EnableWindow $muiex.sm.ShortcutLocationCheckBox ${MUIEX_SETUPMENU_SHORTCUTLOCATION_ENABLED}
		${If} ${MUIEX_IsConfigureShortcutItems} != 0
			${NSD_Check} $muiex.sm.ShortcutLocationCheckBox
		${EndIf}
		GetFunctionAddress $0 OnShortcutLocationClick
	nsDialogs::OnClick /NOUNLOAD $muiex.sm.ShortcutLocationCheckBox $0

		Pop $0

		nsDialogs::Show

	FunctionEnd

	Function "${LEAVE}"

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM LEAVE

	FunctionEnd

	;---
	; イベントハンドラー
	Function OnInstallLocationClick

		# $0 == Control handle
		Exch $0

		${NSD_GetState} $muiex.sm.InstallLocationCheckBox $0
		${If} $0 == ${BST_CHECKED}
			${MUIEX_ChangeInstallLocation}
		${Else}
			${MUIEX_FixInstallLocation}
		${EndIf}

		Pop $0

	FunctionEnd

	Function OnSaveDataLocationClick

		# $0 == Control handle
		Exch $0

		${NSD_GetState} $muiex.sm.SaveDataLocationCheckBox $0
		${If} $0 == ${BST_CHECKED}
			${MUIEX_ChangeSaveLocation}
		${Else}
			${MUIEX_FixSaveLocation}
		${EndIf}

		Pop $0

	FunctionEnd

	Function OnShortcutLocationClick

		# $0 == Control handle
		Exch $0

		${NSD_GetState} $muiex.sm.ShortcutLocationCheckBox $0
		${If} $0 == ${BST_CHECKED}
			${MUIEX_ConfigureShortcutItems}
		${Else}
			${MUIEX_DefaultShortcutItems}
		${EndIf}

		Pop $0

	FunctionEnd

!macroend

!endif


