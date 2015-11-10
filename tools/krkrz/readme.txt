吉里吉里Z 1.2.0.3


【吉里吉里Zについて】
吉里吉里Zは、吉里吉里2 の VCビルド対応とレガシー機能の削除、モダン機能の追加を目的とした吉里吉里2フォークプロジェクトです。


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


【ファイル】
\plugin				: 各種プラグインが入っています。
debugger.sdp		: デバッガの設定ファイルです。
krkrdebg.exe		: デバッガ本体です。
krkrdegb_readme.txt	: デバッガの説明です。
license.txt			: ライセンス文が記述されたテキストファイルです。
readme.txt			: 本ファイルです。簡単な説明を記載しています。
tvpwin32.exe		: 吉里吉里Z本体です。
tvpwin32_dbg.exe	: デバッガ機能を有効化してビルドした吉里吉里Z本体です。


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
2015/08/17 1.2.0.3
2014/08/03 1.1.0.2
2013/12/31 1.0.0.1 リリース

詳細は履歴ページ参照してください。
http://krkrz.github.io/olderversions.html

