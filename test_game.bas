'Music
title_music$ = ""
smith_music$ = "music/Sound.ogg"
jada_music$ = ""
game_over_music$ = ""
victory_music$ = ""

'SFX
slap_sfx = 0
joke_shot_sfx = 1
laser_sfx = 2
game_over_sfx = 3
victory_sfx = 4

LoadSound(slap_sfx, "sfx/slap-sound.wav")
LoadSound(joke_shot_sfx, "sfx/laugh-2.wav")
LoadSound(laser_sfx, "sfx/slap-sound.wav")
LoadSound(game_over_sfx, "sfx/chris-it-was-a-joke.wav")
LoadSound(victory_sfx, "sfx/chris-greatest-night.wav")

'BKG
title_bkg = 999
victory_bkg = 998
defeat_bkg = 997


Include "n00b-engine/game_engine.bas"
Include "rock.bas"
Include "smith.bas"
Include "title.bas"

'Open Game Window
flag = WindowMode(true, false, true, false, false)
Game_WindowOpen("demo",960,640,flag)

LoadImage(title_bkg, "bkg/title-screen-1-text.png")
LoadImage(victory_bkg, "bkg/chris-rock-victory.png")
LoadImage(defeat_bkg, "bkg/game-over-rock.png")

CanvasOpen(5, 960, 640, 0, 0, 960, 640, 1)
SetCanvasZ(5, 0)

Sub DrawHud(n_lives)
	Canvas(5)
	ClearCanvas()
	rh = GetActorID("rh")
	For i = 0 to n_lives-1
		DrawImage(Sprite_Image[Actor_Sprite[rh]], 20 + (i*32), 20)
	Next
	
	'Health Bar for Enemy
	SetColor(RGB(0,0,0))
	RectFill(300, 20, 500, 40)
	
	SetColor(RGB(255,0,0))
	RectFill(302, 22, 496 * (smith_health/50), 36)
	
End Sub

LoadStage("oscar-stage.stage")

graizor_shot_sound = 1

'LoadSound(graizor_shot_sound, "laugh-1.wav")

Stage_Init(2)
Player_Init()

Smith_Init()


Function Run_Game()
	end_flag = 0

	Lives = 5

	death_action = false
	death_timer = 0
	smith_health = 50
	
	If smith_music$ <> "" Then
		LoadMusic(smith_music$)
		PlayMusic(-1)
	End If
	
	While Not Key(K_ESCAPE)

		Player_Control(graizor)
		
		'------Smith AI------
		Smith_Act()
		
		'--------------------
		
		If death_action Then
			If (timer - death_timer) > 2000 Then
				'Print "balls"
				death_action = false
				Actor_SetEffect(rock, EFFECT_NONE, 0)
			End If
		End If
		
		If Actor_GetCollision(rock, slap) and death_action = false Then
			PlaySound(slap_sfx, 0, 0)
			Lives = Lives - 1
			death_action = true
			death_timer = timer
			Actor_SetEffect(rock, EFFECT_FLASH, 200)
		End If
		
		If Lives < 1 Then
			end_flag = 2
			Exit While
		End If
		
		If smith_health <= 0 Then
			end_flag = 1
			Exit While
		End If
		
		
		DrawHud(lives)
		
		Game_Render()
		
	Wend
	
	StopMusic()
	If end_flag = 1 Then
		Victory_Screen()
	ElseIf end_flag = 2 Then
		Defeat_Screen()
	ElseIf end_flag = 0 Then
		'Exit Game
	End If
	
	'Ask if they want to play again
	'If yes
	LoadFont(0, "font/manaspace/manaspc.ttf", 72)
	Canvas(5)
	ClearCanvas

	SetColor(RGB(97, 5, 5))
	RectFill(0, 0, 960, 640)

	SetColor(RGB(255,255, 255))
	DrawText("PLAY AGAIN?", 400, 200)
	DrawText("Y - YES", 420, 250)
	DrawText("N - NO", 420, 300)

	DeleteFont(0)

	While True
		If Key(K_Y) Then
			end_flag = 1
			Return True
		ElseIf Key(K_N) Then
			Return False
		End If
		Update()
	Wend

	Return False
	
End Function


While True
	If Title_Screen() Then
		If Not Run_Game() Then
			Exit While
		End If
	Else
		Exit While
	End If
Wend


