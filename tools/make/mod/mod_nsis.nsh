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
; ���W�X�g���L�[���[�g
!define NSIS_UTILS_REGKEY_ROOT	SHCTX

;---
; �C���N���[�h

; MUIEX �Ǝ��̊g���y�[�W
!include "mod_muiex.nsh"
; ���[�e�B���e�B�֐��}�N��
!include "mod_utils.nsh"

;---
; �\�[�X�֘A�̃p�X��`
!define PACKAGE_DIR		"${ROOT_DIR}\src\data\products\${TARGET_NAME}"
!define IMAGE_DIR		"${PACKAGE_DIR}\header-images"
!define ICON_DIR		"${PACKAGE_DIR}\icons"

;---
; ���Зp���W�X�g���L�[�̃p�X��`
!define REG_ROOT		"Software\${VENDER}"
!define REG_PRODUCT		"${REG_ROOT}\${PRODUCT}"
!define REG_ADDFILES	"${REG_PRODUCT}\AddFiles"

;---
; Windows �́u�A�v���P�[�V�����̒ǉ��ƍ폜�v�c�[���p���W�X�g���L�[�̃p�X��`
!define REG_MS_WINDOWS_UNINSTALL	"Software\Microsoft\Windows\CurrentVersion\Uninstall"
!define REG_MS_WINDOWS_PRODUCT		"${REG_MS_WINDOWS_UNINSTALL}\${PRODUCT_ID}"

;---
; Windows �̃X�^�[�g���j���[�p�p�X��`
!define SM_ROOT			"$SMPROGRAMS\${VENDER_J}"
!define SM_PRODUCT		"${SM_ROOT}\${PRODUCT_J}"

;---
; �t�@�C�����Ɋւ����`
!define MAINAPPLICATION_NAME		"${PRODUCT_J}"
!define MAINAPPLICATION_ALIAS		"${PRODUCT_J}"
!define MAINAPPLICATION_FILENAME	"${PRODUCT_J}.exe"
!define UNINSTALLER_NAME			"Uninstall.exe"
!define UNINSTALLER_ALIAS			"�A���C���X�g�[��"
!define INDEX_NAME					"Index.ary"
!define README_NAME					"���ǂ݉�����.txt"

;---
; MUI �ݒ�
!define MUI_ABORTWARNING
!define MUI_ABORTWARNING_TEXT			"${SETUP_TITLE} �̃Z�b�g�A�b�v�͊������Ă��܂���B$\n���f���܂����H"
!define MUI_UNABORTWARNING
!define MUI_UNABORTWARNING_TEXT			"${SETUP_TITLE} �̃A���C���X�g�[���͊������Ă��܂���B$\n���f���܂����H"

!define MUI_ICON						"${ICON_DIR}\installer.ico"
!define MUI_UNICON						"${ICON_DIR}\uninstaller.ico"

!define MUI_WELCOMEFINISHPAGE_BITMAP	"${IMAGE_DIR}\side_banner.bmp"
!define MUI_WELCOMEPAGE_TITLE 			"${SETUP_TITLE} �Z�b�g�A�b�v�v���O����"
!define MUI_WELCOMEPAGE_TEXT 			"${SETUP_TITLE} �̃Z�b�g�A�b�v���J�n���܂��B$\n$\n�Z�b�g�A�b�v���J�n����O�ɑ��̑S�ẴA�v���P�[�V�������I�������邱�Ƃ𐄏����܂��B$\n$\n������ɂ́u���ցv���N���b�N���Ă��������B"

!define MUI_UNWELCOMEFINISHPAGE_BITMAP	"${IMAGE_DIR}\unside_banner.bmp"

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP			"${IMAGE_DIR}\page_header_r.bmp"
!define MUI_HEADERIMAGE_UNBITMAP		"${IMAGE_DIR}\unpage_header_r.bmp"

;---
; MUIEX �ݒ�
!define MUIEX_SAVELOCATION_PATH_SUFFIX			"\${VENDER}\${PRODUCT}"
!define MUIEX_SAVELOCATION_INSTALLFOLDER_SUFFIX	"\save"

!define MUIEX_UN_SAVEDATA_PATH_SUFFIX			${MUIEX_SAVELOCATION_PATH_SUFFIX}
!define MUIEX_UN_SAVEDATA_INSTALLFOLDER_SUFFIX	${MUIEX_SAVELOCATION_INSTALLFOLDER_SUFFIX}


;---
; ��`�̒���

; ���݁u���ׂẴ��[�U�[�v�͖������ł��B
!ifdef USE_ALLUSERS
	!undef USE_ALLUSERS
!endif
!define USE_ALLUSERS	0


;---
; �d�v�ȓ���ݒ�

; ���i��
Name "${PRODUCT_J}"
; �����C���X�g�[����p�X
InstallDir "$PROGRAMFILES\${VENDER}"
; �C���X�g�[����p�X�̕ۑ���
!if ${USE_ALLUSERS} == 0
	InstallDirRegKey HKCU "${REG_MS_WINDOWS_PRODUCT}" "InstallLocation"
!else
	InstallDirRegKey HKLM "${REG_MS_WINDOWS_PRODUCT}" "InstallLocation"
!endif
; �}�j�t�F�X�g��ǉ�����
XPStyle on
; �C���X�g�[���[�̎��s�ɊǗ��Ҍ�����v������
RequestExecutionLevel admin
; �C���X�g�[���^�A���C���X�g�[���̏ڍׂ�\������
ShowInstDetails show
ShowUninstDetails show


;---
; ���W���[����`

;---
; ${NSIS_Initialize}
; .onInit �����ł����K���Ăяo���Ă��������B
;
; ${un.NSIS_Initialize}
; un.onInit �����ł����K���Ăяo���Ă��������B
!macro NSIS_InitializeCaller
	Call NSIS_Initialize
!macroend

!macro NSIS_Initialize

	; ���W���[���W�J
	!insertmacro MUIEX_Initialize

	!ifndef NSIS_Initialize
		!define NSIS_Initialize	`!insertmacro NSIS_InitializeCaller`

		Function NSIS_Initialize

			Push $0
			Push $1

			; ���݂̃��[�U�[�^���ׂẴ��[�U�[
			!if ${USE_ALLUSERS} == 0
				SetShellVarContext current
			!else
				SetShellVarContext all
			!endif

			; �C���X�g�[���^�C�v
			ReadRegStr $0 ${NSIS_UTILS_REGKEY_ROOT} "${REG_PRODUCT}" "Type"
			IfErrors NSIS_Initialize_unknowntype
			GoTo NSIS_Initialize_knowntype

			NSIS_Initialize_unknowntype:
				ClearErrors
				StrCpy $0 ""

			NSIS_Initialize_knowntype:

			; �Z�[�u�f�[�^�ۑ���
			ReadRegStr $1 ${NSIS_UTILS_REGKEY_ROOT} "${REG_PRODUCT}" "SaveLocation"
			IfErrors NSIS_Initialize_nothavesavedata
			GoTo NSIS_Initialize_existsavedata

			NSIS_Initialize_nothavesavedata:
				ClearErrors
				StrCpy $1 ""

			NSIS_Initialize_existsavedata:

			; MUIEX ������
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

	; ���W���[���W�J
	!insertmacro un.MUIEX_Initialize

	!ifndef un.NSIS_Initialize
		!define un.NSIS_Initialize	`!insertmacro un.NSIS_InitializeCaller`

		Function un.NSIS_Initialize

			Push $0

			; ���݂̃��[�U�[�^���ׂẴ��[�U�[
			!if ${USE_ALLUSERS} == 0
				SetShellVarContext current
			!else
				SetShellVarContext all
			!endif

			; �Z�[�u�f�[�^�ۑ���
			ReadRegStr $0 ${NSIS_UTILS_REGKEY_ROOT} "${REG_PRODUCT}" "SaveLocation"
			IfErrors NSIS_Initialize_nothavesavedata
			GoTo NSIS_Initialize_existsavedata

			NSIS_Initialize_nothavesavedata:
				ClearErrors
				StrCpy $0 ""

			NSIS_Initialize_existsavedata:

			; UN_MUIEX ������
			${un.MUIEX_Initialize} $0

			Pop $0

			InitPluginsDir

		FunctionEnd
	!endif
!macroend


!verbose pop

!endif	; GUARD_MODNSIS_NSH


