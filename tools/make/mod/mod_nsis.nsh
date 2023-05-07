/**
 * $Revision: 148 $
**/

!ifndef GUARD_MODNSIS_NSH
!define GUARD_MODNSIS_NSH

!verbose push
!ifndef MODNSIS_VERBOSE
  !define MODNSIS_VERBOSE	3
!endif
!verbose ${MODNSIS_VERBOSE}

!define MODNSIS_VERSION	"1.0"

!echo "mod_nsis Version ${MODNSIS_VERSION}"

!addincludedir "${MODNSIS_DIR}"
!addplugindir "${MODNSIS_DIR}"

;---
; レジストリキールート
!define NSIS_UTILS_REGKEY_ROOT	SHCTX

;---
; インクルード

; MUIEX 独自の拡張ページ
!include "mod_muiex.nsh"
; ユーティリティ関数マクロ
!include "mod_utils.nsh"

;---
; ソース関連のパス定義
!define PACKAGE_DIR		"${ROOT_DIR}\src\data\products\${TARGET_NAME}"
!define IMAGE_DIR		"${PACKAGE_DIR}\header-images"
!define ICON_DIR		"${PACKAGE_DIR}\icons"

;---
; 自社用レジストリキーのパス定義
!define REG_ROOT		"Software\${VENDER}"
!define REG_PRODUCT		"${REG_ROOT}\${PRODUCT}"
!define REG_ADDFILES	"${REG_PRODUCT}\AddFiles"

;---
; Windows の「アプリケーションの追加と削除」ツール用レジストリキーのパス定義
!define REG_MS_WINDOWS_UNINSTALL	"Software\Microsoft\Windows\CurrentVersion\Uninstall"
!define REG_MS_WINDOWS_PRODUCT		"${REG_MS_WINDOWS_UNINSTALL}\${PRODUCT_ID}"

;---
; Windows のスタートメニュー用パス定義
!define SM_ROOT			"$SMPROGRAMS\${VENDER_J}"
!define SM_PRODUCT		"${SM_ROOT}\${PRODUCT_J}"

;---
; ファイル名に関する定義
!define MAINAPPLICATION_NAME		"${PRODUCT_J}"
!define MAINAPPLICATION_ALIAS		"${PRODUCT_J}"
!define MAINAPPLICATION_FILENAME	"${PRODUCT_J}.exe"
!define UNINSTALLER_NAME			"Uninstall.exe"
!define UNINSTALLER_ALIAS			"アンインストール"
!define INDEX_NAME					"Index.ary"
!define README_NAME					"お読み下さい.txt"

;---
; MUI 設定
!define MUI_ABORTWARNING
!define MUI_ABORTWARNING_TEXT			"${SETUP_TITLE} のセットアップは完了していません。$\n中断しますか？"
!define MUI_UNABORTWARNING
!define MUI_UNABORTWARNING_TEXT			"${SETUP_TITLE} のアンインストールは完了していません。$\n中断しますか？"

!define MUI_ICON						"${ICON_DIR}\installer.ico"
!define MUI_UNICON						"${ICON_DIR}\uninstaller.ico"

!define MUI_WELCOMEFINISHPAGE_BITMAP	"${IMAGE_DIR}\side_banner.bmp"
!define MUI_WELCOMEPAGE_TITLE 			"${SETUP_TITLE} セットアッププログラム"
!define MUI_WELCOMEPAGE_TEXT 			"${SETUP_TITLE} のセットアップを開始します。$\n$\nセットアップを開始する前に他の全てのアプリケーションを終了させることを推奨します。$\n$\n続けるには「次へ」をクリックしてください。"

!define MUI_UNWELCOMEFINISHPAGE_BITMAP	"${IMAGE_DIR}\unside_banner.bmp"

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP			"${IMAGE_DIR}\page_header_r.bmp"
!define MUI_HEADERIMAGE_UNBITMAP		"${IMAGE_DIR}\unpage_header_r.bmp"

;---
; MUIEX 設定
!define MUIEX_SAVELOCATION_PATH_SUFFIX			"\${VENDER}\${PRODUCT}"
!define MUIEX_SAVELOCATION_INSTALLFOLDER_SUFFIX	"\save"

!define MUIEX_UN_SAVEDATA_PATH_SUFFIX			${MUIEX_SAVELOCATION_PATH_SUFFIX}
!define MUIEX_UN_SAVEDATA_INSTALLFOLDER_SUFFIX	${MUIEX_SAVELOCATION_INSTALLFOLDER_SUFFIX}


;---
; 定義の調整

; 現在「すべてのユーザー」は未実装です。
!ifdef USE_ALLUSERS
	!undef USE_ALLUSERS
!endif
!define USE_ALLUSERS	0


;---
; 重要な動作設定

; 製品名
Name "${PRODUCT_J}"
; 初期インストール先パス
InstallDir "$PROGRAMFILES\${VENDER}"
; インストール先パスの保存先
!if ${USE_ALLUSERS} == 0
	InstallDirRegKey HKCU "${REG_MS_WINDOWS_PRODUCT}" "InstallLocation"
!else
	InstallDirRegKey HKLM "${REG_MS_WINDOWS_PRODUCT}" "InstallLocation"
!endif
; マニフェストを追加する
XPStyle on
; インストーラーの実行に管理者権限を要求する
RequestExecutionLevel admin
; インストール／アンインストールの詳細を表示する
ShowInstDetails show
ShowUninstDetails show


;---
; モジュール定義

;---
; ${NSIS_Initialize}
; .onInit 内部でこれを必ず呼び出してください。
;
; ${un.NSIS_Initialize}
; un.onInit 内部でこれを必ず呼び出してください。
!macro NSIS_InitializeCaller
	Call NSIS_Initialize
!macroend

!macro NSIS_Initialize

	; モジュール展開
	!insertmacro MUIEX_Initialize

	!ifndef NSIS_Initialize
		!define NSIS_Initialize	`!insertmacro NSIS_InitializeCaller`

		Function NSIS_Initialize

			Push $0
			Push $1

			; 現在のユーザー／すべてのユーザー
			!if ${USE_ALLUSERS} == 0
				SetShellVarContext current
			!else
				SetShellVarContext all
			!endif

			; インストールタイプ
			ReadRegStr $0 ${NSIS_UTILS_REGKEY_ROOT} "${REG_PRODUCT}" "Type"
			IfErrors NSIS_Initialize_unknowntype
			GoTo NSIS_Initialize_knowntype

			NSIS_Initialize_unknowntype:
				ClearErrors
				StrCpy $0 ""

			NSIS_Initialize_knowntype:

			; セーブデータ保存先
			ReadRegStr $1 ${NSIS_UTILS_REGKEY_ROOT} "${REG_PRODUCT}" "SaveLocation"
			IfErrors NSIS_Initialize_nothavesavedata
			GoTo NSIS_Initialize_existsavedata

			NSIS_Initialize_nothavesavedata:
				ClearErrors
				StrCpy $1 ""

			NSIS_Initialize_existsavedata:

			; MUIEX 初期化
			${MUIEX_Initialize} $0 $1

			InitPluginsDir

			Pop $1
			Pop $0

		FunctionEnd
	!endif
!macroend

;---
!macro un.NSIS_InitializeCaller
	Call un.NSIS_Initialize
!macroend

!macro un.NSIS_Initialize

	; モジュール展開
	!insertmacro un.MUIEX_Initialize

	!ifndef un.NSIS_Initialize
		!define un.NSIS_Initialize	`!insertmacro un.NSIS_InitializeCaller`

		Function un.NSIS_Initialize

			Push $0

			; 現在のユーザー／すべてのユーザー
			!if ${USE_ALLUSERS} == 0
				SetShellVarContext current
			!else
				SetShellVarContext all
			!endif

			; セーブデータ保存先
			ReadRegStr $0 ${NSIS_UTILS_REGKEY_ROOT} "${REG_PRODUCT}" "SaveLocation"
			IfErrors NSIS_Initialize_nothavesavedata
			GoTo NSIS_Initialize_existsavedata

			NSIS_Initialize_nothavesavedata:
				ClearErrors
				StrCpy $0 ""

			NSIS_Initialize_existsavedata:

			; UN_MUIEX 初期化
			${un.MUIEX_Initialize} $0

			Pop $0

			InitPluginsDir

		FunctionEnd
	!endif
!macroend


!verbose pop

!endif	; GUARD_MODNSIS_NSH


