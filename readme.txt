

--- 目次

・目次
・はじめに
・動作環境
・主要なフォルダの説明
・インストールを推奨するソフトウェア
・ライセンス
・連絡先



--- はじめに

このファイルは、このファイルが置かれているフォルダに含まれるコンテンツ、
及びコンテンツの実行／編集／管理に必要な外部依存プログラムについて最低限度の説明を行います。

Avalanches（以下、本開発環境）は複数のソフトウェアによって構築されています。

「インストールを推奨するソフトウェア」は必ずしもインストールする必要はありませんが
特に理由がなければインストールする事をお勧めします。



--- 動作環境

本開発環境は以下の環境での動作を確認しています。

32bit Windows XP(SP3)/Vista/7/10
64bit Windows 7/10/11



--- 主要なフォルダの説明

便宜上このファイルが置かれているフォルダを / と表記します。
例えば '/foo' という表記があった場合、このファイルの置かれているフォルダ内の
'foo' という名前のファイルを指します。
同様に '/foo/bar' という表記であれば 'foo' フォルダの中の
'bar' という名前のファイルを指します。

 /doc/
 ここにマニュアル類があります。

 /dist/
 ここにマスターデータが生成されます。

 /src/
 ソースが収録されています。

 /src/goki2/
 GOKI2のソースがあります。
 /src/goki2/run.bat を実行するとテストスクリプトが起動します。
 /src/goki2/run_krkr2.bat を実行すると吉里吉里２が起動します。
 自動検索パスを追加する場合は krkr_autopath.ary に行を追加してください。

 /tools/
 ツール類はすべてここに収録されています。

 /tools/game_editor/
 SLG用のエディタです。
 アイテムやキャラクタの編集ができます。

 /tools/convgs/
 シナリオテキストをスクリプトに変換するコンバータです。

 /tools/make/
 マスターデータ作成ツールです。

 /tools/make_roman_table/
 タイピングゲーム用のローマ字対応表作成ツールです。

 /tools/make_word/
 タイピングゲーム用のワードデータ作成ツールです。



--- インストールを推奨するソフトウェア


>>--------------------------------------
>> TortoiseGit
>>
>> 本開発環境を取得するために使います。
>>
>> https://tortoisegit.org/


>>--------------------------------------
>> TortoiseSVN
>>
>> あると便利です。
>> パッチ作成にSubversionのログを読み込むので
>> パッチを作成したいならインストールをおすすめします。
>>
>>
>> ・TortoiseSVN（英語）
>>   https://tortoisesvn.net/
>>
>> ・TortoiseSVN（日本語）
>>   https://ja.osdn.net/projects/tortoisesvn/


>>--------------------------------------
>> Subversion client
>>
>> パッチを作成するときに必要になります。
>> パッチを作成しないならば必要ありません。
>>
>> ・SLIKSVN
>>   https://sliksvn.com/download/


>>--------------------------------------
>> Office application
>>
>> 一部のデータ入力、データ生成に必要になります。
>> 必要がなければインストールする必要はありません。
>>
>> ・【有料】Microsoft Office Suite
>>   有料です。
>>   特に、一部のデータ入力に *.xls/*.xlsx を利用しているため Excel が必要になります。
>>
>>
>> ・Apache OpenOffice
>>   http://www.openoffice.org/ja/
>>
>>   同じく *.xls/*.xlsx の入出力に利用するため Calc が必要になります。
>>   ただし、2012/10/28 現在 *.xlsx の出力ができないようです。
>>   読み込みはできるのでデータ生成のみの用途であればこれだけで十分です。
>>
>>   version 4.1.2 で動作を確認しました。
>>
>>
>> ・LibreOffice
>>   http://ja.libreoffice.org/
>>
>>   同じく *.xls/*.xlsx の入出力に利用するため Calc が必要になります。
>>
>>   動作するとは思いますが、動作確認はされていません。
>>   そのため、非推奨とします。


>>--------------------------------------
>> Ruby
>>
>> .rb ファイルの実行に必要になります。
>> ツール類を実行するために必要になりますが、
>> ツール類を使わないなら必要ありません。
>>
>> ・Ruby
>>   http://www.ruby-lang.org/ja/
>>
>>   version 2.2.3 で開発されました。
>>
>>   version 3.0.1 で動作確認しました。
>>   version 3.2.2 で動作確認しました。


>>--------------------------------------
>> NSIS
>>
>> インストーラの作成に必要になります。
>> インストーラを作成しないなら必要ありません。
>>
>> ・NSIS
>>   https://nsis.sourceforge.io/Download
>>
>>   version 3.06.1 で動作確認しました。
>>   version 3.08 で動作確認しました。



--- ライセンス
ライセンスは吉里吉里２と同じです。



--- 連絡先
mailto:halosuke@gmail.com

http://halo.doorblog.jp/



