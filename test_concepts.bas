Sprite_Dir$ = "sprite/"
Gfx_Dir$ = "gfx/"
Music_Dir$ = "music/"
Sfx_Dir$ = "sfx/"
TileSet_Dir$ = "tileset/"
Video_Dir$ = "video/"
Map_Dir$ = "map/"
Font_Dir$ = "font/"

GAME_MENU_START = 0
GAME_MENU_OPTIONS = 1
GAME_MENU_EXIT = 2

Dim Menu_Options$[3]
Menu_Options$[0] = "Start Game"
Menu_Options$[1] = "Options"
Menu_Options$[2] = "Quit"
Dim Menu_Position[3,2] 'x,y for each menu option
Menu_Position[0,0] = 250
Menu_Position[0,1] = 320

Menu_Position[1,0] = 250
Menu_Position[1,1] = 335

Menu_Position[2,0] = 250
Menu_Position[2,1] = 350

NUMPLAYER_MENU_PLAYER1 = 0
NUMPLAYER_MENU_PLAYER2 = 1
NUMPLAYER_MENU_RETURN = 2

Dim NumPlayerMenu_Options$[3]
NumPlayerMenu_Options$[0] = "1 Player"
NumPlayerMenu_Options$[1] = "2 Player"
NumPlayerMenu_Options$[2] = "Return"
Dim NumPlayerMenu_Position[3,2] 'x,y for each menu option
NumPlayerMenu_Position[0,0] = 250
NumPlayerMenu_Position[0,1] = 150

NumPlayerMenu_Position[1,0] = 250
NumPlayerMenu_Position[1,1] = 165

NumPlayerMenu_Position[2,0] = 250
NumPlayerMenu_Position[2,1] = 180


OPTIONS_MENU_PLAYER1 = 0
OPTIONS_MENU_PLAYER2 = 1
OPTIONS_MENU_RETURN = 2

Dim OptionMenu_Options$[3]
OptionMenu_Options$[0] = "Player 1 Controls"
OptionMenu_Options$[1] = "Player 2 Controls"
OptionMenu_Options$[2] = "Return to Main Menu"
Dim OptionMenu_Position[3,2] 'x,y for each menu option
OptionMenu_Position[0,0] = 250
OptionMenu_Position[0,1] = 150

OptionMenu_Position[1,0] = 250
OptionMenu_Position[1,1] = 165

OptionMenu_Position[2,0] = 250
OptionMenu_Position[2,1] = 180

OPTIONS_PLAYER_MENU_KEYBOARD = 0
OPTIONS_PLAYER_MENU_JOYSTICK = 1
OPTIONS_PLAYER_MENU_JUMP = 2
OPTIONS_PLAYER_MENU_SPECIAL = 3
OPTIONS_PLAYER_MENU_DEFAULT = 4
OPTIONS_PLAYER_MENU_RETURN = 5

Dim OptionMenu_Player_Options$[6]
OptionMenu_Player_Options$[0] = "Set Control to Keyboard"
OptionMenu_Player_Options$[1] = "Set Control to Joystick"
OptionMenu_Player_Options$[2] = "Jump/Talk:"
OptionMenu_Player_Options$[3] = "Special:"
OptionMenu_Player_Options$[4] = "Default"
OptionMenu_Player_Options$[5] = "Return"
Dim OptionMenu_Player_Position[6,2] 'x,y for each menu option
OptionMenu_Player_Position[0,0] = 250
OptionMenu_Player_Position[0,1] = 150

OptionMenu_Player_Position[1,0] = 250
OptionMenu_Player_Position[1,1] = 165

OptionMenu_Player_Position[2,0] = 250
OptionMenu_Player_Position[2,1] = 180

OptionMenu_Player_Position[3,0] = 250
OptionMenu_Player_Position[3,1] = 195

OptionMenu_Player_Position[4,0] = 250
OptionMenu_Player_Position[4,1] = 225

OptionMenu_Player_Position[5,0] = 250
OptionMenu_Player_Position[5,1] = 240

Menu_Option_Width = 130
Menu_Option_Height = 15

OptionMenu_Option_Width = 220
OptionMenu_Option_Height = 15

OptionMenu_Player_Option_Width = 280
OptionMenu_Player_Option_Height = 15

NumPlayerMenu_Option_Width = 280
NumPlayerMenu_Option_Height = 15

Menu_Font = 0
Header_font = 0

LoadFont(0, font_dir$ + "FreeMono.ttf", 16)

'---------Player Controls---------------------------
CONTROLLER_KEYBOARD = 0
CONTROLLER_JOYSTICK = 1
PLAYER1_CONTROLLER = CONTROLLER_JOYSTICK
PLAYER1_BUTTON_JUMP = 0
PLAYER1_BUTTON_SPECIAL = 1
PLAYER2_CONTROLLER = CONTROLLER_JOYSTICK
PLAYER2_BUTTON_JUMP = 0
PLAYER2_BUTTON_SPECIAL = 1

DEFAULT_BUTTON_JUMP = 0
DEFAULT_BUTTON_SPECIAL = 1
DEFAULT_CONTROLLER = CONTROLLER_JOYSTICK

NUMPLAYERS = 0

'---------Joystick-----------------------------------
MAX_JBUTTONS = 30
dim JButton[MAX_JBUTTONS]
dim JAxis[MAX_JBUTTONS]
dim JHat[MAX_JBUTTONS]

Sub GetJoystick(joy_num)
	For i = 0 to MAX_JBUTTONS-1
		JButton[i] = 0
		JAxis[i] = 0
		JHat[i] = 0
	Next
	
	If NumJoyHats(joy_num) > 0 Then
		For i = 0 to NumJoyHats(joy_num)-1
			JHat[i] = JoyHat(joy_num, i)
		Next
	End If
	
	If NumJoyButtons(joy_num) > 0 Then
		For i = 0 to NumJoyButtons(joy_num) - 1
			JButton[i] = JoyButton(joy_num, i)
		Next
	End If
	
	If NumJoyAxes(joy_num) > 0 Then
		For i = 0 to NumJoyAxes(joy_num) - 1
			JAxis[i] = JoyAxis(joy_num, i)
		Next
	End If
End Sub
'------------------------------------------------------------
Sub Option_Player1Control_Menu()
	Font(Menu_Font)
	Selection = 0
	button_select = 0
	player_menu_title$ = ""
	while true
		ClearCanvas()
		SetColor(rgb(255,255,255))
		Font(header_font)
		player_menu_title = "PLAYER 1      CONTROL: "
		Select Case PLAYER1_CONTROLLER
		Case CONTROLLER_KEYBOARD
			player_menu_title = player_menu_title + "KEYBOARD"
		Case CONTROLLER_JOYSTICK
			player_menu_title = player_menu_title + "JOYSTICK"
		End Select
		DrawText(player_menu_title, 230, 125)
		Line(230, 145, 550, 145)
		GetJoystick(0)
		If Key(K_UP) Or JHat[0] = HAT_UP Then
			Selection = Selection - 1
			If Selection < 0 Then
				Selection = 5
			End If
			Wait(150)
		ElseIf Key(K_DOWN) Or JHat[0] = HAT_DOWN Then
			Selection = Selection + 1
			If Selection > 5 Then
				Selection = 0
			End If
			Wait(150)
		End If
		If Key(K_RETURN) Or JButton[0] Then
			Select Case Selection
			Case OPTIONS_PLAYER_MENU_KEYBOARD
				PLAYER1_CONTROLLER = CONTROLLER_KEYBOARD
				PLAYER1_BUTTON_JUMP = K_Z
				PLAYER1_BUTTON_SPECIAL = K_X
				Wait(200)
			Case OPTIONS_PLAYER_MENU_JOYSTICK
				PLAYER1_CONTROLLER = CONTROLLER_JOYSTICK
				PLAYER1_BUTTON_JUMP = 0
				PLAYER1_BUTTON_SPECIAL = 1
				Wait(200)
			Case OPTIONS_PLAYER_MENU_JUMP
				Wait(200)
				SetColor(rgb(0,0,255))
				RectFill(200, 200, 150, 50)
				SetColor(rgb(255,255,255))
				Font(Header_font)
				DrawText("Press a button", 220, 220)
				Update
				While true
					GetJoystick(0)
					Select Case PLAYER1_CONTROLLER
					Case CONTROLLER_KEYBOARD
						If inkey <> 0 Then
							PLAYER1_BUTTON_JUMP = inkey
							Exit While
						End If
					Case CONTROLLER_JOYSTICK
						For i = 0 to NumJoyButtons(0)-1
							If JButton[i] Then
								PLAYER1_BUTTON_JUMP = i
								Exit While
							End If
						Next
					End Select
					Wait(5)
				Wend
				Font(Menu_Font)
				button_select = true
				Wait(200)
			Case OPTIONS_PLAYER_MENU_SPECIAL
				Wait(200)
				SetColor(rgb(0,0,255))
				RectFill(200, 200, 150, 50)
				SetColor(rgb(255,255,255))
				Font(Header_font)
				DrawText("Press a button", 220, 220)
				Update
				While true
					GetJoystick(0)
					Select Case PLAYER1_CONTROLLER
					Case CONTROLLER_KEYBOARD
						If inkey <> 0 Then
							PLAYER1_BUTTON_SPECIAL = inkey
							Exit While
						End If
					Case CONTROLLER_JOYSTICK
						For i = 0 to NumJoyButtons(0)-1
							If JButton[i] Then
								PLAYER1_BUTTON_SPECIAL = i
								Exit While
							End If
						Next
					End Select
					Wait(5)
				Wend
				Font(Menu_Font)
				button_select = true
				Wait(200)
			Case OPTIONS_PLAYER_MENU_DEFAULT
				PLAYER1_BUTTON_JUMP = DEFAULT_BUTTON_JUMP
				PLAYER1_BUTTON_SPECIAL = DEFAULT_BUTTON_SPECIAL
				PLAYER1_CONTROLLER = DEFAULT_CONTROLLER
				Wait(200)
			Case OPTIONS_PLAYER_MENU_RETURN
				Wait(200)
				Return
			End Select
		End If
		If PLAYER1_CONTROLLER = CONTROLLER_JOYSTICK Then
			OptionMenu_Player_Options$[OPTIONS_PLAYER_MENU_JUMP] = "Jump/Talk: BUTTON " + str(PLAYER1_BUTTON_JUMP)
			OptionMenu_Player_Options$[OPTIONS_PLAYER_MENU_SPECIAL] = "Special: BUTTON " + str(PLAYER1_BUTTON_SPECIAL)
		ElseIf PLAYER1_CONTROLLER = CONTROLLER_KEYBOARD Then
			OptionMenu_Player_Options$[OPTIONS_PLAYER_MENU_JUMP] = "Jump/Talk: KEY \q" + chr(PLAYER1_BUTTON_JUMP) + "\q"
			OptionMenu_Player_Options$[OPTIONS_PLAYER_MENU_SPECIAL] = "Special: KEY \q" + chr(PLAYER1_BUTTON_SPECIAL) + "\q"
		End If
		SetColor(rgb(255,255,255))
		Font(Menu_Font)
		for i = 0 to 5
			DrawText(OptionMenu_Player_Options$[i], OptionMenu_Player_Position[i,0], OptionMenu_Player_Position[i,1])
		next
		SetColor(rgb(255,0,0))
		Rect(OptionMenu_Player_Position[Selection, 0], OptionMenu_Player_Position[Selection,1], OptionMenu_Player_Option_Width, OptionMenu_Player_Option_Height)
		If Not button_select Then
			Update
		End If
		button_select = false
		Wait(5)
	Wend
End Sub

Sub Option_Player2Control_Menu()
	Font(Menu_Font)
	Selection = 0
	button_select = 0
	player_menu_title$ = ""
	while true
		ClearCanvas()
		SetColor(rgb(255,255,255))
		Font(header_font)
		player_menu_title = "PLAYER 2      CONTROL: "
		Select Case PLAYER2_CONTROLLER
		Case CONTROLLER_KEYBOARD
			player_menu_title = player_menu_title + "KEYBOARD"
		Case CONTROLLER_JOYSTICK
			player_menu_title = player_menu_title + "JOYSTICK"
		End Select
		DrawText(player_menu_title, 230, 125)
		Line(230, 145, 550, 145)
		GetJoystick(0)
		If Key(K_UP) Or JHat[0] = HAT_UP Then
			Selection = Selection - 1
			If Selection < 0 Then
				Selection = 5
			End If
			Wait(150)
		ElseIf Key(K_DOWN) Or JHat[0] = HAT_DOWN Then
			Selection = Selection + 1
			If Selection > 5 Then
				Selection = 0
			End If
			Wait(150)
		End If
		If Key(K_RETURN) Or JButton[0] Then
			Select Case Selection
			Case OPTIONS_PLAYER_MENU_KEYBOARD
				PLAYER2_CONTROLLER = CONTROLLER_KEYBOARD
				PLAYER2_BUTTON_JUMP = K_Z
				PLAYER2_BUTTON_SPECIAL = K_X
				Wait(200)
			Case OPTIONS_PLAYER_MENU_JOYSTICK
				PLAYER2_CONTROLLER = CONTROLLER_JOYSTICK
				PLAYER2_BUTTON_JUMP = 0
				PLAYER2_BUTTON_SPECIAL = 1
				Wait(200)
			Case OPTIONS_PLAYER_MENU_JUMP
				Wait(200)
				SetColor(rgb(0,0,255))
				RectFill(200, 200, 150, 50)
				SetColor(rgb(255,255,255))
				Font(Header_font)
				DrawText("Press a button", 220, 220)
				Update
				While true
					GetJoystick(0)
					Select Case PLAYER2_CONTROLLER
					Case CONTROLLER_KEYBOARD
						If inkey <> 0 Then
							PLAYER2_BUTTON_JUMP = inkey
							Exit While
						End If
					Case CONTROLLER_JOYSTICK
						For i = 0 to NumJoyButtons(0)-1
							If JButton[i] Then
								PLAYER2_BUTTON_JUMP = i
								Exit While
							End If
						Next
					End Select
					Wait(5)
				Wend
				Font(Menu_Font)
				button_select = true
				Wait(200)
			Case OPTIONS_PLAYER_MENU_SPECIAL
				Wait(200)
				SetColor(rgb(0,0,255))
				RectFill(200, 200, 150, 50)
				SetColor(rgb(255,255,255))
				Font(Header_font)
				DrawText("Press a button", 220, 220)
				Update
				While true
					GetJoystick(0)
					Select Case PLAYER2_CONTROLLER
					Case CONTROLLER_KEYBOARD
						If inkey <> 0 Then
							PLAYER2_BUTTON_SPECIAL = inkey
							Exit While
						End If
					Case CONTROLLER_JOYSTICK
						For i = 0 to NumJoyButtons(0)-1
							If JButton[i] Then
								PLAYER2_BUTTON_SPECIAL = i
								Exit While
							End If
						Next
					End Select
					Wait(5)
				Wend
				Font(Menu_Font)
				button_select = true
				Wait(200)
			Case OPTIONS_PLAYER_MENU_DEFAULT
				PLAYER2_BUTTON_JUMP = DEFAULT_BUTTON_JUMP
				PLAYER2_BUTTON_SPECIAL = DEFAULT_BUTTON_SPECIAL
				PLAYER2_CONTROLLER = DEFAULT_CONTROLLER
				Wait(200)
			Case OPTIONS_PLAYER_MENU_RETURN
				Wait(200)
				Return
			End Select
		End If
		If PLAYER2_CONTROLLER = CONTROLLER_JOYSTICK Then
			OptionMenu_Player_Options$[OPTIONS_PLAYER_MENU_JUMP] = "Jump/Talk: BUTTON " + str(PLAYER2_BUTTON_JUMP)
			OptionMenu_Player_Options$[OPTIONS_PLAYER_MENU_SPECIAL] = "Special: BUTTON " + str(PLAYER2_BUTTON_SPECIAL)
		ElseIf PLAYER2_CONTROLLER = CONTROLLER_KEYBOARD Then
			OptionMenu_Player_Options$[OPTIONS_PLAYER_MENU_JUMP] = "Jump/Talk: KEY \q" + chr(PLAYER2_BUTTON_JUMP) + "\q"
			OptionMenu_Player_Options$[OPTIONS_PLAYER_MENU_SPECIAL] = "Special: KEY \q" + chr(PLAYER2_BUTTON_SPECIAL) + "\q"
		End If
		SetColor(rgb(255,255,255))
		Font(Menu_Font)
		for i = 0 to 5
			DrawText(OptionMenu_Player_Options$[i], OptionMenu_Player_Position[i,0], OptionMenu_Player_Position[i,1])
		next
		SetColor(rgb(255,0,0))
		Rect(OptionMenu_Player_Position[Selection, 0], OptionMenu_Player_Position[Selection,1], OptionMenu_Player_Option_Width, OptionMenu_Player_Option_Height)
		If Not button_select Then
			Update
		End If
		button_select = false
		Wait(5)
	Wend
End Sub

Sub Option_Menu()
	Font(Menu_Font)
	Selection = 0
	while true
		ClearCanvas()
		GetJoystick(0)
		If Key(K_UP) Or JHat[0] = HAT_UP Then
			Selection = Selection - 1
			If Selection < 0 Then
				Selection = 2
			End If
			Wait(150)
		ElseIf Key(K_DOWN) Or JHat[0] = HAT_DOWN Then
			Selection = Selection + 1
			If Selection > 2 Then
				Selection = 0
			End If
			Wait(150)
		End If
		If Key(K_RETURN) Or JButton[0] Then
			Select Case Selection
			Case OPTIONS_MENU_PLAYER1
				Wait(200)
				Option_Player1Control_Menu()
			Case OPTIONS_MENU_PLAYER2
				Wait(200)
				Option_Player2Control_Menu()
			Case OPTIONS_MENU_RETURN
				Wait(200)
				Return
			End Select
			Wait(150)
		End If
		SetColor(rgb(255,255,255))
		Font(Menu_Font)
		for i = 0 to 2
			DrawText(OptionMenu_Options$[i], OptionMenu_Position[i,0], OptionMenu_Position[i,1])
		next
		SetColor(rgb(255,0,0))
		Rect(OptionMenu_Position[Selection, 0], OptionMenu_Position[Selection,1], OptionMenu_Option_Width, OptionMenu_Option_Height)
		Update
		Wait(5)
	wend
End Sub

Sub NumPlayer_Menu()
	Font(Menu_Font)
	Selection = 0
	while true
		ClearCanvas()
		GetJoystick(0)
		If Key(K_UP) Or JHat[0] = HAT_UP Then
			Selection = Selection - 1
			If Selection < 0 Then
				Selection = 2
			End If
			Wait(150)
		ElseIf Key(K_DOWN) Or JHat[0] = HAT_DOWN Then
			Selection = Selection + 1
			If Selection > 2 Then
				Selection = 0
			End If
			Wait(150)
		End If
		If Key(K_RETURN) Or JButton[0] Then
			Select Case Selection
			Case NUMPLAYER_MENU_PLAYER1
				NUMPLAYERS = 1
			Case NUMPLAYER_MENU_PLAYER2
				NUMPLAYERS = 2
			Case NUMPLAYER_MENU_RETURN
				NUMPLAYERS = 0
			End Select
			Wait(200)
			Return
		End If
		SetColor(rgb(255,255,255))
		Font(Menu_Font)
		for i = 0 to 2
			DrawText(NumPlayerMenu_Options$[i], NumPlayerMenu_Position[i,0], NumPlayerMenu_Position[i,1])
		next
		SetColor(rgb(255,0,0))
		Rect(NumPlayerMenu_Position[Selection, 0], NumPlayerMenu_Position[Selection,1], NumPlayerMenu_Option_Width, NumPlayerMenu_Option_Height)
		Update
		Wait(5)
	wend
End Sub

'Character Select
PLAYER_DK = 0
PLAYER_ALANA = 1
Dim Player_Character[2]

alana_pic = -1
alana_w = 0
alana_h = 0
dk_pic = -1
dk_w = 0
dk_h = 0
	

Sub Player1_Character_Select()
	For i = 0 to 128
		If Not ImageExists(i) Then
			alana_pic = i
			LoadImage(i, gfx_dir$ + "bubby.png")
			Exit For
		End If
	Next
	
	For i = 0 to 128
		If Not ImageExists(i) Then
			dk_pic = i
			LoadImage(i, gfx_dir$ + "dk.png")
			Exit For
		End If
	Next
	
	GetImageSize(alana_pic, alana_w, alana_h)
	GetImageSize(dk_pic, dk_w, dk_h)
	
	dim char_menu[2,2]
	char_menu[0,0] = 64
	char_menu[0,1] = 144
	
	char_menu[1,0] = 256
	char_menu[1,1] = 144
	
	Font(Menu_Font)
	Selection = 0
	while true
		ClearCanvas()
		GetJoystick(0)
		If Key(K_LEFT) Or JHat[0] = HAT_LEFT Then
			Selection = Selection - 1
			If Selection < 0 Then
				Selection = 1
			End If
			Wait(150)
		ElseIf Key(K_RIGHT) Or JHat[0] = HAT_RIGHT Then
			Selection = Selection + 1
			If Selection > 1 Then
				Selection = 0
			End If
			Wait(150)
		End If
		If Key(K_RETURN) Or JButton[0] Then
			Select Case Selection
			Case PLAYER_DK
				Player_Character[0] = PLAYER_DK
			Case PLAYER_ALANA
				Player_Character[0] = PLAYER_ALANA
			End Select
			Wait(200)
			Return
		End If
		
		DrawImage_Blit_Ex(dk_pic, 64, 144, 128, 128, 0, 0, dk_w, dk_h)
		DrawImage_Blit_Ex(alana_pic, 256, 144, 128, 128, 0, 0, alana_w, alana_h)
		
		SetColor(rgb(255,255,255))
		DrawText("---------PLAYER 1 SELECT A CHARACTER---------", 100, 90)
		
		SetColor(rgb(255,0,0))
		Rect(char_menu[Selection, 0], char_menu[Selection,1], 128, 128)
		Update
		Wait(5)
	wend
	
End Sub

Sub Player2_Character_Select()
	
	GetImageSize(alana_pic, alana_w, alana_h)
	GetImageSize(dk_pic, dk_w, dk_h)
	
	dim char_menu[2,2]
	char_menu[0,0] = 64
	char_menu[0,1] = 144
	
	char_menu[1,0] = 256
	char_menu[1,1] = 144
	
	Font(Menu_Font)
	Selection = 0
	while true
		ClearCanvas()
		GetJoystick(1)
		If Key(K_LEFT) Or JHat[0] = HAT_LEFT Then
			Selection = Selection - 1
			If Selection < 0 Then
				Selection = 1
			End If
			Wait(150)
		ElseIf Key(K_RIGHT) Or JHat[0] = HAT_RIGHT Then
			Selection = Selection + 1
			If Selection > 1 Then
				Selection = 0
			End If
			Wait(150)
		End If
		If Key(K_RETURN) Or JButton[0] Then
			Select Case Selection
			Case PLAYER_DK
				Player_Character[0] = PLAYER_DK
			Case PLAYER_ALANA
				Player_Character[0] = PLAYER_ALANA
			End Select
			Wait(200)
			Return
		End If
		
		DrawImage_Blit_Ex(dk_pic, 64, 144, 128, 128, 0, 0, dk_w, dk_h)
		DrawImage_Blit_Ex(alana_pic, 256, 144, 128, 128, 0, 0, alana_w, alana_h)
		
		SetColor(rgb(255,255,255))
		DrawText("---------PLAYER 2 SELECT A CHARACTER---------", 100, 90)
		
		SetColor(rgb(255,0,0))		
		Rect(char_menu[Selection, 0], char_menu[Selection,1], 128, 128)
		Update
		Wait(5)
	wend
	DeleteImage(dk_pic)
	DeleteImage(alana_pic)
End Sub


Function Game_Menu()
	Font(Menu_Font)
	Selection = 0
	while true
		ClearCanvas()
		GetJoystick(0)
		If Key(K_UP) Or JHat[0] = HAT_UP Then
			Selection = Selection - 1
			If Selection < 0 Then
				Selection = 2
			End If
			Wait(150)
		ElseIf Key(K_DOWN) Or JHat[0] = HAT_DOWN Then
			Selection = Selection + 1
			If Selection > 2 Then
				Selection = 0
			End If
			Wait(150)
		End If
		If Key(K_RETURN) Or JButton[0] Then
			Select Case Selection
			Case GAME_MENU_EXIT
				Return 0
			Case GAME_MENU_START
				Wait(200)
				NumPlayer_Menu()
				If NUMPLAYERS > 0 Then
					Select Case NUMPLAYERS
					Case 1
						Player1_Character_Select()
					Case 2
						Player1_Character_Select()
						Player2_Character_Select()
					End Select
					Return NUMPLAYERS
				End If
			Case GAME_MENU_OPTIONS
				Wait(200)
				Option_Menu()
			End Select
			Wait(150)
		End If
		SetColor(rgb(255,255,255))
		Font(Menu_Font)
		for i = 0 to 2
			DrawText(Menu_Options$[i], Menu_Position[i,0], Menu_Position[i,1])
		next
		SetColor(rgb(255,0,0))
		Rect(Menu_Position[Selection, 0], Menu_Position[Selection,1], Menu_Option_Width, Menu_Option_Height)
		Update
		Wait(5)
	wend
	return 0
End Function

WindowOpen(0,"Test",WINDOWPOS_CENTERED,WINDOWPOS_CENTERED,640,480,0)
'CanvasOpen(0,640,480,0,0,640,480,1)




'Game_Menu

'Update()
