;/*
; * $Revision: 288 $
;**/


; ◆スクリプトキュー
;
; storage: 追加したいスクリプトファイル名です。
;
@que storage=testcase


; ◆改行の扱い方
;
; ignore: 改行コードを r タグとして扱うかどうか
@cr_handling ignore


; ◆ウインドウの設定
;
;                caption: ウインドウのタイトルバーに表示する文字列です。
;                  width: ウインドウの幅です。（正確にはクライアント領域の幅です）
;                 height: ウインドウの高さです。（正確にはクライアント領域の高さです）
; fix-position-to-center: 指定するとウインドウ初期位置がデスクトップ中央に設定されます。
;              alt-enter: 指定すると Alt+Enter でスクリーンモードを切り替える事ができるようになります。
;                visible: 指定するとウインドウを表示します。
;
@window width=800 height=600 fix-position-to-center alt-enter


; ◆初期化ウェイト
@wait time=400 !skip !click


; ◆各モジュール設定
;
; 読み込んだモジュールの設定が必要であればここで行ってください。
; モジュールの設定については各モジュールの説明を参照してください。
;
; ココから

; ココまで


; ◆バージョン情報
;
; message: プリセット名、または任意の文字列を指定します。
;
@notice message=version
@notice message=システム初期化完了しました。


; ◆ウインドウの表示
;
; これで全ての設定が終わったのでウインドウを表示する。
;
@window visible


