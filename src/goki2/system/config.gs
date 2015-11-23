;/*
; * $Revision: 288 $
;**/


; ◆スクリプトキュー
;
; storage: 追加したいスクリプトファイル名です。
;
@que storage=testcase


; ◆改行の扱い方
;
; ignore: 改行コードを r タグとして扱うかどうか
@cr_handling ignore


; ◆ウインドウの設定
;
;                caption: ウインドウのタイトルバーに表示する文字列です。
;                  width: ウインドウの幅です。（正確にはクライアント領域の幅です）
;                 height: ウインドウの高さです。（正確にはクライアント領域の高さです）
; fix-position-to-center: 指定するとウインドウ初期位置がデスクトップ中央に設定されます。
;              alt-enter: 指定すると Alt+Enter でスクリーンモードを切り替える事ができるようになります。
;                visible: 指定するとウインドウを表示します。
;
@window width=800 height=600 fix_position_to_center alt_enter


; ◆初期化ウェイト
@wait time=400 !skip !click


; ◆各モジュール設定
;
; 読み込んだモジュールの設定が必要であればここで行ってください。
; モジュールの設定については各モジュールの説明を参照してください。
;
; ココから

; 前景レイヤの数
@cv_layers count=1

; メッセージレイヤの数
@message_layers count=1

; 効果音バッファの数
@se_buffers count=1

; ボイスバッファの数
@voice_buffers count=1

; ビデオバッファの数
@video_buffers count=1

; メッセージ履歴設定
@history_option storage=HistoryBack margin_left=10 margin_top=10 margin_right=10 margin_bottom=10

; メッセージレイヤ設定
@message_option layer=message0 left=10 top=400 width=780 height=190 margin_left=10 margin_top=10 margin_right=10 margin_bottom=10 opacity=128 color=0x000000 shadow_color=0xFFFF0000 current

; BGMバッファ追加
@add_bgm_buffer type=WAVE

; キャラクター定義
;
; タグ名が ! で始まるタグはタグの設定を行う特殊なタグになります。
; これはすべてのタグに対して有効な設定です。
;
; 属性名=名前->値 の形式で置換を行う事ができます。
; この指定はタグの属性名に「名前」が現れた時に 属性名=値 に置換されます。
;
; 例：
;  @!make_character image=立ち絵有り->true
;   ^ ! マークが「有る」事に注意
;  ;
;  ; これは image=true に置換されます。
;  @make_character name=ハロ 立ち絵有り
;   ^ ! マークが「無い」事に注意
;
; さらに置換はカンマで区切って複数同時に指定する事もできます。
;
; 例：
;  @!make_character image=立ち絵有り->true,立ち絵無し->true
;
; /で始まる属性にはパターンを設定できます。
; <VALUE> で囲まれた値はその属性値で置換されます。
; またパターン中のすべての値が指定されていない限りパターンは生成されません。
;
; 例：
;  @!ハロ /storage=A_<POSE>_<FACE>
;         ^ / が「有る」事に注意
;  ;
;  ; これは storage=A_ポーズ１_表情１ に置換されます。
;  @ハロ pose=ポーズ１ face=表情１
;  ;
;  ; さらに置換を設定する事もできます。
;  @!ハロ pose=ポーズ１->pose1 face=表情１->face1
;  ;
;  ; これは storage=A_pose1_face1 に置換されます。
;  @ハロ ポーズ１ 表情１
;
@!make_character image=立ち絵有り->true,立ち絵無し->false
@!make_character voice=ボイス有り->true,ボイス無し->false

; キャラクター作成
@make_character name=地文 actual_viewing_name_string=''
@make_character name=ハロ voice_group=halo 立ち絵有り ボイス有り

; character タグはすべてのキャラクタタグの実体です。
; このタグに対して設定するとすべてのキャラクタタグに適応されます。
;
; 例：
;  @!character gray_scale=セピア->true r_gamma=セピア->1.5 g_gamma=セピア->1.3
;   ^ ! マークに注意
;  ;
;  ; これは gray_scale=true r_gamma=1.5 g_gamma=1.3 に置換されます。
;  @ハロ セピア
;  ;
;  ; これも同様に置換されます。
;  @地文 セピア
@!character centerx=左->200,中->400,右->600,中左->300,中右->500,左端->100,右端->700
@!character gray_scale=セピア->true r_gamma=セピア->1.5 g_gamma=セピア->1.3
@!character visible=表示->true,消去->false
@!character no_voice=nv->true

; サンプルキャラクター設定
@!ハロ /storage=A_<POSE>_<FACE>
@!ハロ face=表情１->face1
@!ハロ pose=ポーズ１->pose1,ポーズ２->pose2

; 改行コードを無視するかどうか
@cr_handling !ignore

; ココまで


; ◆バージョン情報
;
; message: プリセット名、または任意の文字列を指定します。
;
@notice message=version
@notice message=システム初期化完了しました。


; ◆ウインドウの表示
;
; これで全ての設定が終わったのでウインドウを表示する。
;
@window visible


