
--- これは何？
シナリオテキストをスクリプトファイルに変換するためのプログラムです。
事前に決められたフォーマットでシナリオを作成しておけば
あとはこのツールでスクリプトファイルに変換できます。


--- 使い方
 １．このフォルダに作業フォルダを作成します。
 ２．シナリオテキストを作業フォルダにコピーします。
 ３．config.iniを編集します。説明はconfig.iniに書いてあります。
 ４．sample.bat をコピーします。
 ５．コピーした .bat ファイルをエディタで開きます。
 ６．.bat ファイルの内容で sample となっている個所を１．で作成したフォルダ名に変更します。
 ７．吉里吉里Z用または吉里吉里２用の変換実行コマンドを指定します。

     @rem 吉里吉里Zの場合はこちらを利用してください。
     ruby convks.rb .\conv_sample.list --o=.\output_sample --input-encoding=cp932 --output-encoding=UTF-8 -v
     @rem 吉里吉里２の場合はこちらを利用してください。
     @rem ruby convks.rb .\conv_sample.list --o=.\output_sample --input-encoding=cp932 -v

 ８．コピーした .bat ファイルを実行します。


--- その他
 出力先を直接開発環境にする事もできますが
 強制的に上書きする事になるので既に打ち込みが終わっているファイルなどが
 あった場合は酷い事になると思います。
 それでも SVN/GIT を利用していれば revert できますが…あまりお勧めはしません。

 詳しい使い方はヘルプを参照してください。

 $ruby convks.rb -h


--- 依存関係
 RubyGem inifile >= 2.0.2

 インストール方法：
  $gem install inifile


