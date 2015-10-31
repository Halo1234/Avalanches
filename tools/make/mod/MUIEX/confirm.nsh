;/**
; * $Revision: 144 $
; *
; * HOWTO:
; * �y�[�W��}���������ꏊ�� !insertmacro MUIEX_PAGE_CONFIRM ��}�����Ă��������B
;**/

;---
!macro MUIEX_PAGE_CONFIRM
	!insertmacro MUI_PAGE_INIT
	!insertmacro MUIEX_PAGEDECLARATION_CONFIRM
!macroend

;---
; �C���^�[�t�F�[�X
!macro MUIEX_CONFIRM_INTERFACE
	!ifndef MUIEX_CONFIRM_INTERFACE
		!define MUIEX_CONFIRM_INTERFACE

		Var muiex.sc.ConfirmPage
		Var muiex.sc.InfoText
		Var muiex.sc.DetailsText
	!endif

	!insertmacro MUI_DEFAULT MUIEX_CONFIRM_HEADER_TEXT		"�Z�b�g�A�b�v���e�̊m�F"
	!insertmacro MUI_DEFAULT MUIEX_CONFIRM_HEADER_SUB_TEXT	"�Z�b�g�A�b�v���e�̊m�F�����ĉ������B"
	!insertmacro MUI_DEFAULT MUIEX_CONFIRM_INFO				"�Z�b�g�A�b�v�͈ȉ��̓��e�����s���܂��B"

	!insertmacro MUI_DEFAULT MUIEX_CONFIRM_INSTALLLOCATION		"�C���X�g�[����F"

	!ifdef MUIEX_PAGE_SAVELOCATION_USED
		!insertmacro MUIEX_SAVELOCATION_GetReport
	!endif

	!ifdef MUIEX_PAGE_SHORTCUTLOCATION_USED
		!insertmacro MUIEX_SHORTCUTLOCATION_GetReport
	!endif

!macroend

;---
; �錾
!macro MUIEX_PAGEDECLARATION_CONFIRM
	!insertmacro MUIEX_CONFIRM_INTERFACE

	PageEx custom
		PageCallbacks ConfirmEnter_${MUI_UNIQUEID} ConfirmLeave_${MUI_UNIQUEID}
	PageExEnd

	!insertmacro MUIEX_FUNCTION_CONFIRM ConfirmEnter_${MUI_UNIQUEID} ConfirmLeave_${MUI_UNIQUEID}
!macroend

;---
; �R�[���o�b�N�֐�
!macro MUIEX_FUNCTION_CONFIRM ENTER LEAVE

	Function "${ENTER}"

		Push $0
		Push $1

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM ENTER

		!insertmacro MUI_HEADER_TEXT_PAGE ${MUIEX_CONFIRM_HEADER_TEXT} ${MUIEX_CONFIRM_HEADER_SUB_TEXT}

		; �_�C�A���O�쐬
		nsDialogs::Create /NOUNLOAD 1018
		Pop $muiex.sc.ConfirmPage

		; ���x���e�L�X�g
		${NSD_CreateLabel} 0 0 100% 15u ${MUIEX_CONFIRM_INFO}
		Pop $muiex.sc.InfoText

		; ���s���e�e�L�X�g�̍쐬
		StrCpy $0 ""

		; �C���X�g�[����p�X
		StrCpy $0 "$0${MUIEX_CONFIRM_INSTALLLOCATION}$\r$\n    $INSTDIR$\r$\n$\r$\n"

		; �Z�[�u�f�[�^�ۑ���̃��|�[�g
		!ifdef MUIEX_SAVELOCATION_GetReport
			${MUIEX_SAVELOCATION_GetReport} $1
			StrCpy $0 "$0$1"
		!endif

		; �V���[�g�J�b�g�֘A�̃��|�[�g
		!ifdef MUIEX_SHORTCUTLOCATION_GetReport
			${MUIEX_SHORTCUTLOCATION_GetReport} $1
			StrCpy $0 "$0$1"
		!endif

		; ���e�\��
		nsDialogs::CreateControl /NOUNLOAD "EDIT" \
			${ES_MULTILINE}|${ES_READONLY}|${WS_VISIBLE}|${WS_CHILD}|${WS_VSCROLL} \
			${WS_EX_CLIENTEDGE} 0 20u 100% 120u $0
		Pop $muiex.sc.DetailsText

		Pop $0

		nsDialogs::Show

	FunctionEnd

	Function "${LEAVE}"

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM LEAVE

	FunctionEnd

!macroend


