/**
**/



--- 目次

 ・目次
 ・このフォルダの説明
 ・install/master/update フォルダ内での特殊なファイル名について


--- このフォルダの説明

このフォルダ内に make ツールのターゲットを作成する事ができます。
ターゲットフォルダの内容は以下のような仕様になります。

 +--+ [target-name]
    +---+ [header-images]
    +   +---+ page_header_l.bmp
    +   +---+ page_header_r.bmp
    +   +---+ side_banner.bmp
    +   +---+ unpage_header_l.bmp
    +   +---+ unpage_header_r.bmp
    +   +---+ unside_banner.bmp
    +
    +---+ [icons]
    +   +---+ installer.ico
    +   +---+ uninstaller.ico
    +
    +---+ [install]
    +   +---+ 任意
    +
    +---+ [key]
    +   +---+ priv
    +   +---+ pub
    +
    +---+ [master]
    +   +---+ 任意
    +
    +---+ [update]
    +   +---+ 任意
    +
    +---+ override.ini

target-name は /tools/make/make.rb への引数になります。
詳しくは /tools/make/readme.txt を参照してください。

header-images フォルダにはインストーラ／アンインストーラで利用するヘッダ画像や
 バナー画像などを配置します。

icons フォルダにはインストーラ／アンインストーラ等のためのアイコンを配置します。

install フォルダには追加でインストールさせたいバイナリデータを配置します。
 このフォルダの内容はサブフォルダも含めて全てそのままインストールされます。

key フォルダには署名用のキーファイルを配置します。

master フォルダにはマスターデータに追加で収録させたいバイナリを配置します。
 このフォルダの内容はサブフォルダも含めて全てそのままマスターデータに含まれる事になります。

update フォルダにはアップデートプログラムに追加で収録させたいバイナリデータ等を配置します。
 このフォルダの内容はサブフォルダも含めて全てそのままアップデートプログラムに含まれる事になります。

override.ini は /tools/make/config.ini の各項目をオーバーライドします。
 詳しくは /tools/make.config.sample.ini の各項目の説明を参照してください。


--- install/master/update フォルダ内での特殊なファイル名について

これらのフォルダ内では、いくつかの特別な意味を持つファイル名があります。

 [readme.txt]
  make ツールはこのファイルに対して単純なテキスト置換処理を行います。
  置換されるテキストの構文は以下の通りです。

  #{SECTION-NAME.VALUE-NAME}

  SECTION-NAME は config.ini または override.ini で定義されているセクション名です。
  VALUE-NAME は config.ini または override.ini で定義されている値の名前です。
  readme.txt 内の該当するテキストは該当する値で置き換えられます。

  また、以下の値は config.ini または override.ini で定義されない組み込みの値で置換されます。

   #{UPDATEINFO.log}
    config.ini または override.ini で定義されている UPDATE1 ～ UPDATAn までの log 値の内
    パッケージ化時に指定された範囲の log 値の集合です。

    例えば、override.ini で UPDATA1 ～ UPDATA5 までが定義されていて、
    かつ UPDATA1 ～ UPDATA3 までをパッケージ化した場合。
    #{UPDATAINFO.log} は UPDATA1 ～ UPDATA3 までの log 値を結合したテキストで置換されます。

 [krkr.*]
  ファイル名の krkr の部分がターゲット名で置き換えられます。
  ファイル名の一部に krkr が含まれている場合は何も行いません。
  つまり krkrHoge.exe というファイルは krkrHoge.exe のままになります。
 


