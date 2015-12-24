
*label|

@load_roman_table language=japanese
@log message="日本語ローマ字対応表読み込みに成功しました。"

*game_start
@hide_typing_target

@add_typing_word caption="天上不知唯我独損" ruby="ハコワレ"
@add_typing_word caption="暗い宿" ruby="ホテル・ラフレシア"
@add_typing_word caption="電光石火" ruby="デンコウセッカ"
@add_typing_word caption="雷掌" ruby="イズツシ"
@add_typing_word caption="神速" ruby="カンムル"
@add_typing_word caption="落雷" ruby="ナルカミ"
@add_typing_word caption="疾風迅雷" ruby="シップウジンライ"

@dump_typing_word_list

;@remove_typing_word caption="電光石火"
;@remove_typing_word ruby="イズツシ"
;@remove_typing_word caption="神速" ruby="カンムル"
@log message="ワードを３つ削除しました。"

@dump_typing_word_list

;@clear_typing_word_list
@log message="ワード全て削除しました。"

@dump_typing_word_list

@load_typing_words storage=HAMON_Skills.dic
@load_typing_words storage=Vampire_Skils.dic
@log message="ワードリストを読み込みました。"

@dump_typing_word_list

@typing_config target_image=TypingTarget000
@typing_config accept_target=*accept end_target=*end

*label|
@typing_start
@log message="タイピングの受付を開始しました。"

@show_typing_target position=center count=1
@log message="タイピングターゲットをランダムで一つ表示しました。"

@wait_typing target_count=0


*label|
@show_typing_target left=100 top=100
@show_typing_target left=200 top=100
@show_typing_target left=300 top=100
@show_typing_target left=400 top=100
@show_typing_target left=100 top=200
@show_typing_target left=200 top=200
@show_typing_target left=300 top=200
@show_typing_target left=400 top=200

; ターゲットが残り１つになるまで待つ。
@wait_typing target_count=1


*label|
;@show_typing_target position=random ruby="イズツシ"
;@show_typing_target position=random caption="神速"
;@log message="存在しないタイピングターゲットを指定しました。ワーニングが２つログに表示されていれば成功です。"

@wait_typing target_count=0


@log message="全てのターゲットの入力を完了しました。"
@s

*accept|

@wait_typing target_count=0

@show_typing_target left=100 top=100
@show_typing_target left=200 top=100
@show_typing_target left=300 top=100
@show_typing_target left=400 top=100
@show_typing_target left=100 top=200
@show_typing_target left=200 top=200
@show_typing_target left=300 top=200
@show_typing_target left=400 top=200
@s


*end|
@log message="タイピングの受付を終了しました。"

@jump target=*game_start


