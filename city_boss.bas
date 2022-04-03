'include "engine.bas"
'Include "graizor.bas"


Dim gladius_alive
Dim gladius_actor
Dim gladius_action
Dim gladius_action_time
Dim gladius_action_lock
Dim gladius_action_status

Dim GLADIUS_ACTION_STAND_LEFT
Dim GLADIUS_ACTION_WALK_LEFT
Dim GLADIUS_ACTION_THROW_LEFT
Dim GLADIUS_ACTION_CALL_LEFT

Dim GLADIUS_ACTION_STAND_RIGHT
Dim GLADIUS_ACTION_WALK_RIGHT
Dim GLADIUS_ACTION_THROW_RIGHT
Dim GLADIUS_ACTION_CALL_RIGHT

Dim GLADIUS_ACTION_STUN_LEFT
Dim GLADIUS_ACTION_STUN_RIGHT

Dim GLADIUS_ACTION_DEATH
Dim GLADIUS_ACTION_CALL_2

GLADIUS_ACTION_WALK_LEFT = 0
GLADIUS_ACTION_STAND_LEFT = 1
GLADIUS_ACTION_THROW_LEFT = 2
GLADIUS_ACTION_CALL_LEFT = 3

GLADIUS_ACTION_WALK_RIGHT = 4
GLADIUS_ACTION_STAND_RIGHT = 5
GLADIUS_ACTION_THROW_RIGHT = 6
GLADIUS_ACTION_CALL_RIGHT = 7


GLADIUS_ACTION_STUN_LEFT = 8
GLADIUS_ACTION_STUN_RIGHT = 9

GLADIUS_ACTION_DEATH = 10

GLADIUS_ACTION_CALL_2 = 11

Dim gladius_health
Dim gladius_weapon_actor[6]
Dim gladius_weapon_position[6,2]
Dim gladius_weapon_speed[6,2]
Dim gladius_weapon_action[6]

Dim GLADIUS_WEAPON_ACTION_HAND
Dim GLADIUS_WEAPON_ACTION_THROW
Dim GLADIUS_WEAPON_ACTION_GROUND
Dim GLADIUS_WEAPON_ACTION_SPECIAL

GLADIUS_WEAPON_ACTION_HAND = 0
GLADIUS_WEAPON_ACTION_THROW = 1
GLADIUS_WEAPON_ACTION_GROUND = 2
GLADIUS_WEAPON_ACTION_SPECIAL = 3

Dim gladius_death_actor

Dim gladius_walk_speed
Dim gladius_saw_attack
gladius_saw_attack = 1
gladius_walk_speed = 2

Dim gladius_enemy
Dim gladius_distance
Dim gladius_travel_distance
gladius_travel_distance = 100
Dim gladius_throwing_hand
Dim gladius_weapon_throw_speed[2]
gladius_weapon_throw_speed[0] = 3
gladius_weapon_throw_speed[1] = -4

Dim gladius_weapon_throw_ready
gladius_weapon_throw_ready = false

Dim gladius_cmd_order[40]

gladius_cmd_order[0] = GLADIUS_ACTION_STAND_LEFT
gladius_cmd_order[1] = GLADIUS_ACTION_THROW_LEFT
gladius_cmd_order[2] = GLADIUS_ACTION_WALK_LEFT
gladius_cmd_order[3] = GLADIUS_ACTION_STAND_LEFT
gladius_cmd_order[4] = GLADIUS_ACTION_THROW_LEFT
gladius_cmd_order[5] = GLADIUS_ACTION_WALK_LEFT
gladius_cmd_order[6] = GLADIUS_ACTION_STAND_LEFT
gladius_cmd_order[7] = GLADIUS_ACTION_THROW_RIGHT
gladius_cmd_order[8] = GLADIUS_ACTION_WALK_RIGHT
gladius_cmd_order[9] = GLADIUS_ACTION_STAND_RIGHT
gladius_cmd_order[10] = GLADIUS_ACTION_THROW_RIGHT
gladius_cmd_order[11] = GLADIUS_ACTION_WALK_RIGHT
gladius_cmd_order[12] = GLADIUS_ACTION_STAND_RIGHT
gladius_cmd_order[13] = GLADIUS_ACTION_THROW_RIGHT
gladius_cmd_order[14] = GLADIUS_ACTION_STAND_RIGHT
gladius_cmd_order[15] = GLADIUS_ACTION_THROW_RIGHT
gladius_cmd_order[16] = GLADIUS_ACTION_WALK_RIGHT
gladius_cmd_order[17] = GLADIUS_ACTION_STAND_LEFT
gladius_cmd_order[18] = GLADIUS_ACTION_WALK_LEFT
gladius_cmd_order[19] = GLADIUS_ACTION_CALL_LEFT
gladius_cmd_order[20] = GLADIUS_ACTION_CALL_2

gladius_cmd_count = 21

Dim gladius_call_timer
Dim gladius_call_flag

Dim gladius_stun_timer
gladius_stun_timer = timer

Dim gladius_cp1_x
Dim gladius_cp1_y
Dim gladius_cp2_x
Dim gladius_cp2_y

Function AI_Init_Gladius()
	gladius_alive = True
	gladius_actor = GetActorID("gladius")
	gladius_action = GLADIUS_ACTION_STAND_LEFT
	Actor_Physics[gladius_actor] = True
	Actor_Weight[gladius_actor] = 5
	Actor_SetAnimationByName(gladius_actor, "stand_left")
	Actor_SetAnimationFrame(gladius_actor, 0)
	Actor_Persistent[gladius_actor] = True
	
	
	gladius_throwing_hand = 0
	
	gladius_distance = 0
	
	gladius_health = 200
	gladius_enemy = -1
	
	gladius_stun_timer = timer
	
	For i = 0 to 5
		gladius_weapon_actor[i] = GetActorID("saw"+str(i+1))
		'print "actor (saw";str(i+1);") = ";gladius_weapon_actor[i]
		Actor_Persistent[gladius_weapon_actor[i]] = True
	Next
	
			
	If Not gladius_death_actor Then
		gladius_death_actor = NewActor("gladius_death", GetSpriteID("explosion"))
		Actor_SetLayer(gladius_death_actor, Actor_Layer[gladius_actor])
		Actor_SetActive(gladius_death_actor, false)
	End If
	
	gladius_cp1 = GetActorID("cp1")
	gladius_cp2 = GetActorID("cp2")
	
	Actor_SetVisible(gladius_cp1, false)
	Actor_SetVisible(gladius_cp2, false)
	
	gladius_cp1_x = Actor_X[gladius_cp1]
	gladius_cp1_y = Actor_Y[gladius_cp1]
	
	gladius_cp2_x = Actor_X[gladius_cp2]
	gladius_cp2_y = Actor_Y[gladius_cp2]
	
	Return gladius_actor
End Function

Sub AI_Gladius_RunAction()
	actor = gladius_actor
	action = gladius_action
	Select Case action
	Case GLADIUS_ACTION_STAND_LEFT
		'Do nothing for now
	Case GLADIUS_ACTION_WALK_LEFT
		If timer - gladius_action_time > 15 Then
			Actor_Move(actor, -1 * gladius_walk_speed, 0)
			
			gladius_distance = gladius_distance + 1
			gladius_action_time = timer
		End If
	Case GLADIUS_ACTION_THROW_LEFT
		If gladius_weapon_throw_ready Then
			Select Case Actor_CurrentFrame[gladius_actor]
			Case 1
				Select Case gladius_throwing_hand
				Case 0
					For i = 3 to 5
						If gladius_weapon_action[i] = GLADIUS_WEAPON_ACTION_HAND Then
							gladius_weapon_action[i] = GLADIUS_WEAPON_ACTION_THROW
							gladius_weapon_speed[i,0] = -1*gladius_weapon_throw_speed[0]
							gladius_weapon_speed[i,1] = gladius_weapon_throw_speed[1]
							Actor_Jump[gladius_weapon_actor[i]] = 70
							Actor_Force_X[gladius_weapon_actor[i]] = gladius_weapon_speed[i,0]
							Actor_Force_Y[gladius_weapon_actor[i]] = gladius_weapon_speed[i,1]
							Actor_Weight[gladius_weapon_actor[i]] = 3
							Actor_Physics[gladius_weapon_actor[i]] = True
							Actor_Physics_State[gladius_weapon_actor[i]] = PHYSICS_STATE_RISE
							gladius_weapon_throw_ready = False
							Exit For
						End If
					Next
				Case 1
					For i = 0 to 2
						If gladius_weapon_action[i] = GLADIUS_WEAPON_ACTION_HAND Then
							gladius_weapon_action[i] = GLADIUS_WEAPON_ACTION_THROW
							gladius_weapon_speed[i,0] = -1*gladius_weapon_throw_speed[0]
							gladius_weapon_speed[i,1] = gladius_weapon_throw_speed[1]
							Actor_Jump[gladius_weapon_actor[i]] = 70
							Actor_Force_X[gladius_weapon_actor[i]] = gladius_weapon_speed[i,0]
							Actor_Force_Y[gladius_weapon_actor[i]] = gladius_weapon_speed[i,1]
							Actor_Weight[gladius_weapon_actor[i]] = 3
							Actor_Physics[gladius_weapon_actor[i]] = True
							Actor_Physics_State[gladius_weapon_actor[i]] = PHYSICS_STATE_RISE
							gladius_weapon_throw_ready = False
							Exit For
						End If
					Next
				End Select
			End Select
		End If
		
					
	Case GLADIUS_ACTION_CALL_LEFT
		For i = 0 to 5
			If Actor_X[gladius_weapon_actor[i]] >= gladius_cp2_x Then
				gladius_weapon_speed[i,0] = -3
				Actor_SetPosition(gladius_weapon_actor[i], gladius_cp2_x - 1, Actor_Y[gladius_weapon_actor[i]])
			ElseIf Actor_X[gladius_weapon_actor[i]] <= gladius_cp1_x Then
				gladius_weapon_speed[i,0] = 3
				Actor_SetPosition(gladius_weapon_actor[i], gladius_cp1_x + 1, Actor_Y[gladius_weapon_actor[i]])
			End If
			If Actor_Y[gladius_weapon_actor[i]] >= gladius_cp2_y Then
				gladius_weapon_speed[i,1] = -1 * (i-3)
				Actor_SetPosition(gladius_weapon_actor[i], Actor_X[gladius_weapon_actor[i]], gladius_cp2_y - 1)
			ElseIf Actor_Y[gladius_weapon_actor[i]] <= gladius_cp1_y Then
				gladius_weapon_speed[i,1] = i-3
				Actor_SetPosition(gladius_weapon_actor[i], Actor_X[gladius_weapon_actor[i]], gladius_cp1_y + 1)
			End If
			Actor_Move(gladius_weapon_actor[i], gladius_weapon_speed[i,0], gladius_weapon_speed[i,1])
		Next
	
	Case GLADIUS_ACTION_CALL_2
		
		If gladius_call_flag = 0 Then
			For i = 0 to 5
				If Actor_X[gladius_weapon_actor[i]] < Actor_X[gladius_actor] Then
					gladius_weapon_speed[i,0] = 3
				ElseIf Actor_X[gladius_weapon_actor[i]] > Actor_X[gladius_actor] Then
					gladius_weapon_speed[i,0] = -3
				End If
				
				If Actor_Y[gladius_weapon_actor[i]] < (Actor_Y[gladius_actor]+46) Then
					gladius_weapon_speed[i,1] = 3
				ElseIf Actor_Y[gladius_weapon_actor[i]] > (Actor_Y[gladius_actor]-46) Then
					gladius_weapon_speed[i,1] = -3
				End If
				
				Actor_Move(gladius_weapon_actor[i], gladius_weapon_speed[i,0], -3)
				'Actor_Move(gladius_weapon_actor[i], gladius_weapon_speed[i,0], gladius_weapon_speed[i,1])
			Next
		
		End If
		
		If Actor_Y[gladius_weapon_actor[0]] <= (Actor_Y[gladius_actor]-300) And gladius_call_flag = 0 Then
			gladius_call_flag = 1
			For i = 0 to 5
				Actor_SetPosition(gladius_weapon_actor[i], Actor_X[gladius_actor], (Actor_Y[gladius_actor] - 100) - 40*i)
			Next
		ElseIf gladius_call_flag = 1 Then
			gladius_call_flag = 2
			For i = 0 to 5
				If Actor_Y[gladius_weapon_actor[i]] < 540 Then
					Actor_Move(gladius_weapon_actor[i], 0, 3)
					gladius_call_flag = 1
				End If
			Next
		End If
		
	
	Case GLADIUS_ACTION_STAND_RIGHT
		'Do nothing for now
	Case GLADIUS_ACTION_WALK_RIGHT
		If timer - gladius_action_time > 15 Then
			Actor_Move(actor, gladius_walk_speed, 0)
			
			gladius_distance = gladius_distance + 1
			gladius_action_time = timer
		End If
	Case GLADIUS_ACTION_THROW_RIGHT
		If gladius_weapon_throw_ready Then
			Select Case Actor_CurrentFrame[gladius_actor]
			Case 1
				Select Case gladius_throwing_hand
				Case 0
					For i = 3 to 5
						If gladius_weapon_action[i] = GLADIUS_WEAPON_ACTION_HAND Then
							gladius_weapon_action[i] = GLADIUS_WEAPON_ACTION_THROW
							gladius_weapon_speed[i,0] = gladius_weapon_throw_speed[0]
							gladius_weapon_speed[i,1] = gladius_weapon_throw_speed[1]
							Actor_Jump[gladius_weapon_actor[i]] = 60
							Actor_Force_X[gladius_weapon_actor[i]] = gladius_weapon_speed[i,0]
							Actor_Force_Y[gladius_weapon_actor[i]] = gladius_weapon_speed[i,1]
							Actor_Weight[gladius_weapon_actor[i]] = 3
							Actor_Physics[gladius_weapon_actor[i]] = True
							Actor_Physics_State[gladius_weapon_actor[i]] = PHYSICS_STATE_RISE
							gladius_weapon_throw_ready = False
							Exit For
						End If
					Next
				Case 1
					For i = 0 to 2
						If gladius_weapon_action[i] = GLADIUS_WEAPON_ACTION_HAND Then
							gladius_weapon_action[i] = GLADIUS_WEAPON_ACTION_THROW
							gladius_weapon_speed[i,0] = gladius_weapon_throw_speed[0]
							gladius_weapon_speed[i,1] = gladius_weapon_throw_speed[1]
							Actor_Jump[gladius_weapon_actor[i]] = 60
							Actor_Force_X[gladius_weapon_actor[i]] = gladius_weapon_speed[i,0]
							Actor_Force_Y[gladius_weapon_actor[i]] = gladius_weapon_speed[i,1]
							Actor_Weight[gladius_weapon_actor[i]] = 3
							Actor_Physics[gladius_weapon_actor[i]] = True
							Actor_Physics_State[gladius_weapon_actor[i]] = PHYSICS_STATE_RISE
							gladius_weapon_throw_ready = False
							Exit For
						End If
					Next
				End Select
			End Select
		End If
		
					
	Case GLADIUS_ACTION_CALL_LEFT
		'Do nothing for now
	
	
	Case GLADIUS_ACTION_STUN_LEFT
		'Do nothing
	Case GLADIUS_ACTION_STUN_RIGHT
		'Do nothing
	Case GLADIUS_ACTION_DEATH
		'print "animation = ";Actor_CurrentAnimation[guard_death_actor[gnum]]
		'print "num aframes = ";Sprite_Animation_NumFrames[ Actor_Sprite[guard_death_actor[gnum]], 0]
		'print "cframe = ";Actor_CurrentFrameTime[guard_death_actor[gnum]]
		'print "cdelay = ";Actor_CurrentFrameDelay[guard_death_actor[gnum]]
	End Select
End Sub

Sub AI_Gladius_StartAction(action)
	Select Case action
	Case GLADIUS_ACTION_STAND_LEFT
		Actor_SetAnimationByName(gladius_actor, "STAND_LEFT")
		Actor_SetAnimationFrame(gladius_actor, 0)
		gladius_action_time = timer
	Case GLADIUS_ACTION_WALK_LEFT
		Actor_SetAnimationByName(gladius_actor, "WALK_LEFT")
		gladius_distance = 0
	Case GLADIUS_ACTION_THROW_LEFT
		Select Case gladius_throwing_hand
		Case 0
			Actor_SetAnimationByName(gladius_actor, "ATTACK_LEFT_V")
		Case 1
			Actor_SetAnimationByName(gladius_actor, "ATTACK_LEFT_H")
		End Select
		
		gladius_weapon_throw_ready = true
		'THROW SAW CODE HERE
		
		gladius_throwing_hand = Not gladius_throwing_hand
		gladius_action_time = timer
	Case GLADIUS_ACTION_CALL_LEFT
		Actor_SetAnimationByName(gladius_actor, "THROW2_LEFT")
		Actor_SetAnimationFrame(gladius_actor, 0)
		gladius_call_timer = timer
		
		For i = 0 to 2
			gladius_weapon_speed[i,0] = -3
			gladius_weapon_speed[i,1] = -3
			Actor_Physics[gladius_weapon_actor[i]] = False
		Next
		
		For i = 3 to 5
			gladius_weapon_speed[i,0] = 3
			gladius_weapon_speed[i,1] = 0
		Next
	
	Case GLADIUS_ACTION_CALL_2
		Actor_SetAnimationByName(gladius_actor, "THROW2_LEFT")
		Actor_SetAnimationFrame(gladius_actor, 0)
		gladius_call_timer = timer
		'print "balls"
		For i = 0 to 5
			Actor_Physics[gladius_weapon_actor[i]] = False
		Next
		
		gladius_call_flag = 0
	
	Case GLADIUS_ACTION_STAND_RIGHT
		Actor_SetAnimationByName(gladius_actor, "STAND_RIGHT")
		Actor_SetAnimationFrame(gladius_actor, 0)
		gladius_action_time = timer
	Case GLADIUS_ACTION_WALK_RIGHT
		Actor_SetAnimationByName(gladius_actor, "WALK_RIGHT")
		gladius_distance = 0
	Case GLADIUS_ACTION_THROW_RIGHT
		Select Case gladius_throwing_hand
		Case 0
			Actor_SetAnimationByName(gladius_actor, "ATTACK_RIGHT_V")
		Case 1
			Actor_SetAnimationByName(gladius_actor, "ATTACK_RIGHT_H")
		End Select
		
		gladius_weapon_throw_ready = true
		'THROW SAW CODE HERE
		
		gladius_throwing_hand = Not gladius_throwing_hand
		gladius_action_time = timer
	Case GLADIUS_ACTION_CALL_RIGHT
		Actor_SetAnimationByName(gladius_actor, "THROW2_RIGHT")
		Actor_SetAnimationFrame(gladius_actor, 0)
		
	
	Case GLADIUS_ACTION_STUN_LEFT
		
		
	Case GLADIUS_ACTION_STUN_RIGHT
	
	Case GLADIUS_ACTION_DEATH
		Actor_SetActive(gladius_actor, false)
		
		Actor_SetActive(gladius_death_actor, true)
		Actor_SetAnimation(gladius_death_actor, 0)
		Actor_SetAnimationFrame(gladius_death_actor, 0)
		Actor_SetPosition(gladius_death_actor, Actor_X[gladius_actor], Actor_Y[gladius_actor])
		gladius_action_time = timer
		PlaySound(3, 1, 0)
	End Select
	gladius_action = action
	gladius_action_status = true
End Sub

Function AI_Gladius_ActionComplete()
	If Not gladius_action_status Then
		Return True
	End If
	action = gladius_action
	Select Case action
	Case GLADIUS_ACTION_STAND_LEFT
		If timer - gladius_action_time > 1000 Then
			gladius_action_status = False
			Return True
		End If
	Case GLADIUS_ACTION_WALK_LEFT
		If gladius_distance >= gladius_travel_distance Then
			gladius_action_status = False
			Return True
		End If
	Case GLADIUS_ACTION_THROW_LEFT
		If Actor_AnimationEnded[gladius_actor] Then
			gladius_action_status = False
			Return True
		End If
	Case GLADIUS_ACTION_CALL_LEFT
		If timer - gladius_call_timer >= 20000 Then
			gladius_action_status = False
			
			For i = 0 to 5
				Actor_Physics[gladius_weapon_actor[i]] = True
			Next
			Return True
		End If
	
	
	Case GLADIUS_ACTION_CALL_2
		gladius_action_status = False
		g_saw_status = False
		If gladius_call_flag = 2 Then
			g_saw_status = True
		
		End If
		
		gladius_action_status = Not g_saw_status
		
		If g_saw_status Then
			For i = 0 to 5
				gladius_weapon_action[i] = GLADIUS_WEAPON_ACTION_HAND
			Next
		End If
		
		Return g_saw_status
		
	Case GLADIUS_ACTION_STAND_RIGHT
		If timer - gladius_action_time > 1000 Then
			gladius_action_status = False
			Return True
		End If
	Case GLADIUS_ACTION_WALK_RIGHT
		If gladius_distance >= gladius_travel_distance Then
			gladius_action_status = False
			Return True
		End If
	Case GLADIUS_ACTION_THROW_RIGHT
		If Actor_AnimationEnded[gladius_actor] Then
			gladius_action_status = False
			Return True
		End If
	Case GLADIUS_ACTION_CALL_RIGHT
		If timer - gladius_action_time > 500 Then
			gladius_action_status = False
			Return True
		End If
	
	
	Case GLADIUS_ACTION_STUN_LEFT
		If timer - gladius_action_time > 250 Then
			gladius_action_status = false
			Return True
		End If
	Case GLADIUS_ACTION_STUN_RIGHT
		If timer - gladius_action_time > 250 Then
			gladius_action_status = false
			Return True
		End If
	Case GLADIUS_ACTION_DEATH
		If Actor_AnimationEnded[gladius_death_actor] Then
			gladius_action_status = false
			'print "end death"
			Return True
		End If
	End Select
End Function

'walk left 20 steps
'stand left 1 sec
'walk right 20 steps
'stand right 1 sec
Dim GLADIUS_DIR_LEFT
Dim GLADIUS_DIR_RIGHT
GLADIUS_DIR_LEFT = 0
GLADIUS_DIR_RIGHT = 2
Function Gladius_GetDirection()
	a = gladius_action
	If a = GLADIUS_ACTION_WALK_LEFT Or a = GLADIUS_ACTION_STAND_LEFT Or a = GLADIUS_ACTION_THROW_LEFT Or a = GLADIUS_ACTION_CALL_LEFT Or a = GLADIUS_ACTION_STUN_LEFT Or a = GLADIUS_ACTION_CALL_2 Then
		Return GLADIUS_DIR_LEFT
	Else
		Return GLADIUS_DIR_RIGHT
	End If
End Function

Sub Gladius_Attack_Collision(gz_id)
	If Not Player_isStunned Then
		For i = 0 to 5
			If Actor_GetCollision(gz_id, gladius_weapon_actor[i]) Then
				Player_isStunned = True
				Player_Stun_Time = Timer
				If Player_Action <= 15 Then
					Player_Current_Action = PLAYER_ACTION_STUN_RIGHT
					Player_Stun_Speed = -4
				Else
					Player_Current_Action = PLAYER_ACTION_STUN_LEFT
					Player_Stun_Speed = 4
				End If
				Actor_Jump[gz_id] = 10
				Actor_Force_X[0] = 2
				Actor_Force_Y[gz_id] = -3
				'Actor_Momentum[0] = 2
				Actor_Weight[gz_id] = 3
				Actor_Physics_State[gz_id] = PHYSICS_STATE_RISE
				Actor_SetActive(Actor_ChildActor[gz_id], false)
				Graizor_Health = Graizor_Health - gladius_saw_attack
				PlaySound(1, 0, 0)
				Exit For
			End If
		Next
	End If
End Sub

Dim gladius_current_cmd
gladius_current_cmd = 0

Sub AI_Gladius(gz_id)
	actor = gladius_actor
	action = gladius_action
	
	
	'print "action = ";action
	
	If Actor_Y[gladius_actor] > Stage_End_Y Then
		gladius_alive = false
		Actor_SetActive(gladius_actor, false)
	End If
	
	If gladius_health <= 0 And gladius_alive And gladius_action <> GLADIUS_ACTION_DEATH Then
		'Play death animation
		AI_Gladius_StartAction(GLADIUS_ACTION_DEATH)
	End If
	
	Gladius_Attack_Collision(gz_id)
	
	If Actor_GetCollision(Actor_ChildActor[gz_id], actor) and action <> GLADIUS_ACTION_STUN_LEFT and action <> GLADIUS_ACTION_STUN_RIGHT and (timer-gladius_stun_timer)>250 Then
		If Gladius_GetDirection() = GLADIUS_DIR_LEFT Then
			'AI_Gladius_StartAction(GLADIUS_ACTION_STUN_LEFT)
		Else
			'AI_Guard_StartAction(GLADIUS_ACTION_STUN_RIGHT)
		End If
		PlaySound(1, 0, 0)
		gladius_stun_timer = timer
		gladius_health = gladius_health - Graizor_Sword_Attack
		'print gladius_health
	ElseIf gladius_enemy >= 0 Then
		If enemy_hit[gladius_enemy] and action <> GLADIUS_ACTION_STUN_LEFT and action <> GLADIUS_ACTION_STUN_RIGHT Then
			If Gladius_GetDirection() = GLADIUS_DIR_LEFT Then
				'AI_Gladius_StartAction(GLADIUS_ACTION_STUN_LEFT)
			Else
				'AI_Gladius_StartAction(GLADIUS_ACTION_STUN_RIGHT)
			End If
			PlaySound(1, 0, 0)
			gladius_stun_timer = timer
			gladius_health = gladius_health - blaster_atk
			'print gladius_health
		End If
	End If
	
	If (Timer - gladius_stun_timer) < 100 Then
		'SetColor(RGBA(255,255,255,0))
		'RectFill(Actor_X[gladius_actor], Actor_Y[gladius_actor], Sprite_Frame_Width[Actor_Sprite[gladius_actor]], Sprite_Frame_Height[Actor_Sprite[gladius_actor]])
		SetImageBlendMode(Sprite_Image[Actor_Sprite[gladius_actor]], BLENDMODE_ADD)
	Else
		SetImageBlendMode(Sprite_Image[Actor_Sprite[gladius_actor]], BLENDMODE_BLEND)
	End If
	
	gdir = Gladius_GetDirection
	
	x_off_v = 0
	y_off_v = 0
	
	x_off_h = 0
	y_off_h = 0
	
'stand left
'------------------------
'frame 1
'v - 47,87
'h - 34, 87

'frame 2
'v - 48,87
'h - 32, 87

'frame 2
'v - 49,90
'h - 31, 87

'frame 2
'v - 48,90
'h - 32, 87
'-------------------------
	
	Select Case gladius_action
	Case GLADIUS_ACTION_THROW_LEFT
		Select Case Actor_CurrentFrame[gladius_actor]
		Case 0
			Select Case gladius_throwing_hand
			Case 0
				x_off_v = 84
				y_off_v = 10
				x_off_h = 34
				y_off_h = 87
			Default
				x_off_v = 46
				y_off_v = 89
				x_off_h = 84
				y_off_h = 10
			End Select
		Case 1
			Select Case gladius_throwing_hand
			Case 0
				x_off_v = 13
				y_off_v = 46
				x_off_h = 35
				y_off_h = 87
			Default
				x_off_v = 48
				y_off_v = 90
				x_off_h = 32
				y_off_h = 87
			End Select
		End Select
	
	Case GLADIUS_ACTION_THROW_RIGHT
		Select Case Actor_CurrentFrame[gladius_actor]
		Case 0
			Select Case gladius_throwing_hand
			Case 0
				x_off_v = 12
				y_off_v = 24
				x_off_h = 64
				y_off_h = 87
			Default
				x_off_v = 50
				y_off_v = 89
				x_off_h = 14
				y_off_h = 10
			End Select
		Case 1
			Select Case gladius_throwing_hand
			Case 0
				x_off_v = 83
				y_off_v = 13
				x_off_h = 63
				y_off_h = 87
			Default
				x_off_v = 48
				y_off_v = 89
				x_off_h = 66
				y_off_h = 87
			End Select
		End Select
	
	Default
		Select Case gdir
		Case GLADIUS_DIR_RIGHT
			Select Case Actor_CurrentFrame[gladius_actor]
			Case 0
				x_off_v = 51
				y_off_v = 87
				x_off_h = 64
				y_off_h = 87
			Case 1
				x_off_v = 50
				y_off_v = 87
				x_off_h = 66
				y_off_h = 87
			Case 2
				x_off_v = 49
				y_off_v = 90
				x_off_h = 67
				y_off_h = 87
			Case 3
				x_off_v = 50
				y_off_v = 87
				x_off_h = 66
				y_off_h = 87
			Default
				x_off_v = 51
				y_off_v = 87
				x_off_h = 64
				y_off_h = 87
			End Select
		Default
			Select Case Actor_CurrentFrame[gladius_actor]
			Case 0
				x_off_v = 47
				y_off_v = 87
				x_off_h = 34
				y_off_h = 87
			Case 1
				x_off_v = 48
				y_off_v = 87
				x_off_h = 32
				y_off_h = 87
			Case 2
				x_off_v = 49
				y_off_v = 90
				x_off_h = 31
				y_off_h = 87
			Case 3
				x_off_v = 48
				y_off_v = 87
				x_off_h = 32
				y_off_h = 87
			Default
				x_off_v = 47
				y_off_v = 87
				x_off_h = 34
				y_off_h = 87
			End Select
		End Select
	End Select
	
	
	For i = 0 to 5
		If gladius_weapon_action[i] = GLADIUS_WEAPON_ACTION_HAND Then
			If i < 3 Then
				Actor_SetPosition(gladius_weapon_actor[i], Actor_X[gladius_actor] + x_off_h, Actor_Y[gladius_actor] + y_off_h)
			Else
				Actor_SetPosition(gladius_weapon_actor[i], Actor_X[gladius_actor] + x_off_v, Actor_Y[gladius_actor] + y_off_v)
			End If
		End If
	Next
	
	gladius_enemy = -1
	
	AI_Gladius_RunAction()
	
	'x < 320
	
	If AI_Gladius_ActionComplete() Then
		'print "change"
		Select Case action
		
		Case GLADIUS_ACTION_DEATH
			Actor_SetActive(gladius_death_actor, false)
			
			Actor_SetActive(gladius_weapon_actor[0], false)
			Actor_SetActive(gladius_weapon_actor[1], false)
			Actor_SetActive(gladius_weapon_actor[2], false)
			Actor_SetActive(gladius_weapon_actor[3], false)
			Actor_SetActive(gladius_weapon_actor[4], false)
			Actor_SetActive(gladius_weapon_actor[5], false)
			
			gladius_action = 0
			gladius_alive = false
		
		Default
			gladius_current_cmd = gladius_current_cmd + 1
			If gladius_current_cmd >= gladius_cmd_count Then
				gladius_current_cmd = 0
			End If
			'print gladius_current_cmd;" -> ";gladius_cmd_order[gladius_current_cmd]
			AI_Gladius_StartAction(gladius_cmd_order[gladius_current_cmd])
		End Select
	End If
	
	If gladius_alive Then
		enemy[num_enemies] = gladius_actor
		enemy_hit[num_enemies] = False
		gladius_enemy = num_enemies
		num_enemies = num_enemies + 1
	Else
		gladius_enemy = -1
	End If
End Sub


Sub city_boss()
	STAGE_COMPLETE = False
	LoadStage("nc_boss.stage")
	
	Stage_Init(2)
	Graizor_Init
	
	'DEBUG
	'Graizor_Health = 30
	
	Actor_SetAnimationByName(graizor, "stand_right")
	
	'print "delay = ";Actor_CurrentFrameDelay[fire1]
	
	'Gladuis
	gladius = GetActorID("gladius")
	AI_Init_Gladius
	Actor_SetAnimationByName(gladius, "STAND_LEFT")
	
	Dim saw
	
	For i = 1 to 6
		saw = GetActorID("saw"+str(i))
		Select Case i
		Case 1,2,3: Actor_SetPosition(saw, Actor_X[gladius]+34, Actor_Y[gladius]+87)
		Case 4,5,6: Actor_SetPosition(saw, Actor_X[gladius]+47, Actor_Y[gladius]+87)
		End Select
	Next
	
	
	'------------FADE IN---------------------
	
	Actor_SetPosition(graizor, 192, 544)
	
	st_x = 0
	st_y = 0
	If Actor_X[graizor] > 320 Then
		st_x = Actor_X[graizor] - 320
	End If
		
	If Actor_Y[graizor] > 240 Then
		st_y = Actor_Y[graizor] - 240
	End If
	
	
		
	Stage_SetOffset(st_x, st_y)
	
	Dim boss_end_t
	
	cp = 0
	Init_Checkpoints
	Add_Checkpoint(Actor_X[graizor], Actor_Y[graizor])
	
	Init_Boss_HBar(1, gladius_health)

	While Not Key(K_ESCAPE)
		num_enemies = 0
		If Graizor_CheckDeath Then
			If Player_Continues > 0 Then
				Player_Continues = Player_Continues -1
				StartFromCheckpoint(cp)
			Else
				Exit While
			End If
		End If
		
		AI_Gladius(graizor)
		
		Player_Control(graizor)
		
		st_x = 0
		st_y = 0
		
		If gladius_alive = false And boss_end_t = 0 Then
			boss_end_t = timer
		End If
		
		If (Not gladius_alive) And (timer-boss_end_t > 3000) Then
			STAGE_COMPLETE = True
			Exit While
		End IF
		
		If Actor_X[graizor] > 320 Then
			st_x = Actor_X[graizor] - 320
		End If
		
		If Actor_Y[graizor] > 240 Then
			st_y = Actor_Y[graizor] - 240
		End If
		
		If Actor_Y[graizor] > 600 Then
			'Actor_SetPosition(graizor, 52, 380)
		End If
		
		If key(K_P) Then
			Print "FPS: ";FPS
		End If
		
		Stage_SetOffset(st_x, st_y)
		
		
		DrawHud
		Boss_Hud(gladius_health)
		
		Game_Render
		'Wait(0)
	Wend
	
	'Stage_FadeOut
	Clear_Boss_HBar
	ClearStage(100,100)
End Sub
