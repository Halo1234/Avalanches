/**
 * $Revision: 144 $
**/

!ifndef GUARD_UNMODMUIEXBASIC_NSH
!define GUARD_UNMODMUIEXBASIC_NSH

!include "MUI2.nsh"

;---
; UN_MUIEX �S�̂ŗ��p����ϐ�
Var muiex.un.CurrentSaveLocation
Var muiex.un.CurrentSaveLocationPath

!macro un.MUIEX_VARIABLES
!macroend

;---
; ${un.MUIEX_Initialize} SAVELOCATION
; UN_MUIEX ���g���ꍇ�͕K�� un.onInit �ł�����Ăяo���Ă��������B
;
; SAVELOCATION �ɂ͌��݂̃Z�[�u�ꏊ���w�肵�Ă��������B
; �Z�[�u�f�[�^�������ꍇ�͋󕶎�����w�肵�܂��B
!macro un.MUIEX_InitializeCaller _SAVELOCATION
	Push `${_SAVELOCATION}`
	Call un.MUIEX_Initialize
!macroend

!macro un.MUIEX_Initialize
	!ifndef un.MUIEX_Initialize
		!insertmacro un.MUIEX_VARIABLES

		!define un.MUIEX_Initialize	`!insertmacro un.MUIEX_InitializeCaller`

		Function un.MUIEX_Initialize

			Exch $0 ; _SAVELOCATION

			StrCpy $muiex.un.CurrentSaveLocation $0
			StrCpy $muiex.un.CurrentSaveLocationPath ""

			Pop $0

		FunctionEnd
	!endif
!macroend


;---
!macro un.MUIEX_PAGE_FUNCTION_CUSTOM TYPE
	!ifdef un.MUIEX_PAGE_CUSTOMFUNCTION_${TYPE}
		Call "${un.MUIEX_PAGE_CUSTOMFUNCTION_${TYPE}}"
		!undef un.MUIEX_PAGE_CUSTOMFUNCTION_${TYPE}
	!endif
!macroend


;---
; �ǎ��p�C���^�[�t�F�[�X
; ������A�������݂��ł��܂��� UN_MUIEX �̎d�l��ł͓ǎ��p�ł��B
; �����ɂ킽���ď������݂��\���ǂ����͕ۏ؂���܂���B
!define un.MUIEX_CurrentSaveLocation		`$muiex.un.CurrentSaveLocation`
!define un.MUIEX_CurrentSaveLocationPath	`$muiex.un.CurrentSaveLocationPath`

;---
; �e��l�ύX�p�C���^�[�t�F�[�X

;---
; ${un.MUIEX_SetCurrentSaveLocationPath} PATH
; MUIEX_UNPAGE_SAVEDATA �ɂ���Đ����ȃp�X���Z�b�g���邽�߂Ɏg����B
!macro un.MUIEX_SetCurrentSaveLocationPathCaller _PATH
	Push `${_PATH}`
	Call un.MUIEX_SetCurrentSaveLocationPath
!macroend

!macro un.MUIEX_SetCurrentSaveLocationPath
	!ifndef un.MUIEX_SetCurrentSaveLocationPath
		!define un.MUIEX_SetCurrentSaveLocationPath	`!insertmacro un.MUIEX_SetCurrentSaveLocationPathCaller`

		Function un.MUIEX_SetCurrentSaveLocationPath
			Pop $muiex.un.CurrentSaveLocationPath
		FunctionEnd
	!endif
!macroend

!endif


