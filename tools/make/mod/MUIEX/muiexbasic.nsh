/**
 * $Revision: 144 $
**/

!ifndef GUARD_MODMUIEXBASIC_NSH
!define GUARD_MODMUIEXBASIC_NSH

!include "MUI2.nsh"
!include "WinVer.nsh"

;---
; MUIEX �S�̂ŗ��p����ϐ�
Var muiex.IsChangeInstallLocation
Var muiex.IsChangeSaveLocation
Var muiex.IsConfigureShortcutItems

Var muiex.IsAvailableAppDataFolderForSave
Var muiex.IsAvailableInstallFolderForSave
Var muiex.SaveLocation
Var muiex.SaveLocationPath

Var muiex.InstallType
Var muiex.CurrentSaveLocation
Var muiex.CurrentSaveLocationPath

!macro MUIEX_VARIABLES
	!insertmacro MUI_DEFAULT MUIEX_INSTALLTYPE_FULL		"Full"
	!insertmacro MUI_DEFAULT MUIEX_INSTALLTYPE_SAVEONLY	"SaveOnly"
	!insertmacro MUI_DEFAULT MUIEX_INSTALLTYPE_NORMAL	""
!macroend


;---
; ${MUIEX_Initialize} TYPE
; MUIEX ���g���ꍇ�͕K�� .onInit �ł�����Ăяo���Ă��������B
;
; TYPE �ɂ͈ȉ��̒l�̂����ꂩ��n���Ă��������B
; +------------+-------------------------------------------------------------+
; |    TYPE    |                         DESCRIPTION                         |
; | "Full"     | ���ɃC���X�g�[������Ă���̂ŏC���C���X�g�[����v������B  |
; | "SaveOnly" | �Z�[�u�f�[�^�݂̂��C���X�g�[������Ă���B                  |
; | ""         | �V�K�C���X�g�[����v������B                                |
; +------------+-------------------------------------------------------------+
;
; SAVELOCATION �ɂ͌��݂̃Z�[�u�ꏊ���w�肵�Ă��������B
; �Z�[�u�f�[�^�������ꍇ�͋󕶎�����w�肵�܂��B
!macro MUIEX_InitializeCaller _TYPE _SAVELOCATION
	Push `${_SAVELOCATION}`
	Push `${_TYPE}`
	Call MUIEX_Initialize
!macroend

!macro MUIEX_Initialize
	!ifndef MUIEX_Initialize
		!insertmacro MUIEX_VARIABLES

		!define MUIEX_Initialize	`!insertmacro MUIEX_InitializeCaller`

		!insertmacro MUIEX_ChangeInstallLocation
		!insertmacro MUIEX_FixInstallLocation

		!insertmacro MUIEX_ChangeSaveLocation
		!insertmacro MUIEX_FixSaveLocation

		!insertmacro MUIEX_ConfigureShortcutItems
		!insertmacro MUIEX_DefaultShortcutItems

		!insertmacro MUIEX_AvailableAppDataFolderForSave
		!insertmacro MUIEX_NotAvailableAppDataFolderForSave
		!insertmacro MUIEX_AvailableInstallFolderForSave
		!insertmacro MUIEX_NotAvailableInstallFolderForSave
		!insertmacro MUIEX_SetSaveLocation
		!insertmacro MUIEX_SetSaveLocationPath
		!insertmacro MUIEX_SetCurrentSaveLocationPath

		Function MUIEX_Initialize

			Exch $0 ; _TYPE
			Exch
			Exch $1 ; _SAVELOCATION

			; �C���C���X�g�[�����ăC���X�g�[�����V�K�C���X�g�[��������
			${If} $0 == `${MUIEX_INSTALLTYPE_FULL}`
				${OrIf} $0 == `${MUIEX_INSTALLTYPE_SAVEONLY}`
				StrCpy $muiex.InstallType $0
				; �Z�[�u�f�[�^�̈ړ����K�v��������Ȃ��̂Ō��݂̃Z�[�u�ꏊ���L�^���Ă���
				StrCpy $muiex.CurrentSaveLocation $1
				; �A���C���X�g�[���������݂͕K�v�Ȃ�
				!ifdef MUIEX_SECID_WRITEUNINSTALLER
					!insertmacro UnselectSection ${MUIEX_SECID_WRITEUNINSTALLER}
				!endif
			${ElseIf} $0 == `${MUIEX_INSTALLTYPE_NORMAL}`
				StrCpy $muiex.InstallType $0
				; �A���C���X�g�[���������݂��K�v
				!ifdef MUIEX_SECID_WRITEUNINSTALLER
					!insertmacro SelectSection ${MUIEX_SECID_WRITEUNINSTALLER}
				!endif
			${Else}
				MessageBox MB_OK|MB_ICONSTOP "���݂̃C���X�g�[���^�C�v�����m�̏�Ԃł��B"
				Abort "���݂̃C���X�g�[���^�C�v�����m�̏�Ԃł��B"
			${EndIf}

			${MUIEX_ChangeInstallLocation}
			${MUIEX_FixSaveLocation}
			${MUIEX_DefaultShortcutItems}

			; AppData �t�H���_�����p�\���ǂ������ׂ�B
			${If} $APPDATA != ""
				${MUIEX_AvailableAppDataFolderForSave}
			${Else}
				${MUIEX_NotAvailableAppDataFolderForSave}
			${EndIf}

			; InstallFolder �����p�\���ǂ������ׂ�B
			; ����͒P���� Vista �ȏ�ł���Η��p�s�Ƃ���B
			${If} ${AtMostWinXP}
				${MUIEX_AvailableInstallFolderForSave}
			${Else}
				${MUIEX_NotAvailableInstallFolderForSave}
			${EndIf}

			${MUIEX_SetSaveLocation} ""

			${MUIEX_SetSaveLocationPath} ""
			${MUIEX_SetCurrentSaveLocationPath} ""

			Pop $1
			Pop $0

		FunctionEnd
	!endif
!macroend


;---
!macro MUIEX_PAGE_FUNCTION_CUSTOM TYPE
	!ifdef MUIEX_PAGE_CUSTOMFUNCTION_${TYPE}
		Call "${MUIEX_PAGE_CUSTOMFUNCTION_${TYPE}}"
		!undef MUIEX_PAGE_CUSTOMFUNCTION_${TYPE}
	!endif
!macroend


;---
; �ǎ��p�C���^�[�t�F�[�X
; ������A�������݂��ł��܂��� MUIEX �̎d�l��ł͓ǎ��p�ł��B
; �����ɂ킽���ď������݂��\���ǂ����͕ۏ؂���܂���B
!define MUIEX_IsChangeInstallLocation			`$muiex.IsChangeInstallLocation`
!define MUIEX_IsChangeSaveLocation				`$muiex.IsChangeSaveLocation`
!define MUIEX_IsConfigureShortcutItems			`$muiex.IsConfigureShortcutItems`
!define MUIEX_IsAvailableAppDataFolderForSave	`$muiex.IsAvailableAppDataFolderForSave`
!define MUIEX_IsAvailableInstallFolderForSave	`$muiex.IsAvailableInstallFolderForSave`
!define MUIEX_SaveLocation						`$muiex.SaveLocation`
!define MUIEX_SaveLocationPath					`$muiex.SaveLocationPath`
!define MUIEX_InstallType						`$muiex.Installtype`
!define MUIEX_CurrentSaveLocation				`$muiex.CurrentSaveLocation`
!define MUIEX_CurrentSaveLocationPath			`$muiex.CurrentSaveLocationPath`

;---
; �e��l�ύX�p�C���^�[�t�F�[�X

;---
; ${MUIEX_ChangeInstallLocation}
; �C���X�g�[�����ύX����B
;
; ${MUIEX_FixInstallLocation}
; �C���X�g�[�����ύX���Ȃ��B
!macro MUIEX_ChangeInstallLocationCaller
	Call MUIEX_ChangeInstallLocation
!macroend

!macro MUIEX_ChangeInstallLocation
	!ifndef MUIEX_ChangeInstallLocation
		!define MUIEX_ChangeInstallLocation	`!insertmacro MUIEX_ChangeInstallLocationCaller`

		Function MUIEX_ChangeInstallLocation
			StrCpy $muiex.IsChangeInstallLocation 1
		FunctionEnd
	!endif
!macroend

;---
!macro MUIEX_FixInstallLocationCaller
	Call MUIEX_FixInstallLocation
!macroend

!macro MUIEX_FixInstallLocation
	!ifndef MUIEX_FixInstallLocation
		!define MUIEX_FixInstallLocation	`!insertmacro MUIEX_FixInstallLocationCaller`

		Function MUIEX_FixInstallLocation
			StrCpy $muiex.IsChangeInstallLocation 0
		FunctionEnd
	!endif
!macroend


;---
; ${MUIEX_ChangeSaveLocation}
; �Z�[�u�f�[�^�ۑ����ύX����B
;
; ${MUIEX_FixSaveLocation}
; �Z�[�u�f�[�^�ۑ����ύX���Ȃ��B
!macro MUIEX_ChangeSaveLocationCaller
	Call MUIEX_ChangeSaveLocation
!macroend

!macro MUIEX_ChangeSaveLocation
	!ifndef MUIEX_ChangeSaveLocation
		!define MUIEX_ChangeSaveLocation	`!insertmacro MUIEX_ChangeSaveLocationCaller`

		Function MUIEX_ChangeSaveLocation
			StrCpy $muiex.IsChangeSaveLocation 1
		FunctionEnd
	!endif
!macroend

;---
!macro MUIEX_FixSaveLocationCaller
	Call MUIEX_FixSaveLocation
!macroend

!macro MUIEX_FixSaveLocation
	!ifndef MUIEX_FixSaveLocation
		!define MUIEX_FixSaveLocation	`!insertmacro MUIEX_FixSaveLocationCaller`

		Function MUIEX_FixSaveLocation
			StrCpy $muiex.IsChangeSaveLocation 0
		FunctionEnd
	!endif
!macroend


;---
; ${MUIEX_ConfigureShortcutItems}
; �V���[�g�J�b�g�֘A�̃R���t�B�O���s���B
;
; ${MUIEX_DefaultShortcutItems}
; �V���[�g�J�b�g�֘A�̃R���t�B�O���s��Ȃ��B
!macro MUIEX_ConfigureShortcutItemsCaller
	Call MUIEX_ConfigureShortcutItems
!macroend

!macro MUIEX_ConfigureShortcutItems
	!ifndef MUIEX_ConfigureShortcutItems
		!define MUIEX_ConfigureShortcutItems	`!insertmacro MUIEX_ConfigureShortcutItemsCaller`

		Function MUIEX_ConfigureShortcutItems
			StrCpy $muiex.IsConfigureShortcutItems 1
		FunctionEnd
	!endif
!macroend

;---
!macro MUIEX_DefaultShortcutItemsCaller
	Call MUIEX_DefaultShortcutItems
!macroend

!macro MUIEX_DefaultShortcutItems
	!ifndef MUIEX_DefaultShortcutItems
		!define MUIEX_DefaultShortcutItems	`!insertmacro MUIEX_DefaultShortcutItemsCaller`

		Function MUIEX_DefaultShortcutItems
			StrCpy $muiex.IsConfigureShortcutItems 0
		FunctionEnd
	!endif
!macroend


;---
; ${MUIEX_AvailableAppDataFolderForSave}
; APPDATA �t�H���_�����p�ł�����B
; ${MUIEX_NotAvailableAppDataFolderForSave}
; APPDATA �t�H���_�����p�ł��Ȃ����B
!macro MUIEX_AvailableAppDataFolderForSaveCaller
	Call MUIEX_AvailableAppDataFolderForSave
!macroend

!macro MUIEX_AvailableAppDataFolderForSave
	!ifndef MUIEX_AvailableAppDataFolderForSave
		!define MUIEX_AvailableAppDataFolderForSave	`!insertmacro MUIEX_AvailableAppDataFolderForSaveCaller`

		Function MUIEX_AvailableAppDataFolderForSave
			StrCpy $muiex.IsAvailableAppDataFolderForSave 1
		FunctionEnd
	!endif
!macroend

;---
!macro MUIEX_NotAvailableAppDataFolderForSaveCaller
	Call MUIEX_NotAvailableAppDataFolderForSave
!macroend

!macro MUIEX_NotAvailableAppDataFolderForSave
	!ifndef MUIEX_NotAvailableAppDataFolderForSave
		!define MUIEX_NotAvailableAppDataFolderForSave	`!insertmacro MUIEX_NotAvailableAppDataFolderForSaveCaller`

		Function MUIEX_NotAvailableAppDataFolderForSave
			StrCpy $muiex.IsAvailableAppDataFolderForSave 0
		FunctionEnd
	!endif
!macroend


;---
; ${MUIEX_AvailableInstallFolderForSave}
; �C���X�g�[���悪���p�ł�����B
; ${MUIEX_NotAvailableInstallFolderForSave}
; �C���X�g�[���悪���p�ł��Ȃ����B
!macro MUIEX_AvailableInstallFolderForSaveCaller
	Call MUIEX_AvailableInstallFolderForSave
!macroend

!macro MUIEX_AvailableInstallFolderForSave
	!ifndef MUIEX_AvailableInstallFolderForSave
		!define MUIEX_AvailableInstallFolderForSave	`!insertmacro MUIEX_AvailableInstallFolderForSaveCaller`

		Function MUIEX_AvailableInstallFolderForSave
			StrCpy $muiex.IsAvailableInstallFolderForSave 1
		FunctionEnd
	!endif
!macroend

;---
!macro MUIEX_NotAvailableInstallFolderForSaveCaller
	Call MUIEX_NotAvailableInstallFolderForSave
!macroend

!macro MUIEX_NotAvailableInstallFolderForSave
	!ifndef MUIEX_NotAvailableInstallFolderForSave
		!define MUIEX_NotAvailableInstallFolderForSave	`!insertmacro MUIEX_NotAvailableInstallFolderForSaveCaller`

		Function MUIEX_NotAvailableInstallFolderForSave
			StrCpy $muiex.IsAvailableInstallFolderForSave 0
		FunctionEnd
	!endif
!macroend


;---
; ${MUIEX_SetSaveLocation} _LOCATION
; �Z�[�u�f�[�^�ۑ��ꏊ��ύX����B
!macro MUIEX_SetSaveLocationCaller _LOCATION
	Push `${_LOCATION}`
	Call MUIEX_SetSaveLocation
!macroend

!macro MUIEX_SetSaveLocation
	!ifndef MUIEX_SetSaveLocation
		!define MUIEX_SetSaveLocation	`!insertmacro MUIEX_SetSaveLocationCaller`

		Function MUIEX_SetSaveLocation
			Pop $muiex.SaveLocation
		FunctionEnd
	!endif
!macroend

;---
; ${MUIEX_SetSaveLocationPath} PATH
; MUIEX_PAGE_SAVELOCATION �ɂ���Đ����ȃp�X���Z�b�g���邽�߂Ɏg����B
!macro MUIEX_SetSaveLocationPathCaller _PATH
	Push `${_PATH}`
	Call MUIEX_SetSaveLocationPath
!macroend

!macro MUIEX_SetSaveLocationPath
	!ifndef MUIEX_SetSaveLocationPath
		!define MUIEX_SetSaveLocationPath	`!insertmacro MUIEX_SetSaveLocationPathCaller`

		Function MUIEX_SetSaveLocationPath
			Pop $muiex.SaveLocationPath
		FunctionEnd
	!endif
!macroend

;---
; ${MUIEX_SetCurrentSaveLocationPath} PATH
; MUIEX_PAGE_SAVELOCATION �ɂ���Đ����ȃp�X���Z�b�g���邽�߂Ɏg����B
!macro MUIEX_SetCurrentSaveLocationPathCaller _PATH
	Push `${_PATH}`
	Call MUIEX_SetCurrentSaveLocationPath
!macroend

!macro MUIEX_SetCurrentSaveLocationPath
	!ifndef MUIEX_SetCurrentSaveLocationPath
		!define MUIEX_SetCurrentSaveLocationPath	`!insertmacro MUIEX_SetCurrentSaveLocationPathCaller`

		Function MUIEX_SetCurrentSaveLocationPath
			Pop $muiex.CurrentSaveLocationPath
		FunctionEnd
	!endif
!macroend


!endif


