Include "n00b-engine/engine.bas"
Include "graizor.bas"
Include "boss_hud.bas"
Include "limit.bas"
Include "energy_cell.bas"
Include "guard_ai.bas"
Include "hover_ai.bas"
Include "amber_beam.bas"
Include "m1_ai.bas"
Include "gren_ai.bas"
Include "forest_boss.bas"
Include "claw_ai.bas"
Include "bitwalker_ai.bas"
Include "skull_bomb.bas"
Include "city_boss.bas"
Include "platforms.bas"
Include "skull_wheel.bas"
Include "default.bas"

'Open Game Window
flag = WindowMode(true, false, true, false, false)
Game_WindowOpen("demo",640,480,flag)
'LoadStage("forest_test_level.stage")

'Bkg_SetFlag(1, STAGE_LAYER_BKG_FLAG_SCROLL)
'Bkg_SetScrollSpeed(1, 1, 0)
'Stage_SetOffset(0, 600)


'Stage 1

Sub Game_Over()
	'do nothing for now
End Sub

Sub Stage1_1()
	LoadStage("stage1.stage")
	
	Stage_Init(2)
	Graizor_Init
	
	g1_actor = GetActorID("guard1")
	g2_actor = GetActorID("guard2")
	g3_actor = GetActorID("guard3")
	g4_actor = GetActorID("guard4")
	g5_actor = GetActorID("guard5")
	g6_actor = GetActorID("guard6")

	g1 = AI_Init_Guard(g1_actor, GUARD_ACTION_STAND_LEFT, GetActorID("axe1"))
	g2 = AI_Init_Guard(g2_actor, GUARD_ACTION_STAND_RIGHT, GetActorID("axe2"))
	g3 = AI_Init_Guard(g3_actor, GUARD_ACTION_STAND_LEFT, GetActorID("axe3"))
	g4 = AI_Init_Guard(g4_actor, GUARD_ACTION_STAND_LEFT, GetActorID("axe4"))
	g5 = AI_Init_Guard(g5_actor, GUARD_ACTION_STAND_LEFT, GetActorID("axe5"))
	g6 = AI_Init_Guard(g6_actor, GUARD_ACTION_STAND_RIGHT, GetActorID("axe6"))


	n = Stage_Layer_Shape_Count[2] - 1
	'Stage_Layer_Shape_Type[2, n] = SHAPE_TYPE_DYNARECT


	'tmp = LoadSprite("leaves")
	'tmp_a = NewActor("tmp_actor", tmp)
	'Actor_SetLayer(tmp_a, 2)
	'Actor_SetActive(tmp_a, True)
	'Actor_SetPosition(tmp_a, Actor_X[0], Actor_Y[0])
	'Actor_SetAnimation(tmp_a, 0)
	'Actor_SetAnimationFrame(tmp_a, 0)

	'tmp_anim = 0

	'LoadMusic(MUSIC_PATH$ + "darkrobojungle.mp3")
	'PlayMusic(-1)

	While Not Key(K_ESCAPE)
		
		If Graizor_CheckDeath Then
			Exit While
		End If
		
		AI_Guard(g1, graizor)
		AI_Guard(g2, graizor)
		AI_Guard(g3, graizor)
		AI_Guard(g4, graizor)
		AI_Guard(g5, graizor)
		AI_Guard(g6, graizor)
		
		Player_Control_Ex(graizor)
		'Print Actor_Physics_State[1]
		
		st_x = 0
		st_y = 0
		If Actor_X[graizor] > 320 Then
			st_x = Actor_X[graizor] - 320
		End If
		
		If Actor_Y[graizor] > 240 Then
			st_y = Actor_Y[graizor] - 240
		End If
		
		If Actor_Y[graizor] > 600 Then
			Actor_SetPosition(graizor, 52, 380)
		End If
		
		Stage_SetOffset(st_x, st_y)
		
		tx = false
		ty = false
		
		speedx = 4
		speedy = 2
		
		if key(K_A) then
			Stage_Layer_Shape_X[2, n] = Stage_Layer_Shape_X[2, n] - speedx
			Stage_Layer_Shape_Param[2, n, 0] = Stage_Layer_Shape_Param[2, n, 0] - speedx
			Stage_Layer_Shape_Attribute[2, n, 0] = -1 * speedx
			'print Stage_Layer_Shape_X[2, n]
			tx = true	
		elseif key(K_D) then
			Stage_Layer_Shape_X[2, n] = Stage_Layer_Shape_X[2, n] + speedx
			Stage_Layer_Shape_Param[2, n, 0] = Stage_Layer_Shape_Param[2, n, 0] + speedx
			Stage_Layer_Shape_Attribute[2, n, 0] = speedx
			tx = true
		end if
		
		if key(K_W) then
			Stage_Layer_Shape_Y[2, n] = Stage_Layer_Shape_Y[2, n] - speedy
			Stage_Layer_Shape_Param[2, n, 1] = Stage_Layer_Shape_Param[2, n, 1] - speedy
			Stage_Layer_Shape_Attribute[2, n, 1] = -1 * speedy
			ty = true
		elseif key(K_S) then
			Stage_Layer_Shape_Y[2, n] = Stage_Layer_Shape_Y[2, n] + speedy
			Stage_Layer_Shape_Param[2, n, 1] = Stage_Layer_Shape_Param[2, n, 1] + speedy
			Stage_Layer_Shape_Attribute[2, n, 1] = speedy
			ty = true
		end if
		
		if not tx then
			Stage_Layer_Shape_Attribute[2, n, 0] = 0
		end if
		
		if not ty then
			Stage_Layer_Shape_Attribute[2, n, 1] = 0
		end if
		
		'if key(K_P) then
		'	print "O-N: ";Actor_X[graizor];" - ";Actor_NewX[graizor]
		'end if
		
		DrawHud
		
		Game_Render
		
	Wend
	

End Sub
 

Sub city_test()
	STAGE_COMPLETE = False
	LoadStage("City_Ruin.stage")
	
	Init_Default
	
	Stage_Init(2)
	Graizor_Init
	
	Dim num_mine_beams
	num_mine_beams = 3
	Dim mine_beam[3]
	
	mine_beam[0] = GetActorID("mine_beam_01")
	mine_beam[1] = GetActorID("mine_beam_02")
	mine_beam[2] = GetActorID("mine_beam_03")
	
	Actor_SetVisible(mine_beam[0], False)
	Actor_SetVisible(mine_beam[1], False)
	Actor_SetVisible(mine_beam[2], False)
	
	'fire1 = GetActorID("fire1")
	'fire_spr = Actor_Sprite[fire1]
	
	'fire1_x = Actor_X[fire1]
	'fire1_y = Actor_Y[fire1]
	
	'For i = 1 to 19
	'	n = NewActor("fire"+str(1+i), fire_spr)
	'	Actor_SetPosition(n, fire1_x + 640*i, fire1_y)
	'	Actor_SetAnimation(n, 0)
	'	Actor_SetAnimationFrame(n, 0)
		'Actor_SetActive(n, true)
	'	Actor_SetLayer(n, 1)
	'Next
	
	Dim x[5]
	Dim y[5]
	
	hv = GetActorID("hover_01")
	
	For i = 0 to 4
		x[i] = Actor_X[hv] + ( (i+1) * 400)
		y[i] = Actor_Y[hv]
		'print "-> ";x[i];", ";y[i]
	Next
	
	'Print "Parents -> ";Actor_ParentActor[graizor];", ";Actor_ParentActor[hv+3]
	
	Init_Hovers(5, x, y)
	
	'Actor_SetActive(fire1, true)
	'Actor_SetAnimationByName(fire1,"Animation0")
	'Actor_SetAnimationFrame(fire1, 0)
	
	Actor_SetAnimationByName(graizor, "stand_left")
	
	'print "delay = ";Actor_CurrentFrameDelay[fire1]
	
	
	'------------FADE IN---------------------
	
	st_x = 0
	st_y = 0
	If Actor_X[graizor] > 320 Then
		st_x = Actor_X[graizor] - 320
	End If
		
	If Actor_Y[graizor] > 240 Then
		st_y = Actor_Y[graizor] - 240
	End If
		
	If Actor_Y[graizor] > 600 Then
		Actor_SetPosition(graizor, 52, 380)
	End If
		
	Stage_SetOffset(st_x, st_y)
	
	'Stage_FadeIn	7
	
	'----------------------------------------
	
	Dim b[8]
	s = LoadSprite("c_bullet")
	
	For claw_i = 1 to 6
		For i = 0 to 7
			b[i] = NewActor("shot_"+str(i), s)
		Next
		
		AI_Init_Claw(GetActorID("claw_0" + str(claw_i)), CLAW_ACTION_STAND_LEFT, b)
	Next
	
	Stage_Layer_Active[3] = True
	
	'platform 01
	platform_01 = GetActorID("platform_float_01")
	platform_01_x_speed = 2
	platform_01_x_min = 2528
	platform_01_x_max = 2880
	
	Stage_Layer_AddActorDynaRec(platform_01, 2)
	
	'platform_02
	platform_02 = GetActorID("platform_float_02")
	platform_02_x_speed = 2
	platform_02_x_min = 3072
	platform_02_x_max = 3456
	
	Stage_Layer_AddActorDynaRec(platform_02, 2)
	
	'platform_03
	platform_03 = GetActorID("platform_float_03")
	platform_03_y_speed = 2
	platform_03_y_min = 256
	platform_03_y_max = 416
	
	Stage_Layer_AddActorDynaRec(platform_03, 2)
	
	
	'platform_04
	platform_04 = GetActorID("platform_float_04")
	platform_04_x_speed = 2
	platform_04_x_min = 4512
	platform_04_x_max = 4736
	
	Stage_Layer_AddActorDynaRec(platform_04, 2)
	
	'platform_05
	platform_05 = GetActorID("platform_float_05")
	platform_05_x_speed = 2
	platform_05_x_min = 4832
	platform_05_x_max = 5056
	
	Stage_Layer_AddActorDynaRec(platform_05, 2)
	
	'platform_06
	platform_06 = GetActorID("platform_float_06")
	platform_06_y_speed = 2
	platform_06_y_min = 384
	platform_06_y_max = 512
	
	Stage_Layer_AddActorDynaRec(platform_06, 2)
	
	'platform_07
	platform_07 = GetActorID("platform_float_07")
	Stage_Layer_AddActorDynaRec(platform_07, 2)
	
	'M1
	For i = 1 to 5
		m = GetActorID("m1_0"+str(i))
		'Print "Loading m[";m;"]"
		If i=5 Then
			AI_Init_M1(m, M1_ACTION_STAND_LEFT2)
		Else
			AI_Init_M1(m, 0)
		End If
	Next
	
	
	'GRENGUY
	For i = 1 to 8
		m = GetActorID("gren_0"+str(i))
		'Print "Loading m[";m;"]"
		AI_Init_GREN(m)
	Next
	
	'Amber Beams
	amber_01 = GetActorID("amber_01")
	AI_Init_Amber(amber_01)
	
	Actor_SetPosition(graizor, 32, 480)
	Actor_SetAnimationByName(graizor, "stand_right")
	Actor_SetAnimationFrame(graizor, 0)
	
	'Actor_SetPosition(graizor, 6768 ,151)

	While Not Key(K_ESCAPE)
		num_enemies = 0
		
		If Graizor_CheckDeath Then
			Exit While
		End If
		
		'M1_Act(graizor)
		'GREN_Act(graizor)
		'Hover_Act(graizor)
		'Claw_Act(graizor)
		
		AI_Amber(0, graizor)
		
		'Platform 01
		If Actor_X[platform_01] >= platform_01_x_max Then
			platform_01_x_speed = -2
		ElseIf Actor_X[platform_01] <= platform_01_x_min Then
			platform_01_x_speed = 2
		End If
		
		Actor_Move(platform_01, platform_01_x_speed, 0)
		
		'Platform 02
		If Actor_X[platform_02] >= platform_02_x_max Then
			platform_02_x_speed = -2
		ElseIf Actor_X[platform_02] <= platform_02_x_min Then
			platform_02_x_speed = 2
		End If
		
		Actor_Move(platform_02, platform_02_x_speed, 0)
		
		'Platform 03
		If Actor_Y[platform_03] >= platform_03_y_max Then
			platform_03_y_speed = -2
		ElseIf Actor_Y[platform_03] <= platform_03_y_min Then
			platform_03_y_speed = 2
		End If
		
		Actor_Move(platform_03, 0, platform_03_y_speed)
		
		'Platform 04
		If Actor_X[platform_04] >= platform_04_x_max Then
			platform_04_x_speed = -2
		ElseIf Actor_X[platform_04] <= platform_04_x_min Then
			platform_04_x_speed = 2
		End If
		
		Actor_Move(platform_04, platform_04_x_speed, 0)
		
		'Platform 05
		If Actor_X[platform_05] >= platform_05_x_max Then
			platform_05_x_speed = -2
		ElseIf Actor_X[platform_05] <= platform_05_x_min Then
			platform_05_x_speed = 2
		End If
		
		Actor_Move(platform_05, platform_05_x_speed, 0)
		
		
		'Platform 06
		If Actor_Y[platform_06] >= platform_06_y_max Then
			platform_06_y_speed = -2
		ElseIf Actor_Y[platform_06] <= platform_06_y_min Then
			platform_06_y_speed = 2
		End If
		
		Actor_Move(platform_06, 0, platform_06_y_speed)
		
		
		For i = 0 to num_mine_beams-1
			If Actor_GetCollision(graizor, mine_beam[i]) Then
				Graizor_Health = 0
				'Print "Collision on mine_beam ";i
				Exit For
			End If
		Next
		
		Player_Control(graizor)
		
		st_x = 0
		st_y = 0
		If Actor_X[graizor] > 320 Then
			st_x = Actor_X[graizor] - 320
		End If
		
		'LEVEL COMPLETE CONDITION
		If Actor_X[graizor] > 8480 Then
			STAGE_COMPLETE = TRUE
			Exit While
		End If
		
		If Actor_Y[graizor] > 240 Then
			st_y = Actor_Y[graizor] - 240
		End If
		
		If Actor_Y[graizor] > 600 Then
			Actor_SetPosition(graizor, 52, 380)
		End If
		
		If key(K_P) Then
			Print "FPS: ";FPS
		End If
		
		Stage_SetOffset(st_x, st_y)
		
		
		DrawHud
		
		
		Game_Render
		
	Wend
	
	'Stage_FadeOut
	ClearStage(100,100)
End Sub

Sub stage_1()
	STAGE_COMPLETE = False
	LoadStage("st1.stage")
	
	Init_Default
	
	Stage_Init(2)
	Graizor_Init
	
	
	'------------FADE IN---------------------
	
	st_x = 0
	st_y = 0
	If Actor_X[graizor] > 320 Then
		st_x = Actor_X[graizor] - 320
	End If
		
	If Actor_Y[graizor] > 240 Then
		st_y = Actor_Y[graizor] - 240
	End If
		
	If Actor_Y[graizor] > 600 Then
		Actor_SetPosition(graizor, 52, 380)
	End If
		
	Stage_SetOffset(st_x, st_y)
	
	
	Stage_Layer_Active[3] = True
	
	'platform 01
	'platform_01 = GetActorID("platform_float_01")
	'platform_01_x_speed = 2
	'platform_01_x_min = 2528
	'platform_01_x_max = 2880
	
	'Stage_Layer_AddActorDynaRec(platform_01, 2)
	
	Init_Skulls
	Add_Skull(4288, 1920, 1600, 2)
	Add_Skull(4416, 1920, 1600, 2)
	Add_Skull(4544, 1920, 1600, 2)
	Add_Skull(5920, 1920, 1600, 2)
	Add_Skull(8192, 2016, 1728, 2)
	Add_Skull(8096, 2016, 1728, 2)
	Add_Skull(8000, 2016, 1728, 2)
	Add_Skull(7904, 2016, 1728, 2)
	Add_Skull(7808, 2016, 1728, 2)
	
	Init_Limits
	Add_Limit(2, 2208, 1728, 128, 32)
	Add_Limit(2, 3456, 1728, 320, 32)
	Add_Limit(2, 4192, 1728, 512, 32)
	Add_Limit(2, 5824, 1728, 192, 32)
	Add_Limit(2, 6496, 1824, 1792, 32)

	'M1
	For i = 1 to 7
		m = GetActorID("m1_"+str(i))
		If i = 6 Then
			AI_Init_M1(m, M1_ACTION_STAND_RIGHT2)
		Else
			AI_Init_M1(m, M1_ACTION_STAND_LEFT2)
		End If
	Next
	
	
	'BITWALKER
	For i = 1 to 4
		m = GetActorID("bt_"+str(i))
		AI_Init_BitWalker(m)
	Next
	
	'GUARDS
	AI_Init_Guard_All(2)
	
	Actor_SetPosition(graizor, 96, 1600)
	Actor_SetAnimationByName(graizor, "stand_right")
	Actor_SetAnimationFrame(graizor, 0)
	
	'DEBUG
	'	Actor_SetPosition(graizor, 6944 ,1530)
	
	cp = 0
	Init_Checkpoints
	Add_Checkpoint(96, 1600)
	Add_Checkpoint(3392, 1440)
	Add_Checkpoint(5504, 1568)
	Add_Checkpoint(8320, 1632)
	
	Init_Energy_Cells
	Add_Energy_Cell( GetActorID("energy_cell_1"))
	
	'LoadMusic(dir+"/music/darkrobojungle.mp3")
	'PlayMusic(-1)

	While Not Key(K_ESCAPE)
		num_enemies = 0
		
		stage_limit = Get_Limit(graizor)
		
		If Graizor_CheckDeath Then
			If Player_Continues > 0 Then
				Player_Continues = Player_Continues -1
				Reset_Default
				m1_action[6] = M1_ACTION_STAND_RIGHT2
				Actor_SetAnimationByName(m1_actor[6], "STAND_RIGHT")
				For n = 0 to MAX_M1_BULLETS-1
					Actor_SetAnimationByName(m1_weapon_actor[6, n], "RIGHT")
				Next
				
				StartFromCheckpoint(cp)
			Else
				Exit While
			End If
		ElseIf stage_limit >= 0 Then
			Graizor_Health = 0
			'Print "Limit = ";stage_limit
			'Actor_SetPosition(graizor, 96, 1600)
		End If
		
		M1_Act(graizor)
		BITWALKER_Act(graizor)
		Guard_Act(graizor)
		Skull_Act(graizor)
		Energy_Cell_Act
		
		Player_Control(graizor)
		
		st_x = 0
		st_y = 0
		If Actor_X[graizor] > 320 Then
			st_x = Actor_X[graizor] - 320
		End If
		
		'CHECKPOINTS
		If Actor_X[graizor] >= 8320 Then
			cp = 3
		ElseIf Actor_X[graizor] >= 5504 And cp < 2 Then
			cp = 2
		ElseIf Actor_X[graizor] >= 3392 And cp < 1 Then
			cp = 1
		End If
		
		'LEVEL COMPLETE CONDITION
		If Actor_X[graizor] > 9500 Then
			STAGE_COMPLETE = TRUE
			Exit While
		End If
		
		If Actor_Y[graizor] > 240 Then
			st_y = Actor_Y[graizor] - 240
		End If
		
		'If Actor_Y[graizor] > 600 Then
		'	Actor_SetPosition(graizor, 52, 380)
		'End If
		
		If key(K_P) Then
			Print "FPS: ";FPS
		ElseIf key(K_1) Then
			Actor_SetPosition(graizor, 4128 ,1510)
		ElseIf key(K_2) Then
			Actor_SetPosition(graizor, 7520 ,1400)
		End If
		
		Stage_SetOffset(st_x, st_y)
		
		
		DrawHud
		
		
		Game_Render
		
	Wend
	
	'DeleteMusic
	
	'Stage_FadeOut
	ClearStage(100,100)
End Sub


Sub stage_2()
	STAGE_COMPLETE = False
	LoadStage("st2.stage")
	
	Init_Default
	
	Stage_Init(2)
	Graizor_Init
	
	
	'------------FADE IN---------------------
	
	st_x = 0
	st_y = 0
	If Actor_X[graizor] > 320 Then
		st_x = Actor_X[graizor] - 320
	End If
		
	If Actor_Y[graizor] > 240 Then
		st_y = Actor_Y[graizor] - 240
	End If
		
	If Actor_Y[graizor] > 600 Then
		Actor_SetPosition(graizor, 52, 380)
	End If
		
	Stage_SetOffset(st_x, st_y)
	
	
	'Stage_Layer_Active[3] = True
	
	Init_Skulls
	'Add_Skull(4288, 1920, 1600, 2)
	
	Init_Limits
	'Add_Limit(2, 2208, 1728, 128, 32)
	
	'M1
	For i = 1 to 7
		'm = GetActorID("m1_"+str(i))
		'If i = 6 Then
		'	AI_Init_M1(m, M1_ACTION_STAND_RIGHT2)
		'Else
		'	AI_Init_M1(m, M1_ACTION_STAND_LEFT2)
		'End If
	Next
	
	
	'BITWALKER
	For i = 1 to 4
		'm = GetActorID("bt_"+str(i))
		'AI_Init_BitWalker(m)
	Next
	
	'GUARDS
	'AI_Init_Guard_All(2)
	
	Actor_SetPosition(graizor, 192, 863)
	'Actor_SetPosition(graizor, 4896, 768)
	
	Actor_SetAnimationByName(graizor, "stand_right")
	Actor_SetAnimationFrame(graizor, 0)
	
	cp = 0
	'Init_Checkpoints
	'Add_Checkpoint(96, 1600)
	
	'Init_Energy_Cells
	'Add_Energy_Cell( GetActorID("energy_cell_1"))
	
	Dim px[4]
	Dim py[4]
	
	px[0] = 5376
	py[0] = 960
	
	px[1] = 5152
	py[1] = 960
	
	px[2] = 5152
	py[2] = 256
	
	px[3] = 4864
	py[3] = 256
	
	p_speed_x = 3
	p_speed_y = 3
	
	Init_Platforms
	Add_Platform(4, px, py, p_speed_x, p_speed_y)
	'Add_Platform(4, px, py, p_speed_x, p_speed_y)
	'Add_Platform(4, px, py, p_speed_x, p_speed_y)
	'Add_Platform(4, px, py, p_speed_x, p_speed_y)
	
	skull_wheel_1 = GetActorID("skull_wheel_1")
	AI_Init_Skw(skull_wheel_1)
	Actor_Physics[skull_wheel_1] = True
	Actor_Weight[skull_wheel_1] = 5

	While Not Key(K_ESCAPE)
		num_enemies = 0
		
		stage_limit = Get_Limit(graizor)
		
		If Graizor_CheckDeath Then
			If Player_Continues > 0 Then
				Player_Continues = Player_Continues -1
				StartFromCheckpoint(cp)
			Else
				Exit While
			End If
		ElseIf stage_limit >= 0 Then
			Graizor_Health = 0
			'Print "Limit = ";stage_limit
			'Actor_SetPosition(graizor, 96, 1600)
		End If
		
		'M1_Act(graizor)
		'BITWALKER_Act(graizor)
		'Guard_Act(graizor)
		'Skull_Act(graizor)
		'Energy_Cell_Act
		Platforms_Act
		Skw_Act(graizor)
		
		Player_Control(graizor)
		
		st_x = 0
		st_y = 0
		If Actor_X[graizor] > 320 Then
			st_x = Actor_X[graizor] - 320
		End If
		
		'CHECKPOINTS
		'If Actor_X[graizor] >= 8320 Then
		'	cp = 3
		'ElseIf Actor_X[graizor] >= 5504 And cp < 2 Then
		'	cp = 2
		'ElseIf Actor_X[graizor] >= 3392 And cp < 1 Then
		'	cp = 1
		'End If
		
		'LEVEL COMPLETE CONDITION
		'If Actor_X[graizor] > 9500 Then
		'	STAGE_COMPLETE = TRUE
		'	Exit While
		'End If
		
		If Actor_Y[graizor] > 240 Then
			st_y = Actor_Y[graizor] - 240
		End If
		
		'If Actor_Y[graizor] > 600 Then
		'	Actor_SetPosition(graizor, 52, 380)
		'End If
		
		If key(K_P) Then
			Print "FPS: ";FPS
		ElseIf key(K_1) Then
			Actor_SetPosition(graizor, 5152, 500)
		ElseIf key(K_A) Then
			Actor_Move(graizor, -1, 0)
		ElseIf key(K_D) Then
			Actor_Move(graizor, 1, 0)
		ElseIf Key(K_R) Then
			Print Actor_X[graizor]
		End If
		
		Stage_SetOffset(st_x, st_y)
		
		
		DrawHud
		
		
		Game_Render
		'If Actor_NumStageCollisions[graizor] > 6 Then
		'	Print Actor_NumStageCollisions[graizor]
		'End If
	Wend
	
	'Stage_FadeOut
	'Print "DEBUG 1"
	ClearStage(100,100)
	'Print "DEBUG 2"
End Sub


Sub Run_Game()
	Graizor_Health = 8
	Graizor_Sword_Attack = 4
	Graizor_Beam_Attack = 2
	blaster_atk = Graizor_Beam_Attack
	blaster_ammo = 30
	Player_Continues = 5
	
	'Init_Default
	'Stage1_Boss
	'Return
	'city_test
	stage_1
	
	If STAGE_COMPLETE Then
		Init_Default
		Stage1_Boss
	Else
		'Lose Condition
		Game_Over
		Return
	End If
	
	Return
	'city_test
	stage_1
	
	If STAGE_COMPLETE Then
		Init_Default
		Stage1_Boss
	Else
		'Lose Condition
		Game_Over
		Return
	End If
	
End Sub


'---TITLE------------------

Dim Title_Star_Sprite
Dim Game_Select_Sprite
Dim Game_Font[2]
Dim Game_Menu$[3,20]
Dim Game_Menu_Current_Item

num_stars = 200
Dim Title_Star_Data[num_stars, 3]

Game_Menu$[0,0] = "New Game"
Game_Menu$[0,1] = "Load Game"
Game_Menu$[0,2] = "Options"
Game_Menu$[0,3] = "Quit"

Game_Menu$[1,0] = "[LABEL]SCREEN OPTIONS"
Game_Menu$[1,1] = "[LABEL]________________________________________"
Game_Menu$[1,2] = "Fullscreen: &ON_OFF"
Game_Menu$[1,3] = "[SPACE]"
Game_Menu$[1,4] = "[SPACE]"
Game_Menu$[1,5] = "[LABEL]PLAYER CONTROL: &CONTROL"
Game_Menu$[1,6] = "[LABEL]________________________________________"
Game_Menu$[1,7] = "Set Control to Keyboard"
Game_Menu$[1,8] = "Set Control to Joystick"
Game_Menu$[1,9] = "Attack Button: &ATK_BTN"
Game_Menu$[1,10] = "Jump Button: &JMP_BTN"
Game_Menu$[1,11] = "Weapon Button: &WPN_BTN"
Game_Menu$[1,12] = "[SPACE]"
Game_Menu$[1,13] = "[SPACE]"
Game_Menu$[1,14] = "Back To Main Menu"


Dim Game_Menu_Variable$[3,10,2]
Game_Menu_Variable$[1, 0, 0] = "&ON_OFF"
Game_Menu_Variable$[1, 1, 0] = "&CONTROL"
Game_Menu_Variable$[1, 2, 0] = "&ATK_BTN"
Game_Menu_Variable$[1, 3, 0] = "&JMP_BTN"
Game_Menu_Variable$[1, 4, 0] = "&WPN_BTN"

Dim Game_Menu_Count[3]
Game_Menu_Count[0] = 4
Game_Menu_Count[1] = 8

Dim Game_Menu_X[3]
Dim Game_Menu_Y[3]

Dim Game_Current_Menu

Dim Selectable_Menu_Items[3,20]

Dim Game_Menu_Select_Width[3]
Dim Game_Menu_Select_Height[3]
Dim Game_Menu_Select_Image_Width
Dim Game_Menu_Select_Image_Height


Dim Title_Logo_Sprite
Dim Menu_Msg_Sprite

Dim Options_Bkg_Color

Sub Title_Load_Assets()
	n = 0
	For i = 0 to 31
		If Not FontIsLoaded(i) Then
			Game_Font[n] = i
			LoadFont(Game_Font[n], FONT_PATH$ + "press-start/prstart.ttf", 14 + (2*n))
			n = n + 1
		End If
		If n = 2 Then
			Exit For
		End If
	Next
	Title_Star_Sprite = GetFreeImage
	LoadImage(Title_Star_Sprite, SPRITE_PATH$ + "title_star.png")
	
	Game_Select_Sprite = GetFreeImage
	LoadImage(Game_Select_Sprite, SPRITE_PATH$ + "Menu_Select.png")
	
	GetImageSize(Game_Select_Sprite, Game_Menu_Select_Image_Width, Game_Menu_Select_Image_Height)
	
	
	Title_Logo_Sprite = GetFreeImage
	LoadImage(Title_Logo_Sprite, SPRITE_PATH$ + "g_title.png")
	
	Menu_Msg_Sprite = GetFreeImage
	LoadImage(Menu_Msg_Sprite, SPRITE_PATH$ + "msg_win.png")
	
	For i = 0 to num_stars-1
		Title_Star_Data[i, 0] = Rand(640)
		Title_Star_Data[i, 1] = Rand(480)
		Title_Star_Data[i, 2] = Rand(4)+1
	Next
	
	CanvasClose(0)
	CanvasOpen(0, 640, 480, 0, 0, 640, 480, 0)
	Canvas(0)
	'SetColor(RGB(0, 0, 255))
	'RectFill(0, 0, 640, 480)
	
	CanvasClose(1)
	CanvasOpen(1, 640, 480, 0, 0, 640, 480, 1)
	Canvas(1)
	ClearCanvas
	
	CanvasClose(2)
	CanvasOpen(2, 640, 480, 0, 0, 640, 480, 1)
	Canvas(2)
	ClearCanvas
	
	CanvasClose(5)
	CanvasOpen(5, 640, 480, 0, 0, 640, 480, 1)
	Canvas(5)
	ClearCanvas
	
	Options_Bkg_Color = HexVal("306082")
	
	SetCanvasZ(0, 3)
	SetCanvasZ(1, 2)
	SetCanvasZ(2, 1)
	SetCanvasZ(5, 0)
	
	Dim w
	Dim h
	
	For menu_num = 0 to 1
		n = 0
		Game_Menu_Select_Width[menu_num] = 1
		For i = 0 to ArraySize(Game_Menu$, 2)-1
			If Game_Menu$[menu_num, i] = "" Then
				Selectable_Menu_Items[menu_num, n] = -1
				Exit For
			End If
			
			If Game_Menu$[menu_num, i] = "[SPACE]" Or Mid$(Game_Menu$[menu_num, i], 0, 7) = "[LABEL]" Then
				'Do Nothing
			Else
				Selectable_Menu_Items[menu_num, n] = i
				GetTextSize(Game_Font[1], Game_Menu$[menu_num, i], w, h)
				If w > Game_Menu_Select_Width[menu_num] Then
					Game_Menu_Select_Width[menu_num] = w + 60
					Game_Menu_Select_Height[menu_num] = h
				End If
				n = n + 1
			End If
			
		Next
	Next
	
	'For i = 0 to 19
	'	Print "Selectable Item: ";Selectable_Menu_Items[1,i]
	'Next
	
	Game_Menu_X[0] = 260
	Game_Menu_Y[0] = 300
	
	Game_Menu_X[1] = 100
	Game_Menu_Y[1] = 100
End Sub

Sub Title_Clear_Assets()
	n = 0
	DeleteFont(Game_Font[0])
	DeleteFont(Game_Font[1])

	DeleteImage(Title_Star_Sprite)
	DeleteImage(Game_Select_Sprite)
	DeleteImage(Title_Logo_Sprite)
	DeleteImage(Menu_Msg_Sprite)
	
	CanvasClose(0)
	CanvasClose(1)
	CanvasClose(2)
	CanvasClose(5)
	
End Sub

Sub Title_Bkg_Update()
	Canvas(1)
	ClearCanvas
	SetColor(RGB(0, 0, 255))
	RectFill(0, 0, 640, 480)
	If num_stars < 1 Then
		Return
	End If
	For i = 0 to num_stars-1
		Title_Star_Data[i, 0] = Title_Star_Data[i, 0] - Title_Star_Data[i, 2]
		If Title_Star_Data[i, 0] <= -3 Then
			Title_Star_Data[i, 0] = 640
		End If
		DrawImage(Title_Star_Sprite, Title_Star_Data[i, 0], Title_Star_Data[i,1])
	Next
End Sub

''''
Game_Menu_Variable$[1, 0, 0] = "&ON_OFF"
Game_Menu_Variable$[1, 1, 0] = "&CONTROL"
Game_Menu_Variable$[1, 2, 0] = "&ATK_BTN"
Game_Menu_Variable$[1, 3, 0] = "&JMP_BTN"
Game_Menu_Variable$[1, 4, 0] = "&WPN_BTN"
'''

Function Game_Menu_Replace_Vars$(txt$)
	out_txt$ = txt$
	For i = 0 to ArraySize(Game_Menu_Variable$, 2)-1
		var$ = Game_Menu_Variable$[Game_Current_Menu, i, 0]
		var_val$ = ""
		Select Case var$
		Case "&ON_OFF"
			If WindowIsFullscreen(0) Then
				var_val$ = "ON"
			Else
				var_val$ = "OFF"
			End IF
		Case "&CONTROL"
			Select Case PLAYER_CONTROL_TYPE
			Case PLAYER_CONTROL_TYPE_KEYBOARD: var_val$ = "Keyboard"
			Case PLAYER_CONTROL_TYPE_JOYSTICK: var_val$ = "Game Controller"
			End Select
		Case "&ATK_BTN"
			If PLAYER_CONTROL_TYPE = PLAYER_CONTROL_TYPE_KEYBOARD Then: var_val$ = Chr$(PLAYER_SLASH_BUTTON)
			Else : var_val$ = "BUTTON " + Str$(PLAYER_SLASH_BUTTON)
			End If
		Case "&JMP_BTN"
			If PLAYER_CONTROL_TYPE = PLAYER_CONTROL_TYPE_KEYBOARD Then: var_val$ = Chr$(PLAYER_JUMP_BUTTON)
			Else : var_val$ = "BUTTON " + Str$(PLAYER_JUMP_BUTTON)
			End If
		Case "&WPN_BTN"
			If PLAYER_CONTROL_TYPE = PLAYER_CONTROL_TYPE_KEYBOARD Then: var_val$ = Chr$(PLAYER_WEAPON_BUTTON)
			Else : var_val$ = "BUTTON " + Str$(PLAYER_WEAPON_BUTTON)
			End If
		End Select
		Game_Menu_Variable$[Game_Current_Menu, i, 1] = var_val$
		out_txt$ = Replace(out_txt$, var$, var_val$)
	Next
	Return out_txt$
End Function

Sub Game_Menu_Update()
	Canvas(2)
	ClearCanvas
	Menu_X = Game_Menu_X[Game_Current_Menu]
	Menu_Y = Game_Menu_Y[Game_Current_Menu]
	Menu_Space = 0
	SetColor(RGB(255,255,255))
	For i = 0 to ArraySize(Game_Menu$, 2)-1
		If Game_Menu$[Game_Current_Menu, i] = "" Then
			Exit For
		End If
		Select Case Game_Menu_Current_Item
		Case i
			DrawImage_Blit_Ex(Game_Select_Sprite, Menu_X-20, Menu_Y + (i*15), Game_Menu_Select_Width[Game_Current_Menu], Game_Menu_Select_Image_Height, 0, 0, Game_Menu_Select_Image_Width, Game_Menu_Select_Image_Height)
			Font(Game_Font[1])
			Menu_Space = 4
		Default
			Font(Game_Font[0])
			Menu_Space = 0
		End Select
		If Game_Menu$[Game_Current_Menu, i] = "[SPACE]" Then
			'Do nothing
		ElseIf Mid$(Game_Menu$[Game_Current_Menu, i], 0, 7) = "[LABEL]" Then
			DrawText(Game_Menu_Replace_Vars$(Mid$(Game_Menu$[Game_Current_Menu, i],7,Length(Game_Menu$[Game_Current_Menu,i])-7)), Menu_X, Menu_Y + (i*15) + 2)
		Else
			DrawText(Game_Menu_Replace_Vars$(Game_Menu$[Game_Current_Menu, i]), Menu_X, Menu_Y + (i*15) + 2)
		End If
	Next
	
	Select Case Game_Current_Menu
	Case 0
		DrawImage(Title_Logo_Sprite, 200, 120)
	Default
	End Select
End Sub

Game_Menu_Ready = False
Game_Menu_Key_Timer = 0
Dim Game_Menu_Item_Selected
Dim Current_Selectable_Item

Sub Game_Menu_Control()
	If (Timer - Game_Menu_Key_Timer) < 200 Then
		Return
	ElseIf Not (Key(K_RETURN) Or JoyButton(0, 0)) Then
		Game_Menu_Ready = True
	End If
	
	If Not Game_Menu_Ready Then
		Return
	End If
	
	If (Key(K_DOWN) Or JoyHat(0, 0) = HAT_DOWN) And Selectable_Menu_Items[Game_Current_Menu, Current_Selectable_Item+1] <> -1 Then
		Current_Selectable_Item = Current_Selectable_Item + 1
		Game_Menu_Current_Item = Selectable_Menu_Items[Game_Current_Menu, Current_Selectable_Item]
		Game_Menu_Key_Timer = Timer
	ElseIf (Key(K_UP) Or JoyHat(0, 0) = HAT_UP) And Current_Selectable_Item > 0 Then
		Current_Selectable_Item = Current_Selectable_Item - 1
		Game_Menu_Current_Item = Selectable_Menu_Items[Game_Current_Menu, Current_Selectable_Item]
		Game_Menu_Key_Timer = Timer
	ElseIf Key(K_RETURN) Or JoyButton(0, 0) Then
		'Print "Item selected = ";Game_Menu$[Game_Current_Menu, Game_Menu_Current_Item]
		Game_Menu_Key_Timer = Timer
		Game_Menu_Ready = False
		Game_Menu_Item_Selected = True
	End If
End Sub

Sub Game_Menu_Action()
	If Not Game_Menu_Item_Selected Then
		Return
	End If
	Select Case Game_Current_Menu
	Case 0 'Title Menu
		Select Case Current_Selectable_Item
		Case 0 'New Game
			'Stage_FadeOut
			Title_Clear_Assets
			Run_Game
			Title_Load_Assets	
			'Stage_FadeIn
		Case 1 'Load Game
		
		Case 2 'Options
			Game_Current_Menu = 1
			Current_Selectable_Item = 0
			Game_Menu_Current_Item = Selectable_Menu_Items[1, Current_Selectable_Item]
		Case 3 'Quit
			End
		End Select
	Case 1 'Options Menu
		Select Case Current_Selectable_Item
		Case 0 'Fullscreen Toggle
			Title_Clear_Assets
			SetWindowFullscreen(0, Not WindowIsFullscreen(0) )
			Title_Load_Assets
		Case 1 'Set Control to Keyboard
			PLAYER_CONTROL_TYPE = PLAYER_CONTROL_TYPE_KEYBOARD
			Player_SetDefaultControls(PLAYER_CONTROL_TYPE_KEYBOARD)
		Case 2 'Set Control to Joystick
			PLAYER_CONTROL_TYPE = PLAYER_CONTROL_TYPE_JOYSTICK
			Player_SetDefaultControls(PLAYER_CONTROL_TYPE_JOYSTICK)
		Case 3, 4, 5 'Attack button
			Select Case PLAYER_CONTROL_TYPE
			Case PLAYER_CONTROL_TYPE_KEYBOARD
				While True
					Title_Bkg_Update
					
					Canvas(2)
					DrawImage(Menu_Msg_Sprite, 250, 200)
					SetColor(RGB(255,255,255))
					Font(Game_Font[0])
					DrawText("Press A Button", 270, 220)
					
					k = Inkey
					If k = K_ESCAPE Then
						While Key(K_ESCAPE)
							Title_Bkg_Update
							Update
						Wend
						Exit While
					ElseIf k <> 0 And k <> K_RETURN Then
						Select Case Current_Selectable_Item
						Case 3: PLAYER_SLASH_BUTTON = k
						Case 4: PLAYER_JUMP_BUTTON = k
						Case 5: PLAYER_WEAPON_BUTTON = k
						End Select
						Exit While
					End If
					Update
				Wend
			Case PLAYER_CONTROL_TYPE_JOYSTICK
				GetJoystick(0)
				While button[0]
					GetJoystick(0)
					Title_Bkg_Update
					Update
				Wend
				While True
					Title_Bkg_Update
					
					Canvas(2)
					DrawImage(Menu_Msg_Sprite, 250, 200)
					SetColor(RGB(255,255,255))
					Font(Game_Font[0])
					DrawText("Press A Button", 270, 220)
					
					GetJoystick(0)
					If button[6] Then
						While button[6]
							GetJoystick(0)
							Title_Bkg_Update
							Update
						Wend
						Exit While
					ElseIf joy_button_activity Then
						k = 0
						If NumJoyButtons(0) > 0 Then
							For i = 0 To NumJoyButtons(0)-1
								If button[i] Then
									k = i
									Exit For
								End If
							Next
						End If
						Select Case Current_Selectable_Item
						Case 3: PLAYER_SLASH_BUTTON = k
						Case 4: PLAYER_JUMP_BUTTON = k
						Case 5: PLAYER_WEAPON_BUTTON = k
						End Select
						Exit While
					End If
					Update
				Wend
			End Select
		Case 6 'Back to Main Menu
			Game_Current_Menu = 0
			Current_Selectable_Item = 0
			Game_Menu_Current_Item = Selectable_Menu_Items[0, Current_Selectable_Item]
		End Select
	End Select
	Game_Menu_Item_Selected = False
End Sub

Function Title_Screen()
	While Not Key(K_ESCAPE)
		Title_Bkg_Update
		Game_Menu_Update
		Game_Menu_Control
		Game_Menu_Action
		Update
	Wend
	End
End Function

Game_Init

Title_Load_Assets
Title_Screen

'end

'Graizor_Jump_Height = 40
'Graizor_Jump_Force = 3.5

Stage1_1
'wait(300)
'Update
'print "end stage 1"
Stage1_Boss
'city_test
'city_boss
'stage_2
