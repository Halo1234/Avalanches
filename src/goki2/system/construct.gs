
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
; 必要のないモジュールをコメントアウトした場合
; /src/goki2/system/KAGCompatible.gsからも
; コメントアウトしたモジュールの設定をコメントアウトしてください。
;
; 例えばModBookmarkをコメントアウトした場合、
; KAGCompatible.gsのKAGCompatibleBookmark.gsの読み込みもコメントアウトすること。

; スナップショット機能
@load_module name=ModSnapshot
; ブックマーク機能
@load_module name=ModBookmark
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
; ADV機能
@load_module name=ModADV
; タイピングゲーム機能
@load_module name=ModTypingProcessor
; シミュレーションゲーム機能
@load_module name=ModSLG
; メニュー機能
; メニューが必要なければコメントアウトすること
@load_module name=ModSystemMenuItems
@load_module name=ModSaveLoadMenuItems
;@load_module name=ModMessageMenuItems
@load_module name=ModHelpMenuItems
; システムボタン
@load_module name=ModSystemButtons
; セーブロード画面
@load_module name=ModSaveLoad
; システム画面
@load_module name=ModSystem
; 選択肢
@load_module name=ModSelect
; タイトル画面
@load_module name=ModTitle
; CG/回想画面
@load_module name=ModCGMemory
; バージョンウインドウ
@load_module name=ModVersionWindow

; ここまで
;


