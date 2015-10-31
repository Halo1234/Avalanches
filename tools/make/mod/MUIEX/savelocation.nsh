;/**
; * $Revision: 144 $
; *
; * HOWTO:
; * �y�[�W��}���������ꏊ�� !insertmacro MUIEX_PAGE_SAVELOCATION ��}�����Ă��������B
; *
; * NOTE:
; * ${MUIEX_SAVELOCATION_GetReport} �ł��̃y�[�W�őI�����ꂽ���e�ɂ���
; * �l�Ԃ��ǂ߂�`�Ń��|�[�g���擾���鎖���ł��܂��B
; * ���̊֐��}�N�����g���ɂ͎��O�� !insertmacro ${MUIEX_SAVELOCATION_GetReport} ��}������K�v������܂��B
; * �������AMUIEX_PAGE_CONFIRM �� MUIEX_PAGE_SETUPMENU ���g���ꍇ�͎����I�� !insertmacro ����܂��B
; *
; * NOTE:
; * MUIEX_PAGE_SAVELOCATION �� !insertmacro ����O�ɒ�`��ǉ����鎖��
; * �e���ڂ̕\����ԂƑI�����ꂽ�p�X�̃T�t�B�b�N�X��ύX���鎖���ł��܂��B
; * ������`���Ȃ���΃f�t�H���g�l���g���܂��B
; *
; * �\����Ԃ��`�����`���ƃf�t�H���g�l�ł��B
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
; * ���P�D���� MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SHOW ���ǂ̂悤�ɒ�`���Ă���ɕ\������܂��B
; * ���Q�D���� MUIEX_SAVELOCATION_OPTIONALFOLDER_SHOW ���ǂ̂悤�ɒ�`���Ă���ɔ�\���ɂȂ�܂��B
; * ���@�@���̃I�v�V�����͖������ł��B
; *
; * �T�t�B�b�N�X�̒�`���ƃf�t�H���g�l�ł��B
; * +--------------------------------+----+
; * | MUIEX_SAVELOCATION_PATH_SUFFIX | "" |
; * +--------------------------------+----+
; *
; * ����ɌʂɃT�t�B�b�N�X���㏑�����鎖���ł��܂��B
; * �Ⴆ�΁A�C���X�g�[����̂݃T�t�B�b�N�X��ύX����ɂ͈ȉ��̂悤�ɂ��܂��B
; *
; * EXAMPLE:
; * !define MUIEX_SAVELOCATION_PATH_SUFFIX          "vender\product"
; * !define MUIEX_SAVELOCATION_INSTALLFOLDER_SUFFIX "product\save"
; * !insertmacro MUIEX_PAGE_SAVELOCATION
; *
; * �e���ڕʂ̒�`���ł��B
; * ��`����Ă��Ȃ���� MUIEX_SAVELOCATION_PATH_SUFFIX �����p����܂��B
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
; �C���^�[�t�F�[�X
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

	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_HEADER_TEXT		"�Z�[�u�f�[�^�ۑ���̑I��"
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_HEADER_SUB_TEXT	"�������̌�₩��Z�[�u�f�[�^�ۑ����I���ł��܂��B"
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_INFO			\
		"�Z�[�u�f�[�^�̕ۑ����I��ł��������B$\r$\n���ɃZ�[�u�f�[�^�����݂���ꍇ�A�Z�[�u�f�[�^�͐V�����ۑ���Ɉړ�����܂��B"

	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_DOCUMENTSFOLDER			"�}�C�h�L�������g�ɕۑ�����B�i�����j"
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER	"AppData�t�H���_�ɕۑ�����B"
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_INSTALLFOLDER			"�C���X�g�[����ɕۑ�����B"
	!insertmacro MUI_DEFAULT MUIEX_SAVELOCATION_OPTIONALFOLDER			"�C�ӂ̃t�H���_�ɕۑ�����B"

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

	; ��ɕ\��
	!ifdef MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SHOW
		!undef MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SHOW
	!endif
	!define MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SHOW 1

	; ���p�ł��Ȃ��I�v�V����
	!ifdef MUIEX_SAVELOCATION_OPTIONALFOLDER_SHOW
		!undef MUIEX_SAVELOCATION_OPTIONALFOLDER_SHOW
	!endif
	!define MUIEX_SAVELOCATION_OPTIONALFOLDER_SHOW	0

	!insertmacro MUIEX_SAVELOCATION_InitializeVariables
	!insertmacro MUIEX_SAVELOCATION_GetSaveLocationPath
	!insertmacro MUIEX_SAVELOCATION_GetCurrentSaveLocationPath

!macroend

;---
; �錾
!macro MUIEX_PAGEDECLARATION_SAVELOCATION
	!insertmacro MUIEX_SAVELOCATION_INTERFACE

	PageEx custom
		PageCallbacks SaveLocationEnter_${MUI_UNIQUEID} SaveLocationLeave_${MUI_UNIQUEID}
	PageExEnd

	!insertmacro MUIEX_FUNCTION_SAVELOCATION SaveLocationEnter_${MUI_UNIQUEID} SaveLocationLeave_${MUI_UNIQUEID}
!macroend

;---
; �R�[���o�b�N�֐�
!macro MUIEX_FUNCTION_SAVELOCATION ENTER LEAVE

	; �`�F�b�N���
	; 1 : DocumentsFolder
	; 2 : ApplicationDataFolder
	; 3 : InstallFolder
	; 4 : OptionalFolder
	Var muiex.sl.SaveLocationNumber

	Function "${ENTER}"

		; ���[�j���O�΍�
		StrCpy $muiex.sl.DocumentsFolderRadioButton 0
		StrCpy $muiex.sl.ApplicationDataFolderRadioButton 0
		StrCpy $muiex.sl.InstallFolderRadioButton 0
		StrCpy $muiex.sl.OptionalFolderRadioButton 0

		Push $0

		; enable ���
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
			; �Z�[�u�ꏊ�����܂��Ă��Ȃ��̂Ńf�t�H���g�Ƃ���
			StrCpy $muiex.sl.SaveLocationNumber 1
			${MUIEX_SetSaveLocation} "${MUIEX_SAVELOCATION_DOCUMENTSFOLDER_VALUE}"
		${Else}
			; �C�Ӄt�H���_
			StrCpy $muiex.sl.SaveLocationNumber 4
		${EndIf}

		${MUIEX_SAVELOCATION_GetSaveLocationPath} $0
		${MUIEX_SetSaveLocationPath} $0

		; NOTE:
		; ���̏ꍇ�A�O�̃y�[�W�ɖ߂��ăC���X�g�[�����ύX���Ă���\��������̂ōX�V����B
		${If} $muiex.sl.SaveLocationNumber == 3
			${MUIEX_SetSaveLocation} "${MUIEX_SAVELOCATION_INSTALLFOLDER_VALUE}"
		${EndIf}

		; �Z�[�u�f�[�^�ۑ���̕ύX���v������Ă��Ȃ���΂����߂�
		${If} ${MUIEX_IsChangeSaveLocation} == 0
			Return
		${EndIf}
		; �Z�[�u�f�[�^�����ɂ��邪�Ĕz�u�Z�N�V��������`����Ă��Ȃ��ꍇ�͂����߂�
		!ifndef MUIEX_SECID_RELOCATIONSAVEDATA

			${If} ${MUIEX_CurrentSaveLocation} != ""
				Return
			${EndIf}

		!endif

		; ���݂̃Z�[�u�ꏊ�p�X�̏�����
		${MUIEX_SAVELOCATION_GetCurrentSaveLocationPath} $0
		${MUIEX_SetCurrentSaveLocationPath} $0

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM ENTER

		!insertmacro MUI_HEADER_TEXT_PAGE ${MUIEX_SAVELOCATION_HEADER_TEXT} ${MUIEX_SAVELOCATION_HEADER_SUB_TEXT}

		; �_�C�A���O�쐬
		nsDialogs::Create /NOUNLOAD 1018
		Pop $muiex.sl.SaveLocationPage

		; ���x���e�L�X�g
		${NSD_CreateLabel} 0 0 100% 30u ${MUIEX_SAVELOCATION_INFO}
		Pop $muiex.sl.InfoText

		; �p�X�\���p�G�f�B�b�g
		${MUIEX_SAVELOCATION_GetSaveLocationPath} $0
		nsDialogs::CreateControl /NOUNLOAD "EDIT" ${ES_READONLY}|${WS_VISIBLE}|${WS_CHILD} ${WS_EX_CLIENTEDGE} 0 55 100% 12u $0
		Pop $muiex.sl.SaveLocationPathEditBox

		; �}�C�h�L�������g�ɕۑ��i�f�t�H���g�`�F�b�N�j
		!if ${MUIEX_SAVELOCATION_DOCUMENTSFOLDER_SHOW} == 1

			${NSD_CreateRadioButton} 10 65u 100% 12u ${MUIEX_SAVELOCATION_DOCUMENTSFOLDER}
			Pop $muiex.sl.DocumentsFolderRadioButton

			EnableWindow $muiex.sl.DocumentsFolderRadioButton $muiex.sl.DocumentsFolderEnabled
			GetFunctionAddress $0 onDocumentsFolderClick
			nsDialogs::OnClick /NOUNLOAD $muiex.sl.DocumentsFolderRadioButton $0
			${If} $muiex.sl.SaveLocationNumber == 1
				${NSD_Check} $muiex.sl.DocumentsFolderRadioButton
			${EndIf}

		!endif

		; AppData �t�H���_�ɕۑ�
		!if ${MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER_SHOW} == 1

			${NSD_CreateRadioButton} 10 80u 100% 12u ${MUIEX_SAVELOCATION_APPLICATIONDATAFOLDER}
			Pop $muiex.sl.ApplicationDataFolderRadioButton

			EnableWindow $muiex.sl.ApplicationDataFolderRadioButton $muiex.sl.ApplicationDataFolderEnabled
			GetFunctionAddress $0 onApplicationDataFolderClick
			nsDialogs::OnClick /NOUNLOAD $muiex.sl.ApplicationDataFolderRadioButton $0
			${If} $muiex.sl.SaveLocationNumber == 2
				${NSD_Check} $muiex.sl.ApplicationDataFolderRadioButton
			${EndIf}

		!endif

		; �C���X�g�[����ɕۑ�
		!if ${MUIEX_SAVELOCATION_INSTALLFOLDER_SHOW} == 1

			${NSD_CreateRadioButton} 10 95u 100% 12u ${MUIEX_SAVELOCATION_INSTALLFOLDER}
			Pop $muiex.sl.InstallFolderRadioButton

			EnableWindow $muiex.sl.InstallFolderRadioButton $muiex.sl.InstallFolderEnabled
			GetFunctionAddress $0 onInstallFolderClick
			nsDialogs::OnClick /NOUNLOAD $muiex.sl.InstallFolderRadioButton $0
			${If} $muiex.sl.SaveLocationNumber == 3
				${NSD_Check} $muiex.sl.InstallFolderRadioButton
			${EndIf}

		!endif

		; �C�ӂ̃t�H���_�ɕۑ�
		!if ${MUIEX_SAVELOCATION_OPTIONALFOLDER_SHOW} == 1

			${NSD_CreateRadioButton} 10 110u 100% 12u ${MUIEX_SAVELOCATION_OPTIONALFOLDER}
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

		; �Z�[�u�f�[�^�̍Ĕz�u�Z�N�V����������Ύ��s���邩�ǂ������肷��B
		!ifdef MUIEX_SECID_RELOCATIONSAVEDATA

			${If} ${MUIEX_CurrentSaveLocation} != ""
				${AndIf} ${MUIEX_CurrentSaveLocation} != ${MUIEX_SaveLocation}
				!insertmacro SelectSection ${MUIEX_SECID_RELOCATIONSAVEDATA}
			${Else}
				!insertmacro UnselectSection ${MUIEX_SECID_RELOCATIONSAVEDATA}
			${EndIf}

		!endif

		Push $0

		; �����ȃp�X�����肷��
		${MUIEX_SAVELOCATION_GetSaveLocationPath} $0
		${MUIEX_SetSaveLocationPath} $0

		Pop $0

	FunctionEnd

	;---
	; �C�x���g�n���h���[
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

			; �Ƃ肠�����A�ȑO�̃t�H���_���g��
			${MUIEX_SAVELOCATION_GetSaveLocationPath} $0
			${MUIEX_SetSaveLocation} "$0"

			; �u�Q�Ɓv�{�^���L����

		FunctionEnd

	!endif

!macroend


;---
; ${MUIEX_SAVELOCATION_GetReport} VAR
; ���|�[�g�� VAR �ɕԂ��B
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
			StrCpy $0 "�Z�[�u�f�[�^�ۑ���F$\r$\n    $1$\r$\n"

			${If} ${MUIEX_CurrentSaveLocation} != ""
				${AndIf} ${MUIEX_CurrentSaveLocation} != ${MUIEX_SaveLocation}

				${MUIEX_SAVELOCATION_GetCurrentSaveLocationPath} $1
				StrCpy $0 "$0    �Z�[�u�f�[�^���ړ����܂��B$\r$\n"
				StrCpy $0 "$0���Z�[�u�f�[�^�ۑ���F$\r$\n    $1$\r$\n"

			${EndIf}

			StrCpy $0 "$0$\r$\n"

			Pop $1
			Exch $0

		FunctionEnd
	!endif
!macroend


;---
; �����p���[�e�B���e�B

;---
; ${MUIEX_SAVELOCATION_InitializeVariables
!macro MUIEX_SAVELOCATION_InitializeVariablesCaller
	Call MUIEX_SAVELOCATION_InitializeVariables
!macroend

!macro MUIEX_SAVELOCATION_InitializeVariables
	!ifndef MUIEX_SAVELOCATION_InitializeVariables
		!define MUIEX_SAVELOCATION_InitializeVariables	`!insertmacro MUIEX_SAVELOCATION_InitializeVariablesCaller`

		Function MUIEX_SAVELOCATION_InitializeVariables

			; �������̕K�v���Ȃ���΂����ɖ߂�
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
				; �Z�[�u�ꏊ�����܂��Ă��Ȃ��̂Ńf�t�H���g�Ƃ���
				${MUIEX_SetSaveLocation} "${MUIEX_SAVELOCATION_DOCUMENTSFOLDER_VALUE}"
			${Else}
				; �C�Ӄt�H���_
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


