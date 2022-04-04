Dim graizor
Dim beam_sword
Dim blaster

'LoadFont(0, FONT_PATH$ + "FreeMono.ttf", 16)
'Actor_SetPosition(GetActorID("graizor"), Actor_X[graizor], Actor_Y[graizor] - 5)

Dim PLAYER_CONTROL_TYPE
Dim PLAYER_CONTROL_TYPE_KEYBOARD: PLAYER_CONTROL_TYPE_KEYBOARD = 0
Dim PLAYER_CONTROL_TYPE_JOYSTICK: PLAYER_CONTROL_TYPE_JOYSTICK = 1

PLAYER_JUMP_BUTTON = K_Z
PLAYER_SLASH_BUTTON = K_X
PLAYER_LEFT_BUTTON = K_LEFT
PLAYER_RIGHT_BUTTON = K_RIGHT
PLAYER_UP_BUTTON = K_UP
PLAYER_DOWN_BUTTON = K_DOWN
PLAYER_WEAPON_BUTTON = K_C

'k = false

jump_ready = true
jump_button_down = false
jump_button_timer = 0

atk_ready = true
atk_button_down = false
atk_button_timer = 0


Dim PLAYER_ACTION_STAND_RIGHT
Dim PLAYER_ACTION_WALK_RIGHT
Dim PLAYER_ACTION_DUCK_RIGHT
Dim PLAYER_ACTION_JUMP_RIGHT
Dim PLAYER_ACTION_WALK_SHOOT_RIGHT
Dim PLAYER_ACTION_WALK_SHOOT_RIGHT_UP
Dim PLAYER_ACTION_WALK_SHOOT_UPR
Dim PLAYER_ACTION_STAND_SHOOT_RIGHT
Dim PLAYER_ACTION_STAND_SHOOT_UPR
Dim PLAYER_ACTION_JUMP_SHOOT_RIGHT
Dim PLAYER_ACTION_JUMP_SHOOT_RIGHT_UP
Dim PLAYER_ACTION_JUMP_SHOOT_RIGHT_DOWN
Dim PLAYER_ACTION_JUMP_SHOOT_DOWNR
Dim PLAYER_ACTION_JUMP_SHOOT_UPR
Dim PLAYER_ACTION_SLASH_RIGHT
Dim PLAYER_ACTION_JUMP_SLASH_RIGHT

Dim PLAYER_ACTION_STAND_LEFT
Dim PLAYER_ACTION_WALK_LEFT
Dim PLAYER_ACTION_DUCK_LEFT
Dim PLAYER_ACTION_JUMP_LEFT
Dim PLAYER_ACTION_WALK_SHOOT_LEFT
Dim PLAYER_ACTION_WALK_SHOOT_LEFT_UP
Dim PLAYER_ACTION_WALK_SHOOT_UPL
Dim PLAYER_ACTION_STAND_SHOOT_LEFT
Dim PLAYER_ACTION_STAND_SHOOT_UPL
Dim PLAYER_ACTION_JUMP_SHOOT_LEFT
Dim PLAYER_ACTION_JUMP_SHOOT_LEFT_UP
Dim PLAYER_ACTION_JUMP_SHOOT_LEFT_DOWN
Dim PLAYER_ACTION_JUMP_SHOOT_DOWNL
Dim PLAYER_ACTION_JUMP_SHOOT_UPL
Dim PLAYER_ACTION_SLASH_LEFT
Dim PLAYER_ACTION_JUMP_SLASH_LEFT

Dim PLAYER_ACTION_STUN_RIGHT
Dim PLAYER_ACTION_STUN_LEFT
Dim PLAYER_ACTION_DUCK_SLASH_RIGHT
Dim PLAYER_ACTION_DUCK_SLASH_LEFT

Dim PLAYER_ACTION_DOWN_SLASH_RIGHT
Dim PLAYER_ACTION_DOWN_SLASH_LEFT

PLAYER_ACTION_STAND_RIGHT = 0
PLAYER_ACTION_WALK_RIGHT = 1
PLAYER_ACTION_DUCK_RIGHT = 2
PLAYER_ACTION_WALK_SHOOT_RIGHT = 3
PLAYER_ACTION_WALK_SHOOT_RIGHT_UP = 4
PLAYER_ACTION_WALK_SHOOT_UPR = 5
PLAYER_ACTION_STAND_SHOOT_RIGHT = 6
PLAYER_ACTION_STAND_SHOOT_UPR = 7
PLAYER_ACTION_JUMP_RIGHT = 8
PLAYER_ACTION_JUMP_SHOOT_RIGHT = 9
PLAYER_ACTION_JUMP_SHOOT_RIGHT_UP = 10
PLAYER_ACTION_JUMP_SHOOT_RIGHT_DOWN = 11
PLAYER_ACTION_JUMP_SHOOT_DOWNR = 12
PLAYER_ACTION_JUMP_SHOOT_UPR = 13
PLAYER_ACTION_SLASH_RIGHT = 14
PLAYER_ACTION_JUMP_SLASH_RIGHT = 15

PLAYER_ACTION_STAND_LEFT = 16
PLAYER_ACTION_WALK_LEFT = 17
PLAYER_ACTION_DUCK_LEFT = 18
PLAYER_ACTION_WALK_SHOOT_LEFT = 19
PLAYER_ACTION_WALK_SHOOT_LEFT_UP = 20
PLAYER_ACTION_WALK_SHOOT_UPL = 21
PLAYER_ACTION_STAND_SHOOT_LEFT = 22
PLAYER_ACTION_STAND_SHOOT_UPL = 23
PLAYER_ACTION_JUMP_LEFT = 24
PLAYER_ACTION_JUMP_SHOOT_LEFT = 25
PLAYER_ACTION_JUMP_SHOOT_LEFT_UP = 26
PLAYER_ACTION_JUMP_SHOOT_LEFT_DOWN = 27
PLAYER_ACTION_JUMP_SHOOT_DOWNL = 28
PLAYER_ACTION_JUMP_SHOOT_UPL = 29
PLAYER_ACTION_SLASH_LEFT = 30
PLAYER_ACTION_JUMP_SLASH_LEFT = 31

PLAYER_ACTION_STUN_RIGHT = 32
PLAYER_ACTION_STUN_LEFT = 33

PLAYER_ACTION_DUCK_SLASH_RIGHT = 34
PLAYER_ACTION_DUCK_SLASH_LEFT = 35

PLAYER_ACTION_DOWN_SLASH_RIGHT = 36
PLAYER_ACTION_DOWN_SLASH_LEFT = 37

Dim Player_Current_Physics_State
Player_Current_Physics_State = PHYSICS_STATE_FALL
Dim Player_Current_Action
Dim Player_Action

Dim lock_action
lock_action = false

Dim Player_Stun_Total_Time
Player_Stun_Total_Time = 300
Dim Player_Invincible_Total_Time
Player_Invincible_Total_Time = 800
Dim Player_Invincible
Player_Invincible = False
Dim Player_Invincible_Time
Player_Invincible_Time = 0
Dim Player_Stun_Time
Dim Player_isStunned
Dim Player_Stun_Speed

Dim Graizor_Health
Graizor_Health = 8

Dim blaster_max_shots_onscreen
blaster_max_shots_onscreen = 8

Dim blaster_shot[blaster_max_shots_onscreen]

Dim blaster_ammo
Dim blaster_timer
Dim blaster_atk
Dim blaster_shot_speed[blaster_max_shots_onscreen,2]
blaster_ammo = 30
blaster_shot_move_speed = 6
blaster_timer = timer

Dim explosion_sound

Dim Graizor_Jump_Height
Dim Graizor_Jump_Force

Graizor_Jump_Height = 48
Graizor_Jump_Force = 4

Dim Graizor_Weight
Graizor_Weight = 4.5

'Actor_SyncAnimationTo(beam_sword, graizor)

Dim GRAIZOR_CURRENT_WEAPON
Dim WEAPON_SWITCH_TIMER
Dim weapon_switch_ready
Dim PLAYER_UP_STATE
Dim PLAYER_DOWN_STATE
PLAYER_UP_STATE = 0
PLAYER_DOWN_STATE = 0
GRAIZOR_CURRENT_WEAPON = 0

Dim Down_Slash_Flag
Down_Slash_Flag = 0

Dim Down_Slash_Timer
Down_Slash_Timer = 0

Dim Down_Slash_Sound

Dim num_enemies
Dim enemy[200]
Dim enemy_hit[200]

Dim shot_sound_1
Dim graizor_shot_sound

Dim add_stun_time
add_stun_time = 0

Dim GRAIZOR_DIRECTION_LEFT
Dim GRAIZOR_DIRECTION_RIGHT

GRAIZOR_DIRECTION_LEFT = 0
GRAIZOR_DIRECTION_RIGHT = 1

Function Graizor_Direction()
	If Player_Current_Action <= 15 Or Player_Current_Action = 32 Or Player_Current_Action = 34 Or Player_Current_Action = 36 Then
		Return GRAIZOR_DIRECTION_RIGHT
	End If
	Return GRAIZOR_DIRECTION_LEFT
End Function

Sub GZ_Actor_SetAnimation(actor)

	Select Case Player_Current_Action
	
	Case PLAYER_ACTION_STAND_RIGHT
		Actor_SetAnimationByName(actor, "Idle_right")
		Actor_SetAnimationFrame(actor, 0)
	
	Case PLAYER_ACTION_WALK_RIGHT
		Actor_SetAnimationByName(actor, "Run_right")
		
	Case PLAYER_ACTION_JUMP_RIGHT
		Actor_SetAnimationByName(actor, "Jump_right")
		Actor_SetAnimationFrame(actor, 0)
		
	Case PLAYER_ACTION_STAND_LEFT
		Actor_SetAnimationByName(actor, "Idle_left")
		Actor_SetAnimationFrame(actor, 0)
	
	Case PLAYER_ACTION_WALK_LEFT
		Actor_SetAnimationByName(actor, "Run_left")
		
	Case PLAYER_ACTION_JUMP_LEFT
		Actor_SetAnimationByName(actor, "Jump_left")
		Actor_SetAnimationFrame(actor, 0)
		
	Case PLAYER_ACTION_STUN_LEFT
		Actor_SetAnimationByName(actor, "Stun_left")
		Actor_SetAnimationFrame(actor, 0)
		Actor_Move(actor, Player_Stun_Speed, 0)
		Down_Slash_Flag = 0
		Player_Invincible = True
		Player_Invincible_Time = Timer
		Actor_EnableCollisions(actor, False)
		Actor_SetEffect(actor, EFFECT_FLASH, 70)
	
	Case PLAYER_ACTION_STUN_RIGHT
		Actor_SetAnimationByName(actor, "Stun_right")
		Actor_SetAnimationFrame(actor, 0)
		Actor_Move(actor, Player_Stun_Speed, 0)
		Down_Slash_Flag = 0
		Player_Invincible = True
		Player_Invincible_Time = Timer
		Actor_EnableCollisions(actor, False)
		Actor_SetEffect(actor, EFFECT_FLASH, 70)
	
	End Select
End Sub

Sub Player_SetDefaultControls(control_type)
	Select Case control_type
	Case PLAYER_CONTROL_TYPE_JOYSTICK
		PLAYER_JUMP_BUTTON = 0
		PLAYER_SLASH_BUTTON = 2
		PLAYER_LEFT_BUTTON = HAT_LEFT
		PLAYER_RIGHT_BUTTON = HAT_RIGHT
		PLAYER_UP_BUTTON = HAT_UP
		PLAYER_DOWN_BUTTON = HAT_DOWN
		PLAYER_WEAPON_BUTTON = 1
	Case PLAYER_CONTROL_TYPE_KEYBOARD
		PLAYER_JUMP_BUTTON = K_Z
		PLAYER_SLASH_BUTTON = K_X
		PLAYER_LEFT_BUTTON = K_LEFT
		PLAYER_RIGHT_BUTTON = K_RIGHT
		PLAYER_UP_BUTTON = K_UP
		PLAYER_DOWN_BUTTON = K_DOWN
		PLAYER_WEAPON_BUTTON = K_C
	End Select
End Sub

Function Player_Button(b, is_dir)
	Select Case PLAYER_CONTROL_TYPE
	Case PLAYER_CONTROL_TYPE_KEYBOARD
		Return Key(b)
	Case PLAYER_CONTROL_TYPE_JOYSTICK
		If is_dir And (b=PLAYER_LEFT_BUTTON Or b=PLAYER_RIGHT_BUTTON Or b=PLAYER_UP_BUTTON Or b=PLAYER_DOWN_BUTTON) Then
			Return (joy_hat_activity And hat[0] = b)
		Else
			Return (joy_button_activity And button[b])
		End If
	End Select
	Return False
End Function

Sub Player_Control_Ex(actor)
	
	If Player_Invincible Then
		If (Timer - Player_Invincible_Time) >= Player_Invincible_Total_Time Then
			Player_Invincible = False
			Actor_EnableCollisions(actor, True)
			Actor_SetEffect(actor, EFFECT_NONE, 0)
		End If
	End If

	PLAYER_UP_STATE = false
	PLAYER_DOWN_STATE = false
	
	Player_KeyIsPressed = false
	Player_Action = Player_Current_Action
	
	
	Actor_Weight[actor] = Graizor_Weight
	add_stun_time = 0
	
	
	'''---CONTROLS----------
	
	If Player_Current_Physics_State <> PHYSICS_STATE_GROUND And Actor_Physics_State[actor] = PHYSICS_STATE_GROUND Then
		If Player_Current_Action <= 15 Then
			Player_Action = PLAYER_ACTION_STAND_RIGHT
		Else
			Player_Action = PLAYER_ACTION_STAND_LEFT
		End If
		Player_Current_Physics_State = PHYSICS_STATE_GROUND
	End If
		
	If Player_Button(PLAYER_LEFT_BUTTON,True) Then
		Player_KeyIsPressed = true
		Select Case Actor_Physics_State[actor]
		Case PHYSICS_STATE_GROUND
			Player_Action = PLAYER_ACTION_WALK_LEFT
			If Actor_Speed[actor] > 0 Then
				Actor_Speed[actor] = 0
			End If
			Actor_Speed[actor] = Actor_Speed[actor] - 0.1
			If Actor_Speed[actor] < -3 Then
				Actor_Speed[actor] = -3
			End If
		Case PHYSICS_STATE_RISE
			Player_Action = PLAYER_ACTION_JUMP_LEFT
			Actor_Speed[actor] = Actor_Speed[actor] - 0.1
			If Actor_Speed[actor] < -3 Then
				Actor_Speed[actor] = -3
			End If
		Case PHYSICS_STATE_FALL
			Player_Action = PLAYER_ACTION_JUMP_LEFT
			Actor_Speed[actor] = Actor_Speed[actor] - 0.2
			If Actor_Speed[actor] < -3 Then
				Actor_Speed[actor] = -3
			End If
		End Select
		
		Actor_Force(actor, Actor_Speed[actor], 0)
	End If
	
	If Player_Button(PLAYER_RIGHT_BUTTON,True) Then
		Player_KeyIsPressed = true
		Select Case Actor_Physics_State[actor]
		Case PHYSICS_STATE_GROUND
			Player_Action = PLAYER_ACTION_WALK_RIGHT
			If Actor_Speed[actor] < 0 Then
				Actor_Speed[actor] = 0
			End If
			Actor_Speed[actor] = Actor_Speed[actor] + 0.1
			If Actor_Speed[actor] > 3 Then
				Actor_Speed[actor] = 3
			End If
		Case PHYSICS_STATE_RISE
			Player_Action = PLAYER_ACTION_JUMP_RIGHT
			Actor_Speed[actor] = Actor_Speed[actor] + 0.1
			If Actor_Speed[actor] > 3 Then
				Actor_Speed[actor] = 3
			End If
		Case PHYSICS_STATE_FALL
			Player_Action = PLAYER_ACTION_JUMP_RIGHT
			Actor_Speed[actor] = Actor_Speed[actor] + 0.2
			If Actor_Speed[actor] > 3 Then
				Actor_Speed[actor] = 3
			End If
		End Select
		
		Actor_Force(actor, Actor_Speed[actor], 0)
	End If
	
	
	If Not Player_KeyIsPressed And Actor_Physics_State[actor] = PHYSICS_STATE_GROUND Then
		Actor_Force_X[actor] = 0
		Actor_Speed[actor] = 0
		If Player_Action <= 15 Then
			Player_Action = PLAYER_ACTION_STAND_RIGHT
		Else
			Player_Action = PLAYER_ACTION_STAND_LEFT
		End If
	End If
	
	If jump_ready And Player_Button(PLAYER_JUMP_BUTTON,0) And Actor_Physics_State[actor] = PHYSICS_STATE_GROUND And Not Player_isStunned Then
		If Player_Action <= 15 Then
			Player_Action = PLAYER_ACTION_JUMP_RIGHT
		Else
			Player_Action = PLAYER_ACTION_JUMP_LEFT
		End If
		Actor_Jump[actor] = Graizor_Jump_Height
		'Actor_Force_X[0] = 2
		Actor_Force_Y[actor] = 0 - Graizor_Jump_Force
		'Actor_Momentum[0] = 2
		'Actor_Weight[actor] = 3
		Actor_Physics_State[actor] = PHYSICS_STATE_RISE
		jump_ready = false
		jump_button_timer = timer
		jump_button_down = true
		'PlaySound(2, 1, 0)
		'print "dbg 1"
	ElseIf Actor_Physics_State[actor] <> PHYSICS_STATE_GROUND And Not jump_ready And Not Player_Button(PLAYER_JUMP_BUTTON,0) Then
		jump_button_down = false
		'print "dbg 2"
	ElseIf Actor_Physics_State[actor] = PHYSICS_STATE_RISE And Player_Button(PLAYER_JUMP_BUTTON,0) And jump_button_down And (timer -jump_button_timer) < 200 And Not Player_isStunned Then
		Actor_Jump[actor] = Graizor_Jump_Height + (timer - jump_button_timer)/10
		'print "dbg 3";timer
	ElseIf Actor_Physics_State[actor] = PHYSICS_STATE_GROUND And (Not Player_Button(PLAYER_JUMP_BUTTON,0)) Then
		jump_ready = true
		jump_button_down = false
		If Player_Action = PLAYER_ACTION_JUMP_LEFT Or Player_Action = PLAYER_ACTION_JUMP_RIGHT Then
			If Player_Action <= 15 Then
				Player_Action = PLAYER_ACTION_STAND_RIGHT
			Else
				Player_Action = PLAYER_ACTION_STAND_LEFT
			End If
		End If
		'print "dbg 4"
	End If
	
	
	'''----------END OF CONTROLS---------
	
		'-25-20
	Select Case Player_Current_Action
	
	Case PLAYER_ACTION_STAND_RIGHT
		Player_Current_Action = Player_Action
	
	Case PLAYER_ACTION_WALK_RIGHT
		Player_Current_Action = Player_Action
	
	Case PLAYER_ACTION_JUMP_RIGHT
		If (Actor_Physics_State[actor] <> PHYSICS_STATE_GROUND) And ((Player_Action >= 8 And Player_Action <= 15) Or Player_Action >= 24) Then
			Player_Current_Action = Player_Action
		ElseIf (Actor_Physics_State[actor] = PHYSICS_STATE_GROUND) And ((Player_Action <= 8 Or Player_Action = 14) Or (Player_Action >= 15 And Player_Action < 24) Or Player_Action = 30) Then
			Player_Current_Action = Player_Action
		End If
	
	Case PLAYER_ACTION_STUN_RIGHT
		If (Actor_Physics_State[actor] = PHYSICS_STATE_GROUND) And Timer - Player_Stun_Time >= Player_Stun_Total_Time Then
			Player_Current_Action = PLAYER_ACTION_STAND_RIGHT
			Player_isStunned = False
			jump_ready = true
		End If
		
	Case PLAYER_ACTION_STAND_LEFT
		Player_Current_Action = Player_Action
	
	Case PLAYER_ACTION_WALK_LEFT
		Player_Current_Action = Player_Action
	
	Case PLAYER_ACTION_JUMP_LEFT
		If (Actor_Physics_State[actor] <> PHYSICS_STATE_GROUND) And (( Player_Action >= 8 And Player_Action <= 15) Or Player_Action >= 24) Then
			Player_Current_Action = Player_Action
		ElseIf (Actor_Physics_State[actor] = PHYSICS_STATE_GROUND) And ((Player_Action <= 8 Or Player_Action = 14) Or (Player_Action >= 15 And Player_Action < 24) Or Player_Action = 30) Then
			Player_Current_Action = Player_Action
		End If
	
	Case PLAYER_ACTION_STUN_LEFT
		If (Actor_Physics_State[actor] = PHYSICS_STATE_GROUND) And Timer - Player_Stun_Time >= Player_Stun_Total_Time Then
			Player_Current_Action = PLAYER_ACTION_STAND_RIGHT
			Player_isStunned = False
			jump_ready = true
		End If
		
	End Select
		
	GZ_Actor_SetAnimation(actor)
End Sub


Sub Player_Control(actor)
	Select Case PLAYER_CONTROL_TYPE
	Case PLAYER_CONTROL_TYPE_KEYBOARD
		Player_Control_Ex(actor)
		'Player_Keyboard_Control(actor)
	Case PLAYER_CONTROL_TYPE_JOYSTICK
		GetJoystick(0)
		Player_Control_Ex(actor)
		'Player_Joystick_Control(actor)
	Default
		Player_Control_Ex(actor)
	End Select
End Sub


Sub Player_Init()
	graizor = GetActorID("rock")
	
	Actor_Physics_State[graizor] = PHYSICS_STATE_FALL
	Actor_Weight[graizor] = graizor_weight
	Actor_Physics[graizor] = True

	jump_ready = true
	jump_button_down = false
	jump_button_timer = 0
	
	Player_Action = PLAYER_ACTION_STAND_RIGHT
	
	Graizor_Jump_Height = 40
	Graizor_Jump_Force = 3.5

End Sub


Sub Stage_Init(p_layer)
	Stage_Layer_Physics[p_layer] = True
	ClearJoysticks
End Sub


