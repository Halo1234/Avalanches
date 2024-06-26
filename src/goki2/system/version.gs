
; NOTE: パッチなどのリリース時にはこのファイルを書きかえてアーカイブに含める事をお勧めします。

; ◆ゲームバージョン
;
; バージョンの付け方は個人の自由です。
; ただし、管理できなければ意味はありませんので計画的に利用してください。
;
; GOKI2 のバージョン表記は 'TITLE X.Y [special string]' という形式を採用しています。
;
; 例：
;  @version title='GOKI2' major=1 minor=0 special='Sample application'
;
; バージョン表示：
;  'GOKI2: version 1.0 [Sample application]'
;
@version title='Test' major=1 minor=0 special='Sample application.'

; システム変数読み込み
; ModBookmarkが読み込まれていない場合エラーとなる
; コメントアウトで対応すること
@load_system_variables

; イニシャライザ呼び出し
@update_initializer

; ◆二重起動防止
;
; このタグを処理した時点で同じアプリケーションが起動していれば
; その旨をユーザーに報告して、後から起動されたゲームは終了します。
@single


