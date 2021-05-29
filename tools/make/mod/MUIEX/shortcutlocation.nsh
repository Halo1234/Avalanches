;/**
; * $Revision: 148 $
; *
; * HOWTO:
; * �y�[�W��}���������ꏊ�� !insertmacro MUIEX_PAGE_SHORTCUTLOCATION ��}�����Ă��������B
; * 
; * ���̃y�[�W�őI���ł���I�v�V�����͈ȉ��̒ʂ�ł��B
; *
; * �E�X�^�[�g���j���[
; *   MUIEX_SECID_CREATESTARTMENU ����`����Ă���Ε\������܂��B
; *   �X�^�[�g���j���[���쐬����Z�N�V������ ID ���w�肵�Ă��������B
; *   ���[�U�[���쐬���Ȃ���I�������ꍇ�w�肳�ꂽ�Z�N�V�����͌Ăяo����܂���B
; *
; * �E�A���C���X�g�[���V���[�g�J�b�g
; *   MUIEX_SECID_CREATEUNINSTALLSHORTCUTINSTARTMENU ����`����Ă���Ε\������܂��B
; *   ��MUIEX_SECID_CREATESTARTMENU ����`����Ă��Ȃ���΂Ȃ�܂���B
; *   �A���C���X�g�[���V���[�g�J�b�g���쐬����Z�N�V������ ID ���w�肵�Ă��������B
; *   ���[�U�[���쐬���Ȃ���I�������ꍇ�w�肳�ꂽ�Z�N�V�����͌Ăяo����܂���B
; *
; * �E�f�X�N�g�b�v�V���[�g�J�b�g
; *   MUIEX_SECID_CREATEDESKTOPSHORTCUT ����`����Ă���Ε\������܂��B
; *   �f�X�N�g�b�v�ɃV���[�g�J�b�g���쐬����Z�N�V������ ID ���w�肵�Ă��������B
; *   ���[�U�[���쐬���Ȃ���I�������ꍇ�w�肳�ꂽ�Z�N�V�����͌Ăяo����܂���B
; *
; * FIXME:
; * ���݂̂Ƃ���I�v�V�����������`����Ȃ������ꍇ
; * �I���ł�����̂��������݂��Ȃ��y�[�W���\������Ă��܂��܂��B
; *
; * NOTE:
; * ${MUIEX_SHORTCUTLOCATION_GetReport} �ł��̃y�[�W�őI�����ꂽ���e�ɂ���
; * �l�Ԃ��ǂ߂�`�Ń��|�[�g���擾���鎖���ł��܂��B
; * ���̊֐��}�N�����g���ɂ͎��O�� !insertmacro ${MUIEX_SHORTCUTLOCATION_GetReport} ��}������K�v������܂��B
; * �������AMUIEX_PAGE_CONFIRM ���g���ꍇ�͂������g���K�v�͂Ȃ��ł��傤�B
; *
; * NOTE:
; * MUIEX_PAGE_SHORTCUTLOCATION �� !insertmacro ����O�ɒ�`��ǉ����鎖��
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
; �C���^�[�t�F�[�X
!macro MUIEX_SHORTCUTLOCATION_INTERFACE
	!ifndef MUIEX_SHORTCUTLOCATION_INTERFACE
		!define MUIEX_SHORTCUTLOCATION_INTERFACE

		Var muiex.sh.ShortcutLocationPage
		Var muiex.sh.InfoText
		Var muiex.sh.CreateStartMenuCheckBox
		Var muiex.sh.CreateUninstallShortcutCheckBox
		Var muiex.sh.CreateDesktopShortcutCheckBox

	!endif

	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_HEADER_TEXT		"�V���[�g�J�b�g�쐬"
	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_HEADER_SUB_TEXT	"�K�v�ȃV���[�g�J�b�g��I�����鎖���ł��܂��B"
	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_INFO				\
		"�X�^�[�g���j���[��o�^����ƃT�|�[�g�c�[���ւ̃V���[�g�J�b�g�������I�ɓo�^����܂��B$\n�ʏ�͂����o�^���鎖�������߂��܂��B$\n�A���C���X�g�[���ւ̃V���[�g�J�b�g���쐬���Ȃ��ꍇ�u�R���g���[���p�l���v�́u�A�v���P�[�V�����̒ǉ��ƍ폜�v�c�[������A���C���X�g�[�����鎖���ł��܂��B"

	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_CREATESTARTMENU			"�X�^�[�g���j���[�ɓo�^����B�i�����j"
	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_CREATEUNINSTALLSHORTCUT	"�X�^�[�g���j���[�ɃA���C���X�g�[���ւ̃V���[�g�J�b�g���쐬����B"
	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_CREATEDESKTOPSHORTCUT	"�f�X�N�g�b�v�ɃV���[�g�J�b�g���쐬����B"

	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_CREATESTARTMENU_ENABLED			1
	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_CREATEUNINSTALLSHORTCUT_ENABLED	1
	!insertmacro MUI_DEFAULT MUIEX_SHORTCUTLOCATION_CREATEDESKTOPSHORTCUT_ENABLED	1

	!insertmacro MUIEX_SHORTCUTLOCATION_SyncRadioButton

!macroend

;---
; �錾
!macro MUIEX_PAGEDECLARATION_SHORTCUTLOCATION
	!insertmacro MUIEX_SHORTCUTLOCATION_INTERFACE

	PageEx custom
		PageCallbacks ShortcutLocationEnter_${MUI_UNIQUEID} ShortcutLocationLeave_${MUI_UNIQUEID}
	PageExEnd

	!insertmacro MUIEX_FUNCTION_SHORTCUTLOCATION ShortcutLocationEnter_${MUI_UNIQUEID} ShortcutLocationLeave_${MUI_UNIQUEID}
!macroend

;---
; �R�[���o�b�N�֐�
!macro MUIEX_FUNCTION_SHORTCUTLOCATION ENTER LEAVE

	Function "${ENTER}"

		; ���[�j���O�΍�
		StrCpy $muiex.sh.CreateStartMenuCheckBox 0
		StrCpy $muiex.sh.CreateUninstallShortcutCheckBox 0
		StrCpy $muiex.sh.CreateDesktopShortcutCheckBox 0

		; �V���[�g�J�b�g�ۑ���̕ύX���v������Ă��Ȃ���΂����߂�
		${If} ${MUIEX_IsConfigureShortcutItems} == 0
			Return
		${EndIf}

		Push $0

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM ENTER

		!insertmacro MUI_HEADER_TEXT_PAGE ${MUIEX_SHORTCUTLOCATION_HEADER_TEXT} ${MUIEX_SHORTCUTLOCATION_HEADER_SUB_TEXT}

		; �_�C�A���O�쐬
		nsDialogs::Create /NOUNLOAD 1018
		Pop $muiex.sh.ShortcutLocationPage

		; ���x���e�L�X�g
		${NSD_CreateLabel} 0 0 100% 35u ${MUIEX_SHORTCUTLOCATION_INFO}
		Pop $muiex.sh.InfoText

		; �X�^�[�g���j���[�̓o�^
		!ifdef MUIEX_SECID_CREATESTARTMENU

			${NSD_CreateCheckBox} 10u 65u 100% 12u ${MUIEX_SHORTCUTLOCATION_CREATESTARTMENU}
			Pop $muiex.sh.CreateStartMenuCheckBox

			EnableWindow $muiex.sh.CreateStartMenuCheckBox ${MUIEX_SHORTCUTLOCATION_CREATESTARTMENU_ENABLED}
			GetFunctionAddress $0 OnCreateStartMenuClick
			nsDialogs::OnClick /NOUNLOAD $muiex.sh.CreateStartMenuCheckBox $0
			${MUIEX_SHORTCUTLOCATION_SyncRadioButton} ${MUIEX_SECID_CREATESTARTMENU} $muiex.sh.CreateStartMenuCheckBox

			; �A���C���X�g�[���ւ̃V���[�g�J�b�g���X�^�[�g���j���[�ɍ쐬����
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

		; �f�X�N�g�b�v�ɃV���[�g�J�b�g���쐬
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
	; �C�x���g�n���h���[
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
; ���|�[�g�� VAR �ɕԂ��B
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
					StrCpy $0 "$0�X�^�[�g���j���[�F$\r$\n    �쐬����B$\r$\n$\r$\n"
					Goto startmenu_done

				startmenu_notselected:
					StrCpy $0 "$0�X�^�[�g���j���[�F$\r$\n    �쐬���Ȃ��B$\r$\n$\r$\n"
					Goto startmenu_done

				startmenu_done:

				!ifdef MUIEX_SECID_CREATEUNINSTALLSHORTCUTINSTARTMENU

					!insertmacro SectionFlagIsSet ${MUIEX_SECID_CREATEUNINSTALLSHORTCUTINSTARTMENU} ${SF_SELECTED} \
						uninstall_selected uninstall_notselected

					uninstall_selected:
						StrCpy $0 "$0�A���C���X�g�[���ւ̃V���[�g�J�b�g�F$\r$\n    �쐬����B$\r$\n$\r$\n"
						Goto uninstall_done

					uninstall_notselected:
						StrCpy $0 "$0�A���C���X�g�[���ւ̃V���[�g�J�b�g�F$\r$\n    �쐬���Ȃ��B$\r$\n$\r$\n"
						Goto uninstall_done

					uninstall_done:

				!endif

			!endif

			!ifdef MUIEX_SECID_CREATEDESKTOPSHORTCUT

				!insertmacro SectionFlagIsSet ${MUIEX_SECID_CREATEDESKTOPSHORTCUT} ${SF_SELECTED} desktop_selected desktop_notselected

				desktop_selected:
					StrCpy $0 "$0�f�X�N�g�b�v�V���[�g�J�b�g�F$\r$\n    �쐬����B$\r$\n$\r$\n"
					Goto desktop_done

				desktop_notselected:
					StrCpy $0 "$0�f�X�N�g�b�v�V���[�g�J�b�g�F$\r$\n    �쐬���Ȃ��B$\r$\n$\r$\n"
					Goto desktop_done

				desktop_done:

			!endif

			Exch $0

		FunctionEnd
	!endif
!macroend


;---
; �����p���[�e�B���e�B

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


