
--- これは何？
 タイピングゲーム用のワードデータを指定したエクセルから生成するツールです。

--- 使い方

 １．/src/data/sample_typing_words/word.xls をコピーしてファイル名を変更します。
 ２．１で作成したファイルを開いてワードデータを入力します。
 ３．run.bat/run_cp932.batを開いて..\..\src\data\sample_typing_words\words.odsを１で作成したファイル名に変更します。
 ４．run.bat/run_cp932.batを実行します。

 吉里吉里２用ならば--output-encodingにはcp932を指定してください。
 吉里吉里Z用ならば--output-encodingにはutf-8を指定してください。

 --cf=config.iniは通常は変更する必要はありません。

 出力されたファイルは開発環境にコピーしてスクリプトから
 @load_typing_words storage=ファイル名.dic
 として読み込みます。


--- 情報

 $ruby make.rb -h


