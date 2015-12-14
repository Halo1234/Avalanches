
; ◆スクリプトキュー
;
; storage: 追加したいスクリプトファイル名です。
;
@que storage=KAGCompatible,first


; ◆改行の扱い方
;
; ignore: false を指定すると改行コードを r タグとして扱います。
@cr_handling ignore


; ◆ウインドウの設定
;
;                caption: ウインドウのタイトルバーに表示する文字列です。
;                  width: ウインドウの幅です。（正確にはクライアント領域の幅です）
;                 height: ウインドウの高さです。（正確にはクライアント領域の高さです）
; fix_position_to_center: 指定するとウインドウ初期位置がデスクトップ中央に設定されます。
;              alt_enter: 指定すると Alt+Enter でスクリーンモードを切り替える事ができるようになります。
;                visible: 指定するとウインドウを表示します。
;
@window width=800 height=600 fix_position_to_center alt_enter


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
@history_option width=800 height=600 margin_left=18 margin_top=18 margin_right=18 margin_bottom=18 color=0x000000

; メッセージレイヤ設定
@message_option layer=message0 left=10 top=400 width=780 height=190 margin_left=10 margin_top=10 margin_right=10 margin_bottom=10 opacity=128 color=0x000000 shadow_color=0xFFFF0000 current

; BGMバッファ追加
@add_bgm_buffer type=WAVE

; キャラクター定義
;
; タグ名が ! で始まるタグはタグの拡張構文設定を行う特殊なタグになります。
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
;  @!make_character image=立ち絵有り->true,立ち絵無し->false
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

@redirect alias=mob name=make_character
@!mob /mob=true

; キャラクター作成
;
;                 name: キャラクター名を指定します。
;                       ここで指定した名前がそのままタグ名になります。
;                  mob: true を指定すると１つのスクリプトファイル内でのみ有効なキャラクターを作成します。
;           auto_voice: 自動ボイス再生を行う場合に true を指定します。
; voice_storage_format: ボイスファイルのフォーマットを指定します。
;                       これは一つの番号を引数として受け取る sprintf() の引数です。
;                       例： halo_voice_%03d
;                       デフォルトでは「名前%03d」です。（名前は name で指定した文字列）
;                image: 立ち絵などのグラフィックを持つ場合に true を指定します。
;                voice: ボイスを持つ場合に true を指定します。
@make_character name=地文
@make_character name=ハロ 立ち絵有り ボイス有り

; character タグはすべてのキャラクタタグの実体です。
; このタグに対して拡張構文を設定するとすべてのキャラクタタグに適応されます。
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
;
; character タグの仕様
;
;      storage: 画像ファイル名を指定します。
;          key: 画像のキー値を指定します。
;  asd_storage: ASDファイル名を指定します。
;   gray_scale: true を指定するとグレイスケール化します。
;      r_gamma: Gamma値を指定します。
;      g_gamma: Gamma値を指定します。
;      b_gamma: Gamma値を指定します。
;      r_floor: Floor値を指定します。
;      g_floor: Floor値を指定します。
;      b_floor: Floor値を指定します。
;       r_ceil: Ceil値を指定します。
;       g_ceil: Ceil値を指定します。
;       b_ceil: Ceil値を指定します。
;       mcolor: ブレンドする色を指定します。
;     mopacity: ブレンドする色の不透明度を指定します。
;         mode: 透過モードを指定します。
;      flip_ud: true を指定すると上下を入れ替えます。
;      flip_lr: true を指定すると左右を入れ替えます。
;    clip_left: 画像のクリッピング座標を指定します。
;     clip_top: 画像のクリッピング座標を指定します。
;   clip_width: 画像のクリッピング座標を指定します。
;  clip_height: 画像のクリッピング座標を指定します。
;     center_x: 画像中心位置のX座標値です。
;     center_y: 画像中心位置のY座標値です。
;         left: 画像の左上隅表示位置を指定します。
;          top: 画像の左上隅表示位置を指定します。
;        right: 画像の右下隅表示位置を指定します。
;       bottom: 画像の右下隅表示位置を指定します。
;      opacity: 画像の不透明度を指定します。
;        index: 画像の重ね合わせ順序を指定します。
;        voice: true を指定するとボイスを再生します。何も指定しなければ true とみなします。
; voice_number: ボイス番号を指定します。何も指定しなければ自動で割り当てられます。
;         time: トランジションの時間を指定します。何も指定しなければ 200 になります。
;        vague: トランジションの曖昧値を指定します。何も指定しなければ 128 になります。
;       method: トランジションのタイプを指定します。何も指定しなければ他の値から推測されます。    
;         from: スクロールトランジションの引数です。left, top, right, bottom のいずれかを指定します。
;         stay: スクロールトランジションの引数です。stayfore, stayback, nostay のいずれかを指定します。
;         rule: ルール画像を指定します。
;     children: トランジションの対象に子レイヤも含めるかどうかを指定します。何も指定しなければ true になります。
@!character center_x=左->200,中->400,右->600,中左->300,中右->500,左端->100,右端->700
@!character gray_scale=セピア->true r_gamma=セピア->1.5 g_gamma=セピア->1.3
@!character visible=表示->true,消去->false
@!character no_voice=nv->true

; サンプルキャラクター設定
;
; タグの仕様は character タグと同じです。
@!ハロ /storage=A_<POSE>_<FACE>
@!ハロ face=表情１->face1
@!ハロ pose=ポーズ１->pose1,ポーズ２->pose2

; 時間帯を定義します。
;
;   name: 時間帯名を指定します。ここで指定した名前がそのままタグになります。
; suffix: 立ち絵のファイル名などの末尾につける文字列を指定します。
@make_time_zone name=朝 suffix=''
@make_time_zone name=夕 suffix=ev
@make_time_zone name=夜 suffix=ng

; サンプル背景
;
;    name: 名前を指定します。この名前がそのままタグ名になります。
; storage: 背景として読み込むファイル名を指定します。
@make_stage name=白 storage=白
@make_stage name=黒 storage=黒
@make_stage name=赤 storage=赤

; ココまで


; ◆初期化ウェイト
@wait time=400 !skip !click


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


