
; 画像関連機能
@load_module name=ModImage
; メッセージレイヤ関連機能
@load_module name=ModMessage

; ウインドウ設定
@window width=200 height=200 fix_position_to_center visible

; メッセージレイヤの数
@message_layers count=1

; メッセージレイヤ設定
@message_option layer=message0 left=0 top=0 width=200 height=200 opacity=0 color=0 caption_color=0xFFFFFF current

@using_mod_message

@cr_handling ignore

@cm

@!show_message type=vista

@show_message layer=message0 vista
@wait_show_message

タイトル：[emb exp=System.title][r]
バージョン：[emb exp=window.conductor.majorVersionNumber].[emb exp=window.conductor.minorVersionNumber]
[emb exp=window.conductor.specialVersionString]

@s


