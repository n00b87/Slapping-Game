Include "n00b-engine/game_engine.bas"
Include "rock.bas"
Include "smith.bas"

'Open Game Window
flag = WindowMode(true, false, true, false, false)
Game_WindowOpen("demo",960,640,flag)

CanvasOpen(5, 960, 640, 0, 0, 960, 640, 1)
SetCanvasZ(5, 0)

Sub DrawHud(lives)
	Canvas(5)
	For i = 0 to lives-1
		DrawImage(Sprite_Image[Actor_Sprite[rock]], 20 + (i*32), 20)
	Next
End Sub

LoadStage("oscar-stage.stage")

'SFX
LoadSound(0, "sfx/slap-sound.wav")

Stage_Init(2)
Player_Init()

Smith_Init()


Lives = 5

death_action = false
death_timer = 0


While Not Key(K_ESCAPE)

	Player_Control(graizor)
	
	'------Smith AI------
	Smith_Act()
	
	'--------------------
	
	If death_action Then
		If (timer - death_timer) > 1200 Then
			'Print "balls"
			death_action = false
			Actor_SetEffect(rock, EFFECT_NONE, 0)
		End If
	End If
	
	If Actor_GetCollision(rock, slap) and death_action = false Then
		PlaySound(0, 0, 0)
		Lives = Lives - 1
		death_action = true
		death_timer = timer
		Actor_SetEffect(rock, EFFECT_FLASH, 1200)
	End If
		
	
	DrawHud(lives)
	
	Game_Render()
	
Wend