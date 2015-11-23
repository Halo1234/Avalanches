;/*
; * $Revision: 341 $
;**/

; NOTE: ここでプロジェクトに必要な機能を読み込んでください。
; NOTE: 最初に生成されるメインウインドウはデフォルトでは、何の機能も持っていません。


; ◆プラグイン読み込み
;
;  Windows の場合、主に *.dll ファイルになります。

; ogg デコーダ
@load_plugin name=wuvorbis.dll


; ◆モジュール読み込み
;
; ここでプロジェクトに必要なモジュールを読み込んでください。

; ブックマーク機能
@load_module name=ModBookmark
; ADV機能
@load_module name=ModADV
; 画像関連機能
@load_module name=ModImage
; メッセージレイヤ関連機能
@load_module name=ModMessage
; 音楽関連機能
@load_module name=ModSound
; ビデオ関連機能
@load_module name=ModVideo
; 右クリック関連機能
@load_module name=ModRightClick

; ここまで
;


