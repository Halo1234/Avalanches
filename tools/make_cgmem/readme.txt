
--- これは何？
 CG/回想画面で利用するデータを生成します。

--- 使い方

 １．/src/data/cgmemory/list.xlsx をコピーしてファイル名を変更します。
 ２．１で作成したファイルを開いてCG/回想のデータを入力します。（シート名が出力ファイル名になります）
     入力データは拡張子を含めないでください。
 ３．run.batまたはrun_cp932.batを開いて..\..\src\data\cgmemory\list.xlsxを１で作成したファイル名に変更します。
 ４．run.batまたはrun_cp932.batを実行します。

 吉里吉里２用ならば--output-encodingにはcp932を指定してください。
 吉里吉里Z用ならば--output-encodingにはutf-8を指定してください。

 --cf=config.iniは通常は変更する必要はありません。

 出力されたファイルは開発環境にコピーしてスクリプトから
 @load_cgmemory storage=ファイル名.dic
 として読み込みます。


--- 情報

 $ruby make.rb -h


