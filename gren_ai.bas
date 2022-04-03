'include "engine.bas"

MAX_GRENS = 12

Dim gren_init_pos[MAX_GRENS, 2]

Dim gren_alive[MAX_GRENS]
Dim gren_actor[MAX_GRENS]
Dim gren_action[MAX_GRENS]
Dim gren_action_time[MAX_GRENS]
Dim gren_action_lock[MAX_GRENS]
Dim gren_action_status[MAX_GRENS]

Dim GREN_ACTION_STAND_LEFT
Dim GREN_ACTION_WALK_LEFT
Dim GREN_ACTION_SHOOT_LEFT
Dim GREN_ACTION_SLASH_LEFT

Dim GREN_ACTION_STAND_RIGHT
Dim GREN_ACTION_WALK_RIGHT
Dim GREN_ACTION_SHOOT_RIGHT
Dim GREN_ACTION_SLASH_RIGHT

Dim GREN_ACTION_STUN_LEFT
Dim GREN_ACTION_STUN_RIGHT

Dim GREN_ACTION_WALK_LEFT2
Dim GREN_ACTION_WALK_RIGHT2

Dim GREN_ACTION_DEATH

GREN_ACTION_WALK_LEFT = 0
GREN_ACTION_STAND_LEFT = 1
GREN_ACTION_SHOOT_LEFT = 2
GREN_ACTION_SLASH_LEFT = 3
GREN_ACTION_WALK_LEFT2 = 4

GREN_ACTION_WALK_RIGHT = 5
GREN_ACTION_STAND_RIGHT = 6
GREN_ACTION_SHOOT_RIGHT = 7
GREN_ACTION_SLASH_RIGHT = 8
GREN_ACTION_WALK_RIGHT2 = 9

GREN_ACTION_STUN_LEFT = 10
GREN_ACTION_STUN_RIGHT = 11

GREN_ACTION_DEATH = 12

Dim gren_distance[MAX_GRENS]

Dim MAX_GREN_BULLETS
MAX_GREN_BULLETS = 3

Dim gren_health[MAX_GRENS]
Dim gren_weapon_actor[MAX_GRENS, MAX_GREN_BULLETS]
Dim gren_weapon_speed[MAX_GRENS, MAX_GREN_BULLETS]
Dim gren_death_actor[MAX_GRENS]

Dim gren_walk_speed
Dim gren_bullet_attack
DIm gren_bullet_speed
gren_bullet_speed = 2
gren_bullet_attack = 1
gren_walk_speed = 2
gren_travel_distance = 60

Dim gren_enemy[MAX_GRENS]
Dim gren_start_action[MAX_GRENS]
Dim gren_action_time2[MAX_GRENS]

Dim gren_shot_wait_time
gren_shot_wait_time = 900

Dim gren_stun_time[MAX_GRENS]

Function AI_Init_GREN(actor)
	For i = 0 to MAX_GRENS-1
		If Not gren_alive[i] Then
			gren_alive[i] = True
			gren_actor[i] = actor
			'gren_action[i] = action
			Actor_Physics[actor] = True
			Actor_Weight[actor] = 5
			gren_init_pos[i, 0] = Actor_X[actor]
			gren_init_pos[i, 1] = Actor_Y[actor]
			'print "Gren: ";Actor_Name[actor]
			Select Case Sprite_Animation_Name$[ Actor_Sprite[actor], Actor_CurrentAnimation[actor] ]
			Case "STAND_LFT"
				gren_action[i] = GREN_ACTION_STAND_LEFT
				gren_start_action[i] = GREN_ACTION_STAND_LEFT
			Case "WALK_LEFT"
				gren_action[i] = GREN_ACTION_WALK_LEFT
				gren_start_action[i] = GREN_ACTION_WALK_LEFT
			Case "STAND_RIGHT"
				gren_action[i] = GREN_ACTION_STAND_RIGHT
				gren_start_action[i] = GREN_ACTION_STAND_RIGHT
			Case "WALK_RIGHT"
				gren_action[i] = GREN_ACTION_WALK_RIGHT
				gren_start_action[i] = GREN_ACTION_WALK_RIGHT
			End Select
			
			
			gren_health[i] = 12
			gren_enemy[i] = -1
			
			bullet_spr = GetSpriteID("grenade_blast")
			
			If bullet_spr < 0 Then
				bullet_spr = LoadSprite("grenade_blast")
				'print "GREN bullet = ";bullet_spr
			End If
			
			'print "Start here"
			For n = 0 to MAX_GREN_BULLETS-1
				gren_weapon_actor[i, n] = NewActor("gren_"+str(i)+"_bullet_0"+str(n+1), bullet_spr)
				Actor_SetAnimationByName(gren_weapon_actor[i, n], "LEFT")
				Actor_SetAnimationFrame(gren_weapon_actor[i, n], 0)
				Actor_SetActive(gren_weapon_actor[i,n], false)
				Actor_SetLayer(gren_weapon_actor[i, n], 2)
				Actor_Physics[gren_weapon_actor[i, n]] = False
			Next
			'print "made it here"
			Actor_SetAnimationFrame(actor, 0)
			
			'If Not gren_death_actor[i] Then
				'print "last"
				gren_death_actor[i] = NewActor("gren_"+str(i)+"_death", GetSpriteID("explosion"))
				Actor_SetLayer(gren_death_actor[i], Actor_Layer[actor])
				Actor_SetActive(gren_death_actor[i], false)
			'End If
			Return i
		End If
	Next
	Return -1
End Function
'0 , 26

Sub AI_GREN_RunAction(gnum)
	actor = gren_actor[gnum]
	
	If Not Actor_isOnScreen(actor) Then
		Return
	End If
	'wpn1 = gren_weapon_actor[gnum,0]
	'wpn2 = gren_weapon_actor[gnum,1]
	action = gren_action[gnum]
	
	Select Case action
	Case GREN_ACTION_STAND_LEFT
		If (timer - gren_action_time2[gnum]) > gren_shot_wait_time Then
			For i = 0 to MAX_GREN_BULLETS-1
				If Not Actor_Active[gren_weapon_actor[gnum, i]] Then
					Actor_SetActive(gren_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(gren_weapon_actor[gnum, i], "MAIN")
					Actor_SetAnimationFrame(gren_weapon_actor[gnum, i], 0)
					Actor_SetPosition(gren_weapon_actor[gnum, i], Actor_X[actor]-8, Actor_Y[actor]-4)
					
					Actor_Jump[gren_weapon_actor[gnum,i]] = 60
					Actor_Force_X[gren_weapon_actor[gnum,i]] = 0-gren_bullet_speed
					Actor_Force_Y[gren_weapon_actor[gnum,i]] = -3
					Actor_Weight[gren_weapon_actor[gnum,i]] = 4
					Actor_Physics[gren_weapon_actor[gnum,i]] = True
					Actor_Physics_State[gren_weapon_actor[gnum,i]] = PHYSICS_STATE_RISE
					
					'gren_weapon_speed[gnum, i] = 0 - gren_bullet_speed
					gren_action_time2[gnum] = timer
					PlaySound(shot_sound_3, 0, 0)
					Exit For
				End If
			Next
		End If
	Case GREN_ACTION_WALK_LEFT
		If timer - gren_action_time[gnum] > 15 Then
			Actor_Move(actor, -1 * gren_walk_speed, 0)
			gren_distance[gnum] = gren_distance[gnum] + 1
			gren_action_time[gnum] = timer
		End If
		
		If (timer - gren_action_time2[gnum]) > gren_shot_wait_time Then
			For i = 0 to MAX_GREN_BULLETS-1
				If Not Actor_Active[gren_weapon_actor[gnum, i]] Then
					Actor_SetActive(gren_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(gren_weapon_actor[gnum, i], "MAIN")
					Actor_SetAnimationFrame(gren_weapon_actor[gnum, i], 0)
					Actor_SetPosition(gren_weapon_actor[gnum, i], Actor_X[actor]-8, Actor_Y[actor]-4)
					
					Actor_Jump[gren_weapon_actor[gnum,i]] = 60
					Actor_Force_X[gren_weapon_actor[gnum,i]] = 0-gren_bullet_speed
					Actor_Force_Y[gren_weapon_actor[gnum,i]] = -3
					Actor_Weight[gren_weapon_actor[gnum,i]] = 4
					Actor_Physics[gren_weapon_actor[gnum,i]] = True
					Actor_Physics_State[gren_weapon_actor[gnum,i]] = PHYSICS_STATE_RISE
					
					'gren_weapon_speed[gnum, i] = 0 - gren_bullet_speed
					gren_action_time2[gnum] = timer
					PlaySound(shot_sound_3, 0, 0)
					Exit For
				End If
			Next
		End If
	
	Case GREN_ACTION_WALK_LEFT2
		If timer - gren_action_time[gnum] > 15 Then
			Actor_Move(actor, gren_walk_speed, 0)
			gren_distance[gnum] = gren_distance[gnum] + 1
			gren_action_time[gnum] = timer
		End If
		
		If (timer - gren_action_time2[gnum]) > gren_shot_wait_time Then
			For i = 0 to MAX_GREN_BULLETS-1
				If Not Actor_Active[gren_weapon_actor[gnum, i]] Then
					Actor_SetActive(gren_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(gren_weapon_actor[gnum, i], "MAIN")
					Actor_SetAnimationFrame(gren_weapon_actor[gnum, i], 0)
					Actor_SetPosition(gren_weapon_actor[gnum, i], Actor_X[actor]-8, Actor_Y[actor]-4)
					
					Actor_Jump[gren_weapon_actor[gnum,i]] = 60
					Actor_Force_X[gren_weapon_actor[gnum,i]] = 0-gren_bullet_speed
					Actor_Force_Y[gren_weapon_actor[gnum,i]] = -3
					Actor_Weight[gren_weapon_actor[gnum,i]] = 4
					Actor_Physics[gren_weapon_actor[gnum,i]] = True
					Actor_Physics_State[gren_weapon_actor[gnum,i]] = PHYSICS_STATE_RISE
					
					'gren_weapon_speed[gnum, i] = 0 - gren_bullet_speed
					gren_action_time2[gnum] = timer
					PlaySound(shot_sound_3, 0, 0)
					Exit For
				End If
			Next
		End If
	
	Case GREN_ACTION_SHOOT_LEFT
		If (timer - gren_action_time[gnum]) > gren_shot_wait_time Then
			For i = 0 to MAX_GREN_BULLETS-1
				If Not Actor_Active[gren_weapon_actor[gnum, i]] Then
					Actor_SetActive(gren_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(gren_weapon_actor[gnum, i], "MAIN")
					Actor_SetAnimationFrame(gren_weapon_actor[gnum, i], 0)
					Actor_SetPosition(gren_weapon_actor[gnum, i], Actor_X[actor]-8, Actor_Y[actor]-4)
					
					Actor_Jump[gren_weapon_actor[gnum,i]] = 60
					Actor_Force_X[gren_weapon_actor[gnum,i]] = 0-gren_bullet_speed
					Actor_Force_Y[gren_weapon_actor[gnum,i]] = -3
					Actor_Weight[gren_weapon_actor[gnum,i]] = 4
					Actor_Physics[gren_weapon_actor[gnum,i]] = True
					Actor_Physics_State[gren_weapon_actor[gnum,i]] = PHYSICS_STATE_RISE
					
					'gren_weapon_speed[gnum, i] = 0 - gren_bullet_speed
					gren_action_time[gnum] = timer
					PlaySound(shot_sound_3, 0, 0)
					Exit For
				End If
			Next
		End If
	
	Case GREN_ACTION_STAND_RIGHT
		'Do nothing for now
		If (timer - gren_action_time2[gnum]) > gren_shot_wait_time Then
			For i = 0 to MAX_GREN_BULLETS-1
				If Not Actor_Active[gren_weapon_actor[gnum, i]] Then
					Actor_SetActive(gren_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(gren_weapon_actor[gnum, i], "MAIN")
					Actor_SetAnimationFrame(gren_weapon_actor[gnum, i], 0)
					Actor_SetPosition(gren_weapon_actor[gnum, i], Actor_X[actor]+16, Actor_Y[actor]-4)
					
					Actor_Jump[gren_weapon_actor[gnum,i]] = 60
					Actor_Force_X[gren_weapon_actor[gnum,i]] = gren_bullet_speed
					Actor_Force_Y[gren_weapon_actor[gnum,i]] = -3
					Actor_Weight[gren_weapon_actor[gnum,i]] = 4
					Actor_Physics[gren_weapon_actor[gnum,i]] = True
					Actor_Physics_State[gren_weapon_actor[gnum,i]] = PHYSICS_STATE_RISE
					
					'gren_weapon_speed[gnum, i] = 0 - gren_bullet_speed
					gren_action_time2[gnum] = timer
					PlaySound(shot_sound_3, 0, 0)
					Exit For
				End If
			Next
		End If
	Case GREN_ACTION_WALK_RIGHT
		If timer - gren_action_time[gnum] > 15 Then
			Actor_Move(actor, gren_walk_speed, 0)
			gren_distance[gnum] = gren_distance[gnum] + 1
			gren_action_time[gnum] = timer
		End If
		
		If (timer - gren_action_time2[gnum]) > gren_shot_wait_time Then
			For i = 0 to MAX_GREN_BULLETS-1
				If Not Actor_Active[gren_weapon_actor[gnum, i]] Then
					Actor_SetActive(gren_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(gren_weapon_actor[gnum, i], "MAIN")
					Actor_SetAnimationFrame(gren_weapon_actor[gnum, i], 0)
					Actor_SetPosition(gren_weapon_actor[gnum, i], Actor_X[actor]+16, Actor_Y[actor]-4)
					
					Actor_Jump[gren_weapon_actor[gnum,i]] = 60
					Actor_Force_X[gren_weapon_actor[gnum,i]] = gren_bullet_speed
					Actor_Force_Y[gren_weapon_actor[gnum,i]] = -3
					Actor_Weight[gren_weapon_actor[gnum,i]] = 4
					Actor_Physics[gren_weapon_actor[gnum,i]] = True
					Actor_Physics_State[gren_weapon_actor[gnum,i]] = PHYSICS_STATE_RISE
					
					gren_weapon_speed[gnum, i] = gren_bullet_speed
					gren_action_time2[gnum] = timer
					PlaySound(shot_sound_3, 0, 0)
					Exit For
				End If
			Next
		End If
		
	Case GREN_ACTION_WALK_RIGHT2
		If timer - gren_action_time[gnum] > 15 Then
			Actor_Move(actor, 0-gren_walk_speed, 0)
			gren_distance[gnum] = gren_distance[gnum] + 1
			gren_action_time[gnum] = timer
		End If
		
		If (timer - gren_action_time2[gnum]) > gren_shot_wait_time Then
			For i = 0 to MAX_GREN_BULLETS-1
				If Not Actor_Active[gren_weapon_actor[gnum, i]] Then
					Actor_SetActive(gren_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(gren_weapon_actor[gnum, i], "MAIN")
					Actor_SetAnimationFrame(gren_weapon_actor[gnum, i], 0)
					Actor_SetPosition(gren_weapon_actor[gnum, i], Actor_X[actor]+16, Actor_Y[actor]-4)
					
					Actor_Jump[gren_weapon_actor[gnum,i]] = 60
					Actor_Force_X[gren_weapon_actor[gnum,i]] = gren_bullet_speed
					Actor_Force_Y[gren_weapon_actor[gnum,i]] = -3
					Actor_Weight[gren_weapon_actor[gnum,i]] = 4
					Actor_Physics[gren_weapon_actor[gnum,i]] = True
					Actor_Physics_State[gren_weapon_actor[gnum,i]] = PHYSICS_STATE_RISE
					
					gren_weapon_speed[gnum, i] = gren_bullet_speed
					gren_action_time2[gnum] = timer
					PlaySound(shot_sound_3, 0, 0)
					Exit For
				End If
			Next
		End If
	Case GREN_ACTION_SHOOT_RIGHT
		If (timer - gren_action_time[gnum]) > gren_shot_wait_time Then
			For i = 0 to MAX_GREN_BULLETS-1
				If Not Actor_Active[gren_weapon_actor[gnum, i]] Then
					Actor_SetActive(gren_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(gren_weapon_actor[gnum, i], "MAIN")
					Actor_SetAnimationFrame(gren_weapon_actor[gnum, i], 0)
					Actor_SetPosition(gren_weapon_actor[gnum, i], Actor_X[actor]+16, Actor_Y[actor]-4)
					
					Actor_Jump[gren_weapon_actor[gnum,i]] = 60
					Actor_Force_X[gren_weapon_actor[gnum,i]] = gren_bullet_speed
					Actor_Force_Y[gren_weapon_actor[gnum,i]] = -3
					Actor_Weight[gren_weapon_actor[gnum,i]] = 4
					Actor_Physics[gren_weapon_actor[gnum,i]] = True
					Actor_Physics_State[gren_weapon_actor[gnum,i]] = PHYSICS_STATE_RISE
					
					gren_weapon_speed[gnum, i] = gren_bullet_speed
					gren_action_time[gnum] = timer
					PlaySound(shot_sound_3, 0, 0)
					Exit For
				End If
			Next
		End If
	Case GREN_ACTION_SLASH_RIGHT
		'Actor_Move(actor, 3, 0)
		'Actor_SetPosition(wpn, Actor_X[actor], Actor_Y[actor])
	Case GREN_ACTION_STUN_LEFT
		If gren_distance[gnum] < 5 Then
			Actor_Move(actor, 1, 0)
			gren_distance[gnum] = gren_distance[gnum] + 1	
		End If
	Case GREN_ACTION_STUN_RIGHT
		If gren_distance[gnum] < 5 Then
			Actor_Move(actor, -1, 0)
			gren_distance[gnum] = gren_distance[gnum] + 1	
		End If
	Case GREN_ACTION_DEATH
		'print "animation = ";Actor_CurrentAnimation[gren_death_actor[gnum]]
		'print "num aframes = ";Sprite_Animation_NumFrames[ Actor_Sprite[gren_death_actor[gnum]], 0]
		'print "cframe = ";Actor_CurrentFrameTime[gren_death_actor[gnum]]
		'print "cdelay = ";Actor_CurrentFrameDelay[gren_death_actor[gnum]]
	End Select
End Sub

Sub AI_GREN_StartAction(gnum, action)
	Select Case action
	Case GREN_ACTION_STAND_LEFT
		Actor_SetAnimationByName(gren_actor[gnum], "STAND_LFT")
		Actor_SetAnimationFrame(gren_actor[gnum], 0)
		gren_action_time[gnum] = timer
	Case GREN_ACTION_WALK_LEFT
		Actor_SetAnimationByName(gren_actor[gnum], "WALK_LEFT")
		gren_distance[gnum] = 0
	Case GREN_ACTION_WALK_LEFT2
		Actor_SetAnimationByName(gren_actor[gnum], "WALK_LEFT")
		gren_distance[gnum] = 0
	Case GREN_ACTION_SHOOT_LEFT
		Actor_SetAnimationByName(gren_actor[gnum], "STAND_LFT")
		Actor_SetAnimationFrame(gren_actor[gnum], 0)
	Case GREN_ACTION_STAND_RIGHT
		Actor_SetAnimationByName(gren_actor[gnum], "STAND_RIGHT")
		Actor_SetAnimationFrame(gren_actor[gnum], 0)
		gren_action_time[gnum] = timer
	Case GREN_ACTION_WALK_RIGHT
		Actor_SetAnimationByName(gren_actor[gnum], "WALK_RIGHT")
		gren_distance[gnum] = 0
	Case GREN_ACTION_WALK_RIGHT2
		Actor_SetAnimationByName(gren_actor[gnum], "WALK_RIGHT")
		gren_distance[gnum] = 0
	Case GREN_ACTION_SHOOT_RIGHT
		Actor_SetAnimationByName(gren_actor[gnum], "STAND_RIGHT")
		Actor_SetAnimationFrame(gren_actor[gnum], 0)
	Case GREN_ACTION_STUN_LEFT
		Actor_SetAnimationByName(gren_actor[gnum], "STUN_LEFT")
		Actor_SetAnimationFrame(gren_actor[gnum], 0)
		gren_action_time[gnum] = timer
		gren_distance[gnum] = 0
		PlaySound(1, 0, 0)
	Case GREN_ACTION_STUN_RIGHT
		Actor_SetAnimationByName(gren_actor[gnum], "STUN_RIGHT")
		Actor_SetAnimationFrame(gren_actor[gnum], 0)
		gren_action_time[gnum] = timer
		gren_distance[gnum] = 0
		PlaySound(1, 0, 0)
	Case GREN_ACTION_DEATH
		Actor_SetActive(gren_actor[gnum], false)
		Actor_SetActive(gren_death_actor[gnum], true)
		Actor_SetAnimation(gren_death_actor[gnum], 0)
		Actor_SetAnimationFrame(gren_death_actor[gnum], 0)
		Actor_SetPosition(gren_death_actor[gnum], Actor_X[gren_actor[gnum]], Actor_Y[gren_actor[gnum]])
		gren_action_time[gnum] = timer
		PlaySound(3, 1, 0)
	End Select
	gren_action[gnum] = action
	gren_action_status[gnum] = true
End Sub

Function AI_GREN_ActionComplete(gnum)
	If Not gren_action_status[gnum] Then
		Return True
	End If
	action = gren_action[gnum]
	Select Case action
	Case GREN_ACTION_STAND_LEFT
		If timer - gren_action_time[gnum] > 1000 Then
			gren_action_status[gnum] = False
			Return True
		End If
	Case GREN_ACTION_WALK_LEFT
		If gren_distance[gnum] >= gren_travel_distance Then
			gren_action_status[gnum] = False
			Return True
		End If
	Case GREN_ACTION_WALK_LEFT2
		If gren_distance[gnum] >= gren_travel_distance Then
			gren_action_status[gnum] = False
			Return True
		End If
	Case GREN_ACTION_SHOOT_LEFT
		'If timer - gren_action_time[gnum] > 2000 Then
		'	gren_action_status[gnum] = False
		'	Return True
		'End If
	Case GREN_ACTION_STAND_RIGHT
		If timer - gren_action_time[gnum] > 1000 Then
			gren_action_status[gnum] = False
			Return True
		End If
	Case GREN_ACTION_WALK_RIGHT
		If gren_distance[gnum] >= gren_travel_distance Then
			gren_action_status[gnum] = False
			Return True
		End If
	Case GREN_ACTION_SHOOT_RIGHT
		'If timer - gren_action_time[gnum] > 2000 Then
		'	gren_action_status[gnum] = False
		'	Return True
		'End If
	Case GREN_ACTION_STUN_LEFT
		If timer - gren_action_time[gnum] > gren_stun_time[gnum] Then
			gren_action_status[gnum] = false
			Return True
		End If
	Case GREN_ACTION_STUN_RIGHT
		If timer - gren_action_time[gnum] > gren_stun_time[gnum] Then
			gren_action_status[gnum] = false
			Return True
		End If
	Case GREN_ACTION_DEATH
		If Actor_AnimationEnded[gren_death_actor[gnum]] Then
			gren_action_status[gnum] = false
			'print "end death"
			Return True
		End If
	End Select
End Function

'walk left 20 steps
'stand left 1 sec
'walk right 20 steps
'stand right 1 sec
Dim GREN_DIR_LEFT
Dim GREN_DIR_RIGHT
GREN_DIR_LEFT = 0
GREN_DIR_RIGHT = 2
Function GREN_GetDirection(gnum)
	a = gren_action[gnum]
	If a = GREN_ACTION_SHOOT_LEFT Or a = GREN_ACTION_SLASH_LEFT Or a = GREN_ACTION_STAND_LEFT Or a = GREN_ACTION_WALK_LEFT Or a = GREN_ACTION_STUN_LEFT Then
		Return GREN_DIR_LEFT
	Else
		Return GREN_DIR_RIGHT
	End If
End Function

Dim gren_weapon_impact[MAX_GRENS, MAX_GREN_BULLETS]

Sub GREN_Attack_Collision(gz_id, gnum)
	For i = 0 to MAX_GREN_BULLETS-1
		bullet_actor = gren_weapon_actor[gnum, i]
		If Actor_isActive(bullet_actor) Then
			If (gren_weapon_impact[gnum, i] And Actor_AnimationEnded[bullet_actor]) Then
				gren_weapon_impact[gnum, i] = False
				Actor_SetActive(bullet_actor, False)
			ElseIf (Not Actor_isOnScreen(bullet_actor)) Then
				gren_weapon_impact[gnum, i] = False
				Actor_SetActive(bullet_actor, False)
			ElseIf ( Not gren_weapon_impact[gnum,i] ) And Actor_NumStageCollisions[bullet_actor] > 0 Then
				PlaySound(impact_sound_3, 0, 0)
				Actor_SetAnimationByName(bullet_actor, "EXPLODE")
				Actor_Physics[bullet_actor] = False
				gren_weapon_impact[gnum, i] = True
			ElseIf Actor_GetCollision(gz_id, bullet_actor) And (Not Player_isStunned) And(Not gren_weapon_impact[gnum,i]) Then
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
				'Actor_Force_X[0] = 2
				Actor_Force_Y[gz_id] = -3
				'Actor_Momentum[0] = 2
				Actor_Weight[gz_id] = 3
				Actor_Physics_State[gz_id] = PHYSICS_STATE_RISE
				Actor_SetActive(Actor_ChildActor[gz_id], false)
				Graizor_Health = Graizor_Health - gren_bullet_attack
				PlaySound(impact_sound_3, 0, 0)
				Actor_SetAnimationByName(bullet_actor, "EXPLODE")
				
				Actor_Physics[gren_weapon_actor[gnum,i]] = False
				
				Actor_SetAnimationFrame(bullet_actor, 0)
				gren_weapon_impact[gnum, i] = True
			ElseIf Actor_isActive(bullet_actor) And (Not gren_weapon_impact[gnum, i]) Then
				'Actor_Move(bullet_actor, gren_weapon_speed[gnum, i], 0)
				'print "actor_name = "; Actor_Name[bullet_actor]
				'print "actor info:   gnum=";gnum;"      i=";i
				'print "": print ""
			End If
		End If
	Next
End Sub

Sub AI_GREN(gnum, gz_id)
	actor = gren_actor[gnum]
	action = gren_action[gnum]
	
	
	'print "action = ";action
	
	If Actor_Y[actor] > Stage_End_Y Then
		gren_alive[gnum] = false
		Actor_SetActive(gren_actor[gnum], false)
	End If
	
	If gren_health[gnum] <= 0 And gren_alive[gnum] And gren_action[gnum] <> GREN_ACTION_DEATH Then
		'Play death animation
		AI_GREN_StartAction(gnum, GREN_ACTION_DEATH)
	End If
	
	GREN_Attack_Collision(gz_id, gnum)
	
	'If (Not Player_isStunned) And gren_alive[gnum] And action <> GREN_ACTION_DEATH And (action = GREN_ACTION_STAND_LEFT Or action = GREN_ACTION_STAND_RIGHT Or action = GREN_ACTION_SHOOT_LEFT Or action = GREN_ACTION_SHOOT_RIGHT) Then
	'	If Actor_GetDistance(gz_id, actor) <= 300 Then
	'		If Actor_X[gz_id] <= Actor_X[actor] Then
	'			AI_GREN_StartAction(gnum, GREN_ACTION_SHOOT_LEFT)
	'		Else
	'			AI_GREN_StartAction(gnum, GREN_ACTION_SHOOT_RIGHT)
	'		End If
	'	ElseIf gren_action[gnum] = GREN_ACTION_SHOOT_LEFT Or gren_action[gnum] = GREN_ACTION_SHOOT_RIGHT Then
	'		AI_GREN_StartAction(gnum, GREN_ACTION_STAND_LEFT)
	'	End If
	'End If
	
	If Actor_GetCollision(Actor_ChildActor[gz_id], actor) and action <> GREN_ACTION_STUN_LEFT and action <> GREN_ACTION_STUN_RIGHT Then
		If GREN_GetDirection(gnum) = GREN_DIR_LEFT Then
			AI_GREN_StartAction(gnum, GREN_ACTION_STUN_LEFT)
		Else
			AI_GREN_StartAction(gnum, GREN_ACTION_STUN_RIGHT)
		End If
		gren_stun_time[gnum] = 250 + add_stun_time
		gren_health[gnum] = gren_health[gnum] - Graizor_Sword_Attack
	ElseIf gren_enemy[gnum] >= 0 Then
		If enemy_hit[gren_enemy[gnum]] and action <> GREN_ACTION_STUN_LEFT and action <> GREN_ACTION_STUN_RIGHT Then
			If GREN_GetDirection(gnum) = GREN_DIR_LEFT Then
				AI_GREN_StartAction(gnum, GREN_ACTION_STUN_LEFT)
			Else
				AI_GREN_StartAction(gnum, GREN_ACTION_STUN_RIGHT)
			End If
			gren_stun_time[gnum] = 100 + add_stun_time
			gren_health[gnum] = gren_health[gnum] - blaster_atk
		End If
	End If
	
	gren_enemy[gnum] = -1
	
	AI_GREN_RunAction(gnum)
	
	If AI_GREN_ActionComplete(gnum) Then
		'print "change"
		Select Case action
		Case GREN_ACTION_STAND_LEFT
			AI_GREN_StartAction(gnum, GREN_ACTION_STAND_LEFT)
		Case GREN_ACTION_WALK_LEFT
			AI_GREN_StartAction(gnum, GREN_ACTION_WALK_LEFT2)
		Case GREN_ACTION_WALK_LEFT2
			AI_GREN_StartAction(gnum, GREN_ACTION_WALK_LEFT)
		Case GREN_ACTION_SHOOT_LEFT
			
		Case GREN_ACTION_STAND_RIGHT
			AI_GREN_StartAction(gnum, GREN_ACTION_STAND_LEFT)
		Case GREN_ACTION_WALK_RIGHT
			AI_GREN_StartAction(gnum, GREN_ACTION_WALK_RIGHT2)
		Case GREN_ACTION_WALK_RIGHT2
			AI_GREN_StartAction(gnum, GREN_ACTION_WALK_RIGHT)
		Case GREN_ACTION_SHOOT_RIGHT
			
		Case GREN_ACTION_STUN_LEFT
			AI_GREN_StartAction(gnum, gren_start_action[gnum])
		Case GREN_ACTION_STUN_RIGHT
			AI_GREN_StartAction(gnum, gren_start_action[gnum])
		Case GREN_ACTION_DEATH
			Actor_SetActive(gren_death_actor[gnum], false)
			'Actor_SetActive(gren_weapon_actor[gnum], false)
			gren_action[gnum] = 0
			gren_alive[gnum] = false
		End Select
	End If
	
	If gren_alive[gnum] Then
		enemy[num_enemies] = gren_actor[gnum]
		enemy_hit[num_enemies] = False
		gren_enemy[gnum] = num_enemies
		num_enemies = num_enemies + 1
	Else
		gren_enemy[gnum] = -1
	End If
End Sub

Sub GREN_Act(gz_id)
	For i = 0 to MAX_GRENS-1
		If gren_alive[i] Then
			AI_GREN(i, gz_id)
		ElseIf gren_actor[i] >= 0 Then
			'print"": print "actor !!!!"
			GREN_Attack_Collision(gz_id, i)
		End If
	Next
End Sub
