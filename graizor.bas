Include "simple_touch.bas"

Dim graizor
Dim beam_sword
Dim blaster

'LoadFont(0, FONT_PATH$ + "FreeMono.ttf", 16)
'Actor_SetPosition(GetActorID("graizor"), Actor_X[graizor], Actor_Y[graizor] - 5)

Dim PLAYER_CONTROL_TYPE
Dim PLAYER_CONTROL_TYPE_KEYBOARD: PLAYER_CONTROL_TYPE_KEYBOARD = 0
Dim PLAYER_CONTROL_TYPE_JOYSTICK: PLAYER_CONTROL_TYPE_JOYSTICK = 1
Dim PLAYER_CONTROL_TYPE_TOUCH: PLAYER_CONTROL_TYPE_TOUCH = 2

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
		If GRAIZOR_CURRENT_WEAPON = 1 Then
			If PLAYER_UP_STATE Then
				Actor_SetAnimationByName(actor, "stand_shoot_upr")
				Actor_SetAnimationFrame(actor, 0)
				Actor_SetAnimationByName(blaster, "upr")
				Actor_SetAnimationFrame(blaster, 0)
			Else
				Actor_SetAnimationByName(actor, "stand_shoot_right")
				Actor_SetAnimationFrame(actor, 0)
				Actor_SetAnimationByName(blaster, "stand_right")
				Actor_SetAnimationFrame(blaster, 0)
			End If
		Else
			Actor_SetAnimationByName(actor, "stand_right")
			Actor_SetAnimationFrame(actor, 0)
		End If
	Case PLAYER_ACTION_WALK_RIGHT
		If GRAIZOR_CURRENT_WEAPON = 1 Then
			If PLAYER_UP_STATE Then
				Actor_SetAnimationByName(actor, "walk_shoot_upr")
				Actor_SetAnimationByName(blaster, "upr")
				Actor_SetAnimationFrame(blaster, 0)
			Else
				Actor_SetAnimationByName(actor, "walk_shoot_right")
				Actor_SetAnimationByName(blaster, "stand_right")
				Actor_SetAnimationFrame(blaster, 0)
			End If
		Else
			Actor_SetAnimationByName(actor, "walk_right")
		End If
	Case PLAYER_ACTION_DUCK_RIGHT
		Select Case GRAIZOR_CURRENT_WEAPON
		Case 0
			Actor_SetAnimationByName(actor, "duck_right")
		Case 1
			Actor_SetAnimationByName(actor, "duck_shoot_right")
		Default
			Actor_SetAnimationByName(actor, "duck_right")
		End Select
		Actor_SetAnimationFrame(actor, 0)
	Case PLAYER_ACTION_JUMP_RIGHT
		If GRAIZOR_CURRENT_WEAPON = 1 Then
			If PLAYER_UP_STATE Then
				Actor_SetAnimationByName(actor, "jump_shoot_upr")
				Actor_SetAnimationFrame(actor, 0)
				Actor_SetAnimationByName(blaster, "upr")
				Actor_SetAnimationFrame(blaster, 0)
			Else
				Actor_SetAnimationByName(actor, "jump_shoot_right")
				Actor_SetAnimationFrame(actor, 0)
				Actor_SetAnimationByName(blaster, "stand_right")
				Actor_SetAnimationFrame(blaster, 0)
			End If
		Else
			Actor_SetAnimationByName(actor, "jump_right")
			Actor_SetAnimationFrame(actor, 0)
		End If
	Case PLAYER_ACTION_WALK_SHOOT_RIGHT
		Actor_SetAnimationByName(actor, "walk_shoot_right")
	Case PLAYER_ACTION_WALK_SHOOT_RIGHT_UP
		Actor_SetAnimationByName(actor, "walk_shoot_up_right")
	Case PLAYER_ACTION_WALK_SHOOT_UPR
		Actor_SetAnimationByName(actor, "walk_shoot_upr")
	Case PLAYER_ACTION_STAND_SHOOT_RIGHT
		Actor_SetAnimationByName(actor, "stand_shoot_right")
	Case PLAYER_ACTION_STAND_SHOOT_UPR
		Actor_SetAnimationByName(actor, "stand_shoot_upr")
	Case PLAYER_ACTION_JUMP_SHOOT_RIGHT
		Actor_SetAnimationByName(actor, "jump_shoot_right")
	Case PLAYER_ACTION_JUMP_SHOOT_RIGHT_UP
		Actor_SetAnimationByName(actor, "jump_shoot_up_right")
	Case PLAYER_ACTION_JUMP_SHOOT_RIGHT_DOWN
		Actor_SetAnimationByName(actor, "jump_shoot_down_right")
	Case PLAYER_ACTION_JUMP_SHOOT_DOWNR
		Actor_SetAnimationByName(actor, "jump_shoot_downr")
	Case PLAYER_ACTION_JUMP_SHOOT_UPR
		Actor_SetAnimationByName(actor, "jump_shoot_upr")
	Case PLAYER_ACTION_SLASH_RIGHT
		If lock_action Then
			If Actor_AnimationEnded[actor] Or Actor_GetAnimationName$(actor, Actor_CurrentAnimation[actor]) <> "slash_right" Then
				lock_action = false
				Actor_SetAnimationFrame(actor, 0)
				Select Case Actor_Physics_State[actor]
				Case PHYSICS_STATE_GROUND
					Actor_SetAnimationByName(actor, "stand_right")
					Player_Current_Action = PLAYER_ACTION_STAND_RIGHT
				Default
					Actor_SetAnimationByName(actor, "jump_right")
					Player_Current_Action = PLAYER_ACTION_JUMP_RIGHT
				End Select
				Actor_SetActive(beam_sword, false)
				'atk_ready = true
			End If
		Else
			Actor_SetAnimationByName(actor, "slash_right")
			Actor_SetActive(beam_sword, true)
			Actor_SetAnimation(beam_sword, 0)
			Actor_SetAnimationFrame(beam_sword, 0)
			lock_action = true
			Actor_SetAnimationFrame(actor, 0)
		End If
	Case PLAYER_ACTION_DUCK_SLASH_RIGHT
		If lock_action Then
			If Actor_AnimationEnded[actor] Or Actor_GetAnimationName$(actor, Actor_CurrentAnimation[actor]) <> "duck_slash_right" Then
				lock_action = false
				Actor_SetAnimationFrame(actor, 0)
				Select Case Actor_Physics_State[actor]
				Case PHYSICS_STATE_GROUND
					Actor_SetAnimationByName(actor, "duck_right")
					Player_Current_Action = PLAYER_ACTION_STAND_RIGHT
				Default
					Actor_SetAnimationByName(actor, "jump_right")
					Player_Current_Action = PLAYER_ACTION_JUMP_RIGHT
				End Select
				Actor_SetActive(beam_sword, false)
				'atk_ready = true
			End If
		Else
			Actor_SetAnimationByName(actor, "duck_slash_right")
			Actor_SetActive(beam_sword, true)
			Actor_SetAnimation(beam_sword, 0)
			Actor_SetAnimationFrame(beam_sword, 0)
			lock_action = true
			Actor_SetAnimationFrame(actor, 0)
		End If
	Case PLAYER_ACTION_JUMP_SLASH_RIGHT
		If lock_action Then
			If Actor_AnimationEnded[actor] Or Actor_GetAnimationName$(actor, Actor_CurrentAnimation[actor]) <> "jump_slash_right" Then
				lock_action = false
				Actor_SetAnimationFrame(actor, 0)
				Select Case Actor_Physics_State[actor]
				Case PHYSICS_STATE_GROUND
					Actor_SetAnimationByName(actor, "stand_right")
					Player_Current_Action = PLAYER_ACTION_STAND_RIGHT
				Default
					Actor_SetAnimationByName(actor, "jump_right")
					Player_Current_Action = PLAYER_ACTION_JUMP_RIGHT
				End Select
				Actor_SetActive(beam_sword, false)
				'atk_ready = true
			End If
		Else
			Actor_SetAnimationByName(actor, "jump_slash_right")
			Actor_SetActive(beam_sword, true)
			Actor_SetAnimation(beam_sword, 0)
			Actor_SetAnimationFrame(beam_sword, 0)
			lock_action = true
			Actor_SetAnimationFrame(actor, 0)
		End If
	Case PLAYER_ACTION_STAND_LEFT
		If GRAIZOR_CURRENT_WEAPON = 1 Then
			If PLAYER_UP_STATE Then
				Actor_SetAnimationByName(actor, "stand_shoot_upl")
				Actor_SetAnimationFrame(actor, 0)
				Actor_SetAnimationByName(blaster, "upl")
				Actor_SetAnimationFrame(blaster, 0)
			Else
				Actor_SetAnimationByName(actor, "stand_shoot_left")
				Actor_SetAnimationFrame(actor, 0)
				Actor_SetAnimationByName(blaster, "stand_left")
				Actor_SetAnimationFrame(blaster, 0)
			End If
		Else
			Actor_SetAnimationByName(actor, "stand_left")
			Actor_SetAnimationFrame(actor, 0)
		End If
	Case PLAYER_ACTION_WALK_LEFT
		If GRAIZOR_CURRENT_WEAPON = 1 Then
			If PLAYER_UP_STATE Then
				Actor_SetAnimationByName(actor, "walk_shoot_upl")
				Actor_SetAnimationByName(blaster, "upl")
				Actor_SetAnimationFrame(blaster, 0)
			Else
				Actor_SetAnimationByName(actor, "walk_shoot_left")
				Actor_SetAnimationByName(blaster, "stand_left")
				Actor_SetAnimationFrame(blaster, 0)
			End If
		Else
			Actor_SetAnimationByName(actor, "walk_left")
		End If
	Case PLAYER_ACTION_DUCK_LEFT
		Select Case GRAIZOR_CURRENT_WEAPON
		Case 0
			Actor_SetAnimationByName(actor, "duck_left")
		Case 1
			Actor_SetAnimationByName(actor, "duck_shoot_left")
		Default
			Actor_SetAnimationByName(actor, "duck_left")
		End Select
		Actor_SetAnimationFrame(actor, 0)
	Case PLAYER_ACTION_JUMP_LEFT
		If GRAIZOR_CURRENT_WEAPON = 1 Then
			If PLAYER_UP_STATE Then
				Actor_SetAnimationByName(actor, "jump_shoot_upl")
				Actor_SetAnimationFrame(actor, 0)
				Actor_SetAnimationByName(blaster, "upl")
				Actor_SetAnimationFrame(blaster, 0)
			Else
				Actor_SetAnimationByName(actor, "jump_shoot_left")
				Actor_SetAnimationFrame(actor, 0)
				Actor_SetAnimationByName(blaster, "stand_left")
				Actor_SetAnimationFrame(blaster, 0)
			End If
		Else
			Actor_SetAnimationByName(actor, "jump_left")
			Actor_SetAnimationFrame(actor, 0)
		End If
	Case PLAYER_ACTION_WALK_SHOOT_LEFT
		Actor_SetAnimationByName(actor, "walk_shoot_left")
	Case PLAYER_ACTION_WALK_SHOOT_LEFT_UP
		Actor_SetAnimationByName(actor, "walk_shoot_up_left")
	Case PLAYER_ACTION_WALK_SHOOT_UPR
		Actor_SetAnimationByName(actor, "walk_shoot_upl")
	Case PLAYER_ACTION_STAND_SHOOT_LEFT
		Actor_SetAnimationByName(actor, "stand_shoot_left")
	Case PLAYER_ACTION_STAND_SHOOT_UPR
		Actor_SetAnimationByName(actor, "stand_shoot_upl")
	Case PLAYER_ACTION_JUMP_SHOOT_LEFT
		Actor_SetAnimationByName(actor, "jump_shoot_left")
	Case PLAYER_ACTION_JUMP_SHOOT_LEFT_UP
		Actor_SetAnimationByName(actor, "jump_shoot_up_left")
	Case PLAYER_ACTION_JUMP_SHOOT_LEFT_DOWN
		Actor_SetAnimationByName(actor, "jump_shoot_down_left")
	Case PLAYER_ACTION_JUMP_SHOOT_DOWNR
		Actor_SetAnimationByName(actor, "jump_shoot_downr")
	Case PLAYER_ACTION_JUMP_SHOOT_UPR
		Actor_SetAnimationByName(actor, "jump_shoot_upl")
	Case PLAYER_ACTION_SLASH_LEFT
		If lock_action Then
			If Actor_AnimationEnded[actor] Or Actor_GetAnimationName$(actor, Actor_CurrentAnimation[actor]) <> "slash_left" Then
				lock_action = false
				Actor_SetAnimationFrame(actor, 0)
				Select Case Actor_Physics_State[actor]
				Case PHYSICS_STATE_GROUND
					Actor_SetAnimationByName(actor, "stand_left")
					Player_Current_Action = PLAYER_ACTION_STAND_LEFT
				Default
					Actor_SetAnimationByName(actor, "jump_left")
					Player_Current_Action = PLAYER_ACTION_JUMP_LEFT
				End Select
				Actor_SetActive(beam_sword, false)
				'atk_ready = true
			End If
		Else
			Actor_SetAnimationByName(actor, "slash_left")
			Actor_SetActive(beam_sword, true)
			Actor_SetAnimation(beam_sword, 1)
			Actor_SetAnimationFrame(beam_sword, 0)
			lock_action = true
			Actor_SetAnimationFrame(actor, 0)
		End If
	Case PLAYER_ACTION_JUMP_SLASH_LEFT
		If lock_action Then
			If Actor_AnimationEnded[actor] Or Actor_GetAnimationName$(actor, Actor_CurrentAnimation[actor]) <> "jump_slash_left" Then
				lock_action = false
				Actor_SetAnimationFrame(actor, 0)
				Select Case Actor_Physics_State[actor]
				Case PHYSICS_STATE_GROUND
					Actor_SetAnimationByName(actor, "stand_left")
					Player_Current_Action = PLAYER_ACTION_STAND_LEFT
				Default
					Actor_SetAnimationByName(actor, "jump_left")
					Player_Current_Action = PLAYER_ACTION_JUMP_LEFT
				End Select
				Actor_SetActive(beam_sword, false)
				'atk_ready = true
			End If
		Else
			Actor_SetAnimationByName(actor, "jump_slash_left")
			Actor_SetActive(beam_sword, true)
			Actor_SetAnimation(beam_sword, 1)
			Actor_SetAnimationFrame(beam_sword, 0)
			lock_action = true
			Actor_SetAnimationFrame(actor, 0)
		End If
	Case PLAYER_ACTION_DUCK_SLASH_LEFT
		If lock_action Then
			If Actor_AnimationEnded[actor] Or Actor_GetAnimationName$(actor, Actor_CurrentAnimation[actor]) <> "duck_slash_left" Then
				lock_action = false
				Actor_SetAnimationFrame(actor, 0)
				Select Case Actor_Physics_State[actor]
				Case PHYSICS_STATE_GROUND
					Actor_SetAnimationByName(actor, "duck_left")
					Player_Current_Action = PLAYER_ACTION_STAND_LEFT
				Default
					Actor_SetAnimationByName(actor, "jump_left")
					Player_Current_Action = PLAYER_ACTION_JUMP_LEFT
				End Select
				Actor_SetActive(beam_sword, false)
				'atk_ready = true
			End If
		Else
			Actor_SetAnimationByName(actor, "duck_slash_left")
			Actor_SetActive(beam_sword, true)
			Actor_SetAnimation(beam_sword, 1)
			Actor_SetAnimationFrame(beam_sword, 0)
			lock_action = true
			Actor_SetAnimationFrame(actor, 0)
		End If
	Case PLAYER_ACTION_DOWN_SLASH_LEFT
			If Down_Slash_Flag = 1 Then
				Select Case Actor_Physics_State[actor]
				Case PHYSICS_STATE_GROUND
					PlaySound(down_slash_sound, 0, 0)
					Actor_SetAnimationByName(actor, "down_slash_left_3")
					Actor_SetAnimationFrame(actor, 0)
					Actor_SetAnimationByName(beam_sword, "slash_down_left_2")
					Actor_SetAnimationFrame(beam_sword, 0)
					'Actor_SetActive(beam_sword, false)
					'Player_Current_Action = PLAYER_ACTION_DUCK_LEFT
					Down_Slash_Flag = 2
					Down_Slash_Timer = Timer
					'Print "THE END"
				End Select
			ElseIf Down_Slash_Flag = 2 Then
				If Timer - Down_Slash_Timer > 150 Then
					Actor_SetAnimationByName(actor, "duck_left")
					Actor_SetAnimationFrame(actor, 0)
					Actor_SetActive(beam_sword, false)
					Actor_SetPosition(beam_sword, 0, 0)
					Player_Current_Action = PLAYER_ACTION_DUCK_LEFT
					Down_Slash_Flag = 0
					'Print "THE END"
				End If
			ElseIf Down_Slash_Flag = 0 Then
				Actor_SetAnimationByName(actor, "down_slash_left_2")
				Actor_SetActive(beam_sword, true)
				Actor_SetAnimationByName(beam_sword, "slash_down_left")
				Actor_SetAnimationFrame(beam_sword, 0)
				Actor_SetAnimationFrame(actor, 0)
				Down_Slash_Flag = 1
			End If
	Case PLAYER_ACTION_DOWN_SLASH_RIGHT
			If Down_Slash_Flag = 1 Then
				Select Case Actor_Physics_State[actor]
				Case PHYSICS_STATE_GROUND
					PlaySound(down_slash_sound, 1, 0)
					Actor_SetAnimationByName(actor, "down_slash_right_3")
					Actor_SetAnimationFrame(actor, 0)
					Actor_SetAnimationByName(beam_sword, "slash_down_right_2")
					Actor_SetAnimationFrame(beam_sword, 0)
					'Actor_SetActive(beam_sword, false)
					'Player_Current_Action = PLAYER_ACTION_DUCK_LEFT
					Down_Slash_Flag = 2
					Down_Slash_Timer = Timer
					'Print "THE END"
				End Select
			ElseIf Down_Slash_Flag = 2 Then
				If Timer - Down_Slash_Timer > 150 Then
					Actor_SetAnimationByName(actor, "duck_right")
					Actor_SetAnimationFrame(actor, 0)
					Actor_SetActive(beam_sword, false)
					Actor_SetPosition(beam_sword, 0, 0)
					Player_Current_Action = PLAYER_ACTION_DUCK_RIGHT
					Down_Slash_Flag = 0
					'Print "THE END"
				End If
			ElseIf Down_Slash_Flag = 0 Then
				Actor_SetAnimationByName(actor, "down_slash_right_2")
				Actor_SetActive(beam_sword, true)
				Actor_SetAnimationByName(beam_sword, "slash_down_right")
				Actor_SetAnimationFrame(beam_sword, 0)
				Actor_SetAnimationFrame(actor, 0)
				Down_Slash_Flag = 1
			End If
	Case PLAYER_ACTION_STUN_LEFT
		Actor_SetAnimationByName(actor, "stun_left")
		Actor_SetAnimationFrame(actor, 0)
		Actor_Move(actor, Player_Stun_Speed, 0)
		Down_Slash_Flag = 0
		Player_Invincible = True
		Player_Invincible_Time = Timer
		Actor_EnableCollisions(actor, False)
		Actor_SetEffect(actor, EFFECT_FLASH, 70)
	Case PLAYER_ACTION_STUN_RIGHT
		Actor_SetAnimationByName(actor, "stun_right")
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
	Case PLAYER_CONTROL_TYPE_TOUCH
		PLAYER_JUMP_BUTTON = ST_MB_A
		PLAYER_SLASH_BUTTON = ST_MB_W
		PLAYER_LEFT_BUTTON = ST_MB_LEFT
		PLAYER_RIGHT_BUTTON = ST_MB_RIGHT
		PLAYER_UP_BUTTON = ST_MB_UP
		PLAYER_DOWN_BUTTON = ST_MB_DOWN
		PLAYER_WEAPON_BUTTON = ST_MB_S
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
	Case PLAYER_CONTROL_TYPE_TOUCH
		If touch_status Then
			Return mobile_button(b)
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
	
	If (Timer - WEAPON_SWITCH_TIMER) > 500 Then
		weapon_switch_ready = True
	End If
	
	'right 35 -9
	'left
	'up
	'down
	sword_y_off = -20
	Actor_Weight[actor] = Graizor_Weight
	add_stun_time = 0
	Select Case Player_Current_Action
	Case PLAYER_ACTION_DUCK_LEFT, PLAYER_ACTION_DUCK_RIGHT, PLAYER_ACTION_DUCK_SLASH_LEFT, PLAYER_ACTION_DUCK_SLASH_RIGHT
		sword_y_off = -6
	Case PLAYER_ACTION_DOWN_SLASH_LEFT, PLAYER_ACTION_DOWN_SLASH_RIGHT
		sword_y_off = -1
		If Down_Slash_Flag > 0 Then
			Actor_Weight[actor] = Graizor_Weight + 2
		Else
			Actor_SetActive(beam_sword, false)
		End If
		add_stun_time = 100
	End Select
	
	Select Case Actor_CurrentAnimation[beam_sword]
	Case 0
		Actor_SetPosition(beam_sword, Actor_X[graizor]-25, Actor_Y[graizor]+sword_y_off)
	Case 1
		Actor_SetPosition(beam_sword, Actor_X[graizor]-40, Actor_Y[graizor]+sword_y_off)
	Case 2
		Actor_SetPosition(beam_sword, Actor_X[graizor]-30, Actor_Y[graizor]+sword_y_off)
	Case 3
		Actor_SetPosition(beam_sword, Actor_X[graizor]-34, Actor_Y[graizor]+sword_y_off)
	End Select
	
	If Not (Player_Action = PLAYER_ACTION_DOWN_SLASH_LEFT Or Player_Action = PLAYER_ACTION_DOWN_SLASH_RIGHT) Then	
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
		
		If Player_Button(PLAYER_UP_BUTTON, True) Then
			PLAYER_UP_STATE = True
		End If
		
		
		If Player_Button(PLAYER_DOWN_BUTTON, True) Then
			PLAYER_DOWN_STATE = True
			Select Case Actor_Physics_State[actor]
			Case PHYSICS_STATE_RISE
				Actor_Physics_State[actor] = PHYSICS_STATE_FALL
			Case PHYSICS_STATE_GROUND
				'PLAY DUCKING ANIMATION
				If Not Player_KeyIsPressed Then
					If Player_Action <= 8 Then 'Right
						Player_Action = PLAYER_ACTION_DUCK_RIGHT
					ElseIf Player_Action >= 16 And Player_Action <= 24 Then 'Left
						Player_Action = PLAYER_ACTION_DUCK_LEFT
					End If
					jump_ready = false
				End If
				Player_KeyIsPressed = True
			End Select
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
		
		Select Case GRAIZOR_CURRENT_WEAPON
		Case 0
			If atk_ready And Player_Button(PLAYER_SLASH_BUTTON,0) And (Not Player_isStunned) Then
				If Actor_Physics_State[actor] = PHYSICS_STATE_GROUND Then
					If Player_Action = PLAYER_ACTION_DUCK_RIGHT Then
						Player_Action = PLAYER_ACTION_DUCK_SLASH_RIGHT
					ElseIf Player_Action = PLAYER_ACTION_DUCK_LEFT Then
						Player_Action = PLAYER_ACTION_DUCK_SLASH_LEFT
					ElseIf Player_Action <= 15 Then
						Player_Action = PLAYER_ACTION_SLASH_RIGHT
					Else
						Player_Action = PLAYER_ACTION_SLASH_LEFT
					End If
				Else
					If Player_Action <= 15 Then
						If PLAYER_DOWN_STATE Then
							Player_Action = PLAYER_ACTION_DOWN_SLASH_RIGHT
							Actor_Physics_State[actor] = PHYSICS_STATE_FALL
							Actor_Force_X[actor] = 0
							Player_Current_Action = Player_Action
						Else
							Player_Action = PLAYER_ACTION_JUMP_SLASH_RIGHT
						End If
					Else
						If PLAYER_DOWN_STATE Then
							Player_Action = PLAYER_ACTION_DOWN_SLASH_LEFT
							Actor_Physics_State[actor] = PHYSICS_STATE_FALL
							Actor_Force_X[actor] = 0
							Player_Current_Action = Player_Action
						Else
							Player_Action = PLAYER_ACTION_JUMP_SLASH_LEFT
						End If
					End If
				End If
				PlaySound(0, 0, 0)
				atk_ready = false
				atk_button_timer = timer
				atk_button_down = true
				'print "dbg 1"
			ElseIf Not atk_ready And Not Player_Button(PLAYER_SLASH_BUTTON,0) And Not Player_isStunned Then
				atk_button_down = false
				atk_ready = true
				'print "dbg 2"
			End If
		Case 1
			If Player_Button(PLAYER_SLASH_BUTTON,0) And (Not Player_isStunned) and blaster_ammo > 0 Then
				y_blast_off = 0
				If Player_Action = PLAYER_ACTION_DUCK_LEFT Or Player_Action = PLAYER_ACTION_DUCK_RIGHT Then
					y_blast_off = 14
				End If
				If Timer - blaster_timer > 200 Then
					For i = 0 to blaster_max_shots_onscreen
						If Not Actor_Active[blaster_shot[i]] Then
							Actor_SetActive(blaster_shot[i], True)
							Actor_SetAnimation(blaster_shot[i], 0)
							Actor_SetAnimationFrame(blaster_shot[i], 0)
							If Player_Action <= 15 Then
								If PLAYER_UP_STATE Then
									Actor_SetPosition(blaster_shot[i], Actor_X[blaster]+31, Actor_Y[blaster])
									blaster_shot_speed[i, 0] = 0
									blaster_shot_speed[i, 1] = -1 * blaster_shot_move_speed
								Else
									Actor_SetPosition(blaster_shot[i], Actor_X[blaster]+64, Actor_Y[blaster]+24 + y_blast_off)
									blaster_shot_speed[i, 0] = blaster_shot_move_speed
									blaster_shot_speed[i, 1] = 0
								End If
							Else
								If PLAYER_UP_STATE Then
									Actor_SetPosition(blaster_shot[i], Actor_X[blaster]+27, Actor_Y[blaster])
									blaster_shot_speed[i, 0] = 0
									blaster_shot_speed[i, 1] = -1 * blaster_shot_move_speed
								Else
									Actor_SetPosition(blaster_shot[i], Actor_X[blaster], Actor_Y[blaster]+24 + y_blast_off)
									blaster_shot_speed[i, 0] = -1 * blaster_shot_move_speed
									blaster_shot_speed[i, 1] = 0
								End If
							End If
							
							blaster_timer = timer
							blaster_ammo = blaster_ammo - 1
							PlaySound(graizor_shot_sound, 0, 0)
							'print "shoot"
							Exit For
						End If
					Next
				End If
			End If
			
		End Select
		
	End If
	
	For i = 0 to blaster_max_shots_onscreen
		If Actor_Active[blaster_shot[i]] Then
			If Not Actor_isOnScreen(blaster_shot[i]) Or (Actor_CurrentAnimation[blaster_shot[i]] = 1 And Actor_AnimationEnded[blaster_shot[i]]) Then
				Actor_SetActive(blaster_shot[i], False)
			Else
				Actor_Move(blaster_shot[i], blaster_shot_speed[i,0], blaster_shot_speed[i,1])
				If num_enemies > 0 Then
					For n = 0 to num_enemies - 1
						If Actor_GetCollision(blaster_shot[i], enemy[n]) Then
							Actor_SetAnimation(blaster_shot[i], 1)
							Actor_SetActive(blaster_shot[i], False)
							enemy_hit[n] = True
							'print "hit:";num_enemies
						ElseIf Actor_NumStageCollisions[blaster_shot[i]] > 0 Or Actor_Collision_Inside_Shape[blaster_shot[i]] >= 0 Then
							Actor_SetAnimation(blaster_shot[i], 1)
							Actor_SetActive(blaster_shot[i], False)
							Actor_NumStageCollisions[blaster_shot[i]] = 0
							'Print blaster_shot[i];"::";Actor_Collision_Inside_Shape[blaster_shot[i]]
							Actor_Collision_Inside_Shape[blaster_shot[i]] = -1
							'print "hit:";num_enemies
						End If
					Next
				End If
			End If
		End If
	Next
	
	If Not (Player_Action = PLAYER_ACTION_DOWN_SLASH_LEFT Or Player_Action = PLAYER_ACTION_DOWN_SLASH_RIGHT) Then
		If Player_Button(PLAYER_WEAPON_BUTTON,0) and weapon_switch_ready Then
			GRAIZOR_CURRENT_WEAPON = Not GRAIZOR_CURRENT_WEAPON
			WEAPON_SWITCH_TIMER = Timer
			weapon_switch_ready = False
		End If
		
		
		Select Case Player_Current_Action
		Case PLAYER_ACTION_STAND_RIGHT, PLAYER_ACTION_WALK_RIGHT, PLAYER_ACTION_JUMP_RIGHT, PLAYER_ACTION_STAND_LEFT, PLAYER_ACTION_WALK_LEFT, PLAYER_ACTION_JUMP_LEFT
			If PLAYER_UP_STATE Then
				Select Case Actor_Physics_State[graizor]
				Case PHYSICS_STATE_GROUND
					'Actor_SetPosition(blaster, Actor_X[graizor], Actor_Y[graizor]-24)
					Actor_SetOffsetFrom(blaster, graizor, 0, -24)
				Case PHYSICS_STATE_RISE
					'Actor_SetPosition(blaster, Actor_X[graizor], Actor_Y[graizor]-26)
					Actor_SetOffsetFrom(blaster, graizor, 0, -26)
				Case PHYSICS_STATE_FALL
					'Actor_SetPosition(blaster, Actor_X[graizor], Actor_Y[graizor]-22)
					Actor_SetOffsetFrom(blaster, graizor, 0, -22)
				End Select
			Else
				Select Case Actor_Physics_State[graizor]
				Case PHYSICS_STATE_GROUND
					'Actor_SetPosition(blaster, Actor_X[graizor], Actor_Y[graizor])
					Actor_SetOffsetFrom(blaster, graizor, 0, 0)
				Case PHYSICS_STATE_RISE
					'Actor_SetPosition(blaster, Actor_X[graizor], Actor_Y[graizor]-2)
					Actor_SetOffsetFrom(blaster, graizor, 0, -2)
				Case PHYSICS_STATE_FALL
					'Actor_SetPosition(blaster, Actor_X[graizor], Actor_Y[graizor]+2)
					Actor_SetOffsetFrom(blaster, graizor, 0, 2)
				End Select
			End If
			
			Select Case GRAIZOR_CURRENT_WEAPON
			Case 1
				Actor_SetActive(blaster, True)
			Default
				Actor_SetActive(blaster, False)
			End Select
		'Case PLAYER_ACTION_JUMP_RIGHT 'Up Right
		'	Actor_SetPosition(blaster, Actor_X[graizor]+1, Actor_Y[graizor]-27)
		Default
			Actor_SetActive(blaster, False)
		End Select
			
		
		'-25-20
		Select Case Player_Current_Action
		Case PLAYER_ACTION_STAND_RIGHT
			Player_Current_Action = Player_Action
		Case PLAYER_ACTION_WALK_RIGHT
			Player_Current_Action = Player_Action
		Case PLAYER_ACTION_DUCK_RIGHT
			Player_Current_Action = Player_Action
		Case PLAYER_ACTION_JUMP_RIGHT
			If (Actor_Physics_State[actor] <> PHYSICS_STATE_GROUND) And ((Player_Action >= 8 And Player_Action <= 15) Or Player_Action >= 24) Then
				Player_Current_Action = Player_Action
			ElseIf (Actor_Physics_State[actor] = PHYSICS_STATE_GROUND) And ((Player_Action <= 8 Or Player_Action = 14) Or (Player_Action >= 15 And Player_Action < 24) Or Player_Action = 30) Then
				Player_Current_Action = Player_Action
			End If
		Case PLAYER_ACTION_WALK_SHOOT_RIGHT
		Case PLAYER_ACTION_WALK_SHOOT_RIGHT_UP
		Case PLAYER_ACTION_WALK_SHOOT_UPR
		Case PLAYER_ACTION_STAND_SHOOT_RIGHT
		Case PLAYER_ACTION_STAND_SHOOT_UPR
		Case PLAYER_ACTION_JUMP_SHOOT_RIGHT
		Case PLAYER_ACTION_JUMP_SHOOT_RIGHT_UP
		Case PLAYER_ACTION_JUMP_SHOOT_RIGHT_DOWN
		Case PLAYER_ACTION_JUMP_SHOOT_DOWNR
		Case PLAYER_ACTION_JUMP_SHOOT_UPR
		
		Case PLAYER_ACTION_SLASH_RIGHT
			
		Case PLAYER_ACTION_JUMP_SLASH_RIGHT
			
		Case PLAYER_ACTION_STAND_LEFT
			Player_Current_Action = Player_Action
		Case PLAYER_ACTION_WALK_LEFT
			Player_Current_Action = Player_Action
		Case PLAYER_ACTION_DUCK_LEFT
			Player_Current_Action = Player_Action
		Case PLAYER_ACTION_JUMP_LEFT
			If (Actor_Physics_State[actor] <> PHYSICS_STATE_GROUND) And (( Player_Action >= 8 And Player_Action <= 15) Or Player_Action >= 24) Then
				Player_Current_Action = Player_Action
			ElseIf (Actor_Physics_State[actor] = PHYSICS_STATE_GROUND) And ((Player_Action <= 8 Or Player_Action = 14) Or (Player_Action >= 15 And Player_Action < 24) Or Player_Action = 30) Then
				Player_Current_Action = Player_Action
			End If
			
		Case PLAYER_ACTION_WALK_SHOOT_LEFT
		Case PLAYER_ACTION_WALK_SHOOT_LEFT_UP
		Case PLAYER_ACTION_WALK_SHOOT_UPL
		Case PLAYER_ACTION_STAND_SHOOT_LEFT
		Case PLAYER_ACTION_STAND_SHOOT_UPL
		Case PLAYER_ACTION_JUMP_SHOOT_LEFT
		Case PLAYER_ACTION_JUMP_SHOOT_LEFT_UP
		Case PLAYER_ACTION_JUMP_SHOOT_LEFT_DOWN
		Case PLAYER_ACTION_JUMP_SHOOT_DOWNL
		Case PLAYER_ACTION_JUMP_SHOOT_UPL
		Case PLAYER_ACTION_SLASH_LEFT
			
		Case PLAYER_ACTION_JUMP_SLASH_LEFT
			
		Case PLAYER_ACTION_STUN_LEFT
			If (Actor_Physics_State[actor] = PHYSICS_STATE_GROUND) And Timer - Player_Stun_Time >= Player_Stun_Total_Time Then
				Player_Current_Action = PLAYER_ACTION_STAND_LEFT
				Player_isStunned = False
				atk_ready = true
				jump_ready = true
			End If
		Case PLAYER_ACTION_STUN_RIGHT
			If (Actor_Physics_State[actor] = PHYSICS_STATE_GROUND) And Timer - Player_Stun_Time >= Player_Stun_Total_Time Then
				Player_Current_Action = PLAYER_ACTION_STAND_RIGHT
				Player_isStunned = False
				atk_ready = true
				jump_ready = true
			End If
		
		End Select
		
	End If
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

Dim Graizor_Sword_Attack
Dim Graizor_Death_Actor
Dim Graizor_isDead
Dim Graizor_Dead_Time

Sub Graizor_Init()
	graizor = GetActorID("graizor")
	
	MOBILE_BUTTONS_IMAGE = GetFreeImage()
	LoadImage(MOBILE_BUTTONS_IMAGE, "mobile_buttons.png")
	
	If graizor = -1 Then
		spr = LoadSprite("graizor")
		graizor = NewActor("graizor", spr)
		Actor_SetLayer(graizor, 2)
	End If
	
	beam_sword = GetActorID("beam_sword")
	blaster = GetActorID("graizor_blaster")
	If beam_sword = -1 Then
		spr = LoadSprite("beam_sword")
		beam_sword = NewActor("beam_sword", spr)
		Actor_SetLayer(beam_sword, Actor_Layer[graizor])
	End If
	If blaster = -1 Then
		spr = LoadSprite("graizor_blaster")
		blaster = NewActor("graizor_blaster", spr)
		Actor_SetLayer(blaster, Actor_Layer[graizor])
	End If
	
	spr = LoadSprite("graizor_shot")
	For i = 0 to blaster_max_shots_onscreen
		blaster_shot[i] = NewActor("shot_" + str(i), spr)
		Actor_SetLayer(blaster_shot[i], Actor_Layer[graizor])
		Actor_SetActive(blaster_shot[i], False)
		Actor_Physics[blaster_shot[i]] = True
		Actor_Weight[blaster_shot[i]] = 0
	Next
	'print "beam_sword = ";beam_sword
	Graizor_Death_Actor = NewActor("graizor_death", GetSpriteID("explosion"))
	Actor_Physics[Graizor_Death_Actor] = False
	
	Actor_SetActive(Graizor_Death_Actor, false)
	Graizor_isDead = False
	Graizor_Dead_Time = 0
	
	Actor_SetAnimationByName(graizor, "walk_right")
	Actor_SetActive(beam_sword, false)
	Actor_SetParent(beam_sword, graizor)
	
	Actor_SetActive(blaster, false)
	'Actor_SyncAnimationTo(blaster, graizor)
	
	Actor_Physics_State[graizor] = PHYSICS_STATE_FALL
	Actor_Weight[graizor] = graizor_weight
	Actor_Physics[graizor] = True
	
	Graizor_Sword_Attack = 4
	blaster_atk = 3
	
	jump_ready = true
	jump_button_down = false
	jump_button_timer = 0

	atk_ready = true
	atk_button_down = false
	atk_button_timer = 0
	
	Player_Action = PLAYER_ACTION_STAND_RIGHT
	
	Graizor_Jump_Height = 40
	Graizor_Jump_Force = 3.5
	
	Graizor_Health = 8

End Sub

'Print "sword = ";GetActorID("beam_sword")
'Print Actor_LayerPosition[GetActorID("beam_sword")]


Dim Stage_End_X 
Dim Stage_End_Y
Dim hud
Dim hbar

Dim hud_font
Dim hud_weapon_select_box

Dim impact_sound_2
Dim impact_sound_3

Dim shot_sound_2
Dim shot_sound_3

Dim Player_Continues

'Game Init
Sub Game_Init()
	Player_Continues = 5
	hud = GetFreeImage
	LoadImage(hud, SPRITE_PATH$ + "gz_hud.png")
	hbar = GetFreeImage
	LoadImage(hbar, SPRITE_PATH$ + "hbar.png")
	hud_weapon_select_box = GetFreeImage
	LoadImage(hud_weapon_select_box, SPRITE_PATH$ + "weapon_select_box.png")
	
	For i = 0 to 15
		If Not FontIsLoaded(i) Then
			hud_font = i
			Exit For
		End If
	Next
	
	LoadFont(hud_font, FONT_PATH$ + "press-start/prstart.ttf", 16)
	
	LoadSound(0, "sfx/swish-1.wav")
	LoadSound(1, "sfx/slash.ogg")
	SetSoundVolume(1, 40)
	'LoadSound(2, "sfx/sfx_movement_jump8.wav")
	LoadSound(3, "sfx/Explosion.wav")
	
	LoadSound(4, "sfx/sfx_wpn_laser8.wav")
	SetSoundVolume(4, 40)
	shot_sound_1 = 4
	
	explosion_sound = 3
	
	LoadSound(5, "sfx/sfx_sound_neutral11.wav")
	'SetSoundVolume(5, 20)
	graizor_shot_sound = 5
	
	LoadSound(6, "sfx/sfx_exp_various1.wav")
	impact_sound_2 = 6
	
	'LoadSound(7, "sfx/sfx_exp_short_hard14.wav")
	'SetSoundVolume(7, 30)
	impact_sound_3 = 6
	
	LoadSound(8, "sfx/sfx_wpn_laser9.wav")
	SetSoundVolume(8, 30)
	shot_sound_2 = 8
	
	LoadSound(9, "sfx/sfx_weapon_singleshot7.wav")
	SetSoundVolume(9, 30)
	shot_sound_3 = 9
	
	LoadSound(10, "sfx/sfx_movement_jump19_landing.wav")
	'SetSoundVolume(9, 30)
	Down_Slash_Sound = 10
End Sub


Sub Stage_Init(p_layer)
	Stage_Layer_Physics[p_layer] = True
	
	CanvasClose(5)
	CanvasOpen(5, 640, 480, 0, 0, 640, 480, 1)
	SetCanvasZ(5, 0)
	
	s = LoadSprite("explosion")

	'print "Spr Num Frames = ";Sprite_Animation_NumFrames[s, 0]
	'print "Spr Delay = ";Sprite_Animation_FPS[s, 0]
	Stage_End_X = 200000
	Stage_End_Y = 200000
	ClearJoysticks
End Sub

hud_x = 10
hud_y = 10


Sub DrawHud()
	Canvas(5)
	ClearCanvas
	'54  76 + 2  98 + 4
	DrawImage(hud, hud_x, hud_y) ' 410)
	If Graizor_Health > 0 Then
		For i = 0 to Graizor_Health-1
			DrawImage(hbar, hud_x + (56 + (i*24)), hud_y + 7)
		Next
	End If
	Font(hud_font)
	
	SetColor(RGB(255,255,255))
	'Rect(63 + (96 * GRAIZOR_CURRENT_WEAPON), 38, 96, 26)
	Select Case GRAIZOR_CURRENT_WEAPON
	Case 0
		DrawImage(hud_weapon_select_box, hud_x + 55, hud_y + 34)
	Case 1
		DrawImage(hud_weapon_select_box, hud_x + 118, hud_y + 34)
	End Select
	
	DrawText(str(blaster_ammo), hud_x + 206, hud_y + 35)
	DrawText("x" + str(Player_Continues), hud_x + 8, hud_y + 38)
	
End Sub


Function KillGraizor()
	If Graizor_isDead Then
		If Actor_AnimationEnded[Graizor_Death_Actor] Then
			Actor_SetActive(Graizor_Death_Actor, false)
			Graizor_isDead = False
			Return True
		End If
	Else
		PlaySound(3, 0, 0)
		Graizor_Dead_Time = Timer
		Graizor_isDead = True
		Actor_SetActive(graizor, false)
		Actor_SetActive(Graizor_Death_Actor, True)
		Actor_SetLayer(Graizor_Death_Actor, 2)
		Actor_SetAnimation(Graizor_Death_Actor, 0)
		Actor_SetAnimationFrame(Graizor_Death_Actor, 0)
		Actor_SetPosition(Graizor_Death_Actor, Actor_X[graizor], Actor_Y[graizor])
	End If
	Return False
End Function

Function Graizor_CheckDeath()
	If Graizor_Health <= 0 Then
		If KillGraizor Then
			Actor_SetActive(graizor, true)
			'Actor_SetPosition(graizor, 52, 380)
			Actor_SetAnimationByName(graizor, "stand_right")
			Actor_SetAnimationFrame(graizor, 0)
			Player_Current_Action = PLAYER_ACTION_STAND_RIGHT
			Player_isStunned = False
			Down_Slash_Flag = 0
			Return True
		End If
	End If
	Return False
End Function

