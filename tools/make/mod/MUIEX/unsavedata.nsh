;/**
; * $Revision: 148 $
; *
; * HOWTO:
; * �y�[�W��}���������ꏊ�� !insertmacro MUIEX_UNPAGE_SAVEDATA ��}�����Ă��������B
; *
; * ���̃y�[�W���g���ꍇ�̓Z�[�u�f�[�^�폜�p�̃Z�N�V�������`����K�v������܂��B
; * �Z�N�V������ ID �� MUIEX_UN_SECID_REMOVESAVEDATA �ƒ�`���Ă��������B
; * �Z�N�V������ ID ����`����Ȃ������ꍇ���̃y�[�W�͕\������܂���B
; *
; * NOTE:
; * ${un.MUIEX_SAVEDATA_GetReport} �ł��̃y�[�W�őI�����ꂽ���e�ɂ���
; * �l�Ԃ��ǂ߂�`�Ń��|�[�g���擾���鎖���ł��܂��B
; * ���̊֐��}�N�����g���ɂ͎��O�� !insertmacro ${un.MUIEX_SAVEDATA_GetReport} ��}������K�v������܂��B
; * �������AMUIEX_UNPAGE_CONFIRM ���g���ꍇ�͂������g���K�v�͂Ȃ��ł��傤�B
; *
; * NOTE:
; * MUIEX_UNPAGE_SAVEDATA �� !insertmacro ����O�ɒ�`��ǉ����鎖��
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
; �C���^�[�t�F�[�X
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

	!insertmacro MUI_DEFAULT MUIEX_UN_SAVEDATA_HEADER_TEXT		"�Z�[�u�f�[�^"
	!insertmacro MUI_DEFAULT MUIEX_UN_SAVEDATA_HEADER_SUB_TEXT	"�Z�[�u�f�[�^���폜���邩�A�c���Ă������I���ł��܂��B"
	!insertmacro MUI_DEFAULT MUIEX_UN_SAVEDATA_INFO				\
		"�Z�[�u�f�[�^�͌�Łu�A�v���P�[�V�����̒ǉ��ƍ폜�v����폜���鎖���\�ł��B$\n��x�폜�����Z�[�u�f�[�^�͌��ɂ͖߂�܂���B"

	!insertmacro MUI_DEFAULT MUIEX_UN_SAVEDATA_OPEN		"�Z�[�u�f�[�^�ۑ�����J��"
	!insertmacro MUI_DEFAULT MUIEX_UN_SAVEDATA_REMOVE	"�Z�[�u�f�[�^���폜����B"
	!insertmacro MUI_DEFAULT MUIEX_UN_SAVEDATA_KEEP		"�Z�[�u�f�[�^���c���B"

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
; �錾
!macro MUIEX_UN_PAGEDECLARATION_SAVEDATA

	; �Z�[�u�f�[�^�폜�p�̃Z�N�V��������`����Ă��Ȃ���΃y�[�W��\�����Ȃ�
	!ifdef MUIEX_UN_SECID_REMOVESAVEDATA

		!insertmacro MUIEX_UN_SAVEDATA_INTERFACE

		PageEx un.custom
			PageCallbacks un.SaveDataEnter_${MUI_UNIQUEID} un.SaveDataLeave_${MUI_UNIQUEID}
		PageExEnd

		!insertmacro MUIEX_UN_FUNCTION_SAVEDATA un.SaveDataEnter_${MUI_UNIQUEID} un.SaveDataLeave_${MUI_UNIQUEID}

	!endif
!macroend

;---
; �R�[���o�b�N�֐�
!macro MUIEX_UN_FUNCTION_SAVEDATA ENTER LEAVE

	Function "${ENTER}"

		Push $0

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM ENTER

		!insertmacro MUI_HEADER_TEXT_PAGE ${MUIEX_UN_SAVEDATA_HEADER_TEXT} ${MUIEX_UN_SAVEDATA_HEADER_SUB_TEXT}

		; �_�C�A���O�쐬
		nsDialogs::Create /NOUNLOAD 1018
		Pop $muiex.un.sd.SaveDataPage

		; ���x���e�L�X�g
		${NSD_CreateLabel} 0 0 100% 30u ${MUIEX_UN_SAVEDATA_INFO}
		Pop $muiex.un.sd.InfoText

		; �����ȃZ�[�u�f�[�^�ۑ��ꏊ�̃p�X���Z�b�g����
		${un.MUIEX_SAVEDATA_GetSaveLocationPath} $0
		${un.MUIEX_SetCurrentSaveLocationPath} $0

		; �p�X�\���p�G�f�B�b�g
		nsDialogs::CreateControl /NOUNLOAD "EDIT" ${ES_READONLY}|${WS_VISIBLE}|${WS_CHILD} ${WS_EX_CLIENTEDGE} 0 55 100% 12u $0
		Pop $muiex.un.sd.SaveDataPathEditBox

		; �Z�[�u�f�[�^�ۑ�����J�������N
		${NSD_CreateLink} 0 55u 100% 12u ${MUIEX_UN_SAVEDATA_OPEN}
		Pop $muiex.un.sd.OpenLink
		GetFunctionAddress $0 un.onOpenClick
		nsDialogs::OnClick /NOUNLOAD $muiex.un.sd.OpenLink $0

		; �Z�[�u�f�[�^���폜����B
		${NSD_CreateRadioButton} 10u 80u 100% 12u ${MUIEX_UN_SAVEDATA_REMOVE}
		Pop $muiex.un.sd.RemoveRadioButton

		EnableWindow $muiex.un.sd.RemoveRadioButton ${MUIEX_UN_SAVEDATA_REMOVE_ENABLED}
		GetFunctionAddress $0 un.onRemoveClick
		nsDialogs::OnClick /NOUNLOAD $muiex.un.sd.RemoveRadioButton $0

		; �Z�[�u�f�[�^���c���B�i�f�t�H���g�`�F�b�N�j
		${NSD_CreateRadioButton} 10u 95u 100% 12u ${MUIEX_UN_SAVEDATA_KEEP}
		Pop $muiex.un.sd.KeepRadioButton

		EnableWindow $muiex.un.sd.KeepRadioButton ${MUIEX_UN_SAVEDATA_KEEP_ENABLED}
		GetFunctionAddress $0 un.onKeepClick
		nsDialogs::OnClick /NOUNLOAD $muiex.un.sd.KeepRadioButton $0

		; �`�F�b�N��Ԑݒ�
		${un.MUIEX_SAVEDATA_SyncRadioButton} $muiex.un.sd.RemoveRadioButton $muiex.un.sd.KeepRadioButton

		Pop $0

		nsDialogs::Show

	FunctionEnd

	Function "${LEAVE}"

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM LEAVE

	FunctionEnd

	;---
	; �C�x���g�n���h���[

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
; ���|�[�g�� VAR �ɕԂ��B
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
			StrCpy $0 "�Z�[�u�f�[�^�ۑ���F$\r$\n    $0$\r$\n"

			!insertmacro SectionFlagIsSet ${MUIEX_UN_SECID_REMOVESAVEDATA} ${SF_SELECTED} SyncRadioButton_selected SyncRadioButton_notselected

			SyncRadioButton_selected:
				StrCpy $0 "$0    �Z�[�u�f�[�^���폜���܂��B$\r$\n"
				GoTo GetReport_done

			SyncRadioButton_notselected:
				StrCpy $0 "$0    �Z�[�u�f�[�^���c���܂��B$\r$\n"
				StrCpy $0 "$0    ��ō폜�������ꍇ�́u�A�v���P�[�V�����̒ǉ��ƍ폜�v����폜���鎖���ł��܂��B$\r$\n"
				GoTo GetReport_done

			GetReport_done:

			StrCpy $0 "$0$\r$\n"

			Exch $0

		FunctionEnd
	!endif
!macroend


;---
; �����p���[�e�B���e�B

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


