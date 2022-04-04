Include "n00b-engine/game_engine.bas"
Include "rock.bas"
Include "smith.bas"

'Open Game Window
flag = WindowMode(true, false, true, false, false)
Game_WindowOpen("demo",960,640,flag)


LoadStage("oscar-stage.stage")

Stage_Init(2)
Player_Init()

Smith_Init()

While Not Key(K_ESCAPE)

	Player_Control(graizor)
	
	'------Smith AI------
	Smith_Act()
	
	'--------------------
	
	Game_Render()
	
Wend