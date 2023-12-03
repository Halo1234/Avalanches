/**
 * $Revision: 148 $
**/

!ifndef GUARD_INSTALLER_NSH
!define GUARD_INSTALLER_NSH


!ifndef NSIS_UTILS_REGKEY_ROOT
	!define NSIS_UTILS_REGKEY_ROOT	SHCTX
!endif

!include Util.nsh

;---
; エラー処理用マクロ
!macro NSIS_UTILS_ErrorBreakNoAbort _MSG _RETRY_LABEL
	MessageBox MB_RETRYCANCEL|MB_ICONSTOP "!!!>${_MSG}" IDRETRY ${_RETRY_LABEL}
!macroend

!macro NSIS_UTILS_ErrorBreak _MSG _RETRY_LABEL
	!insertmacro NSIS_UTILS_ErrorBreakNoAbort `${_MSG}` `${_RETRY_LABEL}`
	Abort "!!!>${_MSG}"
!macroend


;---
; ${OpenExternalInstallerIndex} VAR PATH
; PATH が指すインデックスファイルを開いて VAR に返す。
; このインデックスファイルは外部作成のインデックスファイルです。
;
; ${CloseExternalInstallerIndex} VAR
; 同インデックスファイルを閉じる
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
; (TYPE)INDEX を追加する。
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
; PATH が指すインデックスファイルをコピー用に開いて VAR に返す。
; ${OpenDeleteIndex} VAR PATH
; PATH が指すインデックスファイルを削除に開いて VAR に返す。
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
; INDEX が指すインデックスファイルから次に処理すべき行を VAR に返す。
; INDEX を開くには ${OpenCopyIndex} または ${OpenDeleteIndex} を使ってください。
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
; INDEX が指すインデックスファイルを閉じる。
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
; 何らかの原因によって書き込みに失敗した場合は Abort します。
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
		!insertmacro NSIS_UTILS_ErrorBreak "$0\$1$\nRegistry write failed." SafeWriteRegDWORD_retry

	SafeWriteRegDWORD_epilogue:
		Pop $1
		Pop $2
		Pop $0
!macroend

;---
; ${SafeWriteRegStr} KEY NAME VALUE
; 何らかの原因によって書き込みに失敗した場合は Abort します。
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
		!insertmacro NSIS_UTILS_ErrorBreak "$0\$1$\nRegistry write failed." SafeWriteRegStr_retry

	SafeWriteRegStr_epilogue:
		Pop $1
		Pop $2
		Pop $0

!macroend


;---
; ${SafeDeleteRegValue} KEY NAME
; レジストリから値を削除します。
;
; ${SafeDeleteRegKey} KEY
; レジストリからキーを削除します。
; 値が存在しないか、削除できなかった場合はエラーフラグがセットされます。
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
		!insertmacro NSIS_UTILS_ErrorBreak "$0$1$\nRegistry value could not be deleted." SafeDeleteRegValue_retry

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

	; 本来なら /ifempty 指定でいきたいが面倒なのでとりあえず動くようにする
	;DeleteRegKey /ifempty ${NSIS_UTILS_REGKEY_ROOT} $0
	DeleteRegKey ${NSIS_UTILS_REGKEY_ROOT} $0

	IfErrors SafeDeleteRegKey_error_break SafeDeleteRegKey_epilogue

	SafeDeleteRegKey_error_break:
		MessageBox MB_OK "$0 Deletion failed."

	SafeDeleteRegKey_epilogue:
		Pop $0

!macroend


;---
; ${SafeFileCopy} SRC DEST
; SRC のファイルを DEST にコピーする。
; 何らかの原因によってファイルコピーが失敗した場合は Abort します。
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
		!insertmacro NSIS_UTILS_ErrorBreak "$0$\nFailed to copy file." SafeFileCopy_retry

	SafeFileCopy_epilogue:
		Pop $1
		Pop $0

!macroend


;---
; ${SafeFileOpenReadOnly} VAR PATH
; ${SafeFileOpenWrite} VAR PATH
; ${SafeFileOpenAppend} VAR PATH
; PATH ファイルを開いて VAR にハンドルを返す。
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
		!insertmacro NSIS_UTILS_ErrorBreakNoAbort "$0$\nThe file was not found or could not be opened." SafeFileOpenReadOnly_retry

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
		!insertmacro NSIS_UTILS_ErrorBreakNoAbort "$0$\nThe file could not be opened." SafeFileOpenWrite_retry

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
		!insertmacro NSIS_UTILS_ErrorBreakNoAbort "$0$\nThe file could not be opened." SafeFileOpenAppend_retry

	SafeFileOpenAppend_epilogue:
		Exch
		Pop $0
		Exch $1

!macroend


;---
; ${SafeDelete} PATH
; PATH を削除する。
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
; $INDEX_DIR\$INDEX_NAME で指定した $INDEX_DIR\$INDEX_NAME ファイルが管理するファイルやフォルダをすべて削除します。
; 最後に $INDEX_DIR\$INDEX_NAME ファイルも削除します。
; このマクロは管理外のファイルやフォルダは決して削除しません。
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

	; INDEX が存在しないならば何もしない
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


