*label|

; Loading the romaji correspondence table (required)
@load_roman_table language=english
@log message="Successfully loaded the English Romanization table."

; timer set
@typing_config limit=60

*game_start
; Hide the typing object for now (just in case)
@hide_typing_target

; add word
@add_typing_word caption="test" ruby="test"
@add_typing_word caption="Japanese" ruby="japanese"
@add_typing_word caption="English" ruby="english"
@add_typing_word caption="hello world" ruby="hello world"
@add_typing_word caption="hello" ruby="hello"
@add_typing_word caption="world" ruby="world"
@add_typing_word caption="male" ruby="male"
@add_typing_word caption="female" ruby="female"
@add_typing_word caption="I am a hero." ruby="i am a hero."
@add_typing_word caption="I am a villan." ruby="all for one."

; Output typing object to log (for debugging)
@dump_typing_word_list

; Specify the image of the typing object
@typing_config target_image=TypingTarget000,TypingTarget001
; accept_target : Label that jumps when all typing objects are input
; end_target : Label that flies when the game ends
@typing_config accept_target=*accept end_target=*end

*label|
; Start typing
@typing_start
@log message="Started accepting typing requests."

@show_typing_target position=center count=1
@log message="Displayed one random typing target."

;Waiting for completion of typing object input
;@wait_typing
@s

*accept|
; Jumps here when the typing object is completed

; Wait until there are 0 typing objects
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
; Comes here when time is over
@log message="Typing acceptance has ended."

; Use this to end the game
@typing_end

;@jump target=*game_start

@hide_typing_base_layer
@wait_hide_typing_base_layer


