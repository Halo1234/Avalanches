;/**
; * $Revision: 148 $
; *
; * HOWTO:
; * �y�[�W��}���������ꏊ�� !insertmacro MUIEX_UNPAGE_CONFIRM ��}�����Ă��������B
;**/

;---
!macro MUIEX_UNPAGE_CONFIRM
	!insertmacro MUI_PAGE_INIT
	!insertmacro MUIEX_UN_PAGEDECLARATION_CONFIRM
!macroend

;---
; �C���^�[�t�F�[�X
!macro MUIEX_UN_CONFIRM_INTERFACE
	!ifndef MUIEX_UN_CONFIRM_INTERFACE
		!define MUIEX_UN_CONFIRM_INTERFACE

		Var muiex.un.sc.ConfirmPage
		Var muiex.un.sc.InfoText
		Var muiex.un.sc.DetailsText
	!endif

	!insertmacro MUI_DEFAULT MUIEX_UN_CONFIRM_HEADER_TEXT		"�Z�b�g�A�b�v���e�̊m�F"
	!insertmacro MUI_DEFAULT MUIEX_UN_CONFIRM_HEADER_SUB_TEXT	"�Z�b�g�A�b�v���e�̊m�F�����ĉ������B"
	!insertmacro MUI_DEFAULT MUIEX_UN_CONFIRM_INFO				"�Z�b�g�A�b�v�͈ȉ��̓��e�����s���܂��B"

	!insertmacro MUI_DEFAULT MUIEX_UN_CONFIRM_INSTALLLOCATION		"�C���X�g�[����F"

	!ifdef MUIEX_UNPAGE_SAVEDATA_USED
		!insertmacro un.MUIEX_SAVEDATA_GetReport
	!endif

!macroend

;---
; �錾
!macro MUIEX_UN_PAGEDECLARATION_CONFIRM
	!insertmacro MUIEX_UN_CONFIRM_INTERFACE

	PageEx un.custom
		PageCallbacks un.ConfirmEnter_${MUI_UNIQUEID} un.ConfirmLeave_${MUI_UNIQUEID}
	PageExEnd

	!insertmacro MUIEX_UN_FUNCTION_CONFIRM un.ConfirmEnter_${MUI_UNIQUEID} un.ConfirmLeave_${MUI_UNIQUEID}
!macroend

;---
; �R�[���o�b�N�֐�
!macro MUIEX_UN_FUNCTION_CONFIRM ENTER LEAVE

	Function "${ENTER}"

		Push $0
		Push $1

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM ENTER

		!insertmacro MUI_HEADER_TEXT_PAGE ${MUIEX_UN_CONFIRM_HEADER_TEXT} ${MUIEX_UN_CONFIRM_HEADER_SUB_TEXT}

		; �_�C�A���O�쐬
		nsDialogs::Create /NOUNLOAD 1018
		Pop $muiex.un.sc.ConfirmPage

		; ���x���e�L�X�g
		${NSD_CreateLabel} 0 0 100% 15u ${MUIEX_UN_CONFIRM_INFO}
		Pop $muiex.un.sc.InfoText

		; ���s���e�e�L�X�g�̍쐬
		StrCpy $0 ""

		; �C���X�g�[����p�X
		StrCpy $0 "$0${MUIEX_UN_CONFIRM_INSTALLLOCATION}$\r$\n    $INSTDIR$\r$\n$\r$\n"

		; �Z�[�u�f�[�^�ۑ���̃��|�[�g
		!ifdef un.MUIEX_SAVEDATA_GetReport
			${un.MUIEX_SAVEDATA_GetReport} $1
			StrCpy $0 "$0$1"
		!endif

		; ���e�\��
		nsDialogs::CreateControl /NOUNLOAD "EDIT" \
			${ES_MULTILINE}|${ES_READONLY}|${WS_VISIBLE}|${WS_CHILD}|${WS_VSCROLL} \
			${WS_EX_CLIENTEDGE} 0 20u 100% 120u $0
		Pop $muiex.un.sc.DetailsText

		Pop $0

		nsDialogs::Show

	FunctionEnd

	Function "${LEAVE}"

		!insertmacro MUIEX_PAGE_FUNCTION_CUSTOM LEAVE

	FunctionEnd

!macroend


