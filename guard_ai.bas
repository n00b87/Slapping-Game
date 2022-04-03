'include "engine.bas"

MAX_GUARDS = 20

Dim guard_init_pos[MAX_GUARDS, 2]

Dim guard_alive[MAX_GUARDS]
Dim guard_actor[MAX_GUARDS]
Dim guard_action[MAX_GUARDS]
Dim guard_action_time[MAX_GUARDS]
Dim guard_action_lock[MAX_GUARDS]
Dim guard_action_status[MAX_GUARDS]

Dim GUARD_ACTION_STAND_LEFT
Dim GUARD_ACTION_WALK_LEFT
Dim GUARD_ACTION_SHOOT_LEFT
Dim GUARD_ACTION_SLASH_LEFT

Dim GUARD_ACTION_STAND_RIGHT
Dim GUARD_ACTION_WALK_RIGHT
Dim GUARD_ACTION_SHOOT_RIGHT
Dim GUARD_ACTION_SLASH_RIGHT

Dim GUARD_ACTION_STUN_LEFT
Dim GUARD_ACTION_STUN_RIGHT

Dim GUARD_ACTION_DEATH

GUARD_ACTION_WALK_LEFT = 0
GUARD_ACTION_STAND_LEFT = 1
GUARD_ACTION_SHOOT_LEFT = 2
GUARD_ACTION_SLASH_LEFT = 3

GUARD_ACTION_WALK_RIGHT = 4
GUARD_ACTION_STAND_RIGHT = 5
GUARD_ACTION_SHOOT_RIGHT = 6
GUARD_ACTION_SLASH_RIGHT = 7

GUARD_ACTION_STUN_LEFT = 8
GUARD_ACTION_STUN_RIGHT = 9

GUARD_ACTION_DEATH = 10

Dim guard_distance[MAX_GUARDS]

Dim guard_health[MAX_GUARDS]
Dim guard_weapon_actor[MAX_GUARDS]
Dim guard_death_actor[MAX_GUARDS]

Dim guard_walk_speed
Dim guard_axe_attack
guard_axe_attack = 1
guard_walk_speed = 2
guard_travel_distance = 20

Dim guard_enemy[MAX_GUARDS]

Dim guard_stun_time[MAX_GUARDS]
Dim guard_stun_speed[MAX_GUARDS]
Dim guard_stun_distance[MAX_GUARDS]

Function AI_Init_Guard(actor, action, axe)
	For i = 0 to MAX_GUARDS-1
		If Not guard_alive[i] Then
			guard_alive[i] = True
			guard_actor[i] = actor
			guard_action[i] = action
			Actor_Physics[actor] = True
			Actor_Weight[actor] = 5
			guard_init_pos[i, 0] = Actor_X[actor]
			guard_init_pos[i, 1] = Actor_Y[actor]
			Select Case action
			Case GUARD_ACTION_STAND_LEFT
				Actor_SetAnimationByName(actor, "stand_left")
			Case GUARD_ACTION_WALK_LEFT
				Actor_SetAnimationByName(actor, "walk_left")
			Case GUARD_ACTION_SHOOT_LEFT
				Actor_SetAnimationByName(actor, "shoot_left")
			Case GUARD_ACTION_SLASH_LEFT
				Actor_SetAnimationByName(actor, "slash_left")
			
			Case GUARD_ACTION_STAND_RIGHT
				Actor_SetAnimationByName(actor, "stand_right")
			Case GUARD_ACTION_WALK_RIGHT
				Actor_SetAnimationByName(actor, "walk_right")
			Case GUARD_ACTION_SHOOT_RIGHT
				Actor_SetAnimationByName(actor, "shoot_right")
			Case GUARD_ACTION_SLASH_RIGHT
				Actor_SetAnimationByName(actor, "slash_right")
			
			Default
				Actor_SetAnimationByName(actor, "stand_left")
			End Select
			guard_health[i] = 8
			guard_enemy[i] = -1
			guard_weapon_actor[i] = axe
			
			
			Actor_SetActive(actor, true)
			Actor_SetAnimationFrame(actor, 0)
			Actor_SetAnimationFrame(axe, 0)
			Actor_SetActive(axe, false)
			Actor_SetParent(axe, actor)
			Actor_SetLayer(axe, Actor_Layer[actor])
			
			guard_death_actor[i] = NewActor("guard_death", GetSpriteID("explosion"))
			Actor_SetLayer(guard_death_actor[i], Actor_Layer[actor])
			Actor_SetActive(guard_death_actor[i], false)
			Return i
		End If
	Next
	Return -1
End Function

Sub AI_Init_Guard_All(layer)
	n = 0
	
	axe_sprite = GetSpriteID("axe")
	If axe_sprite < 0 Then
		axe_sprite = LoadSprite("axe")
	End If
	
	For i = 0 to Stage_Layer_NumActors[layer]-1
		a_name$ = Actor_Name[ Stage_Layer_Actor[layer, i] ]
		If Left(LCase(a_name), 5) = "guard" Then
			'print "init guard: ";a_name
			g_actor = Stage_Layer_Actor[layer, i]
			axe = NewActor("axe" + str(n+1), axe_sprite)
			
			g_action = 0
			Select Case Sprite_Animation_Name$[ Actor_Sprite[g_actor], Actor_CurrentAnimation[g_actor] ]
			Case "stand_right"
				g_action = GUARD_ACTION_STAND_RIGHT
			Case "walk_right"
				g_action = GUARD_ACTION_WALK_RIGHT
			Case "stand_left"
				g_action = GUARD_ACTION_STAND_LEFT
			Case "walk_left"
				g_action = GUARD_ACTION_WALK_LEFT
			End Select
			
			AI_Init_Guard(g_actor, g_action, axe)
			n = n + 1
		End If
	Next
	
	
	'Print n;" number of guards"
	'Print "Active = ";Actor_Active[guard_actor[0]]
End Sub

Sub AI_Guard_RunAction(gnum)
	actor = guard_actor[gnum]
	wpn = guard_weapon_actor[gnum]
	action = guard_action[gnum]
	Select Case action
	Case GUARD_ACTION_STAND_LEFT
		'Do nothing for now
	Case GUARD_ACTION_WALK_LEFT
		If timer - guard_action_time[gnum] > 15 Then
			Actor_Move(actor, -1 * guard_walk_speed, 0)
			guard_distance[gnum] = guard_distance[gnum] + 1
			guard_action_time[gnum] = timer
		End If
	Case GUARD_ACTION_SHOOT_LEFT
		'Do nothing for now
	Case GUARD_ACTION_SLASH_LEFT
		Actor_Move(actor, -3, 0)
		Actor_SetPosition(wpn, Actor_X[actor] - 62, Actor_Y[actor])
	Case GUARD_ACTION_STAND_RIGHT
		'Do nothing for now
	Case GUARD_ACTION_WALK_RIGHT
		If timer - guard_action_time[gnum] > 15 Then
			Actor_Move(actor, guard_walk_speed, 0)
			guard_distance[gnum] = guard_distance[gnum] + 1
			guard_action_time[gnum] = timer
		End If
	Case GUARD_ACTION_SHOOT_RIGHT
		'Do nothing for now
	Case GUARD_ACTION_SLASH_RIGHT
		Actor_Move(actor, 3, 0)
		Actor_SetPosition(wpn, Actor_X[actor], Actor_Y[actor])
	Case GUARD_ACTION_STUN_LEFT
		If guard_distance[gnum] < guard_stun_distance[gnum] Then
			Actor_Move(actor, guard_stun_speed[gnum], 0)
			guard_distance[gnum] = guard_distance[gnum] + 1	
		End If
	Case GUARD_ACTION_STUN_RIGHT
		If guard_distance[gnum] < guard_stun_distance[gnum] Then
			Actor_Move(actor, guard_stun_speed[gnum], 0)
			guard_distance[gnum] = guard_distance[gnum] + 1	
		End If
	Case GUARD_ACTION_DEATH
		'print "animation = ";Actor_CurrentAnimation[guard_death_actor[gnum]]
		'print "num aframes = ";Sprite_Animation_NumFrames[ Actor_Sprite[guard_death_actor[gnum]], 0]
		'print "cframe = ";Actor_CurrentFrameTime[guard_death_actor[gnum]]
		'print "cdelay = ";Actor_CurrentFrameDelay[guard_death_actor[gnum]]
	End Select
End Sub

Sub AI_Guard_StartAction(gnum, action)
	Select Case action
	Case GUARD_ACTION_STAND_LEFT
		Actor_SetAnimationByName(guard_actor[gnum], "stand_left")
		Actor_SetAnimationFrame(guard_actor[gnum], 0)
		guard_action_time[gnum] = timer
	Case GUARD_ACTION_WALK_LEFT
		Actor_SetAnimationByName(guard_actor[gnum], "walk_left")
		guard_distance[gnum] = 0
	Case GUARD_ACTION_SHOOT_LEFT
		Actor_SetAnimationByName(guard_actor[gnum], "shoot_left")
		guard_action_time[gnum] = timer
	Case GUARD_ACTION_SLASH_LEFT
		Actor_SetAnimationByName(guard_actor[gnum], "slash_left")
		Actor_SetAnimationFrame(guard_actor[gnum], 0)
		Actor_SetActive(guard_weapon_actor[gnum], true)
		Actor_SetAnimationByName(guard_weapon_actor[gnum], "slash_left")
		Actor_SetAnimationFrame(guard_weapon_actor[gnum], 0)
		Actor_SetPosition(guard_weapon_actor[gnum], Actor_X[guard_actor[gnum]]-62, Actor_Y[guard_actor[gnum]])
		guard_action_time[gnum] = timer
	Case GUARD_ACTION_STAND_RIGHT
		Actor_SetAnimationByName(guard_actor[gnum], "stand_right")
		Actor_SetAnimationFrame(guard_actor[gnum], 0)
		guard_action_time[gnum] = timer
	Case GUARD_ACTION_WALK_RIGHT
		Actor_SetAnimationByName(guard_actor[gnum], "walk_right")
		guard_distance[gnum] = 0
	Case GUARD_ACTION_SHOOT_RIGHT
		Actor_SetAnimationByName(guard_actor[gnum], "shoot_right")
		guard_action_time[gnum] = timer
	Case GUARD_ACTION_SLASH_RIGHT
		Actor_SetAnimationByName(guard_actor[gnum], "slash_right")
		Actor_SetActive(guard_weapon_actor[gnum], true)
		Actor_SetAnimationByName(guard_weapon_actor[gnum], "slash_right")
		Actor_SetAnimationFrame(guard_weapon_actor[gnum], 0)
		guard_action_time[gnum] = timer
	Case GUARD_ACTION_STUN_LEFT
		Actor_SetAnimationByName(guard_actor[gnum], "stun_left")
		Actor_SetAnimationFrame(guard_actor[gnum], 0)
		Actor_SetActive(guard_weapon_actor[gnum], false)
		guard_action_time[gnum] = timer
		guard_distance[gnum] = 0
		PlaySound(1, 0, 0)
	Case GUARD_ACTION_STUN_RIGHT
		Actor_SetAnimationByName(guard_actor[gnum], "stun_right")
		Actor_SetAnimationFrame(guard_actor[gnum], 0)
		Actor_SetActive(guard_weapon_actor[gnum], false)
		guard_action_time[gnum] = timer
		guard_distance[gnum] = 0
		PlaySound(1, 0, 0)
	Case GUARD_ACTION_DEATH
		Actor_SetActive(guard_actor[gnum], false)
		Actor_SetActive(guard_weapon_actor[gnum], false)
		Actor_SetActive(guard_death_actor[gnum], true)
		Actor_SetAnimation(guard_death_actor[gnum], 0)
		Actor_SetAnimationFrame(guard_death_actor[gnum], 0)
		Actor_SetPosition(guard_death_actor[gnum], Actor_X[guard_actor[gnum]], Actor_Y[guard_actor[gnum]])
		guard_action_time[gnum] = timer
		PlaySound(3, 1, 0)
	End Select
	
	Select Case action
	Case GUARD_ACTION_STUN_LEFT, GUARD_ACTION_STUN_RIGHT
		SetImageBlendMode(Sprite_Image[Actor_Sprite[guard_actor[gnum]]], BLENDMODE_ADD)
	Default
		SetImageBlendMode(Sprite_Image[Actor_Sprite[guard_actor[gnum]]], BLENDMODE_BLEND)
	End Select
	
	guard_action[gnum] = action
	guard_action_status[gnum] = true
End Sub

Function AI_Guard_ActionComplete(gnum)
	If Not guard_action_status[gnum] Then
		Return True
	End If
	action = guard_action[gnum]
	Select Case action
	Case GUARD_ACTION_STAND_LEFT
		If timer - guard_action_time[gnum] > 1000 Then
			guard_action_status[gnum] = False
			Return True
		End If
	Case GUARD_ACTION_WALK_LEFT
		If guard_distance[gnum] >= guard_travel_distance Then
			guard_action_status[gnum] = False
			Return True
		End If
	Case GUARD_ACTION_SHOOT_LEFT
		If timer - guard_action_time[gnum] > 2000 Then
			guard_action_status[gnum] = False
			Return True
		End If
	Case GUARD_ACTION_SLASH_LEFT
		If Actor_AnimationEnded[guard_actor[gnum]] Then
			guard_action_status[gnum] = False
			Actor_SetActive(guard_weapon_actor[gnum], false)
			Return True
		End If
	Case GUARD_ACTION_STAND_RIGHT
		If timer - guard_action_time[gnum] > 1000 Then
			guard_action_status[gnum] = False
			Return True
		End If
	Case GUARD_ACTION_WALK_RIGHT
		If guard_distance[gnum] >= guard_travel_distance Then
			guard_action_status[gnum] = False
			Return True
		End If
	Case GUARD_ACTION_SHOOT_RIGHT
		If timer - guard_action_time[gnum] > 2000 Then
			guard_action_status[gnum] = False
			Return True
		End If
	Case GUARD_ACTION_SLASH_RIGHT
		If Actor_AnimationEnded[guard_actor[gnum]] Then
			guard_action_status[gnum] = False
			Actor_SetActive(guard_weapon_actor[gnum], false)
			Return True
		End If
	Case GUARD_ACTION_STUN_LEFT
		If timer - guard_action_time[gnum] > guard_stun_time[gnum] Then
			guard_action_status[gnum] = false
			Return True
		End If
	Case GUARD_ACTION_STUN_RIGHT
		If timer - guard_action_time[gnum] > guard_stun_time[gnum] Then
			guard_action_status[gnum] = false
			Return True
		End If
	Case GUARD_ACTION_DEATH
		If Actor_AnimationEnded[guard_death_actor[gnum]] Then
			guard_action_status[gnum] = false
			'print "end death"
			Return True
		End If
	End Select
End Function

'walk left 20 steps
'stand left 1 sec
'walk right 20 steps
'stand right 1 sec
Dim GUARD_DIR_LEFT
Dim GUARD_DIR_RIGHT
GUARD_DIR_LEFT = 0
GUARD_DIR_RIGHT = 2
Function Guard_GetDirection(gnum)
	a = guard_action[gnum]
	If a = GUARD_ACTION_SHOOT_LEFT Or a = GUARD_ACTION_SLASH_LEFT Or a = GUARD_ACTION_STAND_LEFT Or a = GUARD_ACTION_WALK_LEFT Or a = GUARD_ACTION_STUN_LEFT Then
		Return GUARD_DIR_LEFT
	Else
		Return GUARD_DIR_RIGHT
	End If
End Function

Sub Guard_Attack_Collision(gz_id, gnum)
	If Actor_GetCollision(gz_id, guard_weapon_actor[gnum]) And (Not Player_isStunned) Then
		Player_isStunned = True
		Player_Stun_Time = Timer
		If Graizor_Direction = GRAIZOR_DIRECTION_RIGHT Then
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
		Graizor_Health = Graizor_Health - guard_axe_attack
		PlaySound(1, 0, 0)
	End If
End Sub

Sub AI_Guard(gnum, gz_id)
	actor = guard_actor[gnum]
	action = guard_action[gnum]
	
	If Not Actor_GetDistance(gz_id, guard_actor[gnum]) <= 640 Then
		'Return
	End If
	
	'print "action = ";action
	
	If Actor_Y[guard_actor[gnum]] > Stage_End_Y Then
		guard_alive[gnum] = false
		Actor_SetActive(guard_actor[gnum], false)
	End If
	
	If guard_health[gnum] <= 0 And guard_alive[gnum] And guard_action[gnum] <> GUARD_ACTION_DEATH Then
		'Play death animation
		AI_Guard_StartAction(gnum, GUARD_ACTION_DEATH)
	End If
	
	Guard_Attack_Collision(gz_id, gnum)
	
	If (Not Player_isStunned) And guard_alive[gnum] And action <> GUARD_ACTION_DEATH And (action = GUARD_ACTION_STAND_LEFT Or action = GUARD_ACTION_STAND_RIGHT Or action = GUARD_ACTION_WALK_LEFT Or action = GUARD_ACTION_WALK_RIGHT) Then
		If Actor_GetDistance(gz_id, guard_actor[gnum]) <= 160 Then
			If Actor_X[gz_id] <= Actor_X[actor] Then
				AI_Guard_StartAction(gnum, GUARD_ACTION_SLASH_LEFT)
			Else
				AI_Guard_StartAction(gnum, GUARD_ACTION_SLASH_RIGHT)
			End If
		End If
	End If
	
	If Actor_GetCollision(Actor_ChildActor[gz_id], actor) and action <> GUARD_ACTION_STUN_LEFT and action <> GUARD_ACTION_STUN_RIGHT Then
		If Guard_GetDirection(gnum) = GUARD_DIR_LEFT Then
			guard_stun_time[gnum] = 250 + add_stun_time
			guard_stun_speed[gnum] = -1 + ( -3 * Abs(Sign(add_stun_time)) )
			AI_Guard_StartAction(gnum, GUARD_ACTION_STUN_LEFT)
		Else
			guard_stun_time[gnum] = 250 + add_stun_time
			guard_stun_speed[gnum] = 1 + ( 3 * Abs(Sign(add_stun_time)) )
			AI_Guard_StartAction(gnum, GUARD_ACTION_STUN_RIGHT)
		End If
		guard_health[gnum] = guard_health[gnum] - Graizor_Sword_Attack
	ElseIf guard_enemy[gnum] >= 0 Then
		If enemy_hit[guard_enemy[gnum]] and action <> GUARD_ACTION_STUN_LEFT and action <> GUARD_ACTION_STUN_RIGHT Then
			If Guard_GetDirection(gnum) = GUARD_DIR_LEFT Then
				guard_stun_time[gnum] = 250
				guard_stun_speed[gnum] = -1
				AI_Guard_StartAction(gnum, GUARD_ACTION_STUN_LEFT)
			Else
				guard_stun_time[gnum] = 250
				guard_stun_speed[gnum] = 1
				AI_Guard_StartAction(gnum, GUARD_ACTION_STUN_RIGHT)
			End If
			guard_health[gnum] = guard_health[gnum] - blaster_atk
		End If
	End If
	
	guard_enemy[gnum] = -1
	
	AI_Guard_RunAction(gnum)
	
	If AI_Guard_ActionComplete(gnum) Then
		'print "change"
		Select Case action
		Case GUARD_ACTION_STAND_LEFT
			AI_Guard_StartAction(gnum, GUARD_ACTION_WALK_RIGHT)
		Case GUARD_ACTION_WALK_LEFT
			AI_Guard_StartAction(gnum, GUARD_ACTION_STAND_LEFT)
		Case GUARD_ACTION_SHOOT_LEFT
			
		Case GUARD_ACTION_SLASH_LEFT
			AI_Guard_StartAction(gnum, GUARD_ACTION_STAND_LEFT)
		Case GUARD_ACTION_STAND_RIGHT
			AI_Guard_StartAction(gnum, GUARD_ACTION_WALK_LEFT)
		Case GUARD_ACTION_WALK_RIGHT
			AI_Guard_StartAction(gnum, GUARD_ACTION_STAND_RIGHT)
		Case GUARD_ACTION_SHOOT_RIGHT
			
		Case GUARD_ACTION_SLASH_RIGHT
			AI_Guard_StartAction(gnum, GUARD_ACTION_STAND_RIGHT)
		Case GUARD_ACTION_STUN_LEFT
			AI_Guard_StartAction(gnum, GUARD_ACTION_STAND_LEFT)
		Case GUARD_ACTION_STUN_RIGHT
			AI_Guard_StartAction(gnum, GUARD_ACTION_STAND_RIGHT)
		Case GUARD_ACTION_DEATH
			Actor_SetActive(guard_death_actor[gnum], false)
			Actor_SetActive(guard_weapon_actor[gnum], false)
			guard_action[gnum] = 0
			guard_alive[gnum] = false
		End Select
	End If
	
	If guard_alive[gnum] Then
		enemy[num_enemies] = guard_actor[gnum]
		enemy_hit[num_enemies] = False
		guard_enemy[gnum] = num_enemies
		num_enemies = num_enemies + 1
	Else
		guard_enemy[gnum] = -1
	End If
End Sub

Sub Guard_Act(gz_id)
	For i = 0 to MAX_GUARDS-1
		If guard_alive[i] Then
			AI_Guard(i, gz_id)
			
			'If guard_actor[i] = GetActorID("guard_2") Then
				'Print "2: ";Actor_Active[guard_actor[i]]
			'End If
		Else
			'Actor_SetActive(guard_weapon_actor[i], false)
			'If guard_actor[i] = GetActorID("guard_2") Then
			'	Print ""
			'End If
		End If
	Next
	'a = GetActorID("guard_2")
	'If Key(K_G) Then
	'	Print "guard_2 = ";a
	'	Print "guard_2: ";Actor_X[a];", ";Actor_Y[a]
	'	Print "visible = ";Actor_isVisible(a)
	'	Print "active = ";Actor_isActive(a)
	'	Print "alive = ";guard_alive[1]
	'	Print ""
	'End If
End Sub
