'include "engine.bas"

MAX_HOVERS = 20

Dim hover_init_pos[MAX_HOVERS, 2]

Dim hover_alive[MAX_HOVERS]
Dim hover_actor[MAX_HOVERS]
Dim hover_action[MAX_HOVERS]
Dim hover_action_time[MAX_HOVERS]
Dim hover_action_lock[MAX_HOVERS]
Dim hover_action_status[MAX_HOVERS]

Dim HOVER_ACTION_STILL
Dim HOVER_ACTION_MOVE_LEFT
Dim HOVER_ACTION_MOVE_RIGHT
Dim HOVER_ACTION_SHOOT
Dim HOVER_ACTION_STUN
Dim HOVER_ACTION_DEATH

HOVER_ACTION_STILL = 0
HOVER_ACTION_MOVE_LEFT = 1
HOVER_ACTION_MOVE_RIGHT = 2
HOVER_ACTION_SHOOT = 3
HOVER_ACTION_STUN = 4
HOVER_ACTION_DEATH = 5

Dim hover_distance[MAX_HOVERS]

Dim hover_health[MAX_HOVERS]
Dim hover_weapon_actor[MAX_HOVERS]
Dim hover_death_actor[MAX_HOVERS]
Dim hover_direction[MAX_HOVERS]

Dim hover_ball_splash[MAX_HOVERS]
Dim hover_ball_splash_timer[MAX_HOVERS]

Dim hover_speed
Dim hover_ball_attack
hover_ball_attack = 1
hover_speed = 2
hover_travel_distance = 260

Dim hover_sound
hover_sound = -1
hover_sound_isplaying = false

Dim hover_enemy[MAX_HOVERS]

Function AI_Init_Hover(actor, ball)
	For i = 0 to MAX_HOVERS-1
		If Not hover_alive[i] Then
			hover_alive[i] = True
			hover_actor[i] = actor
			hover_action[i] = HOVER_ACTION_STILL
			hover_distance[i] = 0
			hover_action_time[i] = 0
			hover_action_lock[i] = 0
			hover_action_status[i] = 0
			hover_action[i] = 0
			hover_enemy[i] = -1
			Actor_Physics[actor] = True
			Actor_Weight[actor] = 0
			
			hover_init_pos[i, 0] = Actor_X[actor]
			hover_init_pos[i, 1] = Actor_Y[actor]
			
			Actor_SetLayer(actor, 2)
			Actor_SetActive(actor, True)
			Actor_SetAnimation(actor, 0)
			'Actor_SetParent(actor, actor)
			
			hover_health[i] = 2
			hover_weapon_actor[i] = ball
			Actor_Weight[ball] = 5
			
			Actor_SetAnimationFrame(actor, 0)
			Actor_SetAnimationFrame(ball, 0)
			
			Actor_SetLayer(ball, 2)
			Actor_SetActive(ball, false)
			
			hover_death_actor[i] = NewActor("hover_death", GetSpriteID("explosion"))
			Actor_SetLayer(hover_death_actor[i], Actor_Layer[actor])
			Actor_SetActive(hover_death_actor[i], false)
			
			Return i
		End If
	Next
	Return -1
End Function

Function Init_Hovers(num_hovers, Byref x, Byref y)
	If hover_sound < 0 Then
		For i = 0 to 1023
			If Not SoundExists(i) Then
				hover_sound = i
				LoadSound(hover_sound, SFX_PATH$ + "sfx_wpn_laser11.wav")
				'SetSoundVolume(hover_sound, 25)
			End If
		Next
	End If
	If num_hovers <= 0 Then
		Return 0
	End If
	hover_alive[0] = false
	ball_actor = GetActorID("hover_ball_01")
	'Actor_SetActive(ball_actor, 0)
	'ball_actor = NewActor("hover_ball_00", GetSpriteID("hover_art_ball"))
	h_actor = GetActorID("hover_01")
	AI_Init_Hover(h_actor, ball_actor)
	hover_direction[0] = 0
	
	For i = 1 to num_hovers
		n$ = Str(i+1)
		If Length(n) = 1 Then
			n = "0" + n
		End If
		h_actor = NewActor("hover_"+n, GetSpriteID("hover_art") )
		ball_actor = NewActor("hover_ball_"+n, GetSpriteID("hover_art_ball") )
		hover_alive[i] = false
		AI_Init_Hover(h_actor, ball_actor)
		Actor_SetPosition(h_actor, x[i-1], y[i-1])
		'print Actor_X[h_actor];", ";Actor_Y[h_actor]
		hover_direction[i] = i MOD 2
	Next
	Return True
End Function

Sub AI_Hover_RunAction(hover_num)
	actor = hover_actor[hover_num]
	wpn = hover_weapon_actor[hover_num]
	action = hover_action[hover_num]
	
	Select Case action
	Case HOVER_ACTION_STILL
		'Do nothing for now
	Case HOVER_ACTION_MOVE_LEFT
		If timer - hover_action_time[hover_num] > 15 Then
			Actor_Move(actor, -1 * hover_speed, 0)
			hover_distance[hover_num] = hover_distance[hover_num] + 1
			hover_action_time[hover_num] = timer
		End If
	Case HOVER_ACTION_SHOOT
		'Do nothing for now
		Actor_SetPosition(wpn, Actor_X[actor]+20, Actor_Y[actor]+60)
		Actor_Weight[wpn] = 5
	Case HOVER_ACTION_MOVE_RIGHT
		If timer - hover_action_time[hover_num] > 15 Then
			Actor_Move(actor, hover_speed, 0)
			hover_distance[hover_num] = hover_distance[hover_num] + 1
			hover_action_time[hover_num] = timer
		End If
	Case HOVER_ACTION_DEATH
		'print "animation = ";Actor_CurrentAnimation[guard_death_actor[gnum]]
		'print "num aframes = ";Sprite_Animation_NumFrames[ Actor_Sprite[guard_death_actor[gnum]], 0]
		'print "cframe = ";Actor_CurrentFrameTime[guard_death_actor[gnum]]
		'print "cdelay = ";Actor_CurrentFrameDelay[guard_death_actor[gnum]]
	End Select
End Sub

hv_gz_id = graizor

Sub AI_Hover_StartAction(hover_num, action)
	Select Case action
	Case HOVER_ACTION_STILL
		hover_action_time[hover_num] = timer
		
		Actor_SetPosition(hover_weapon_actor[hover_num], Actor_X[hover_actor[hover_num]], Actor_Y[hover_actor[hover_num]]+44)
		Actor_SetAnimation(hover_weapon_actor[hover_num], 0)
		Actor_Physics[hover_weapon_actor[hover_num]] = True
		Actor_Physics_State[hover_weapon_actor[hover_num]] = PHYSICS_STATE_FALL
		Actor_SetActive(hover_weapon_actor[hover_num], true)
		hover_ball_splash[hover_num] = false
		Actor_Weight[hover_weapon_actor[hover_num]] = 5
		Actor_SetVisible(hover_weapon_actor[hover_num], True)
		
		If Abs(Actor_X[hover_weapon_actor[hover_num]] - Actor_X[hv_gz_id]) < 1280 Then
			PlaySound(hover_sound, 1, 0)
		End If
		
	Case HOVER_ACTION_MOVE_LEFT, HOVER_ACTION_MOVE_RIGHT
		hover_distance[hover_num] = 0
	Case HOVER_ACTION_STUN
		hover_action_time[hover_num] = timer
		hover_distance[hover_num] = 0
		PlaySound(1, 0, 0)
	Case HOVER_ACTION_DEATH
		Actor_SetActive(hover_actor[hover_num], false)
		Actor_SetActive(hover_death_actor[hover_num], true)
		Actor_SetAnimation(hover_death_actor[hover_num], 0)
		Actor_SetAnimationFrame(hover_death_actor[hover_num], 0)
		Actor_SetPosition(hover_death_actor[hover_num], Actor_X[hover_actor[hover_num]], Actor_Y[hover_actor[hover_num]])
		hover_action_time[hover_num] = timer
		PlaySound(3, 1, 0)
	End Select
	hover_action[hover_num] = action
	hover_action_status[hover_num] = true
End Sub

Function AI_Hover_ActionComplete(hover_num)
	If Not hover_action_status[hover_num] Then
		Return True
	End If
	action = hover_action[hover_num]
	Select Case action
	Case HOVER_ACTION_STILL
		If timer - hover_action_time[hover_num] > 1000 Then
			hover_action_status[hover_num] = False
			Return True
		End If
	Case HOVER_ACTION_MOVE_LEFT, HOVER_ACTION_MOVE_RIGHT
		If hover_distance[hover_num] >= hover_travel_distance Then
			hover_action_status[hover_num] = False
			Return True
		End If
	
	Case HOVER_ACTION_STUN
		If timer - hover_action_time[hover_num] > 250 Then
			hover_action_status[hover_num] = false
			Return True
		End If
	Case HOVER_ACTION_DEATH
		If Actor_AnimationEnded[hover_death_actor[hover_num]] Then
			hover_action_status[hover_num] = false
			'print "end death"
			Return True
		End If
	End Select
End Function

Sub Hover_Attack_Collision(gz_id, hover_num)
	If Not Actor_isActive(hover_weapon_actor[hover_num]) Then
		Return
	End If
	If Not Actor_isOnScreen(hover_weapon_actor[hover_num]) Then
		Actor_SetActive(hover_weapon_actor[hover_num], False)
		Actor_SetVisible(hover_weapon_actor[hover_num], False)
	End If
	screen_dist = ( Abs(Actor_X[hover_weapon_actor[hover_num]] - Actor_X[gz_id]) < 1280 )
	If (hover_ball_splash[hover_num] = False) And Actor_Physics_State[hover_weapon_actor[hover_num]] = PHYSICS_STATE_GROUND Then
		Actor_SetAnimationByName(hover_weapon_actor[hover_num], "splash")
		Actor_SetAnimationFrame(hover_weapon_actor[hover_num], 0)
		Actor_Weight[hover_weapon_actor[hover_num]] = 0
		hover_ball_splash_timer[hover_num] = Timer
		hover_ball_splash[hover_num] = True
		If (Not hover_sound_isplaying) And screen_dist Then
			PlaySound(explosion_sound, 1, 0)
			hover_sound_isplaying = True
		End If
	End If
	If (hover_ball_splash[hover_num] = False) And Actor_GetCollision(gz_id, hover_weapon_actor[hover_num]) And (Not Player_isStunned) Then
		
		Actor_SetAnimationByName(hover_weapon_actor[hover_num], "splash")
		Actor_SetAnimationFrame(hover_weapon_actor[hover_num], 0)
		Actor_Weight[hover_weapon_actor[hover_num]] = 0
		hover_ball_splash_timer[hover_num] = Timer
		hover_ball_splash[hover_num] = True
		
		If (Not hover_sound_isplaying) And screen_dist Then
			PlaySound(explosion_sound, 1, 0)
			hover_sound_isplaying = True
		End If
		
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
		'print "Graizor Health = ";Graizor_Health
		'print "hover_ball_attack = ";hover_ball_attack
		Graizor_Health = Graizor_Health - hover_ball_attack
		PlaySound(1, 0, 0)
	ElseIf hover_ball_splash[hover_num] And (Timer - hover_ball_splash_timer[hover_num] > 200) Then
		Actor_SetActive(hover_weapon_actor[hover_num], False)
		Actor_SetVisible(hover_weapon_actor[hover_num], False)
	End If
End Sub

Sub AI_Hover(hover_num, gz_id)
	actor = hover_actor[hover_num]
	action = hover_action[hover_num]
	
	hv_gz_id = gz_id
	
	'print "action = ";action
	
	If Actor_Y[hover_actor[hover_num]] > Stage_End_Y Then
		hover_alive[hover_num] = false
		Actor_SetActive(hover_actor[hover_num], false)
	End If
	
	If hover_health[hover_num] <= 0 And hover_alive[hover_num] And hover_action[hover_num] <> HOVER_ACTION_DEATH Then
		'Play death animation
		AI_Hover_StartAction(hover_num, HOVER_ACTION_DEATH)
	End If
	
	Hover_Attack_Collision(gz_id, hover_num)
	
	If Actor_GetCollision(Actor_ChildActor[gz_id], actor) and action <> HOVER_ACTION_STUN Then
		'Print "DEBUG COLLIDE"
		AI_Hover_StartAction(hover_num, HOVER_ACTION_STUN)
		hover_health[hover_num] = hover_health[hover_num] - Graizor_Sword_Attack
	ElseIf hover_enemy[hover_num] >= 0 Then
		If enemy_hit[hover_enemy[hover_num]] and action <> HOVER_ACTION_STUN Then
			'Print "DEBUG COLLIDE"
			AI_Hover_StartAction(hover_num, HOVER_ACTION_STUN)
			hover_health[hover_num] = hover_health[hover_num] - blaster_atk
		End If
	End If
	
	hover_enemy[hover_num] = -1
	
	AI_Hover_RunAction(hover_num)
	
	If AI_Hover_ActionComplete(hover_num) Then
		'print "change"
		Select Case action
		Case HOVER_ACTION_STILL
			If hover_direction[hover_num] Then
				AI_Hover_StartAction(hover_num, HOVER_ACTION_MOVE_RIGHT)
			Else
				AI_Hover_StartAction(hover_num, HOVER_ACTION_MOVE_LEFT)
			End If
			hover_direction[hover_num] = Not hover_direction[hover_num]
				
		Case HOVER_ACTION_MOVE_LEFT, HOVER_ACTION_MOVE_RIGHT
			AI_Hover_StartAction(hover_num, HOVER_ACTION_STILL)
		
		Case HOVER_ACTION_STUN
			AI_Hover_StartAction(hover_num, HOVER_ACTION_STILL)
		Case HOVER_ACTION_DEATH
			Actor_SetActive(hover_death_actor[hover_num], false)
			Actor_SetActive(hover_weapon_actor[hover_num], false)
			hover_action[hover_num] = 0
			hover_alive[hover_num] = false
		End Select
	End If
	
	If hover_alive[hover_num] Then
		enemy[num_enemies] = hover_actor[hover_num]
		enemy_hit[num_enemies] = False
		hover_enemy[hover_num] = num_enemies
		num_enemies = num_enemies + 1
	Else
		hover_enemy[hover_num] = -1
	End If
End Sub

Sub Hover_Act(gz)
	hover_sound_isplaying = false
	For i = 0 to MAX_HOVERS-1
		If hover_alive[i] Then
			'print i
			AI_Hover(i, gz)
		End If
	Next
End Sub
