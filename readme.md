# Avalanches

[English readme is here](./readme.en.md)

![GitHub total downloads](https://img.shields.io/github/downloads/Halo1234/Avalanches/total?style=flat-square&color=brightgreen)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/Halo1234/Avalanches?style=flat-square)

Avalanchesは吉里吉里2 / 吉里吉里Zをベースとした、ゲーム開発・運用を強力にサポートする統合開発環境です。SLGエディタ、シナリオコンバータ、タイピングゲーム用ツールなど、実践的なツール群を同梱しています。
Avalanchesにはサポートする各ゲームのフレームワークとしてGOKI2が含まれます。
GOKI2を使ってすぐにゲーム開発を始めたい方は、[こちらのリンク](https://github.com/Halo1234/Avalanches/releases/latest):rocket:から最新のパッケージをダウンロードしてください。

[最新リリースをチェックする](https://github.com/Halo1234/Avalanches/releases/latest)

---

## 目次
* [はじめに](#はじめに)
* [動作環境](#動作環境)
* [ディレクトリ構造](#ディレクトリ構造)
* [推奨ソフトウェア](#推奨ソフトウェア)
* [ライセンス](#ライセンス)
* [連絡先](#連絡先)

---

## はじめに
本開発環境は複数のソフトウェアによって構築されています。
`/tools/` 内の各ツールを活用することで、ゲームのデータ作成やコンバート作業を効率化できます。「推奨ソフトウェア」は必須ではありませんが、フル機能を活用するためにインストールをお勧めします。

---

## 動作環境
* **OS:** Windows 11 (64bit) 動作確認済み

---

## ディレクトリ構造

| パス | 説明 |
| :--- | :--- |
| `/doc/` | マニュアル・ドキュメント類 |
| `/dist/` | 生成されたマスターデータの出力先 |
| `/src/` | ソースコード一式 |
| `/src/goki2/` | GOKI2（吉里吉里2/吉里吉里Zベース）のテスト・実行環境。`run.bat` でテスト起動。 |
| `/tools/` | **各種ツール群（詳細は以下）** |

### 収録ツール一覧
* **`game_editor`**: SLG用エディタ（アイテム・キャラ編集）
* **`convgs`**: シナリオテキスト → スクリプト変換
* **`make`**: マスターデータ作成
* **`make_roman_table`**: タイピングゲーム用ローマ字対応表作成
* **`make_word`**: タイピングゲーム用ワードデータ作成
* **`make_cgmem`**: CG回想用データ生成

---

## 推奨ソフトウェア

開発を円滑に進めるために、用途に合わせて以下のツールの導入を推奨します。

### 必須級（開発・管理）
* **[TortoiseGit](https://tortoisegit.org/)**: リポジトリの取得・管理
* **[Ruby](http://www.ruby-lang.org/ja/)**: ツール群（.rb）の実行に必要 (v4.0.1 動作確認済)

### パッチ・インストーラ作成
* **[TortoiseSVN](https://tortoisesvn.net/)**: パッチ作成時のログ読み込み用
* **[SlikSVN](https://sliksvn.com/download/)**: パッチ作成時のクライアントとして必要
* **[NSIS](https://nsis.sourceforge.io/Download)**: インストーラ作成用 (v3.11 動作確認済)

### データ入力（Excel互換ソフト）
* **Microsoft Office (Excel)**: `*.xls/xlsx` 形式のデータ入力に推奨
* **[Apache OpenOffice](http://www.openoffice.org/ja/)**: Calcにて代用可能 (v4.1.2 動作確認済)
* **[LibreOffice](http://ja.libreoffice.org/)**: 動作すると思われますが、非推奨（動作未確認）

---

## ライセンス
MITライセンス

Copyright (c) 2026 HALO

本ソフトウェアおよび関連ドキュメントのコピーを取得するすべての人に対し、本ソフトウェアを無償で制限なく使用、複製、変更、結合、出版、配布、サブライセンス、および/または販売する権利を許諾します。また、本ソフトウェアを提供された人物に対し、以下の条件に従ってこれを行うことを許可します。

上記の著作権表示および本許諾表示を、本ソフトウェアのすべてのコピーまたは重要な部分に記載するものとします。

本ソフトウェアは「現状のまま」提供され、明示的か黙示的かを問わず、商品性、特定の目的への適合性、および非侵害性に関する保証を含め、いかなる種類の保証も行いません。作者または著作権保持者は、本ソフトウェアの使用、あるいはその他の取り扱いによって生じる、契約上の行為、不法行為、またはその他の理由によるいかなる請求、損害、またはその他の責任に対しても、一切の責任を負いません。

---

## 連絡先
* **Email:** [halosuke@gmail.com](mailto:halosuke@gmail.com)
* **Blog:** [http://halo.doorblog.jp/](http://halo.doorblog.jp/)
* **GitHub:** 不具合報告などは[Issues](https://github.com/Halo1234/Avalanches/issues) まで
