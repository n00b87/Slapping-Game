'include "engine.bas"

MAX_SKWS = 20

Dim skw_init_pos[MAX_SKWS, 2]

Dim skw_alive[MAX_SKWS]
Dim skw_actor[MAX_SKWS]
Dim skw_action[MAX_SKWS]
Dim skw_action_time[MAX_SKWS]
Dim skw_action_lock[MAX_SKWS]
Dim skw_action_status[MAX_SKWS]

Dim SKW_ACTION_STILL
Dim SKW_ACTION_MOVE_LEFT
Dim SKW_ACTION_MOVE_RIGHT
Dim SKW_ACTION_SHOOT
Dim SKW_ACTION_STUN
Dim SKW_ACTION_DEATH

SKW_ACTION_STILL = 0
SKW_ACTION_MOVE_LEFT = 1
SKW_ACTION_MOVE_RIGHT = 2
SKW_ACTION_STUN = 3
SKW_ACTION_DEATH = 4

Dim skw_distance[MAX_SKWS]

Dim skw_health[MAX_SKWS]
Dim skw_death_actor[MAX_SKWS]
Dim skw_direction[MAX_SKWS]

Dim skw_ball_splash[MAX_SKWS]
Dim skw_ball_splash_timer[MAX_SKWS]

Dim skw_speed
Dim skw_ball_attack
skw_ball_attack = 1
skw_speed = 2
skw_travel_distance = 260

Dim skw_sound
skw_sound = -1
skw_sound_isplaying = false

Dim skw_enemy[MAX_SKWS]

Function AI_Init_Skw(actor)
	For i = 0 to MAX_SKWS-1
		If Not skw_alive[i] Then
			skw_alive[i] = True
			skw_actor[i] = actor
			Select Case skw_direction[i]
			Case 0 : skw_action[i] = SKW_ACTION_MOVE_LEFT
			Default : skw_action[i] = SKW_ACTION_MOVE_RIGHT
			End Select
			skw_distance[i] = 0
			skw_action_time[i] = timer
			skw_action_lock[i] = 0
			skw_action_status[i] = 0
			skw_enemy[i] = -1
			Actor_Physics[actor] = True
			Actor_Weight[actor] = 0
			
			skw_init_pos[i, 0] = Actor_X[actor]
			skw_init_pos[i, 1] = Actor_Y[actor]
			
			Actor_SetLayer(actor, 2)
			Actor_SetActive(actor, True)
			Actor_SetAnimation(actor, 0)
			'Actor_SetParent(actor, actor)
			
			skw_health[i] = 9
			Actor_SetAnimationFrame(actor, 0)
			
			skw_death_actor[i] = NewActor("skw_death", GetSpriteID("explosion"))
			Actor_SetLayer(skw_death_actor[i], Actor_Layer[actor])
			Actor_SetActive(skw_death_actor[i], false)
			
			Return i
		End If
	Next
	Return -1
End Function

Function Init_Skws(num_skws)

	If num_skws <= 0 Then
		Return 0
	End If
	
	sprite = LoadSprite("skull_wheel")

	For i = 1 to num_skws
		h_actor = NewActor("skull_wheel_"+str(i), sprite)
		skw_alive[i] = false
		AI_Init_Skw(h_actor)
		'Actor_SetPosition(h_actor, x[i-1], y[i-1])
		'print Actor_X[h_actor];", ";Actor_Y[h_actor]
		skw_direction[i] = i MOD 2
	Next
	Return True
End Function

Sub AI_Skw_RunAction(skw_num)
	actor = skw_actor[skw_num]
	action = skw_action[skw_num]
	
	'Print "Action = ";action
	
	Select Case action
	Case SKW_ACTION_STILL
		'Do nothing for now
	Case SKW_ACTION_MOVE_LEFT
		If timer - skw_action_time[skw_num] > 10 Then
			Actor_Move(actor, -1 * skw_speed, 0)
			skw_distance[skw_num] = skw_distance[skw_num] + 1
			skw_action_time[skw_num] = timer
		End If
	Case SKW_ACTION_MOVE_RIGHT
		If timer - skw_action_time[skw_num] > 10 Then
			Actor_Move(actor, skw_speed, 0)
			skw_distance[skw_num] = skw_distance[skw_num] + 1
			skw_action_time[skw_num] = timer
		End If
	Case SKW_ACTION_DEATH
		'print "animation = ";Actor_CurrentAnimation[guard_death_actor[gnum]]
		'print "num aframes = ";Sprite_Animation_NumFrames[ Actor_Sprite[guard_death_actor[gnum]], 0]
		'print "cframe = ";Actor_CurrentFrameTime[guard_death_actor[gnum]]
		'print "cdelay = ";Actor_CurrentFrameDelay[guard_death_actor[gnum]]
	End Select
End Sub

hv_gz_id = graizor

Sub AI_Skw_StartAction(skw_num, action)
	Select Case action
	Case SKW_ACTION_STILL
		skw_action_time[skw_num] = timer
		
	Case SKW_ACTION_MOVE_LEFT, SKW_ACTION_MOVE_RIGHT
		skw_distance[skw_num] = 0
	Case SKW_ACTION_STUN
		skw_action_time[skw_num] = timer
		skw_distance[skw_num] = 0
		PlaySound(1, 0, 0)
	Case SKW_ACTION_DEATH
		Actor_SetActive(skw_actor[skw_num], false)
		Actor_SetActive(skw_death_actor[skw_num], true)
		Actor_SetAnimation(skw_death_actor[skw_num], 0)
		Actor_SetAnimationFrame(skw_death_actor[skw_num], 0)
		Actor_SetPosition(skw_death_actor[skw_num], Actor_X[skw_actor[skw_num]], Actor_Y[skw_actor[skw_num]])
		skw_action_time[skw_num] = timer
		PlaySound(3, 1, 0)
	End Select
	skw_action[skw_num] = action
	skw_action_status[skw_num] = true
End Sub

Function AI_Skw_ActionComplete(skw_num)
	If Not skw_action_status[skw_num] Then
		Return True
	End If
	action = skw_action[skw_num]
	Select Case action
	Case SKW_ACTION_STILL
		If timer - skw_action_time[skw_num] > 1000 Then
			skw_action_status[skw_num] = False
			Return True
		End If
	Case SKW_ACTION_MOVE_LEFT, SKW_ACTION_MOVE_RIGHT
		If skw_distance[skw_num] >= skw_travel_distance Then
			skw_action_status[skw_num] = False
			Return True
		End If
	
	Case SKW_ACTION_STUN
		If timer - skw_action_time[skw_num] > 250 Then
			skw_action_status[skw_num] = false
			Return True
		End If
	Case SKW_ACTION_DEATH
		If Actor_AnimationEnded[skw_death_actor[skw_num]] Then
			skw_action_status[skw_num] = false
			'print "end death"
			Return True
		End If
	End Select
End Function

Sub Skw_Attack_Collision(gz_id, skw_num)
	If Not Actor_isActive(skw_actor[skw_num]) Then
		Return
	End If
	
	'screen_dist = ( Abs(Actor_X[skw_weapon_actor[skw_num]] - Actor_X[gz_id]) < 1280 )
	
	If Actor_GetCollision(gz_id, skw_actor[skw_num]) And (Not Player_isStunned) Then
		
		Player_isStunned = True
		Player_Stun_Time = Timer
		If Actor_X[gz_id] > Actor_X[skw_actor[skw_num]] Then
			Player_Current_Action = PLAYER_ACTION_STUN_LEFT
			Player_Stun_Speed = 5
			AI_Skw_StartAction(skw_num, SKW_ACTION_MOVE_LEFT)
		Else
			Player_Current_Action = PLAYER_ACTION_STUN_RIGHT
			Player_Stun_Speed = -5
			AI_Skw_StartAction(skw_num, SKW_ACTION_MOVE_RIGHT)
		End If
		Actor_Jump[gz_id] = 10
		'Actor_Force_X[0] = 2
		Actor_Force_Y[gz_id] = -3
		'Actor_Momentum[0] = 2
		Actor_Weight[gz_id] = 3
		Actor_Physics_State[gz_id] = PHYSICS_STATE_RISE
		Actor_SetActive(Actor_ChildActor[gz_id], false)
		'print "Graizor Health = ";Graizor_Health
		'print "skw_ball_attack = ";skw_ball_attack
		Graizor_Health = Graizor_Health - skw_ball_attack
		PlaySound(1, 0, 0)
	End If
End Sub

Sub AI_Skw(skw_num, gz_id)
	actor = skw_actor[skw_num]
	action = skw_action[skw_num]
	
	hv_gz_id = gz_id
	
	'print "action = ";action
	
	If Actor_Y[skw_actor[skw_num]] > Stage_End_Y Then
		skw_alive[skw_num] = false
		Actor_SetActive(skw_actor[skw_num], false)
	End If
	
	If skw_health[skw_num] <= 0 And skw_alive[skw_num] And skw_action[skw_num] <> SKW_ACTION_DEATH Then
		'Play death animation
		AI_Skw_StartAction(skw_num, SKW_ACTION_DEATH)
	End If
	
	Skw_Attack_Collision(gz_id, skw_num)
	
	If Actor_GetCollision(Actor_ChildActor[gz_id], actor) and action <> SKW_ACTION_STUN Then
		'Print "DEBUG COLLIDE"
		AI_Skw_StartAction(skw_num, SKW_ACTION_STUN)
		skw_health[skw_num] = skw_health[skw_num] - Graizor_Sword_Attack
	ElseIf skw_enemy[skw_num] >= 0 Then
		If enemy_hit[skw_enemy[skw_num]] and action <> SKW_ACTION_STUN Then
			'Print "DEBUG COLLIDE"
			AI_Skw_StartAction(skw_num, SKW_ACTION_STUN)
			skw_health[skw_num] = skw_health[skw_num] - blaster_atk
		End If
	End If
	
	skw_enemy[skw_num] = -1
	
	AI_Skw_RunAction(skw_num)
	
	If AI_Skw_ActionComplete(skw_num) Then
		'print "change"
		Select Case action
		Case SKW_ACTION_MOVE_LEFT
			AI_Skw_StartAction(skw_num, SKW_ACTION_MOVE_RIGHT)
		
		Case SKW_ACTION_MOVE_RIGHT
			AI_Skw_StartAction(skw_num, SKW_ACTION_MOVE_LEFT)
		
		Case SKW_ACTION_STUN
			AI_Skw_StartAction(skw_num, SKW_ACTION_MOVE_LEFT)
		Case SKW_ACTION_DEATH
			Actor_SetActive(skw_death_actor[skw_num], false)
			skw_action[skw_num] = 0
			skw_alive[skw_num] = false
		End Select
	End If
	
	If skw_alive[skw_num] Then
		enemy[num_enemies] = skw_actor[skw_num]
		enemy_hit[num_enemies] = False
		skw_enemy[skw_num] = num_enemies
		num_enemies = num_enemies + 1
	Else
		skw_enemy[skw_num] = -1
	End If
End Sub

Sub Skw_Act(gz)
	skw_sound_isplaying = false
	For i = 0 to MAX_SKWS-1
		If skw_alive[i] Then
			'print i
			AI_Skw(i, gz)
		End If
	Next
End Sub
