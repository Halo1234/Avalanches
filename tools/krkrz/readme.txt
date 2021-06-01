吉里吉里Z 1.4.0


【吉里吉里Zについて】
吉里吉里Zは2Dゲームやアプリケーションを作ることのできる開発/実行環境です。


【ダウンロードページ】
http://krkrz.github.io/


【ヘルプ】
詳細なドキュメントについては、上記ページの各種オンラインヘルプを参照してください。
各種ヘルプは以下のページになります。

吉里吉里Zリファレンス
http://krkrz.github.io/docs/kirikiriz/j/contents/index.html

TJS2 リファレンス
http://krkrz.github.io/docs/tjs2/j/contents/index.html

吉里吉里Zでの吉里吉里2からの変更点一覧
http://krkrz.github.io/updatefromkr2.html

リリーサー等のツールは吉里吉里2のものを使用してください。以下からダウンロードできます。
http://krkrz.github.io/download/kr2_232r2.zip


【ノベルゲームを作るには】
http://krkrz.github.io/ から「KAG for 吉里吉里Z」をダウンロードして、展開した中にある data フォルダを tvpwin32/tvpwin64.exe と同じフォルダに置きます。
KAG3 の使い方は、以下のページにあります。
https://krkrz.github.io/krkr2doc/kag3doc/contents/index.html
KAG3 にセーブロード画面やコンフィグ画面などほ加えた「鱧入りKAG3 for 吉里吉里Z」もあります。
こちらの方が最初は手軽かもしれません。
基本的な使い方は同じです。


【ファイル】
\imageviewer        : 簡易的なイメージビューアです。tvpwin32/tvpwin64.exe にこのフォルダを D&D すると起動できます。
\movieplayer        : 簡易的な動画プレイヤーです。tvpwin32/tvpwin64.exe にこのフォルダを D&D すると起動できます。
\plugin             : 各種プラグインが入っています。
\plugin64           : 各種プラグインの64bit版が入っています。
debugger.sdp        : デバッガの設定ファイルです。
krkrdebg.exe        : デバッガ本体です。
krkrdegb_readme.txt : デバッガの説明です。
license.txt         : ライセンス文が記述されたテキストファイルです。
readme.txt          : 本ファイルです。簡単な説明を記載しています。
tvpwin32.exe        : 吉里吉里Z本体です。
tvpwin32_dbg.exe    : デバッガ機能を有効化してビルドした吉里吉里Z本体です。
tvpwin64.exe        : 吉里吉里Z本体の64bit版です。


【吉里吉里2 の TJS2スクリプトの動作について】
吉里吉里Z は吉里吉里2 と完全互換ではないため、吉里吉里2 の TJS2スクリプトを動かすにはいくつか変更が必要です。

吉里吉里Z では標準の文字コードがUTF-8に変更されています。
旧スクリプトをそのまま動かす場合は、コマンドラインで -readencoding=Shift_JIS の追加が必要です。

組み込み機能であった KAGParser とメニューはプラグイン化されています。
KAGParser とメニュークラスが必要であれば KAGParser.dll と menu.dll をリンクする必要があります。

マルチタッチをサポートするデバイスが有効な端末ではタッチが有効になります。
( onMouseDown ではなく onTouchDown が届くと言うような動作となる )
タッチ処理を行わない場合は、従来のマウス処理でハンドリング出来るように無効化する必要があります。
無効化するには Window.enableTouch を false にします。

PassThroughDrawDevice は削除されているので、使用している箇所は書き換えが必要です。

その他削除されたメソッド等を使用している場合は、それらの処理を書き換える必要があります。

より詳細な変更点については上記「吉里吉里Zでの吉里吉里2からの変更点一覧」ページを参照してください。


【更新履歴】
2017/12/25 1.4.0.8
2016/08/10 1.3.3.7
2016/08/01 1.3.2.6
2016/06/03 1.3.1.5
2016/05/31 1.3.0.4
2015/08/17 1.2.0.3
2014/08/03 1.1.0.2
2013/12/31 1.0.0.1 リリース

詳細は履歴ページ参照してください。
http://krkrz.github.io/olderversions.html

