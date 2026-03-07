[English readme is here](./readme.en.md)

## これは何？
シナリオテキストをスクリプトファイルに変換するためのプログラムです。  
事前に決められたフォーマットでシナリオを作成しておけば  
あとはこのツールでスクリプトファイルに変換できます。  


## 使い方
 １．このフォルダに作業フォルダを作成して名前を分かりやすいものに変更します。（ここでは***MyGame***とします）  
 ２．シナリオテキストを***MyGame***フォルダにコピーします。  
 ３．config.iniを編集します。説明はconfig.iniに書いてあります。  
 ４．sample.bat をコピーして分かりやすい名前を付けます。（ここでは***MyGame.bat***とします）  
 ５．***MyGame.bat*** ファイルをエディタで開きます。  
 ６．***MyGame.bat*** ファイルの内容で ***sample*** を ***MyGame*** で置換します。  
 ７．吉里吉里Z用または吉里吉里２用の変換実行コマンドを指定します。  

```bat:MyGame.bat
     @rem 吉里吉里Zの場合はこちらを利用してください。
     ruby convgs.rb .\conv_MyGame.list --o=.\output_MyGame --input-encoding=cp932 --output-encoding=UTF-8 -v
     @rem 吉里吉里２の場合はこちらを利用してください。
     @rem ruby convgs.rb .\conv_MyGame.list --o=.\output_MyGame --input-encoding=cp932 -v
```

 ８．編集内容を保存して MyGame.bat を実行します。  


## その他
 出力先を直接開発環境にする事もできますが  
 強制的に上書きする事になるので既に打ち込みが終わっているファイルなどが  
 あった場合は酷い事になると思います。  
 それでも SVN/GIT を利用していれば revert できますが…あまりお勧めはしません。  

 詳しい使い方はヘルプを参照してください。  

 $ruby convgs.rb -h  


## 依存関係
 RubyGem inifile >= 2.0.2  

 インストール方法：  
  Windowsキー+Rを押してcmdを入力してエンター  
  コマンドプロンプトに以下を入力（$は含めない）してエンター  
  $gem install inifile  


