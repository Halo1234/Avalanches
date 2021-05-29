;/**
; * $Revision: 148 $
; *
; * HOWTO:
; * ページを挿入したい場所に !insertmacro MUIEX_PAGE_SHORTCUTLOCATION を挿入してください。
; * 
; * このページで選択できるオプションは以下の通りです。
; *
; * ・スタートメニュー
; *   MUIEX_SECID_CREATESTARTMENU が定義されていれば表示されます。
; *   スタートメニューを作成するセクションの ID を指定してください。
; *   ユーザーが作成しないを選択した場合指定されたセクションは呼び出されません。
; *
; * ・アンインストールショートカット
; *   MUIEX_SECID_CREATEUNINSTALLSHORTCUTINSTARTMENU が定義されていれば表示されます。
; *   ※MUIEX_SECID_CREATESTARTMENU が定義されていなければなりません。
; *   アンインストールショートカットを作成するセクションの ID を指定してください。
; *   ユーザーが作成しないを選択した場合指定されたセクションは呼び出されません。
; *
; * ・デスクトップショートカット
; *   MUIEX_SECID_CREATEDESKTOPSHORTCUT が定義されていれば表示されます。
; *   デスクトップにショートカットを作成するセクションの ID を指定してください。
; *   ユーザーが作成しないを選択した場合指定されたセクションは呼び出されません。
; *
; * FIXME:
; * 現在のところオプションが何一つ定義されなかった場合
; * 選択できるものが何も存在しないページが表示されてしまいます。
; *
; * NOTE:
; * ${MUIEX_SHORTCUTLOCATION_GetReport} でこのページで選択された内容について
; * 人間が読める形でレポートを取得する事ができます。
; * この関数マクロを使うには事前に !insertmacro ${MUIEX_SHORTCUTLOCATION_GetReport} を挿入する必要があります。
; * ただし、MUIEX_PAGE_CONFIRM を使う場合はこれらを使う必要はないでしょう。
; *
; * NOTE:
; * MUIEX_PAGE_SHORTCUTLOCATION を !insertmacro する前に定義を追加する事で
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
; * +--------------------------------------------------------+---+
; * | MUIEX_SHORTCUTLOCATION_CREATESTARTMENU_ENABLED         | 1 |
; * | MUIEX_SHORTCUTLOCATION_CREATEUNINSTALLSHORTCUT_ENABLED | 1 |
; * | MUIEX_SHORTCUTLOCATION_CREATEDESKTOPSHORTCUT_ENABLED   | 1 |
; * +--------------------------------------------------------+---+
; *
;**/

!ifndef GUARD_MODSHORTCUTLOCATION_NSH
!define GUARD_MODSHORTCUTLOCATION_NSH

!include Sections.nsh

;---
!macro MUIEX_PAGE_SHORTCUTLOCATION
	!ifndef MUIEX_PAGE_SHORTCUTLOCATION_USED
		!define MUIEX_PAGE_SHORTCUTLOCATION_USED
	!endif

	!insertmacro MUI_PAGE_INIT
	!insertmacro MUIEX_PAGEDECLARATION_SHORTCUTLOCATION
!macroend

;---
; インターフェース
!macro MUIEX_SHORTCUTLOCATION_INTERFACE
	!ifndef MUIEX_SHORTCUTLOCATION_INTERFACE
		!define MUIEX_SHORTCUTLOCATION_INTERFACE

		Var muiex.sh.ShortcutLocationPage
		Var muiex.sh.InfoText
		Var muiex.sh.CreateStartMenuCheckBox
		Var muiex.sh.CreateUninstallShortcutCheckBox
		Var muiex.sh.CreateDesktopShortcutCheckBox

	!endif

	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_HEADER_TEXT		"ショートカット作成"
	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_HEADER_SUB_TEXT	"必要なショートカットを選択する事ができます。"
	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_INFO				\
		"スタートメニューを登録するとサポートツールへのショートカットも自動的に登録されます。$\n通常はこれを登録する事をお奨めします。$\nアンインストーラへのショートカットを作成しない場合「コントロールパネル」の「アプリケーションの追加と削除」ツールからアンインストールする事ができます。"

	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_CREATESTARTMENU			"スタートメニューに登録する。（推奨）"
	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_CREATEUNINSTALLSHORTCUT	"スタートメニューにアンインストーラへのショートカットを作成する。"
	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_CREATEDESKTOPSHORTCUT	"デスクトップにショートカットを作成する。"

	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_CREATESTARTMENU_ENABLED			1
	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_CREATEUNINSTALLSHORTCUT_ENABLED	1
	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_CREATEDESKTOPSHORTCUT_ENABLED	1

	!insertmacro MUIEX_SHORTCUTLOCATION_SyncRadioButton

!macroend

;---
; 宣言
!macro MUIEX_PAGEDECLARATION_SHORTCUTLOCATION
	!insertmacro MUIEX_SHORTCUTLOCATION_INTERFACE

	PageEx custom
		PageCallbacks ShortcutLocationEnter_${MUI_UNIQUEID} ShortcutLocationLeave_${MUI_UNIQUEID}
	PageExEnd

	!insertmacro MUIEX_FUNCTION_SHORTCUTLOCATION ShortcutLocationEnter_${MUI_UNIQUEID} ShortcutLocationLeave_${MUI_UNIQUEID}
!macroend

;---
; コールバック関数
!macro MUIEX_FUNCTION_SHORTCUTLOCATION ENTER LEAVE

	Function "${ENTER}"

		; ワーニング対策
		StrCpy $muiex.sh.CreateStartMenuCheckBox 0
		StrCpy $muiex.sh.CreateUninstallShortcutCheckBox 0
		StrCpy $muiex.sh.CreateDesktopShortcutCheckBox 0

		; ショートカット保存先の変更が要求されていなければすぐ戻る
		${If} ${MUIEX_IsConfigureShortcutItems} == 0
			Return
		${EndIf}

		Push $0

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM ENTER

		!insertmacro MUI_HEADER_TEXT_PAGE ${MUIEX_SHORTCUTLOCATION_HEADER_TEXT} ${MUIEX_SHORTCUTLOCATION_HEADER_SUB_TEXT}

		; ダイアログ作成
		nsDialogs::Create /NOUNLOAD 1018
		Pop $muiex.sh.ShortcutLocationPage

		; ラベルテキスト
		${NSD_CreateLabel} 0 0 100% 35u ${MUIEX_SHORTCUTLOCATION_INFO}
		Pop $muiex.sh.InfoText

		; スタートメニューの登録
		!ifdef MUIEX_SECID_CREATESTARTMENU

			${NSD_CreateCheckBox} 10u 65u 100% 12u ${MUIEX_SHORTCUTLOCATION_CREATESTARTMENU}
			Pop $muiex.sh.CreateStartMenuCheckBox

			EnableWindow $muiex.sh.CreateStartMenuCheckBox ${MUIEX_SHORTCUTLOCATION_CREATESTARTMENU_ENABLED}
			GetFunctionAddress $0 OnCreateStartMenuClick
			nsDialogs::OnClick /NOUNLOAD $muiex.sh.CreateStartMenuCheckBox $0
			${MUIEX_SHORTCUTLOCATION_SyncRadioButton} ${MUIEX_SECID_CREATESTARTMENU} $muiex.sh.CreateStartMenuCheckBox

			; アンインストーラへのショートカットをスタートメニューに作成する
			!ifdef MUIEX_SECID_CREATEUNINSTALLSHORTCUTINSTARTMENU

				${NSD_CreateCheckBox} 20u 80u 100% 12u ${MUIEX_SHORTCUTLOCATION_CREATEUNINSTALLSHORTCUT}
				Pop $muiex.sh.CreateUninstallShortcutCheckBox

				!if ${MUIEX_SHORTCUTLOCATION_CREATEUNINSTALLSHORTCUT_ENABLED} == 1

					${NSD_GetState} $muiex.sh.CreateStartMenuCheckBox $0
					${If} $0 == ${BST_CHECKED}
						EnableWindow $muiex.sh.CreateUninstallShortcutCheckBox 1
					${Else}
						EnableWindow $muiex.sh.CreateUninstallShortcutCheckBox 0
					${EndIf}

				!else

					EnableWindow $muiex.sh.CreateUninstallShortcutCheckBox 0

				!endif

				GetFunctionAddress $0 OnCreateUninstallShortcutClick
				nsDialogs::OnClick /NOUNLOAD $muiex.sh.CreateUninstallShortcutCheckBox $0
				${MUIEX_SHORTCUTLOCATION_SyncRadioButton} ${MUIEX_SECID_CREATEUNINSTALLSHORTCUTINSTARTMENU} $muiex.sh.CreateUninstallShortcutCheckBox

			!endif

		!endif

		; デスクトップにショートカットを作成
		!ifdef MUIEX_SECID_CREATEDESKTOPSHORTCUT

			${NSD_CreateCheckBox} 10u 95u 100% 12u ${MUIEX_SHORTCUTLOCATION_CREATEDESKTOPSHORTCUT}
			Pop $muiex.sh.CreateDesktopShortcutCheckBox

			EnableWindow $muiex.sh.CreateDesktopShortcutCheckBox ${MUIEX_SHORTCUTLOCATION_CREATEDESKTOPSHORTCUT_ENABLED}
			GetFunctionAddress $0 OnCreateDesktopShortcutClick
			nsDialogs::OnClick /NOUNLOAD $muiex.sh.CreateDesktopShortcutCheckBox $0
			${MUIEX_SHORTCUTLOCATION_SyncRadioButton} ${MUIEX_SECID_CREATEDESKTOPSHORTCUT} $muiex.sh.CreateDesktopShortcutCheckBox

		!endif

		Pop $0

		nsDialogs::Show

	FunctionEnd

	Function "${LEAVE}"

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM LEAVE

	FunctionEnd

	;---
	; イベントハンドラー
	!ifdef MUIEX_SECID_CREATESTARTMENU

		Function OnCreateStartMenuClick

			# $0 == Control handle
			Exch $0

			${NSD_GetState} $muiex.sh.CreateStartMenuCheckBox $0
			${If} $0 == ${BST_CHECKED}
				!insertmacro SelectSection ${MUIEX_SECID_CREATESTARTMENU}
			${Else}
				!insertmacro UnselectSection ${MUIEX_SECID_CREATESTARTMENU}
			${EndIf}

			!if ${MUIEX_SHORTCUTLOCATION_CREATEUNINSTALLSHORTCUT_ENABLED} == 1
				${NSD_GetState} $muiex.sh.CreateStartMenuCheckBox $0
				${If} $0 == ${BST_CHECKED}
					EnableWindow $muiex.sh.CreateUninstallShortcutCheckBox 1
				${Else}
					EnableWindow $muiex.sh.CreateUninstallShortcutCheckBox 0
				${EndIf}
			!endif

			Pop $0

		FunctionEnd

		!ifdef MUIEX_SECID_CREATEUNINSTALLSHORTCUTINSTARTMENU

			Function OnCreateUninstallShortcutClick

				# $0 == Control handle
				Exch $0

				${NSD_GetState} $muiex.sh.CreateUninstallShortcutCheckBox $0
				${If} $0 == ${BST_CHECKED}
					!insertmacro SelectSection ${MUIEX_SECID_CREATEUNINSTALLSHORTCUTINSTARTMENU}
				${Else}
					!insertmacro UnselectSection ${MUIEX_SECID_CREATEUNINSTALLSHORTCUTINSTARTMENU}
				${EndIf}

				Pop $0

			FunctionEnd

		!endif

	!endif

	!ifdef MUIEX_SECID_CREATEDESKTOPSHORTCUT

		Function OnCreateDesktopShortcutClick

			# $0 == Control handle
			Exch $0

			${NSD_GetState} $muiex.sh.CreateDesktopShortcutCheckbox $0
			${If} $0 == ${BST_CHECKED}
				!insertmacro SelectSection ${MUIEX_SECID_CREATEDESKTOPSHORTCUT}
			${Else}
				!insertmacro UnselectSection ${MUIEX_SECID_CREATEDESKTOPSHORTCUT}
			${EndIf}

			Pop $0

		FunctionEnd

	!endif

!macroend


;---
; ${MUIEX_SHORTCUTLOCATION_GetReport} VAR
; レポートを VAR に返す。
!macro MUIEX_SHORTCUTLOCATION_GetReportCaller _VAR
	Call MUIEX_SHORTCUTLOCATION_GetReport
	Pop `${_VAR}`
!macroend

!macro MUIEX_SHORTCUTLOCATION_GetReport
	!ifndef MUIEX_SHORTCUTLOCATION_GetReport
		!define MUIEX_SHORTCUTLOCATION_GetReport	`!insertmacro MUIEX_SHORTCUTLOCATION_GetReportCaller`

		Function MUIEX_SHORTCUTLOCATION_GetReport

			Push $0

			StrCpy $0 ""

			!ifdef MUIEX_SECID_CREATESTARTMENU

				!insertmacro SectionFlagIsSet ${MUIEX_SECID_CREATESTARTMENU} ${SF_SELECTED} startmenu_selected startmenu_notselected

				startmenu_selected:
					StrCpy $0 "$0スタートメニュー：$\r$\n    作成する。$\r$\n$\r$\n"
					Goto startmenu_done

				startmenu_notselected:
					StrCpy $0 "$0スタートメニュー：$\r$\n    作成しない。$\r$\n$\r$\n"
					Goto startmenu_done

				startmenu_done:

				!ifdef MUIEX_SECID_CREATEUNINSTALLSHORTCUTINSTARTMENU

					!insertmacro SectionFlagIsSet ${MUIEX_SECID_CREATEUNINSTALLSHORTCUTINSTARTMENU} ${SF_SELECTED} \
						uninstall_selected uninstall_notselected

					uninstall_selected:
						StrCpy $0 "$0アンインストーラへのショートカット：$\r$\n    作成する。$\r$\n$\r$\n"
						Goto uninstall_done

					uninstall_notselected:
						StrCpy $0 "$0アンインストーラへのショートカット：$\r$\n    作成しない。$\r$\n$\r$\n"
						Goto uninstall_done

					uninstall_done:

				!endif

			!endif

			!ifdef MUIEX_SECID_CREATEDESKTOPSHORTCUT

				!insertmacro SectionFlagIsSet ${MUIEX_SECID_CREATEDESKTOPSHORTCUT} ${SF_SELECTED} desktop_selected desktop_notselected

				desktop_selected:
					StrCpy $0 "$0デスクトップショートカット：$\r$\n    作成する。$\r$\n$\r$\n"
					Goto desktop_done

				desktop_notselected:
					StrCpy $0 "$0デスクトップショートカット：$\r$\n    作成しない。$\r$\n$\r$\n"
					Goto desktop_done

				desktop_done:

			!endif

			Exch $0

		FunctionEnd
	!endif
!macroend


;---
; 内部用ユーティリティ

;---
; ${MUIEX_SHORTCUTLOCATION_SyncRadioButton} SECID CTRLID
!macro MUIEX_SHORTCUTLOCATION_SyncRadioButtonCaller _SECID _CTRLID
	Push `${_CTRLID}`
	Push `${_SECID}`
	Call MUIEX_SHORTCUTLOCATION_SyncRadioButton
!macroend

!macro MUIEX_SHORTCUTLOCATION_SyncRadioButton
	!ifndef MUIEX_SHORTCUTLOCATION_SyncRadioButton
		!define MUIEX_SHORTCUTLOCATION_SyncRadioButton	`!insertmacro MUIEX_SHORTCUTLOCATION_SyncRadioButtonCaller`
		Function MUIEX_SHORTCUTLOCATION_SyncRadioButton

			Exch $0	; _SECID
			Exch
			Exch $1 ; _CTRLID

			!insertmacro SectionFlagIsSet $0 ${SF_SELECTED} SyncRadioButton_selected SyncRadioButton_notselected

			SyncRadioButton_selected:
				${NSD_Check} $1
				Return

			SyncRadioButton_notselected:
				${NSD_Uncheck} $1
				Return

		FunctionEnd
	!endif
!macroend

!endif


