;/*
; * $Revision: 278 $
;**/

*label|

@load_roman_table language=japanese
@log message="日本語ローマ字対応表読み込みに成功しました。"

@add_typing_word caption="天上不知唯我独損" ruby="ハコワレ"
@add_typing_word caption="暗い宿" ruby="ホテル・ラフレシア"
@add_typing_word caption="電光石火" ruby="デンコウセッカ"
@add_typing_word caption="雷掌" ruby="イズツシ"
@add_typing_word caption="神速" ruby="カンムル"
@add_typing_word caption="落雷" ruby="ナルカミ"
@add_typing_word caption="疾風迅雷" ruby="シップウジンライ"

@dump_typing_word_list

@remove_typing_word caption="電光石火"
@remove_typing_word ruby="イズツシ"
@remove_typing_word caption="神速" ruby="カンムル"
@log message="ワードを３つ削除しました。"

@dump_typing_word_list

@clear_typing_word_list
@log message="ワード全て削除しました。"

@dump_typing_word_list

@load_typing_words storage=HAMON_Skills.dic
@log message="ワードリストを読み込みました。"

@dump_typing_word_list

@typing_config target_image=TypingTarget000

*label|
@typing_start
@log message="タイピングの受付を開始しました。"

@show_typing_target position=center count=1
@log message="タイピングターゲットをランダムで一つ表示しました。"

@wait_typing target_count=0


*label|
@show_typing_target left=100 top=random caption="波紋疾走"
@log message="タイピングターゲットを caption 属性を指定して表示しました。"

@show_typing_target left=random top=100 ruby="サンライトイエロー・オーバードライブ"
@log message="タイピングターゲットを ruby 属性を指定して表示しました。"

; ターゲットが残り１つになるまで待つ。
@wait_typing target_count=1


*label|
@show_typing_target position=random ruby="イズツシ"
@show_typing_target position=random caption="神速"
@log message="存在しないタイピングターゲットを指定しました。ワーニングが２つログに表示されていれば成功です。"

@wait_typing target_count=0


@log message="全てのターゲットの入力を完了しました。"

*label|
@typing_end
@log message="タイピングの受付を終了しました。"


