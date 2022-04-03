'include "engine.bas"
'Include "graizor.bas"

MAX_CLAWS = 20

Dim claw_init_pos[MAX_CLAWS, 2]

Dim claw_alive[MAX_CLAWS]
Dim claw_actor[MAX_CLAWS]
Dim claw_action[MAX_CLAWS]
Dim claw_action_time[MAX_CLAWS]
Dim claw_action_lock[MAX_CLAWS]
Dim claw_action_status[MAX_CLAWS]

Dim CLAW_ACTION_STAND_LEFT
Dim CLAW_ACTION_JUMP_LEFT
Dim CLAW_ACTION_SHOOT_LEFT

Dim CLAW_ACTION_STAND_RIGHT
Dim CLAW_ACTION_JUMP_RIGHT
Dim CLAW_ACTION_SHOOT_RIGHT

Dim CLAW_ACTION_STUN_LEFT
Dim CLAW_ACTION_STUN_RIGHT

Dim CLAW_ACTION_DEATH

CLAW_ACTION_JUMP_LEFT = 0
CLAW_ACTION_STAND_LEFT = 1
CLAW_ACTION_SHOOT_LEFT = 2

CLAW_ACTION_JUMP_RIGHT = 4
CLAW_ACTION_STAND_RIGHT = 5
CLAW_ACTION_SHOOT_RIGHT = 6

CLAW_ACTION_STUN_LEFT = 8
CLAW_ACTION_STUN_RIGHT = 9

CLAW_ACTION_DEATH = 10

Dim claw_distance[MAX_CLAWS]

Dim claw_health[MAX_CLAWS]
Dim claw_weapon_actor[MAX_CLAWS,8]
Dim claw_weapon_timer[MAX_CLAWS]
Dim claw_weapon_speed[MAX_CLAWS,8]
Dim claw_weapon_impact[MAX_CLAWS,8]
Dim claw_death_actor[MAX_CLAWS]

Dim claw_walk_speed
Dim claw_axe_attack
claw_axe_attack = 1
claw_walk_speed = 2
claw_travel_distance = 20

Dim claw_gz_impact
Dim claw_gz_timer

claw_gz_impact = False

Dim claw_enemy[MAX_CLAWS]


Function AI_Init_Claw(actor, action, byref bullet)
	For i = 0 to MAX_CLAWS-1
		If Not claw_alive[i] Then
			claw_alive[i] = True
			claw_actor[i] = actor
			claw_action[i] = action
			Actor_Physics[actor] = True
			Actor_Weight[actor] = 3
			claw_init_pos[i, 0] = Actor_X[actor]
			claw_init_pos[i, 1] = Actor_Y[actor]
			Select Case action
			Case CLAW_ACTION_STAND_LEFT
				Actor_SetAnimationByName(actor, "STAND_LEFT")
			Case CLAW_ACTION_JUMP_LEFT
				Actor_SetAnimationByName(actor, "JUMP_LEFT")
			Case CLAW_ACTION_SHOOT_LEFT
				Actor_SetAnimationByName(actor, "ATTACK_LEFT")
			End Select
			claw_health[i] = 4
			claw_enemy[i] = -1
			
			For n = 0 to 7
				claw_weapon_actor[i,n] = bullet[n]
			
				Actor_SetAnimationFrame(bullet[n], 0)
				Actor_SetActive(bullet[n], false)
				Actor_SetParent(bullet[n], actor)
				Actor_Physics[bullet[n]] = True
				Actor_SetLayer(bullet[n],2)
				Actor_Weight[bullet[n]] = 2
			Next
			
			Actor_SetAnimationFrame(actor, 0)
				
			
			claw_death_actor[i] = NewActor("claw_death", GetSpriteID("explosion"))
			Actor_SetLayer(claw_death_actor[i], Actor_Layer[actor])
			Actor_SetActive(claw_death_actor[i], false)
			Return i
		End If
	Next
	Return -1
End Function

Sub AI_Claw_Bullets(gnum, gz_id)
	'Bullets
	For i = 0 to 7
		If Actor_Active[claw_weapon_actor[gnum, i]] Then
			If Not Actor_isOnScreen(claw_weapon_actor[gnum, i]) Then
					Actor_SetActive(claw_weapon_actor[gnum, i], False) 
			ElseIf Actor_GetCollision(gz_id, claw_weapon_actor[gnum, i]) And (Not claw_weapon_impact[gnum, i]) And (Not claw_gz_impact) Then
				'Graizor_Health = Graizor_Health - claw_axe_attack
				'PRINT "IMPACT"; Actor_X[gz_id];", ";Actor_Y[gz_id];" -- ";Actor_X[claw_weapon_actor[gnum, i]];", ";Actor_Y[claw_weapon_actor[gnum, i]]
				claw_gz_impact = True
				claw_weapon_impact[gnum, i] = True
				Actor_SetAnimationByName(claw_weapon_actor[gnum, i], "IMPACT")
				Actor_Weight[claw_weapon_actor[gnum, i]] = 0
				Actor_SetAnimationFrame(claw_weapon_actor[gnum, i], 0)
			ElseIf Actor_Physics_State[claw_weapon_actor[gnum, i]] = PHYSICS_STATE_GROUND And (Not claw_weapon_impact[gnum, i]) Then
				claw_weapon_impact[gnum, i] = True
				Actor_SetAnimationByName(claw_weapon_actor[gnum, i], "IMPACT")
				Actor_SetAnimationFrame(claw_weapon_actor[gnum, i], 0)
			ElseIf claw_weapon_impact[gnum, i] And Actor_AnimationEnded[claw_weapon_actor[gnum, i]] Then
				claw_weapon_impact[gnum, i] = False
				Actor_SetActive(claw_weapon_actor[gnum, i], False)
			ElseIf Not claw_weapon_impact[gnum, i] Then
				Actor_Move(claw_weapon_actor[gnum, i], claw_weapon_speed[gnum, i], 0)
			End If
		End If
	Next
End Sub

Sub AI_Claw_RunAction(gnum, gz_id)
	actor = claw_actor[gnum]
	
	action = claw_action[gnum]
	
	'If Key(K_D) Then
	'	Print "Actor on Screen = "; Actor_isOnScreen(claw_actor[gnum])
	'End If
	
	Select Case action
	Case CLAW_ACTION_STAND_LEFT
		'Do nothing for now
	Case CLAW_ACTION_JUMP_LEFT
		'Do nothing for now
		
		If timer - claw_weapon_timer[gnum] > 600 and claw_alive[gnum] And Actor_isOnScreen(claw_actor[gnum]) Then
			For i = 0 to 7
				If Not Actor_Active[claw_weapon_actor[gnum, i]] Then
					Actor_SetActive(claw_weapon_actor[gnum, i], True)
					Actor_SetAnimationByName(claw_weapon_actor[gnum, i], "MAIN")
					Actor_SetAnimationFrame(claw_weapon_actor[gnum, i], 0)
					Actor_Physics_State[claw_weapon_actor[gnum, i]] = PHYSICS_STATE_FALL
					Actor_Weight[claw_weapon_actor[gnum, i]] = 2
					Actor_SetPosition(claw_weapon_actor[gnum, i], Actor_X[claw_actor[gnum]]+8, Actor_Y[claw_actor[gnum]]+36)
					claw_weapon_speed[gnum, i] = -2
					claw_weapon_timer[gnum] = timer
					PlaySound(shot_sound_1, 0, 0)
					Exit For
				End If
			Next
		End If
	Case CLAW_ACTION_SHOOT_LEFT
		'Do nothing for now
	
	Case CLAW_ACTION_STAND_RIGHT
		'Do nothing for now
	Case CLAW_ACTION_JUMP_RIGHT
		'Do nothing for now
		If timer - claw_weapon_timer[gnum] > 600 and claw_alive[gnum] And Actor_isOnScreen(claw_actor[gnum]) Then
			For i = 0 to 7
				If Not Actor_Active[claw_weapon_actor[gnum, i]] Then
					Actor_SetActive(claw_weapon_actor[gnum, i], True)
					Actor_SetAnimationByName(claw_weapon_actor[gnum, i], "MAIN")
					Actor_SetAnimationFrame(claw_weapon_actor[gnum, i], 0)
					Actor_Physics_State[claw_weapon_actor[gnum, i]] = PHYSICS_STATE_FALL
					Actor_Weight[claw_weapon_actor[gnum, i]] = 2
					Actor_SetPosition(claw_weapon_actor[gnum, i], Actor_X[claw_actor[gnum]]+62, Actor_Y[claw_actor[gnum]]+36)
					claw_weapon_speed[gnum, i] = 2
					claw_weapon_timer[gnum] = timer
					PlaySound(shot_sound_1, 0, 0)
					Exit For
				End If
			Next
		End If
	Case CLAW_ACTION_SHOOT_RIGHT
		'Do nothing for now
	
	End Select
	
	'Bullets
	AI_Claw_Bullets(gnum, gz_id)
	
End Sub

Sub AI_Claw_StartAction(gnum, action)
	Select Case action
	Case CLAW_ACTION_STAND_LEFT
		Actor_SetAnimationByName(claw_actor[gnum], "STAND_LEFT")
		Actor_SetAnimationFrame(claw_actor[gnum], 0)
		claw_action_time[gnum] = timer
	Case CLAW_ACTION_JUMP_LEFT
		Actor_SetAnimationByName(claw_actor[gnum], "JUMP_LEFT")
		If Actor_Physics_State[claw_actor[gnum]] = PHYSICS_STATE_GROUND Then
			Actor_Physics_State[claw_actor[gnum]] = PHYSICS_STATE_RISE
			Actor_Jump[claw_actor[gnum]] = 100
			Actor_Force_Y[claw_actor[gnum]] = -4
		End If
		'Print "State = ";Actor_Physics_State[claw_actor[gnum]]
		'Print "Jump = ";Actor_Jump[claw_actor[gnum]]
		'Print "Y Force = ";Actor_Force_Y[claw_actor[gnum]]
		'maybe play a sound effect
	Case CLAW_ACTION_SHOOT_LEFT
		Actor_SetAnimationByName(claw_actor[gnum], "ATTACK_LEFT")
		claw_action_time[gnum] = timer
		
	Case CLAW_ACTION_STUN_LEFT
		Actor_SetAnimationByName(claw_actor[gnum], "STUN_LEFT")
		Actor_SetAnimationFrame(claw_actor[gnum], 0)
		
		'Need to add bullet logic
		'Actor_SetActive(guard_weapon_actor[gnum], false)
		
		claw_action_time[gnum] = timer
		claw_distance[gnum] = 0
		PlaySound(1, 0, 0)
		
		
	
	
	Case CLAW_ACTION_STAND_RIGHT
		Actor_SetAnimationByName(claw_actor[gnum], "STAND_RIGHT")
		Actor_SetAnimationFrame(claw_actor[gnum], 0)
		claw_action_time[gnum] = timer
	Case CLAW_ACTION_JUMP_RIGHT
		Actor_SetAnimationByName(claw_actor[gnum], "JUMP_RIGHT")
		If Actor_Physics_State[claw_actor[gnum]] = PHYSICS_STATE_GROUND Then
			Actor_Physics_State[claw_actor[gnum]] = PHYSICS_STATE_RISE
			Actor_Jump[claw_actor[gnum]] = 100
			Actor_Force_Y[claw_actor[gnum]] = -4
		End If
		'Print "State = ";Actor_Physics_State[claw_actor[gnum]]
		'Print "Jump = ";Actor_Jump[claw_actor[gnum]]
		'Print "Y Force = ";Actor_Force_Y[claw_actor[gnum]]
		'maybe play a sound effect
	Case CLAW_ACTION_SHOOT_RIGHT
		Actor_SetAnimationByName(claw_actor[gnum], "ATTACK_RIGHT")
		claw_action_time[gnum] = timer
		
	Case CLAW_ACTION_STUN_RIGHT
		Actor_SetAnimationByName(claw_actor[gnum], "STUN_RIGHT")
		Actor_SetAnimationFrame(claw_actor[gnum], 0)
		
		'Need to add bullet logic
		'Actor_SetActive(guard_weapon_actor[gnum], false)
		
		claw_action_time[gnum] = timer
		claw_distance[gnum] = 0
		PlaySound(1, 0, 0)
	
	Case CLAW_ACTION_DEATH
		Actor_SetActive(claw_actor[gnum], false)
		
		'Actor_SetActive(guard_weapon_actor[gnum], false)
		
		Actor_SetActive(claw_death_actor[gnum], true)
		Actor_SetAnimation(claw_death_actor[gnum], 0)
		Actor_SetAnimationFrame(claw_death_actor[gnum], 0)
		Actor_SetPosition(claw_death_actor[gnum], Actor_X[claw_actor[gnum]], Actor_Y[claw_actor[gnum]])
		claw_action_time[gnum] = timer
		PlaySound(3, 1, 0)
	End Select
	claw_action[gnum] = action
	claw_action_status[gnum] = true
End Sub

Function AI_Claw_ActionComplete(gnum)
	If Not claw_action_status[gnum] Then
		Return True
	End If
	action = claw_action[gnum]
	Select Case action
	Case CLAW_ACTION_STAND_LEFT
		If timer - claw_action_time[gnum] > 1000 Then
			claw_action_status[gnum] = False
			Return True
		End If
	Case CLAW_ACTION_JUMP_LEFT
		If Actor_Physics_State[claw_actor[gnum]] = PHYSICS_STATE_GROUND Then
			claw_action_status[gnum] = False
			Return True
		End If
	Case CLAW_ACTION_SHOOT_LEFT
		If timer - claw_action_time[gnum] > 2000 Then
			claw_action_status[gnum] = False
			Return True
		End If
	
	Case CLAW_ACTION_STUN_LEFT
		If timer - claw_action_time[gnum] > 500 Then
			claw_action_status[gnum] = false
			Return True
		End If
	
	
	
	Case CLAW_ACTION_STAND_RIGHT
		If timer - claw_action_time[gnum] > 1000 Then
			claw_action_status[gnum] = False
			Return True
		End If
	Case CLAW_ACTION_JUMP_RIGHT
		If Actor_Physics_State[claw_actor[gnum]] = PHYSICS_STATE_GROUND Then
			claw_action_status[gnum] = False
			Return True
		End If
	Case CLAW_ACTION_SHOOT_RIGHT
		If timer - claw_action_time[gnum] > 2000 Then
			claw_action_status[gnum] = False
			Return True
		End If
	
	Case CLAW_ACTION_STUN_RIGHT
		If timer - claw_action_time[gnum] > 500 Then
			claw_action_status[gnum] = false
			Return True
		End If
	
	
	Case CLAW_ACTION_DEATH
		If Actor_AnimationEnded[claw_death_actor[gnum]] Then
			claw_action_status[gnum] = false
			'print "end death"
			Return True
		End If
	End Select
End Function

'walk left 20 steps
'stand left 1 sec
'walk right 20 steps
'stand right 1 sec
Dim CLAW_DIR_LEFT
Dim CLAW_DIR_RIGHT
CLAW_DIR_LEFT = 0
CLAW_DIR_RIGHT = 2

Function Claw_GetDirection(gnum)
	a = claw_action[gnum]
	If a = CLAW_ACTION_SHOOT_LEFT Or a = CLAW_ACTION_STAND_LEFT Or a = CLAW_ACTION_JUMP_LEFT Or a = CLAW_ACTION_STUN_LEFT Then
		Return CLAW_DIR_LEFT
	Else
		Return CLAW_DIR_RIGHT
	End If
End Function

claw_impact_stun = False

Sub Claw_Attack_Collision(gz_id, gnum)
	If (Not Player_isStunned) And claw_gz_impact Then 'And Actor_GetCollision(gz_id, claw_weapon_actor[gnum]) Then
		Player_isStunned = True
		Player_Stun_Time = Timer
		If Player_Action <= 15 Then
			Player_Current_Action = PLAYER_ACTION_STUN_LEFT
			Player_Stun_Speed = -4
		Else
			Player_Current_Action = PLAYER_ACTION_STUN_RIGHT
			Player_Stun_Speed = 4
		End If
		Actor_Jump[gz_id] = 10
		'Actor_Force_X[0] = 2
		Actor_Force_Y[gz_id] = -3
		'Actor_Momentum[0] = 2
		Actor_Weight[gz_id] = 3
		Actor_Physics_State[gz_id] = PHYSICS_STATE_RISE
		Actor_SetActive(Actor_ChildActor[gz_id], false)
		Graizor_Health = Graizor_Health - claw_axe_attack
		PlaySound(1, 0, 0)
		claw_impact_stun = True
	End If
End Sub

Sub AI_Claw(gnum, gz_id)
	actor = claw_actor[gnum]
	action = claw_action[gnum]
	
	
	If Not Player_isStunned and claw_impact_stun Then
		claw_impact_stun = False
		claw_gz_impact = False
	End If
	
	'print "action = ";action
	
	If Actor_Y[actor] > Stage_End_Y Then
		claw_alive[gnum] = false
		Actor_SetActive(actor, false)
	End If
	
	If claw_health[gnum] <= 0 And claw_alive[gnum] And claw_action[gnum] <> CLAW_ACTION_DEATH Then
		'Play death animation
		AI_Claw_StartAction(gnum, CLAW_ACTION_DEATH)
	End If
	
	Claw_Attack_Collision(gz_id, gnum)
	
	If (Not Player_isStunned) And claw_alive[gnum] And action <> CLAW_ACTION_DEATH And (action = CLAW_ACTION_STAND_LEFT Or action = CLAW_ACTION_STAND_RIGHT) Then
		If Actor_X[gz_id] <= Actor_X[actor] Then
			AI_Claw_StartAction(gnum, CLAW_ACTION_JUMP_LEFT)
		Else
			AI_Claw_StartAction(gnum, CLAW_ACTION_JUMP_RIGHT)
		End If
	End If
	
	If Actor_GetCollision(Actor_ChildActor[gz_id], actor) and action <> CLAW_ACTION_STUN_LEFT and action <> CLAW_ACTION_STUN_RIGHT Then
		If Claw_GetDirection(gnum) = CLAW_DIR_LEFT Then
			AI_Claw_StartAction(gnum, CLAW_ACTION_STUN_LEFT)
		Else
			AI_Claw_StartAction(gnum, CLAW_ACTION_STUN_RIGHT)
		End If
		claw_health[gnum] = claw_health[gnum] - Graizor_Sword_Attack
	ElseIf claw_enemy[gnum] >= 0 Then
		If enemy_hit[claw_enemy[gnum]] and action <> CLAW_ACTION_STUN_LEFT and action <> CLAW_ACTION_STUN_RIGHT Then
			If Claw_GetDirection(gnum) = CLAW_DIR_LEFT Then
				AI_Claw_StartAction(gnum, CLAW_ACTION_STUN_LEFT)
			Else
				AI_Claw_StartAction(gnum, CLAW_ACTION_STUN_RIGHT)
			End If
			claw_health[gnum] = claw_health[gnum] - blaster_atk
		End If
	End If
	
	claw_enemy[gnum] = -1
	
	AI_Claw_RunAction(gnum, gz_id)
	
	If AI_Claw_ActionComplete(gnum) Then
		'print "change";action
		Select Case action
		Case CLAW_ACTION_STAND_LEFT
			If Actor_Physics_State[actor] = PHYSICS_STATE_GROUND Then
				AI_Claw_StartAction(gnum, CLAW_ACTION_JUMP_RIGHT)
			End If
		Case CLAW_ACTION_JUMP_LEFT
			AI_Claw_StartAction(gnum, CLAW_ACTION_STAND_LEFT)
		Case CLAW_ACTION_SHOOT_LEFT
			
		Case CLAW_ACTION_STAND_RIGHT
			If Actor_Physics_State[actor] = PHYSICS_STATE_GROUND Then
				AI_Claw_StartAction(gnum, CLAW_ACTION_JUMP_LEFT)
			End If
		Case CLAW_ACTION_JUMP_RIGHT
			AI_Claw_StartAction(gnum, CLAW_ACTION_STAND_RIGHT)
		Case CLAW_ACTION_SHOOT_RIGHT
			
		Case CLAW_ACTION_STUN_LEFT
			AI_Claw_StartAction(gnum, CLAW_ACTION_STAND_LEFT)
		Case CLAW_ACTION_STUN_RIGHT
			AI_Claw_StartAction(gnum, CLAW_ACTION_STAND_RIGHT)
		Case CLAW_ACTION_DEATH
			Actor_SetActive(claw_death_actor[gnum], false)
			'Actor_SetActive(claw_weapon_actor[gnum], false)
			claw_action[gnum] = 0
			claw_alive[gnum] = false
		End Select
	End If
	
	If claw_alive[gnum] Then
		enemy[num_enemies] = claw_actor[gnum]
		enemy_hit[num_enemies] = False
		claw_enemy[gnum] = num_enemies
		num_enemies = num_enemies + 1
	Else
		claw_enemy[gnum] = -1
	End If
End Sub


Sub Claw_Act(gz_id)
	For i = 0 to MAX_CLAWS-1
		If claw_alive[i] Then
			AI_Claw(i, gz_id)
		ElseIf claw_actor[i] >= 0 Then
			'print"": print "actor !!!!"
			Claw_Attack_Collision(gz_id, i)
			AI_Claw_Bullets(i, gz_id)
		End If
	Next
End Sub
