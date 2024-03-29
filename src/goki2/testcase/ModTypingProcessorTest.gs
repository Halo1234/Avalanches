
*label|

; ローマ字対応表の読み込み（必ず必要）
@load_roman_table language=japanese
@log message="日本語ローマ字対応表読み込みに成功しました。"

; タイマーセット
@typing_config limit=60

*game_start
; タイピングオブジェクトを一旦非表示にする（念のため）
@hide_typing_target

; ワードを追加する
@add_typing_word caption="天上不知唯我独損" ruby="ハコワレ"
@add_typing_word caption="暗い宿" ruby="ホテル・ラフレシア"
@add_typing_word caption="電光石火" ruby="デンコウセッカ"
@add_typing_word caption="雷掌" ruby="イズツシ"
@add_typing_word caption="神速" ruby="カンムル"
@add_typing_word caption="落雷" ruby="ナルカミ"
@add_typing_word caption="疾風迅雷" ruby="シップウジンライ"

; ログにタイピングオブジェクトを出力する（デバッグ用）
@dump_typing_word_list

; ワードを削除する
@remove_typing_word caption="電光石火"
@remove_typing_word ruby="イズツシ"
@remove_typing_word caption="神速" ruby="カンムル"
@log message="ワードを３つ削除しました。"

@dump_typing_word_list

@clear_typing_word_list
@log message="ワード全て削除しました。"

@dump_typing_word_list

; ワードをファイルから読み込む
; /tools/make_word参照
@load_typing_words storage=HAMON_Skills.dic
@load_typing_words storage=Vampire_Skils.dic
@log message="ワードリストを読み込みました。"

@dump_typing_word_list

; タイピングオブジェクトの画像を指定する
@typing_config target_image=TypingTarget000,TypingTarget001
; accept_target : タイピングオブジェクトを入力しきったら飛ぶラベル
;    end_target : ゲーム終了時に飛ぶラベル
@typing_config accept_target=*accept end_target=*end

*label|
; タイピング開始
@typing_start
@log message="タイピングの受付を開始しました。"

@show_typing_target position=center count=1
@log message="タイピングターゲットをランダムで一つ表示しました。"

; タイピングオブジェクト入力完了待ち
;@wait_typing
@s

*accept|
; タイピングオブジェクトが入力完了されたときにここに飛んでくる

; タイピングオブジェクトが0個になるまで待つ
@wait_typing target_count=0

@show_typing_target left=100 top=100
@show_typing_target left=200 top=100 storage=TypingTarget001
@show_typing_target left=300 top=100
@show_typing_target left=400 top=100
@show_typing_target left=100 top=200
@show_typing_target left=200 top=200
@show_typing_target left=300 top=200
@show_typing_target left=400 top=200
@s


*end|
; タイムオーバー時にここにくる
@log message="タイピングの受付を終了しました。"

; ゲーム終了するならこれを使う
@typing_end

;@jump target=*game_start

@hide_typing_base_layer
@wait_hide_typing_base_layer


