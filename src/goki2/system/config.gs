
; ◆スクリプトキュー
;
; storage: 追加したいスクリプトファイル名です。
;
@que storage=KAGCompatible,testcase


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

; CGレイヤの数
@cg_layers count=1

; メッセージレイヤの数
@message_layers count=2

; 効果音バッファの数
@se_buffers count=1

; ボイスバッファの数
@voice_buffers count=1

; ビデオバッファの数
@video_buffers count=1

; メッセージ履歴設定
@history_option width=800 height=600 slider_storage=sample_slider/sample_slider_button margin_left=50 margin_top=18 margin_right=18 margin_bottom=18 color=0x000000 caption_color=0xFFFFFF shadow_color=0x808080

; メッセージレイヤ設定
@message_option layer=message0 left=10 top=400 width=780 height=190 margin_left=10 margin_top=10 margin_right=10 margin_bottom=10 opacity=128 color=0xFF0000 caption_color=0xFFFFFF shadow_color=0xFF0000 current
@message_option layer=message1 left=10 top=200 width=780 height=190 margin_left=10 margin_top=10 margin_right=10 margin_bottom=10 opacity=128 color=0xFF0000 caption_color=0xFFFFFF shadow_color=0xFF0000

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
;                     name: キャラクター名を指定します。
;                           ここで指定した名前がそのままタグ名になります。
;                      mob: true を指定すると１つのスクリプトファイル内でのみ有効なキャラクターを作成します。
;               auto_voice: 自動ボイス再生を行う場合に true を指定します。
;     voice_storage_format: ボイスファイルのフォーマットを指定します。
;                           これは一つの番号を引数として受け取る sprintf() の引数です。
;                           例： halo_voice_%03d
;                           デフォルトでは「名前%03d」です。（名前は name で指定した文字列）
;                    image: 立ち絵などのグラフィックを持つ場合に true を指定します。
;                    voice: ボイスを持つ場合に true を指定します。
;       sub_directory_name: 立ち絵をサブディレクトリに配置した場合に配置した親ディレクトリの名前を指定します。
;   part_of_directory_path: 立ち絵をサブディレクトリに配置した場合に配置したサブディレクトリの名前を指定します。
;                           例えば、fgimage/A/pose1_face1.pngとした場合
;                           sub_direcotry_nameにはfgimageを指定して、
;                           part_of_directory_pathにはAを指定します。
; voice_sub_directory_name: ボイスをサブディレクトリに配置した場合に配置した親ディレクトリの名前を指定します。
;                           立ち絵でいうpart_of_directory_pathに相当する部分にはシナリオファイル名（拡張子無し）が自動的に指定されます。
;                           例えば、sound/Scenario001/ハロ000.oggとした場合
;                           voice_sub_directory_nameにはsoundを指定して
;                           Scenario001.gsを実行中はハロのボイスは
;                           sound/Scenario001/ハロ000.oggを再生します。
[if exp="global.productInfo.language == 'jp'"]
@make_character name=地文
@make_character name=ハロ 立ち絵有り ボイス有り
@make_character name=ハロ sub_directory_name=images part_of_directory_path=A
@make_character name=ハロ voice_sub_directory_name=testcase
@make_character name=ハロ shadow_color=0x808080 edge_color=0xFF0000
@make_character name=ハロ history_shadow_color=0x808080 history_edge_color=0xFF0000
@make_character name=ハロ history_icon=history_icon_ハロ history_icon_left=18

@make_character name=ハロ助 立ち絵有り ボイス有り
@make_character name=ハロ助 sub_directory_name=images part_of_directory_path=B
@make_character name=ハロ助 voice_sub_directory_name=testcase
@make_character name=ハロ助 shadow_color=0x808080 edge_color=0x0000FF
@make_character name=ハロ助 history_shadow_color=0x808080 history_edge_color=0x0000FF
@make_character name=ハロ助 history_icon=history_icon_ハロ助 history_icon_left=18
[elsif exp="global.productInfo.language == 'en'"]
@make_character name=text
@make_character name=halo 立ち絵有り ボイス有り
@make_character name=halo sub_directory_name=images part_of_directory_path=A
@make_character name=halo voice_sub_directory_name=testcase
@make_character name=halo shadow_color=0x808080 edge_color=0xFF0000
@make_character name=halo history_shadow_color=0x808080 history_edge_color=0xFF0000
@make_character name=halo history_icon=history_icon_ハロ history_icon_left=18

@make_character name=halosuke 立ち絵有り ボイス有り
@make_character name=halosuke sub_directory_name=images part_of_directory_path=B
@make_character name=halosuke voice_sub_directory_name=testcase
@make_character name=halosuke shadow_color=0x808080 edge_color=0x0000FF
@make_character name=halosuke history_shadow_color=0x808080 history_edge_color=0x0000FF
@make_character name=halosuke history_icon=history_icon_ハロ助 history_icon_left=18
[endif]

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
;       target: セルアニメーションを行うためのasdファイルのラベル名を指定します。

; サンプルキャラクター設定
;
; タグの仕様は character タグと同じです。
[if exp="global.productInfo.language == 'jp'"]
@!character center_x=左->200,中->400,右->600,中左->300,中右->500,左端->100,右端->700
@!character gray_scale=セピア->true r_gamma=セピア->1.5 g_gamma=セピア->1.3
@!character visible=表示->true,消去->false
@!character no_voice=nv->true

@!ハロ /storage=A_<POSE>_<FACE>
@!ハロ face=表情１->face1
@!ハロ target=ポーズ１->*target
@!ハロ pose=ポーズ１->pose1,ポーズ２->pose2

@!ハロ助 /storage=B_<POSE>_<FACE>
@!ハロ助 face=表情１->face1
@!ハロ助 target=ポーズ１->*target
@!ハロ助 pose=ポーズ１->pose1,ポーズ２->pose2
[elsif exp="global.productInfo.language == 'en'"]
@!character center_x=l->200,c->400,r->600,cl->300,cr->500,le->100,re->700
@!character gray_scale=sepia->true r_gamma=sepia->1.5 g_gamma=sepia->1.3
@!character visible=v->true,inv->false
@!character no_voice=nv->true

@!halo /storage=A_<POSE>_<FACE>
@!halo face=face1
@!halo target=*target
@!halo pose=pose1,pose2

@!halosuke /storage=B_<POSE>_<FACE>
@!halosuke face=face1
@!halosuke target=*target
@!halosuke pose=pose1,pose2
[endif]

; 時間帯を定義します。
;
;   name: 時間帯名を指定します。ここで指定した名前がそのままタグになります。
; suffix: 立ち絵のファイル名などの末尾につける文字列を指定します。
[if exp="global.productInfo.language == 'jp'"]
@make_time_zone name=朝 suffix=''
@make_time_zone name=夕 suffix=ev
@make_time_zone name=夜 suffix=ng
[elsif exp="global.productInfo.language == 'en'"]
@make_time_zone name=morning suffix=''
@make_time_zone name=evening suffix=ev
@make_time_zone name=night suffix=ng
[endif]

; サンプル背景
;
;    name: 名前を指定します。この名前がそのままタグ名になります。
; storage: 背景として読み込むファイル名を指定します。
[if exp="global.productInfo.language == 'jp'"]
@make_stage name=白 storage=白
@make_stage name=黒 storage=黒
@make_stage name=赤 storage=赤

; システム画面
@system_option page_left=0 page_top=30 page_width=800 page_height=570 click_sound=se001.ogg enter_sound=se002.ogg
@system page=0 page_tab_caption=システム page_tab_left=0 page_tab_top=0
@system page=0 skip_key_left=10 skip_key_top=10 skip_key_caption="スキップキー" skip_key_conf_left=130 skip_key_conf_top=10 skip_key_conf_width=60 skip_key_conf_height=20 skip_key_conf_color=0xFF0000
@system page=0 not_read_skip_key_left=10 not_read_skip_key_top=40 not_read_skip_key_caption="既読スキップキー" not_read_skip_key_conf_left=130 not_read_skip_key_conf_top=40 not_read_skip_key_conf_width=60 not_read_skip_key_conf_height=20 not_read_skip_key_conf_color=0xFF0000
@system page=0 auto_mode_key_left=10 auto_mode_key_top=70 auto_mode_key_caption="オートモードキー" auto_mode_key_conf_left=130 auto_mode_key_conf_top=70 auto_mode_key_conf_width=60 auto_mode_key_conf_height=20 auto_mode_key_conf_color=0xFF0000
@system page=0 enter_key_left=10 enter_key_top=110 enter_key_caption="決定キー" enter_key_conf_left=130 enter_key_conf_top=110 enter_key_conf_width=60 enter_key_conf_height=20 enter_key_conf_color=0xFF0000
@system page=0 cancel_key_left=10 cancel_key_top=150 cancel_key_caption="キャンセルキー" cancel_key_conf_left=130 cancel_key_conf_top=150 cancel_key_conf_width=60 cancel_key_conf_height=20 cancel_key_conf_color=0xFF0000
@system page=0 enter_button_left=10 enter_button_top=190 enter_button_caption="決定キー（PAD）" enter_button_conf_left=130 enter_button_conf_top=190 enter_button_conf_width=60 enter_button_conf_height=20 enter_button_conf_color=0xFF0000
@system page=0 cancel_button_left=10 cancel_button_top=230 cancel_button_caption="キャンセルキー（PAD）" cancel_button_conf_left=130 cancel_button_conf_top=230 cancel_button_conf_width=60 cancel_button_conf_height=20 cancel_button_conf_color=0xFF0000

@system page=0 master_left=400 master_top=10 master_caption="マスターボリューム" master_slider_left=530 master_slider_top=10 master_slider_width=160 master_slider_height=20 master_slider_color=0xFF0000
@system page=0 bgm_left=400 bgm_top=40 bgm_caption="BGMボリューム" bgm_slider_left=530 bgm_slider_top=40 bgm_slider_width=160 bgm_slider_height=20 bgm_slider_color=0xFF0000
@system page=0 se_left=400 se_top=70 se_caption="効果音" se_slider_left=530 se_slider_top=70 se_slider_width=160 se_slider_height=20 se_slider_color=0xFF0000
@system page=0 vo_left=400 vo_top=100 vo_caption="ボイス" vo_slider_left=530 vo_slider_top=100 vo_slider_width=160 vo_slider_height=20 vo_slider_color=0xFF0000

@system page=0 voice1_left=400 voice1_top=130 voice1_caption=ハロのボイス
@system page=0 mob_voice_left=400 mob_voice_top=160 mob_voice_caption=モブのボイス

@system page=0 simple_battle_left=400 simple_battle_top=290 simple_battle_caption="簡易戦闘"

@system page=1 page_tab_caption=メッセージ page_tab_left=80 page_tab_top=0
@system page=1 message_speed_left=400 message_speed_top=10 message_speed_caption="メッセージ速度" message_speed_slider_left=530 message_speed_slider_top=10 message_speed_slider_width=160 message_speed_slider_height=20 message_speed_slider_color=0x00FF00
@system page=1 auto_speed_left=400 auto_speed_top=40 auto_speed_caption="オートモード速度" auto_speed_slider_left=530 auto_speed_slider_top=40 auto_speed_slider_width=160 auto_speed_slider_height=20 auto_speed_slider_color=0x00FF00
@system page=1 message_sample_left=400 message_sample_top=70 message_sample_width=300 message_sample_height=40 message_sample_caption_color=0xFFFFFF message_sample_shadow_color=0x808080 message_sample_edge_color=0x808000

@system page=1 not_read_left=10 not_read_top=30 not_read_caption=既読スキップ
@system page=1 skip_left=10 skip_top=60 skip_caption=全てスキップ
@system page=1 stop_skip_left=10 stop_skip_top=90 stop_skip_caption=選択肢でスキップを停止する
@system page=1 not_stop_skip_left=10 not_stop_skip_top=120 not_stop_skip_caption=選択肢でスキップを停止しない
@system page=1 auto_voice_left=10 auto_voice_top=150 auto_voice_caption=オート時にボイス再生を行う
@system page=1 not_auto_voice_left=10 not_auto_voice_top=180 not_auto_voice_caption=オート時にボイス再生を行わない
@system page=1 click_to_auto_cancel_left=10 click_to_auto_cancel_top=210 click_to_auto_cancel_caption=クリックでオートを解除する
@system page=1 not_click_to_auto_cancel_left=10 not_click_to_auto_cancel_top=240 not_click_to_auto_cancel_caption=クリックでオートを解除しない

@system page=1 ask_save_left=10 ask_save_top=300 ask_save_caption=セーブデータ上書き時に確認する
@system page=1 ask_close_left=10 ask_close_top=340 ask_close_caption=終了時に確認する
@system page=1 ask_start_left=10 ask_start_top=380 ask_start_caption=最初に戻る時に確認する
@system page=1 ask_record_left=10 ask_record_top=420 ask_record_caption=一つ前に戻る時に確認する

@system page=0 fullscreen_left=10 fullscreen_top=270 fullscreen_caption=フルスクリーン
@system page=0 window_left=10 window_top=310 window_caption=ウインドウ

@load_system_config

; セーブロード画面
@save_load_option client_left=10 client_top=10 client_width=780 client_height=580
@save_load record_width=780 record_height=140
@save_load index_left=10 index_top=60
@save_load date_left=180 date_top=10
@save_load summary_left=180 summary_top=30
@save_load thumbnail_left=30 thumbnail_top=0 thumbnail_width=150 thumbnail_height=120 thumbnail_color=0xFF0000

; システムボタン
@system_button log_left=10 log_top=390 log_width=60 log_height=20 log_caption=履歴
@system_button skip_left=80 skip_top=390 skip_width=60 skip_height=20 skip_caption=スキップ
@system_button auto_left=150 auto_top=390 auto_width=60 auto_height=20 auto_caption=オート
@system_button hidden_left=220 hidden_top=390 hidden_width=60 hidden_height=20 hidden_caption=消去
@system_button system_left=290 system_top=390 system_width=60 system_height=20 system_caption=システム
@system_button save_left=360 save_top=390 save_width=60 save_height=20 save_caption=セーブ
@system_button load_left=430 load_top=390 load_width=60 load_height=20 load_caption=ロード
@system_button qsave_left=500 qsave_top=390 qsave_width=60 qsave_height=20 qsave_caption=Qセーブ
@system_button qload_left=570 qload_top=390 qload_width=60 qload_height=20 qload_caption=Qロード
;@system_button debug_left=640 debug_top=390 debug_width=60 debug_height=20 debug_caption=デバッグ

@system_button_option visible

; CG/回想画面
@load_cgmemory key=halo storage=ハロ.dic
@load_cgmemory key=2nd storage=2番目のCG

@cgmemory_option item_width=120 item_height=120
@cgmemory_option blank_thumbnail=thum_blank memory_button=memory_button
@cgmemory_option item_count=8 memory_count=3
@cgmemory_option enter_sound=se001.ogg

@cgmemory halo_left=370 halo_top=270 halo_caption=ハロのCG halo_width=60 halo_height=20
@cgmemory 2nd_left=370 2nd_top=300 2nd_caption=2ndのCG 2nd_width=60 2nd_height=20
@cgmemory mem0_left=10 mem0_top=100 mem1_left=30 mem1_top=100 mem2_left=50 mem2_top=100
@cgmemory item0_left=20 item0_top=10
@cgmemory item1_left=160 item1_top=10
@cgmemory item2_left=300 item2_top=10
@cgmemory item3_left=440 item3_top=10
@cgmemory item4_left=20 item4_top=200
@cgmemory item5_left=160 item5_top=200
@cgmemory item6_left=300 item6_top=200
@cgmemory item7_left=440 item7_top=200
[elsif exp="global.productInfo.language == 'en'"]
@make_stage name=white storage=白
@make_stage name=black storage=黒
@make_stage name=red storage=赤

; システム画面
@system_option page_left=0 page_top=30 page_width=800 page_height=570 click_sound=se001.ogg enter_sound=se002.ogg
@system page=0 page_tab_caption=System page_tab_left=0 page_tab_top=0
@system page=0 skip_key_left=10 skip_key_top=10 skip_key_caption="skip key" skip_key_conf_left=130 skip_key_conf_top=10 skip_key_conf_width=60 skip_key_conf_height=20 skip_key_conf_color=0xFF0000
@system page=0 not_read_skip_key_left=10 not_read_skip_key_top=40 not_read_skip_key_caption="not read" not_read_skip_key_conf_left=130 not_read_skip_key_conf_top=40 not_read_skip_key_conf_width=60 not_read_skip_key_conf_height=20 not_read_skip_key_conf_color=0xFF0000
@system page=0 auto_mode_key_left=10 auto_mode_key_top=70 auto_mode_key_caption="auto mode" auto_mode_key_conf_left=130 auto_mode_key_conf_top=70 auto_mode_key_conf_width=60 auto_mode_key_conf_height=20 auto_mode_key_conf_color=0xFF0000
@system page=0 enter_key_left=10 enter_key_top=110 enter_key_caption="enter key" enter_key_conf_left=130 enter_key_conf_top=110 enter_key_conf_width=60 enter_key_conf_height=20 enter_key_conf_color=0xFF0000
@system page=0 cancel_key_left=10 cancel_key_top=150 cancel_key_caption="cancel key" cancel_key_conf_left=130 cancel_key_conf_top=150 cancel_key_conf_width=60 cancel_key_conf_height=20 cancel_key_conf_color=0xFF0000
@system page=0 enter_button_left=10 enter_button_top=190 enter_button_caption="enter key(PAD)" enter_button_conf_left=130 enter_button_conf_top=190 enter_button_conf_width=60 enter_button_conf_height=20 enter_button_conf_color=0xFF0000
@system page=0 cancel_button_left=10 cancel_button_top=230 cancel_button_caption="cancel key(PAD)" cancel_button_conf_left=130 cancel_button_conf_top=230 cancel_button_conf_width=60 cancel_button_conf_height=20 cancel_button_conf_color=0xFF0000

@system page=0 master_left=400 master_top=10 master_caption="master volume" master_slider_left=530 master_slider_top=10 master_slider_width=160 master_slider_height=20 master_slider_color=0xFF0000
@system page=0 bgm_left=400 bgm_top=40 bgm_caption="BGM volume" bgm_slider_left=530 bgm_slider_top=40 bgm_slider_width=160 bgm_slider_height=20 bgm_slider_color=0xFF0000
@system page=0 se_left=400 se_top=70 se_caption="SE volume" se_slider_left=530 se_slider_top=70 se_slider_width=160 se_slider_height=20 se_slider_color=0xFF0000
@system page=0 vo_left=400 vo_top=100 vo_caption="Voice volume" vo_slider_left=530 vo_slider_top=100 vo_slider_width=160 vo_slider_height=20 vo_slider_color=0xFF0000

@system page=0 voice1_left=400 voice1_top=130 voice1_caption="halo's voice"
@system page=0 mob_voice_left=400 mob_voice_top=160 mob_voice_caption="mob's voice"

@system page=0 simple_battle_left=400 simple_battle_top=290 simple_battle_caption="Simple battle"

@system page=1 page_tab_caption="Message" page_tab_left=80 page_tab_top=0
@system page=1 message_speed_left=400 message_speed_top=10 message_speed_caption="Message speed" message_speed_slider_left=530 message_speed_slider_top=10 message_speed_slider_width=160 message_speed_slider_height=20 message_speed_slider_color=0x00FF00
@system page=1 auto_speed_left=400 auto_speed_top=40 auto_speed_caption="Auto speed" auto_speed_slider_left=530 auto_speed_slider_top=40 auto_speed_slider_width=160 auto_speed_slider_height=20 auto_speed_slider_color=0x00FF00
@system page=1 message_sample_left=400 message_sample_top=70 message_sample_width=300 message_sample_height=40 message_sample_caption_color=0xFFFFFF message_sample_shadow_color=0x808080 message_sample_edge_color=0x808000

@system page=1 not_read_left=10 not_read_top=30 not_read_caption="not read"
@system page=1 skip_left=10 skip_top=60 skip_caption="skip"
@system page=1 stop_skip_left=10 stop_skip_top=90 stop_skip_caption="Stop skipping with choices"
@system page=1 not_stop_skip_left=10 not_stop_skip_top=120 not_stop_skip_caption="Don't stop skipping on choices"
@system page=1 auto_voice_left=10 auto_voice_top=150 auto_voice_caption="Play voice when auto"
@system page=1 not_auto_voice_left=10 not_auto_voice_top=180 not_auto_voice_caption="Do not play voice during auto"
@system page=1 click_to_auto_cancel_left=10 click_to_auto_cancel_top=210 click_to_auto_cancel_caption="Cancel auto by clicking"
@system page=1 not_click_to_auto_cancel_left=10 not_click_to_auto_cancel_top=240 not_click_to_auto_cancel_caption="Do not cancel auto by clicking"

@system page=1 ask_save_left=10 ask_save_top=300 ask_save_caption="Confirm when overwriting save data"
@system page=1 ask_close_left=10 ask_close_top=340 ask_close_caption="Confirm when finished"
@system page=1 ask_start_left=10 ask_start_top=380 ask_start_caption="Please check when returning to the beginning"
@system page=1 ask_record_left=10 ask_record_top=420 ask_record_caption="Check when going back one step"

@system page=0 fullscreen_left=10 fullscreen_top=270 fullscreen_caption="Full screen"
@system page=0 window_left=10 window_top=310 window_caption="Window"

@load_system_config

; セーブロード画面
@save_load_option client_left=10 client_top=10 client_width=780 client_height=580
@save_load record_width=780 record_height=140
@save_load index_left=10 index_top=60
@save_load date_left=180 date_top=10
@save_load summary_left=180 summary_top=30
@save_load thumbnail_left=30 thumbnail_top=0 thumbnail_width=150 thumbnail_height=120 thumbnail_color=0xFF0000

; システムボタン
@system_button log_left=10 log_top=390 log_width=60 log_height=20 log_caption="Hist"
@system_button skip_left=80 skip_top=390 skip_width=60 skip_height=20 skip_caption="Skip"
@system_button auto_left=150 auto_top=390 auto_width=60 auto_height=20 auto_caption="Auto"
@system_button hidden_left=220 hidden_top=390 hidden_width=60 hidden_height=20 hidden_caption="hide"
@system_button system_left=290 system_top=390 system_width=60 system_height=20 system_caption="System"
@system_button save_left=360 save_top=390 save_width=60 save_height=20 save_caption="Save"
@system_button load_left=430 load_top=390 load_width=60 load_height=20 load_caption="Load"
@system_button qsave_left=500 qsave_top=390 qsave_width=60 qsave_height=20 qsave_caption="QSave"
@system_button qload_left=570 qload_top=390 qload_width=60 qload_height=20 qload_caption="QLoad"
;@system_button debug_left=640 debug_top=390 debug_width=60 debug_height=20 debug_caption=デバッグ

@system_button_option visible

; CG/回想画面
@load_cgmemory key=halo storage=ハロ.dic
@load_cgmemory key=2nd storage=2番目のCG

@cgmemory_option item_width=120 item_height=120
@cgmemory_option blank_thumbnail=thum_blank memory_button=memory_button
@cgmemory_option item_count=8 memory_count=3
@cgmemory_option enter_sound=se001.ogg

@cgmemory halo_left=370 halo_top=270 halo_caption="Halo's CG" halo_width=60 halo_height=20
@cgmemory 2nd_left=370 2nd_top=300 2nd_caption="2nd CG" 2nd_width=60 2nd_height=20
@cgmemory mem0_left=10 mem0_top=100 mem1_left=30 mem1_top=100 mem2_left=50 mem2_top=100
@cgmemory item0_left=20 item0_top=10
@cgmemory item1_left=160 item1_top=10
@cgmemory item2_left=300 item2_top=10
@cgmemory item3_left=440 item3_top=10
@cgmemory item4_left=20 item4_top=200
@cgmemory item5_left=160 item5_top=200
@cgmemory item6_left=300 item6_top=200
@cgmemory item7_left=440 item7_top=200
[endif]

; バージョンウインドウ
@version_window storage=VersionWindow

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


