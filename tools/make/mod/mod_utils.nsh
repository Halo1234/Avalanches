/**
 * $Revision: 144 $
**/

!ifndef GUARD_INSTALLER_NSH
!define GUARD_INSTALLER_NSH


!ifndef NSIS_UTILS_REGKEY_ROOT
	!define NSIS_UTILS_REGKEY_ROOT	SHCTX
!endif

!include Util.nsh

;---
; �G���[�����p�}�N��
!macro NSIS_UTILS_ErrorBreakNoAbort _MSG _RETRY_LABEL
	MessageBox MB_RETRYCANCEL|MB_ICONSTOP "!!!>${_MSG}" IDRETRY ${_RETRY_LABEL}
!macroend

!macro NSIS_UTILS_ErrorBreak _MSG _RETRY_LABEL
	!insertmacro NSIS_UTILS_ErrorBreakNoAbort `${_MSG}` `${_RETRY_LABEL}`
	Abort "!!!>${_MSG}"
!macroend


;---
; ${OpenExternalInstallerIndex} VAR PATH
; PATH ���w���C���f�b�N�X�t�@�C�����J���� VAR �ɕԂ��B
; ���̃C���f�b�N�X�t�@�C���͊O���쐬�̃C���f�b�N�X�t�@�C���ł��B
;
; ${CloseExternalInstallerIndex} VAR
; ���C���f�b�N�X�t�@�C�������
!define OpenExternalInstallerIndex		`!insertmacro OpenExternalInstallerIndexCaller`
!define un.OpenExternalInstallerIndex	`!insertmacro OpenExternalInstallerIndexCaller`

!define CloseExternalInstallerIndex		`!insertmacro CloseExternalInstallerIndexCaller`
!define un.CloseExternalInstallerIndex	`!insertmacro CloseExternalInstallerIndexCaller`

!macro OpenExternalInstallerIndexCaller _VAR _PATH
	Push `${_PATH}`
	${CallArtificialFunction} OpenExternalInstallerIndex_
	Pop `${_VAR}`
!macroend

!macro CloseExternalInstallerIndexCaller _ID
	Push `${_ID}`
	${CallArtificialFunction} CloseExternalInstallerIndex_
!macroend

!macro OpenExternalInstallerIndex_
	Exch $0 ; PATH
	MorningNightcap::OpenExternalIndex $0
	Pop $0
!macroend

!macro CloseExternalInstallerIndex_
	Exch $0 ; ID
	MorningNightcap::CloseExternalIndex $0
	Pop $0
!macroend

;---
; ${AddExternalInstallerIndex} ID TYPE INDEX
; (TYPE)INDEX ��ǉ�����B
!define AddExternalInstallerIndex		`!insertmacro AddExternalInstallerIndexCaller`
!define un.AddExternalInstallerIndex	`!insertmacro AddExternalInstallerIndexCaller`

!macro AddExternalInstallerIndexCaller _ID _TYPE _INDEX
	Push `${_INDEX}`
	Push `${_TYPE}`
	Push `${_ID}`
	${CallArtificialFunction} AddExternalInstallerIndex_
!macroend

!macro AddExternalInstallerIndex_
	Exch $0 ; ID
	Exch
	Exch $1 ; TYPE
	Exch 2
	Exch $2 ; INDEX
	MorningNightcap::AddExternalIndex $0 $1 $2
	Pop $2
	Pop $0
	Pop $1
!macroend

;---
; ${OpenCopyIndex} VAR PATH
; PATH ���w���C���f�b�N�X�t�@�C�����R�s�[�p�ɊJ���� VAR �ɕԂ��B
; ${OpenDeleteIndex} VAR PATH
; PATH ���w���C���f�b�N�X�t�@�C�����폜�ɊJ���� VAR �ɕԂ��B
!define OpenCopyIndex		`!insertmacro OpenCopyIndexCaller`
!define un.OpenCopyIndex	`!insertmacro OpenCopyIndexCaller`

!define OpenDeleteIndex		`!insertmacro OpenDeleteIndexCaller`
!define un.OpenDeleteIndex	`!insertmacro OpenDeleteIndexCaller`

!macro OpenCopyIndexCaller _VAR _PATH
	Push "s"
	Push `${_PATH}`
	${CallArtificialFunction} OpenIndex_
	Pop `${_VAR}`
!macroend

!macro OpenDeleteIndexCaller _VAR _PATH
	Push "r"
	Push `${_PATH}`
	${CallArtificialFunction} OpenIndex_
	Pop `${_VAR}`
!macroend

!macro OpenIndex_

	Exch $0 ; PATH
	Exch
	Exch $1 ; MODE

	MorningNightcap::OpenIndex $0 $1

	Exch
	Pop $1
	Exch
	Pop $0

!macroend

;---
; ${GetNextIndex} INDEX VAR
; INDEX ���w���C���f�b�N�X�t�@�C�����玟�ɏ������ׂ��s�� VAR �ɕԂ��B
; INDEX ���J���ɂ� ${OpenCopyIndex} �܂��� ${OpenDeleteIndex} ���g���Ă��������B
!define GetNextIndex	`!insertmacro GetNextIndexCaller`
!define un.GetNextIndex	`!insertmacro GetNextIndexCaller`

!macro GetNextIndexCaller _INDEX _VAR
	Push `${_INDEX}`
	${CallArtificialFunction} GetNextIndex_
	Pop `${_VAR}`
!macroend

!macro GetNextIndex_

	Exch $0 ; INDEX

	MorningNightcap::GetNextIndex $0

	Exch
	Pop $0

!macroend

;---
; ${CloseIndex} INDEX
; INDEX ���w���C���f�b�N�X�t�@�C�������B
!define CloseIndex		`!insertmacro CloseIndexCaller`
!define un.CloseIndex	`!insertmacro CloseIndexCaller`

!macro CloseIndexCaller _INDEX
	Push `${_INDEX}`
	${CallArtificialFunction} CloseIndex_
!macroend

!macro CloseIndex_

	Exch $0 ; INDEX

	MorningNightcap::CloseIndex $0

	Pop $0

!macroend


;---
; ${SafeWriteRegDWORD} KEY NAME VALUE
; ���炩�̌����ɂ���ď������݂Ɏ��s�����ꍇ�� Abort ���܂��B
!define SafeWriteRegDWORD		`!insertmacro SafeWriteRegDWORDCaller`
!define un.SafeWriteRegDWORD	`!insertmacro SafeWriteRegDWORDCaller`

!macro SafeWriteRegDWORDCaller _KEY _NAME _VALUE
	Push `${_VALUE}`
	Push `${_NAME}`
	Push `${_KEY}`
	${CallArtificialFunction} SafeWriteRegDWORD_
!macroend

!macro SafeWriteRegDWORD_

	Exch $0 ; _KEY
	Exch 2
	Exch $2 ; _VALUE
	Exch 1
	Exch $1 ; _NAME

	SafeWriteRegDWORD_retry:
		WriteRegDWORD ${NSIS_UTILS_REGKEY_ROOT} $0 $1 $2

		IfErrors SafeWriteRegDWORD_error_break SafeWriteRegDWORD_epilogue

	SafeWriteRegDWORD_error_break:
		!insertmacro NSIS_UTILS_ErrorBreak "$0\$1$\n���W�X�g���������݂Ɏ��s���܂����B" SafeWriteRegDWORD_retry

	SafeWriteRegDWORD_epilogue:
		Pop $1
		Pop $2
		Pop $0
!macroend

;---
; ${SafeWriteRegStr} KEY NAME VALUE
; ���炩�̌����ɂ���ď������݂Ɏ��s�����ꍇ�� Abort ���܂��B
!define SafeWriteRegStr		`!insertmacro SafeWriteRegStrCaller`
!define un.SafeWriteRegStr	`!insertmacro SafeWriteRegStrCaller`

!macro SafeWriteRegStrCaller _KEY _NAME _VALUE
	Push `${_VALUE}`
	Push `${_NAME}`
	Push `${_KEY}`
	${CallArtificialFunction} SafeWriteRegStr_
!macroend

!macro SafeWriteRegStr_

	Exch $0 ; _KEY
	Exch 2
	Exch $2 ; _VALUE
	Exch 1
	Exch $1 ; _NAME

	SafeWriteRegStr_retry:
		WriteRegStr ${NSIS_UTILS_REGKEY_ROOT} $0 $1 $2

		IfErrors SafeWriteRegStr_error_break SafeWriteRegStr_epilogue

	SafeWriteRegStr_error_break:
		!insertmacro NSIS_UTILS_ErrorBreak "$0\$1$\n���W�X�g���������݂Ɏ��s���܂����B" SafeWriteRegStr_retry

	SafeWriteRegStr_epilogue:
		Pop $1
		Pop $2
		Pop $0

!macroend


;---
; ${SafeDeleteRegValue} KEY NAME
; ���W�X�g������l���폜���܂��B
;
; ${SafeDeleteRegKey} KEY
; ���W�X�g������L�[���폜���܂��B
; �l�����݂��Ȃ����A�폜�ł��Ȃ������ꍇ�̓G���[�t���O���Z�b�g����܂��B
!define SafeDeleteRegValue		`!insertmacro SafeDeleteRegValueCaller`
!define un.SafeDeleteRegValue	`!insertmacro SafeDeleteRegValueCaller`

!macro SafeDeleteRegValueCaller _KEY _NAME
	Push `${_NAME}`
	Push `${_KEY}`
	${CallArtificialFunction} SafeDeleteRegValue_
!macroend

!macro SafeDeleteRegValue_

	Exch $0 ; _KEY
	Exch
	Exch $1 ; _NAME

	SafeDeleteRegValue_retry:
		DeleteRegValue ${NSIS_UTILS_REGKEY_ROOT} $0 $1

		IfErrors SafeDeleteRegValue_error_break SafeDeleteRegValue_epilogue

	SafeDeleteRegValue_error_break:
		!insertmacro NSIS_UTILS_ErrorBreak "$0$1$\n���W�X�g���l���폜�ł��܂���ł����B" SafeDeleteRegValue_retry

	SafeDeleteRegValue_epilogue:
		Pop $1
		Pop $0

!macroend

;---
!define SafeDeleteRegKey	`!insertmacro SafeDeleteRegKeyCaller`
!define un.SafeDeleteRegKey	`!insertmacro SafeDeleteRegKeyCaller`

!macro SafeDeleteRegKeyCaller _KEY
	Push `${_KEY}`
	${CallArtificialFunction} SafeDeleteRegKey_
!macroend

!macro SafeDeleteRegKey_

	Exch $0 ; _KEY

	DeleteRegKey /ifempty ${NSIS_UTILS_REGKEY_ROOT} $0

	IfErrors SafeDeleteRegKey_error_break SafeDeleteRegKey_epilogue

	SafeDeleteRegKey_error_break:
		; Do nothing.

	SafeDeleteRegKey_epilogue:
		Pop $0

!macroend


;---
; ${SafeFileCopy} SRC DEST
; SRC �̃t�@�C���� DEST �ɃR�s�[����B
; ���炩�̌����ɂ���ăt�@�C���R�s�[�����s�����ꍇ�� Abort ���܂��B
!define SafeFileCopy	`!insertmacro SafeFileCopyCaller`
!define un.SafeFileCopy	`!insertmacro SafeFileCopyCaller`

!macro SafeFileCopyCaller _SRC _DEST
	Push `${_DEST}`
	Push `${_SRC}`
	${CallArtificialFunction} SafeFileCopy_
!macroend

!macro SafeFileCopy_

	Exch $0 ; Src
	Exch
	Exch $1 ; Dest

	SafeFileCopy_retry:
		IfFileExists "$0\*.*" SafeFileCopy_is_folder SafeFileCopy_is_file

	SafeFileCopy_is_folder:
		CreateDirectory "$1"
		IfErrors SafeFileCopy_error_break SafeFileCopy_epilogue
	SafeFileCopy_is_file:
		CopyFiles /SILENT "$0" "$1"
		IfErrors SafeFileCopy_error_break SafeFileCopy_epilogue

	SafeFileCopy_error_break:
		!insertmacro NSIS_UTILS_ErrorBreak "$0$\n�t�@�C���̃R�s�[�Ɏ��s���܂����B" SafeFileCopy_retry

	SafeFileCopy_epilogue:
		Pop $1
		Pop $0

!macroend


;---
; ${SafeFileOpenReadOnly} VAR PATH
; ${SafeFileOpenWrite} VAR PATH
; ${SafeFileOpenAppend} VAR PATH
; PATH �t�@�C�����J���� VAR �Ƀn���h����Ԃ��B
!define SafeFileOpenReadOnly		`!insertmacro SafeFileOpenReadOnlyCaller`
!define un.SafeFileOpenReadOnly		`!insertmacro SafeFileOpenReadOnlyCaller`

!macro SafeFileOpenReadOnlyCaller _VAR _PATH
	Push `${_PATH}`
	${CallArtificialFunction} SafeFileOpenReadOnly_
	Pop `${_VAR}`
!macroend

!macro SafeFileOpenReadOnly_

	Exch $0 ; _PATH
	Push $1

	SafeFileOpenReadOnly_retry:
		IfFileExists $0 SafeFileOpenReadOnly_found SafeFileOpenReadOnly_notfound

	SafeFileOpenReadOnly_found:
		FileOpen $1 $0 r
		IfErrors SafeFileOpenReadOnly_error_break SafeFileOpenReadOnly_epilogue

	SafeFileOpenReadOnly_notfound:
	SafeFileOpenReadOnly_error_break:
		ClearErrors
		!insertmacro NSIS_UTILS_ErrorBreakNoAbort "$0$\n�t�@�C����������Ȃ����A�J�����Ƃ��ł��܂���ł����B" SafeFileOpenReadOnly_retry

	SafeFileOpenReadOnly_epilogue:
		Exch
		Pop $0
		Exch $1

!macroend

;---
!define SafeFileOpenWrite		`!insertmacro SafeFileOpenWriteCaller`
!define un.SafeFileOpenWrite	`!insertmacro SafeFileOpenWriteCaller`

!macro SafeFileOpenWriteCaller _VAR _PATH
	Push `${_PATH}`
	${CallArtificialFunction} SafeFileOpenWrite_
	Pop `${_VAR}`
!macroend

!macro SafeFileOpenWrite_

	Exch $0 ; _PATH
	Push $1

	SafeFileOpenWrite_retry:
		FileOpen $1 $0 w
		IfErrors SafeFileOpenWrite_error_break SafeFileOpenWrite_epilogue

	SafeFileOpenWrite_error_break:
		ClearErrors
		!insertmacro NSIS_UTILS_ErrorBreakNoAbort "$0$\n�t�@�C�����J�����Ƃ��ł��܂���ł����B" SafeFileOpenWrite_retry

	SafeFileOpenWrite_epilogue:
		Exch
		Pop $0
		Exch $1

!macroend

;---
!define SafeFileOpenAppend		`!insertmacro SafeFileOpenAppendCaller`
!define un.SafeFileOpenAppend	`!insertmacro SafeFileOpenAppendCaller`

!macro SafeFileOpenAppendCaller _VAR _PATH
	Push `${_PATH}`
	${CallArtificialFunction} SafeFileOpenAppend_
	Pop `${_VAR}`
!macroend

!macro SafeFileOpenAppend_

	Exch $0 ; _PATH
	Push $1

	SafeFileOpenAppend_retry:
		FileOpen $1 $0 a
		IfErrors SafeFileOpenAppend_error_break SafeFileOpenAppend_epilogue

	SafeFileOpenAppend_error_break:
		ClearErrors
		!insertmacro NSIS_UTILS_ErrorBreakNoAbort "$0$\n�t�@�C�����J�����Ƃ��ł��܂���ł����B" SafeFileOpenAppend_retry

	SafeFileOpenAppend_epilogue:
		Exch
		Pop $0
		Exch $1

!macroend


;---
; ${SafeDelete} PATH
; PATH ���폜����B
!define SafeDelete		`!insertmacro SafeDeleteCaller`
!define un.SafeDelete	`!insertmacro SafeDeleteCaller`

!macro SafeDeleteCaller _PATH
	Push `${_PATH}`
	${CallArtificialFunction} SafeDelete_
!macroend

!macro SafeDelete_

	Exch $0 ; _PATH

	IfFileExists "$0\*.*" SafeDelete_is_folder SafeDelete_is_file

	SafeDelete_is_folder:
		RMDir "$0"
		GoTo SafeDelete_done
	SafeDelete_is_file:
		Delete "$0"
		GoTo SafeDelete_done

	SafeDelete_done:
		ClearErrors
		Pop $0

!macroend


;---
; ${DeleteIndexFile} INDEX_DIR INDEX_NAME
; $INDEX_DIR\$INDEX_NAME �Ŏw�肵�� $INDEX_DIR\$INDEX_NAME �t�@�C�����Ǘ�����t�@�C����t�H���_�����ׂč폜���܂��B
; �Ō�� $INDEX_DIR\$INDEX_NAME �t�@�C�����폜���܂��B
; ���̃}�N���͊Ǘ��O�̃t�@�C����t�H���_�͌����č폜���܂���B
!define DeleteIndexFile		`!insertmacro DeleteIndexFileCaller`
!define un.DeleteIndexFile	`!insertmacro DeleteIndexFileCaller`

!macro DeleteIndexFileCaller _INDEX_DIR _INDEX_NAME
	Push `${_INDEX_NAME}`
	Push `${_INDEX_DIR}`
	${CallArtificialFunction2} DeleteIndexFile_
!macroend

!macro DeleteIndexFile_

	Exch $0  ; _INDEX_DIR
	Exch
	Exch $1  ; _INDEX_NAME

	Push $R0 ; line.
	Push $R1 ; File handle.
	Push $R2 ; works

	; INDEX �����݂��Ȃ��Ȃ�Ή������Ȃ�
	IfFileExists "$0\$1" 0 DeleteIndexFile_epilogue

	${OpenDeleteIndex} $R1 "$0\$1"

	DeleteIndexFile_loop:
		${GetNextIndex} $R1 $R0
		StrCmp $R0 "" DeleteIndexFile_done

		${SafeDelete} "$0\$R0"
		GoTo DeleteIndexFile_loop

	DeleteIndexFile_done:
		${CloseIndex} $R1
		SetFileAttributes "$0\$1" NORMAL
		Delete "$0\$1"
		Delete "$0\krenvprf.kep"
		Delete "$0\${MAINAPPLICATION_NAME}.cfu"
		GoTo DeleteIndexFile_epilogue

	DeleteIndexFile_epilogue:
		ClearErrors
		Pop $R2
		Pop $R1
		Pop $R0
		Pop $1
		Pop $0

!macroend

!endif


