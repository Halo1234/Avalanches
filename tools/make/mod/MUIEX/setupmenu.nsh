;/**
; * $Revision: 144 $
; *
; * HOWTO:
; * �y�[�W��}���������ꏊ�� !insertmacro MUIEX_PAGE_SETUPMENU ��}�����Ă��������B
; *
; * NOTE:
; * MUIEX_PAGE_SETUPMENU �� !insertmacro ����O�ɒ�`��ǉ����鎖��
; * �e�R���g���[���� enable ��Ԃ�ύX���鎖���ł��܂��B
; * ������`���Ȃ���΃f�t�H���g�l���g���܂��B
; *
; * �e��`�̖��O�ƃf�t�H���g�l�ł��B
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
; �C���^�[�t�F�[�X
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

	!insertmacro MUI_DEFAULT MUIEX_SETUPMENU_HEADER_TEXT		"�Z�b�g�A�b�v���j���["
	!insertmacro MUI_DEFAULT MUIEX_SETUPMENU_HEADER_SUB_TEXT	"�Z�b�g�A�b�v���ɂ������ύX�ł���ݒ肪����܂��B"
	!insertmacro MUI_DEFAULT MUIEX_SETUPMENU_INFO				\
		"�ύX���������ڂ�I��Ń`�F�b�N������Ă��������B$\n�`�F�b�N����ꂽ���ڂ͎��̃y�[�W�ȍ~�Őݒ��ύX���鎖���ł��܂��B"

	!insertmacro MUI_DEFAULT MUIEX_SETUPMENU_INSTALLLOCATION	"�C���X�g�[�����ύX����B"
	!insertmacro MUI_DEFAULT MUIEX_SETUPMENU_SAVEDATALOCATION	"�Z�[�u�f�[�^�̕ۑ��ꏊ��ύX����B"
	!insertmacro MUI_DEFAULT MUIEX_SETUPMENU_SHORTCUTLOCATION	"�V���[�g�J�b�g�̍쐬�ꏊ��ύX����B"

	; �e�R���g���[���� enable ���
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

	; �e�y�[�W�Ɉˑ�����
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
; �錾
!macro MUIEX_PAGEDECLARATION_SETUPMENU
	!insertmacro MUIEX_SETUPMENU_INTERFACE

	PageEx custom
		PageCallbacks SetupMenuEnter_${MUI_UNIQUEID} SetupMenuLeave_${MUI_UNIQUEID}
	PageExEnd

	!insertmacro MUIEX_FUNCTION_SETUPMENU SetupMenuEnter_${MUI_UNIQUEID} SetupMenuLeave_${MUI_UNIQUEID}
!macroend

;---
; �R�[���o�b�N�֐�
!macro MUIEX_FUNCTION_SETUPMENU ENTER LEAVE

	Function "${ENTER}"

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM ENTER

		!insertmacro MUI_HEADER_TEXT_PAGE ${MUIEX_SETUPMENU_HEADER_TEXT} ${MUIEX_SETUPMENU_HEADER_SUB_TEXT}

		; �_�C�A���O�쐬
		nsDialogs::Create /NOUNLOAD 1018
		Pop $muiex.sm.SetupMenuPage

		; ���x���e�L�X�g
		${NSD_CreateLabel} 0 0 100% 30u ${MUIEX_SETUPMENU_INFO}
		Pop $muiex.sm.InfoText

		; $0 �ޔ�
		Push $0

		; ���s���e�e�L�X�g�̍쐬
		StrCpy $0 ""

		; �C���X�g�[����p�X
		StrCpy $0 "$0�C���X�g�[����F$\r$\n    $INSTDIR$\r$\n$\r$\n"

		; �Z�[�u�f�[�^�ۑ���̃��|�[�g
		!ifdef MUIEX_SAVELOCATION_GetReport
			${MUIEX_SAVELOCATION_InitializeVariables}
			${MUIEX_SAVELOCATION_GetReport} $1
			StrCpy $0 "$0$1"
		!endif

		; �V���[�g�J�b�g�֘A�̃��|�[�g
		!ifdef MUIEX_SHORTCUTLOCATION_GetReport
			${MUIEX_SHORTCUTLOCATION_GetReport} $1
			StrCpy $0 "$0$1"
		!endif

		; ���݂̓��e�\��
		nsDialogs::CreateControl /NOUNLOAD "EDIT" \
			${ES_MULTILINE}|${ES_READONLY}|${WS_VISIBLE}|${WS_CHILD}|${WS_VSCROLL} \
			${WS_EX_CLIENTEDGE} 0 30u 100% 55u $0
		Pop $muiex.sm.DetailsText

		; �C���X�g�[�����ύX���邩�ǂ���
		${NSD_CreateCheckBox} 20u 95u 100% 12u ${MUIEX_SETUPMENU_INSTALLLOCATION}
		Pop $muiex.sm.InstallLocationCheckBox

		; ���ɃC���X�g�[������Ă���ꍇ�̓C���X�g�[����̕ύX�͂ł��Ȃ�
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

		; �Z�[�u�ꏊ��ύX���邩�ǂ���
		${NSD_CreateCheckBox} 20u 110u 100% 12u ${MUIEX_SETUPMENU_SAVEDATALOCATION}
		Pop $muiex.sm.SaveDataLocationCheckBox

		; ���ɃC���X�g�[������Ă���A���Z�[�u�f�[�^�̍Ĕz�u�Z�N�V���������݂��Ȃ��Ȃ�ΕύX�͂ł��Ȃ�
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

		; �V���[�g�J�b�g�̏ꏊ��ύX���邩�ǂ���
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
	; �C�x���g�n���h���[
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


